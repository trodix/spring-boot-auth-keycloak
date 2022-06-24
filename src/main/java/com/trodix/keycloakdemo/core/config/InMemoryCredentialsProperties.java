package com.trodix.keycloakdemo.core.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.ConstructorBinding;
import lombok.AllArgsConstructor;
import lombok.Getter;

@ConfigurationProperties(prefix = "spring.security.user")
@ConstructorBinding
@AllArgsConstructor
@Getter
public class InMemoryCredentialsProperties {

    private final String name;
    private final String password;
    private final String[] roles;

}
