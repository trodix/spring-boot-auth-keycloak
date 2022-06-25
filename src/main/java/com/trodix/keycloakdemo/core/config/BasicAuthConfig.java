package com.trodix.keycloakdemo.core.config;

import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import de.codecentric.boot.admin.server.config.AdminServerProperties;

@Configuration
@Order(1)
public class BasicAuthConfig extends WebSecurityConfigurerAdapter {

    private final AdminServerProperties adminServer;

    private final InMemoryCredentialsProperties inMemoryCredentialsProperties;

    public BasicAuthConfig(final AdminServerProperties adminServer, final InMemoryCredentialsProperties inMemoryCredentialsProperties) {
        this.adminServer = adminServer;
        this.inMemoryCredentialsProperties = inMemoryCredentialsProperties;
    }

    @Override
    protected void configure(final HttpSecurity http) throws Exception {
        final SavedRequestAwareAuthenticationSuccessHandler successHandler = new SavedRequestAwareAuthenticationSuccessHandler();
        successHandler.setTargetUrlParameter("redirectTo");
        successHandler.setDefaultTargetUrl(this.adminServer.getContextPath() + "/");

        http.requestMatchers()
                .antMatchers("/v3/api-docs/**", "/swagger-ui/**", "/swagger-ui.html",
                        this.adminServer.getContextPath(), this.adminServer.getContextPath() + "/login", this.adminServer.getContextPath() + "/assets/**",
                        "/actuator/**",
                        this.adminServer.getContextPath() + "/instances/**")
                // TODO Restrict Spring Boot Admin and actuator endpoints to ADMINISTRATOR role
                // .and().authorizeHttpRequests().antMatchers("/actuator/**", this.adminServer.getContextPath() +
                // "/**").hasRole("ADMINISTRATOR")
                // .and()
                // .authorizeHttpRequests().anyRequest().permitAll()
                .and()
                .exceptionHandling()
                .authenticationEntryPoint(
                        (request, response, authException) -> response.sendError(HttpStatus.UNAUTHORIZED.value(), HttpStatus.UNAUTHORIZED.getReasonPhrase()))
                .and()
                .formLogin()
                .loginPage(this.adminServer.getContextPath() + "/login")
                .successHandler(successHandler)
                .and()
                .logout()
                .logoutUrl(this.adminServer.getContextPath() + "/logout")
                .and()
                .httpBasic()
                .and()
                .csrf()
                .disable()
                // TODO Make `ignoringRequestMatchers` work with
                // `/admin/instances/fccaadbdf87e/actuator/loggers/ROOT`
                // .csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
                // .ignoringRequestMatchers(
                // new AntPathRequestMatcher(this.adminServer.getContextPath() + "/instances/**"),
                // new AntPathRequestMatcher(this.adminServer.getContextPath() + "/actuator/**"))
                // .and()
                .rememberMe()
                .key(UUID.randomUUID().toString())
                .tokenValiditySeconds(60 * 10);
    }

    @Autowired
    public void configureGlobal(final AuthenticationManagerBuilder auth) throws Exception {
        auth.inMemoryAuthentication().withUser(this.inMemoryCredentialsProperties.getName())
                .password("{noop}" + this.inMemoryCredentialsProperties.getPassword()).roles(this.inMemoryCredentialsProperties.getRoles());
    }

}
