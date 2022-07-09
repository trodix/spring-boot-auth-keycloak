# SpringBoot REST API Keycloak Auth

## Development setup

### Run Keycloak

`docker-compose up`

Open keycloak to <http://localhost:8080>

### Run backend API

`mvn spring-boot:run`

Open REST API to <http://localhost:9090>

### Add users and assign them to roles

<img src="./documentation/img/keycloak_create_user.png" />
<img src="./documentation/img/keycloak_user_credentials.png" />
<img src="./documentation/img/keycloak_user_role_mapping.png" />

### Generate a token with Postman

<img src="./documentation/img/postman_oauth2_get_token.png" />

## Tests

### Generate Code Coveage report

`mvn jacoco:prepare-agent test install jacoco:report`
