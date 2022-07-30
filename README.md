# SpringBoot REST API Keycloak Auth

## Development setup

### Run Microservices

`docker-compose up`

Available microservices:

<img src="./documentation/img/schema_archi.png" />

#### **Postgresql**

> Database for keycloak

Port `5432`

#### **Keycloak**

> Authentication server (SSO)

Port `8080` for web ui

Port `9990` for wildfly managment interface

#### **OpenLDAP**

> Users and Groups source (synchronized with Keycloak)

port LDAP `1389`

port LDAPS `1636`

#### **Prometheus**

> Metrics agregator

Port `9090`

#### **Node exporter**

> Linux metrics collector

Port `5100`

#### **Cadvisor**

> Docker metrics collector

Port `5110`

#### **Grafana**

> Metrics visualisation and alerting

Port `3000`

#### **Grafana renderer**

> Transform metrics Graphs to .png images for mailing alerts

Port `3001`

#### **Maildev**

> Development SMTP server for grafana mail alerts

Port SMTP `1025`

Port Webmail `1080`

#### **Activemq**

> Message Broker

Port 61616

### Run backend API

`mvn spring-boot:run`

Open REST API to <http://localhost:8000>
<img src="./documentation/img/rest_api_swagger_doc.png" />

### Add users and assign them to roles

<img src="./documentation/img/keycloak_create_user.png" />
<img src="./documentation/img/keycloak_user_credentials.png" />
<img src="./documentation/img/keycloak_user_role_mapping.png" />

### Generate a token with Postman

<img src="./documentation/img/postman_oauth2_get_token.png" />

## Tests

### Generate Code Coveage report

`mvn jacoco:prepare-agent test install jacoco:report`

## Monitoring

### With SpringBootAdmin

<http://localhost:8000/admin>
<img src="./documentation/img/spring-boot_admin.png" />

### With grafana:

<img src="./documentation/img/grafana_dashboard_host_docker.png" />
<img src="./documentation/img/grafana_dashboard_jvm.png" />
<img src="./documentation/img/grafana_dashboard_performance_logging_custom_metric.png" />
<img src="./documentation/img/grafana_mail_alert.png" />
