package com.trodix.keycloakdemo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.scheduling.annotation.EnableAsync;

import de.codecentric.boot.admin.server.config.EnableAdminServer;

@SpringBootApplication
@ConfigurationPropertiesScan
@EnableAdminServer
@EnableAsync
public class KeycloakDemoApplication {

	public static void main(final String[] args) {
		SpringApplication.run(KeycloakDemoApplication.class, args);
	}

}
