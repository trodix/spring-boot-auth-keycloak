package com.trodix.keycloakdemo.core.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.ConstructorBinding;

import lombok.AllArgsConstructor;
import lombok.Getter;

@ConfigurationProperties(prefix = "swagger")
@ConstructorBinding
@AllArgsConstructor
@Getter
public class SwaggerProperties {

    private final String projectTitle;
    private final String projectDescription;
    private final String projectVersion;
}
