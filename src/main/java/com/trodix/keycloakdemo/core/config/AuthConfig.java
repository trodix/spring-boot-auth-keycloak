package com.trodix.keycloakdemo.core.config;

import java.util.List;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.authentication.session.NullAuthenticatedSessionStrategy;
import org.springframework.security.web.authentication.session.SessionAuthenticationStrategy;
import de.codecentric.boot.admin.server.config.AdminServerProperties;

@Configuration
@EnableGlobalMethodSecurity(
        prePostEnabled = true,
        securedEnabled = true,
        jsr250Enabled = true)
public class AuthConfig {

    private final AdminServerProperties adminServer;

    private final InMemoryCredentialsProperties inMemoryCredentialsProperties;

    private final KeycloakJwtAuthenticationConverter keycloakJwtAuthenticationConverter;

    public AuthConfig(final AdminServerProperties adminServer, final InMemoryCredentialsProperties inMemoryCredentialsProperties, final KeycloakJwtAuthenticationConverter keycloakJwtAuthenticationConverter) {
        this.adminServer = adminServer;
        this.inMemoryCredentialsProperties = inMemoryCredentialsProperties;
        this.keycloakJwtAuthenticationConverter = keycloakJwtAuthenticationConverter;
    }

    @Bean
    public SessionAuthenticationStrategy sessionAuthenticationStrategy() {
        return new NullAuthenticatedSessionStrategy();
    }

    @Bean
    public SecurityFilterChain filterChain(final HttpSecurity http) throws Exception {

        final SavedRequestAwareAuthenticationSuccessHandler successHandler = new SavedRequestAwareAuthenticationSuccessHandler();
        successHandler.setTargetUrlParameter("redirectTo");
        successHandler.setDefaultTargetUrl(this.adminServer.getContextPath() + "/");

        // BASIC Authenticaton
        http.requestMatchers()
                .antMatchers("/v3/api-docs/**", "/swagger-ui/**", "/swagger-ui.html",
                        this.adminServer.getContextPath(), this.adminServer.getContextPath() + "/login",
                        this.adminServer.getContextPath() + "/assets/**",
                        "/actuator/**",
                        this.adminServer.getContextPath() + "/instances/**")
                .and()
                .authorizeRequests().antMatchers("/v3/api-docs/**", "/swagger-ui/**", "/swagger-ui.html",
                        this.adminServer.getContextPath(), this.adminServer.getContextPath() + "/login",
                        this.adminServer.getContextPath() + "/assets/**",
                        "/actuator/**",
                        this.adminServer.getContextPath() + "/instances/**")
                .permitAll()
                // TODO Restrict Spring Boot Admin and actuator endpoints to ADMINISTRATOR role
                // .and().authorizeHttpRequests().antMatchers("/actuator/**", this.adminServer.getContextPath() +
                // "/**").hasRole("ADMINISTRATOR")
                // .and()
                // .authorizeHttpRequests().anyRequest().permitAll()
                .and()
                .exceptionHandling()
                .authenticationEntryPoint(
                        (request, response, authException) -> response.sendError(HttpStatus.UNAUTHORIZED.value(),
                                HttpStatus.UNAUTHORIZED.getReasonPhrase()))
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

        // OAUTH authentication
        http.requestMatchers()
                .anyRequest()
                .and()
                .oauth2ResourceServer(
                        config -> config
                                .jwt()
                                .jwtAuthenticationConverter(keycloakJwtAuthenticationConverter))
                .authorizeRequests()
                .anyRequest()
                .authenticated();

        return http.build();
    }

    @Bean
    public UserDetailsService userDetailsService() {
        final InMemoryUserDetailsManager manager = new InMemoryUserDetailsManager();
        manager.createUser(
                User
                        .withUsername(this.inMemoryCredentialsProperties.getName())
                        .password(encoder().encode(this.inMemoryCredentialsProperties.getPassword()))
                        .roles(this.inMemoryCredentialsProperties.getRoles())
                        .build());

        return manager;
    }

    @Bean
    public PasswordEncoder encoder() {
        return new BCryptPasswordEncoder();
    }

}
