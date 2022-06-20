package com.trodix.keycloakdemo.core.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SwaggerBeanConfig {

    @Bean
    public ApiInfoProvider apiInfoProvider(final SwaggerProperties swaggerProperties) {
        return new ApiInfoProvider(swaggerProperties);
    }
}
