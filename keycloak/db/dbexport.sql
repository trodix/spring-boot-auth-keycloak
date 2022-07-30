--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1 (Debian 14.1-1.pgdg110+1)
-- Dumped by pg_dump version 14.1 (Debian 14.1-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO postgres;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO postgres;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO postgres;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO postgres;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO postgres;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO postgres;

--
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO postgres;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO postgres;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
688b34dd-b755-4fa9-b2d8-f5a610b23bf6	\N	auth-cookie	68547ce3-6e06-4390-a3d3-3f5eaafa1583	8c887b64-15ec-4df3-8cf0-dad03d379acd	2	10	f	\N	\N
4bc7849a-c411-47f0-b775-554b44887220	\N	auth-spnego	68547ce3-6e06-4390-a3d3-3f5eaafa1583	8c887b64-15ec-4df3-8cf0-dad03d379acd	3	20	f	\N	\N
97da0d77-ba72-4ade-84e2-7759d4d994ec	\N	identity-provider-redirector	68547ce3-6e06-4390-a3d3-3f5eaafa1583	8c887b64-15ec-4df3-8cf0-dad03d379acd	2	25	f	\N	\N
758e059a-3079-4295-891b-4cb0718442d9	\N	\N	68547ce3-6e06-4390-a3d3-3f5eaafa1583	8c887b64-15ec-4df3-8cf0-dad03d379acd	2	30	t	df2e15fb-3ba2-4fda-96f9-1e688ca9199e	\N
d0e8b1f0-40f8-40eb-9881-1e235c57a5df	\N	auth-username-password-form	68547ce3-6e06-4390-a3d3-3f5eaafa1583	df2e15fb-3ba2-4fda-96f9-1e688ca9199e	0	10	f	\N	\N
4289a736-f2af-49b1-bb1b-0c307df116c3	\N	\N	68547ce3-6e06-4390-a3d3-3f5eaafa1583	df2e15fb-3ba2-4fda-96f9-1e688ca9199e	1	20	t	24263967-26c2-47d1-af69-0c2af2bb792b	\N
b4f8b3be-26b9-41e9-90c0-6230703c0714	\N	conditional-user-configured	68547ce3-6e06-4390-a3d3-3f5eaafa1583	24263967-26c2-47d1-af69-0c2af2bb792b	0	10	f	\N	\N
2d489c08-220e-4393-84ba-01418b1b872e	\N	auth-otp-form	68547ce3-6e06-4390-a3d3-3f5eaafa1583	24263967-26c2-47d1-af69-0c2af2bb792b	0	20	f	\N	\N
cac866f5-8834-4377-a6cd-4222678f827b	\N	direct-grant-validate-username	68547ce3-6e06-4390-a3d3-3f5eaafa1583	3954b6f1-5f92-4097-9202-b55d678e2942	0	10	f	\N	\N
3b622a4f-370c-4551-a9db-910a920681e3	\N	direct-grant-validate-password	68547ce3-6e06-4390-a3d3-3f5eaafa1583	3954b6f1-5f92-4097-9202-b55d678e2942	0	20	f	\N	\N
3944d3e8-3284-48a0-a124-672106aeb69e	\N	\N	68547ce3-6e06-4390-a3d3-3f5eaafa1583	3954b6f1-5f92-4097-9202-b55d678e2942	1	30	t	c553c971-6a6b-440d-bb64-e7469df62eef	\N
4d4d674c-b041-43a9-94b3-a97a92988821	\N	conditional-user-configured	68547ce3-6e06-4390-a3d3-3f5eaafa1583	c553c971-6a6b-440d-bb64-e7469df62eef	0	10	f	\N	\N
88332bcb-25e8-41c6-87cf-65dcfb77d61c	\N	direct-grant-validate-otp	68547ce3-6e06-4390-a3d3-3f5eaafa1583	c553c971-6a6b-440d-bb64-e7469df62eef	0	20	f	\N	\N
49fcbdf6-1f12-453e-b9b8-56843bf125a9	\N	registration-page-form	68547ce3-6e06-4390-a3d3-3f5eaafa1583	059d1146-8128-4133-8303-1f9d4a2a0014	0	10	t	b1f0aad2-62d6-4445-9ec6-dcfd17a65e3a	\N
3f529ee8-adae-40d8-948f-3a61ec340012	\N	registration-user-creation	68547ce3-6e06-4390-a3d3-3f5eaafa1583	b1f0aad2-62d6-4445-9ec6-dcfd17a65e3a	0	20	f	\N	\N
39fb5b1b-5cf7-4124-9810-62104e218e1a	\N	registration-profile-action	68547ce3-6e06-4390-a3d3-3f5eaafa1583	b1f0aad2-62d6-4445-9ec6-dcfd17a65e3a	0	40	f	\N	\N
b075f6b7-7914-448d-ae1f-abf769ed08ed	\N	registration-password-action	68547ce3-6e06-4390-a3d3-3f5eaafa1583	b1f0aad2-62d6-4445-9ec6-dcfd17a65e3a	0	50	f	\N	\N
582e8909-ab72-464a-8a71-c4dd799f65a1	\N	registration-recaptcha-action	68547ce3-6e06-4390-a3d3-3f5eaafa1583	b1f0aad2-62d6-4445-9ec6-dcfd17a65e3a	3	60	f	\N	\N
847e6454-f4d8-41cc-9443-80698c2f57a9	\N	reset-credentials-choose-user	68547ce3-6e06-4390-a3d3-3f5eaafa1583	4510dda2-46fa-4174-88c6-a71f0347810a	0	10	f	\N	\N
1c5b857f-2dc0-47e5-a7cb-1117001d558c	\N	reset-credential-email	68547ce3-6e06-4390-a3d3-3f5eaafa1583	4510dda2-46fa-4174-88c6-a71f0347810a	0	20	f	\N	\N
0951ded8-616c-4a62-a709-74b4f32f38fe	\N	reset-password	68547ce3-6e06-4390-a3d3-3f5eaafa1583	4510dda2-46fa-4174-88c6-a71f0347810a	0	30	f	\N	\N
640a5936-636e-4d67-a6ea-adda296fdf55	\N	\N	68547ce3-6e06-4390-a3d3-3f5eaafa1583	4510dda2-46fa-4174-88c6-a71f0347810a	1	40	t	e3bdd932-a52c-4d66-add6-6f64197e632b	\N
22b1e797-d44f-4dee-9db8-8d58d5648ce2	\N	conditional-user-configured	68547ce3-6e06-4390-a3d3-3f5eaafa1583	e3bdd932-a52c-4d66-add6-6f64197e632b	0	10	f	\N	\N
e006cc0e-8d14-4e6d-9282-aaf062187a83	\N	reset-otp	68547ce3-6e06-4390-a3d3-3f5eaafa1583	e3bdd932-a52c-4d66-add6-6f64197e632b	0	20	f	\N	\N
2703172b-8187-435a-9269-dd32537093fb	\N	client-secret	68547ce3-6e06-4390-a3d3-3f5eaafa1583	2a314916-4add-4e20-8cf0-8ee8483ada35	2	10	f	\N	\N
7c02653c-a0cf-400a-87f4-10646c532c9d	\N	client-jwt	68547ce3-6e06-4390-a3d3-3f5eaafa1583	2a314916-4add-4e20-8cf0-8ee8483ada35	2	20	f	\N	\N
6d26c083-5546-4182-9093-6d1a78df9f13	\N	client-secret-jwt	68547ce3-6e06-4390-a3d3-3f5eaafa1583	2a314916-4add-4e20-8cf0-8ee8483ada35	2	30	f	\N	\N
5d4773fb-0ca5-41b3-b15d-315023f42030	\N	client-x509	68547ce3-6e06-4390-a3d3-3f5eaafa1583	2a314916-4add-4e20-8cf0-8ee8483ada35	2	40	f	\N	\N
6410f865-8a53-4bd8-93ae-b6c80711c439	\N	idp-review-profile	68547ce3-6e06-4390-a3d3-3f5eaafa1583	53c39822-4550-4abc-bf22-fcab381a702b	0	10	f	\N	d10ca1b0-0d7d-4ee4-bc02-4d44de6445c6
6728300a-71d5-490d-b6d3-48b7c96c5d4b	\N	\N	68547ce3-6e06-4390-a3d3-3f5eaafa1583	53c39822-4550-4abc-bf22-fcab381a702b	0	20	t	d4e07a4e-f5cb-444b-97a2-260f016aee9f	\N
4035760a-a7d5-4e53-9c72-ae9d425e66e0	\N	idp-create-user-if-unique	68547ce3-6e06-4390-a3d3-3f5eaafa1583	d4e07a4e-f5cb-444b-97a2-260f016aee9f	2	10	f	\N	aa6d0334-c251-4a80-9e63-957fb829e84a
16277bc1-4e76-47be-971f-1a6bba733f44	\N	\N	68547ce3-6e06-4390-a3d3-3f5eaafa1583	d4e07a4e-f5cb-444b-97a2-260f016aee9f	2	20	t	408a233f-b529-4bdd-b9a8-1c094d2990bf	\N
678396a7-5677-4aaf-a532-e8c1caf1d430	\N	idp-confirm-link	68547ce3-6e06-4390-a3d3-3f5eaafa1583	408a233f-b529-4bdd-b9a8-1c094d2990bf	0	10	f	\N	\N
82c3ef81-7b4e-4e08-ae9e-58951b477c2d	\N	\N	68547ce3-6e06-4390-a3d3-3f5eaafa1583	408a233f-b529-4bdd-b9a8-1c094d2990bf	0	20	t	2a4da5a5-05b9-435b-9994-bd0d2f8d5368	\N
d2f9dfb0-893b-4cd5-a1e9-dd042279a70b	\N	idp-email-verification	68547ce3-6e06-4390-a3d3-3f5eaafa1583	2a4da5a5-05b9-435b-9994-bd0d2f8d5368	2	10	f	\N	\N
f7e42445-0a2c-432b-bab6-65fe3af08bca	\N	\N	68547ce3-6e06-4390-a3d3-3f5eaafa1583	2a4da5a5-05b9-435b-9994-bd0d2f8d5368	2	20	t	7b2aa57f-67c4-4297-8612-a5ec9e02ddce	\N
f70be32f-8c2a-4212-b8b2-ede961bc5351	\N	idp-username-password-form	68547ce3-6e06-4390-a3d3-3f5eaafa1583	7b2aa57f-67c4-4297-8612-a5ec9e02ddce	0	10	f	\N	\N
f3c4b079-f96f-430f-b243-daa8f087a5f2	\N	\N	68547ce3-6e06-4390-a3d3-3f5eaafa1583	7b2aa57f-67c4-4297-8612-a5ec9e02ddce	1	20	t	b3b40715-073b-482e-9c54-38b183036667	\N
e4c44c20-8497-465f-a1bc-a6c829d0fb09	\N	conditional-user-configured	68547ce3-6e06-4390-a3d3-3f5eaafa1583	b3b40715-073b-482e-9c54-38b183036667	0	10	f	\N	\N
9a12dc7a-1576-49d2-9adc-a284cff37418	\N	auth-otp-form	68547ce3-6e06-4390-a3d3-3f5eaafa1583	b3b40715-073b-482e-9c54-38b183036667	0	20	f	\N	\N
78845cd8-f038-437b-aefe-201a015531ce	\N	http-basic-authenticator	68547ce3-6e06-4390-a3d3-3f5eaafa1583	8622f9cf-20e7-4d7b-bfd2-125095ee56e6	0	10	f	\N	\N
2f875c3d-c1a9-49ba-87cc-365643a409f0	\N	docker-http-basic-authenticator	68547ce3-6e06-4390-a3d3-3f5eaafa1583	4245100b-efc8-490e-b954-0ac61c9693cf	0	10	f	\N	\N
34923c5d-8a1f-4e90-bacb-ab7de8b6aa50	\N	no-cookie-redirect	68547ce3-6e06-4390-a3d3-3f5eaafa1583	e9f49562-597a-4481-a8e2-380b99f3be47	0	10	f	\N	\N
118157ce-c5d8-4ee9-9527-db218861c9fe	\N	\N	68547ce3-6e06-4390-a3d3-3f5eaafa1583	e9f49562-597a-4481-a8e2-380b99f3be47	0	20	t	ee693d05-310c-48ac-a747-838f7e42eba4	\N
fa3ab00a-743c-4c90-93a1-6dd423f78ccd	\N	basic-auth	68547ce3-6e06-4390-a3d3-3f5eaafa1583	ee693d05-310c-48ac-a747-838f7e42eba4	0	10	f	\N	\N
4cd5ad37-f849-42d9-a736-987c186f67d8	\N	basic-auth-otp	68547ce3-6e06-4390-a3d3-3f5eaafa1583	ee693d05-310c-48ac-a747-838f7e42eba4	3	20	f	\N	\N
a6ea6efc-31c9-45df-aa59-06a943e6cdf1	\N	auth-spnego	68547ce3-6e06-4390-a3d3-3f5eaafa1583	ee693d05-310c-48ac-a747-838f7e42eba4	3	30	f	\N	\N
cc686a4d-e947-4a5e-be40-10565dbc0ce2	\N	idp-email-verification	market	638a1c97-a043-4858-adf7-63033439eb76	2	10	f	\N	\N
983b8389-7bd9-40bf-9598-70d1b1b79e4d	\N	\N	market	638a1c97-a043-4858-adf7-63033439eb76	2	20	t	13c8bd61-3794-4329-8bad-36574ba5b539	\N
e5407280-fd58-4444-bcf1-4250807224e6	\N	basic-auth	market	3a8d4ce3-a196-4b2d-afcc-4302d63f36de	0	10	f	\N	\N
6602d63a-fd4b-4f30-af77-24824aa57070	\N	basic-auth-otp	market	3a8d4ce3-a196-4b2d-afcc-4302d63f36de	3	20	f	\N	\N
21d07a26-2df3-4c1c-ab6c-fc2787e35cd6	\N	auth-spnego	market	3a8d4ce3-a196-4b2d-afcc-4302d63f36de	3	30	f	\N	\N
35570edb-18fa-4fba-9689-d818776005f4	\N	conditional-user-configured	market	885a0c79-c1b5-47c7-ae10-74b2a4884b41	0	10	f	\N	\N
f0f05ff9-3282-43c4-acf9-110f9afa6c03	\N	auth-otp-form	market	885a0c79-c1b5-47c7-ae10-74b2a4884b41	0	20	f	\N	\N
65550399-572d-41e9-91fc-d29067c2c780	\N	conditional-user-configured	market	4daa1e5e-59aa-49bc-aacb-f9d236dc4229	0	10	f	\N	\N
94de38a0-d095-47c8-b933-265e454298a4	\N	direct-grant-validate-otp	market	4daa1e5e-59aa-49bc-aacb-f9d236dc4229	0	20	f	\N	\N
90b8d606-58d0-4cd8-ac59-c3590be1f22c	\N	conditional-user-configured	market	94f70a68-6cff-46e6-ba67-bb7bb5b5f145	0	10	f	\N	\N
81493c66-8e6c-41c2-b5ec-28a3606aa843	\N	auth-otp-form	market	94f70a68-6cff-46e6-ba67-bb7bb5b5f145	0	20	f	\N	\N
481cabb2-53cd-4b45-9caf-60c31a19a891	\N	idp-confirm-link	market	fadd86ad-3947-4580-93fd-59fa91bd6e28	0	10	f	\N	\N
d80dd014-4db4-4cec-9a36-d848a09b40bb	\N	\N	market	fadd86ad-3947-4580-93fd-59fa91bd6e28	0	20	t	638a1c97-a043-4858-adf7-63033439eb76	\N
4a9b5a97-ab14-4126-a67e-a368163eb987	\N	conditional-user-configured	market	58839284-0c12-44c3-ba07-f45a11e68d4f	0	10	f	\N	\N
2813edfe-de52-49f2-bf4c-fb45b7b5dfec	\N	reset-otp	market	58839284-0c12-44c3-ba07-f45a11e68d4f	0	20	f	\N	\N
a32534d9-157c-4208-a730-3f738f2d3761	\N	idp-create-user-if-unique	market	6c37c950-2502-4e0a-a232-324656d59a4c	2	10	f	\N	c99851ba-63d2-498a-b64e-914fb1003b34
9c7b4565-bfec-4c70-b2d8-8252557701f6	\N	\N	market	6c37c950-2502-4e0a-a232-324656d59a4c	2	20	t	fadd86ad-3947-4580-93fd-59fa91bd6e28	\N
79e88c9c-8604-4529-80bd-698c4a7e45b3	\N	idp-username-password-form	market	13c8bd61-3794-4329-8bad-36574ba5b539	0	10	f	\N	\N
41100ef4-a63e-4d39-ab09-87cdcb641f7b	\N	\N	market	13c8bd61-3794-4329-8bad-36574ba5b539	1	20	t	94f70a68-6cff-46e6-ba67-bb7bb5b5f145	\N
b257b9c2-78c5-4e5a-bdcd-9063b76df433	\N	auth-cookie	market	a4853b54-14b8-49cb-a551-665e551228c6	2	10	f	\N	\N
c855b27a-c58a-4157-8232-d138d09e241b	\N	auth-spnego	market	a4853b54-14b8-49cb-a551-665e551228c6	3	20	f	\N	\N
f810a45f-cc79-4671-b8de-8165181efc62	\N	identity-provider-redirector	market	a4853b54-14b8-49cb-a551-665e551228c6	2	25	f	\N	\N
0c4494a9-13d5-49b5-9695-517c7c7bc101	\N	\N	market	a4853b54-14b8-49cb-a551-665e551228c6	2	30	t	32963572-a496-4d2c-9e58-43346e6a62a7	\N
e32d83cd-1712-42ee-ae1f-05700e6d92ee	\N	client-secret	market	23362d0f-da70-430b-a893-1aec95a4eb96	2	10	f	\N	\N
70b842da-3120-4fe7-97ac-af40a01487cd	\N	client-jwt	market	23362d0f-da70-430b-a893-1aec95a4eb96	2	20	f	\N	\N
5f62efcf-851a-4f18-bbec-5d8ab0dd9fff	\N	client-secret-jwt	market	23362d0f-da70-430b-a893-1aec95a4eb96	2	30	f	\N	\N
61696809-3694-4c78-90b9-00f0d79837fc	\N	client-x509	market	23362d0f-da70-430b-a893-1aec95a4eb96	2	40	f	\N	\N
87da1e19-7d35-4fa2-84a0-add168efc185	\N	direct-grant-validate-username	market	059401de-42fd-43d0-ab19-c78c33a0ee7a	0	10	f	\N	\N
d4761a57-8e06-4688-8e05-035517dca6f4	\N	direct-grant-validate-password	market	059401de-42fd-43d0-ab19-c78c33a0ee7a	0	20	f	\N	\N
ae3622b6-f7f9-428d-9ec2-e9f5a4af0f23	\N	\N	market	059401de-42fd-43d0-ab19-c78c33a0ee7a	1	30	t	4daa1e5e-59aa-49bc-aacb-f9d236dc4229	\N
c2113c93-3e18-417e-8466-dbe753bf37f8	\N	docker-http-basic-authenticator	market	56f3d745-c96e-424e-ad6d-27664cf4d985	0	10	f	\N	\N
e9e16728-4083-4c00-bf64-f7a43a679021	\N	idp-review-profile	market	895b2a55-bcb2-424d-b59e-d43ee1004b6d	0	10	f	\N	8ba10f5f-1cbd-418a-909e-18be802bd89c
5c2800c2-6328-40c0-86a4-4d72c975b370	\N	\N	market	895b2a55-bcb2-424d-b59e-d43ee1004b6d	0	20	t	6c37c950-2502-4e0a-a232-324656d59a4c	\N
e04ece6f-969b-4812-9b0a-3228bc135225	\N	auth-username-password-form	market	32963572-a496-4d2c-9e58-43346e6a62a7	0	10	f	\N	\N
04e47514-eec1-4ad8-90ed-3b7a9661f647	\N	\N	market	32963572-a496-4d2c-9e58-43346e6a62a7	1	20	t	885a0c79-c1b5-47c7-ae10-74b2a4884b41	\N
67b1d7ac-511e-4b65-bebb-45f31e362941	\N	no-cookie-redirect	market	42749845-fcc0-45de-aecb-22980bbd831f	0	10	f	\N	\N
86cc44c3-b8d5-40f3-915b-44453412221d	\N	\N	market	42749845-fcc0-45de-aecb-22980bbd831f	0	20	t	3a8d4ce3-a196-4b2d-afcc-4302d63f36de	\N
78335544-b160-45a9-9a32-1ae5efa75b0e	\N	registration-page-form	market	b94d42e9-bda5-4e7e-876a-399bc8d57325	0	10	t	2de2f644-6d75-46fe-a4b4-5f74f21b7747	\N
7abdf295-bd95-4083-9cac-71aa67b6dd11	\N	registration-user-creation	market	2de2f644-6d75-46fe-a4b4-5f74f21b7747	0	20	f	\N	\N
4ed01cc7-a101-41e9-a98f-291c152339cf	\N	registration-profile-action	market	2de2f644-6d75-46fe-a4b4-5f74f21b7747	0	40	f	\N	\N
df7f901e-309b-443b-96a0-a2cdbe092c1c	\N	registration-password-action	market	2de2f644-6d75-46fe-a4b4-5f74f21b7747	0	50	f	\N	\N
5612e987-bfae-4299-9056-571e2fb7feb4	\N	registration-recaptcha-action	market	2de2f644-6d75-46fe-a4b4-5f74f21b7747	3	60	f	\N	\N
fa9d0792-2027-466f-996a-ca40843cb490	\N	reset-credentials-choose-user	market	41830241-b538-4106-83e1-e3b89fa74973	0	10	f	\N	\N
381715be-e9b9-46ad-8ec7-d531474320bc	\N	reset-credential-email	market	41830241-b538-4106-83e1-e3b89fa74973	0	20	f	\N	\N
1df8f734-53b7-4653-a25d-1f57d79bc15a	\N	reset-password	market	41830241-b538-4106-83e1-e3b89fa74973	0	30	f	\N	\N
af241d04-e50f-43df-8950-a302192efbd6	\N	\N	market	41830241-b538-4106-83e1-e3b89fa74973	1	40	t	58839284-0c12-44c3-ba07-f45a11e68d4f	\N
401aacc4-70d7-4f8a-b1b7-d35f2e3dc514	\N	http-basic-authenticator	market	0021e259-182f-4fce-bc48-6d88a8e940c0	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
8c887b64-15ec-4df3-8cf0-dad03d379acd	browser	browser based authentication	68547ce3-6e06-4390-a3d3-3f5eaafa1583	basic-flow	t	t
df2e15fb-3ba2-4fda-96f9-1e688ca9199e	forms	Username, password, otp and other auth forms.	68547ce3-6e06-4390-a3d3-3f5eaafa1583	basic-flow	f	t
24263967-26c2-47d1-af69-0c2af2bb792b	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	68547ce3-6e06-4390-a3d3-3f5eaafa1583	basic-flow	f	t
3954b6f1-5f92-4097-9202-b55d678e2942	direct grant	OpenID Connect Resource Owner Grant	68547ce3-6e06-4390-a3d3-3f5eaafa1583	basic-flow	t	t
c553c971-6a6b-440d-bb64-e7469df62eef	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	68547ce3-6e06-4390-a3d3-3f5eaafa1583	basic-flow	f	t
059d1146-8128-4133-8303-1f9d4a2a0014	registration	registration flow	68547ce3-6e06-4390-a3d3-3f5eaafa1583	basic-flow	t	t
b1f0aad2-62d6-4445-9ec6-dcfd17a65e3a	registration form	registration form	68547ce3-6e06-4390-a3d3-3f5eaafa1583	form-flow	f	t
4510dda2-46fa-4174-88c6-a71f0347810a	reset credentials	Reset credentials for a user if they forgot their password or something	68547ce3-6e06-4390-a3d3-3f5eaafa1583	basic-flow	t	t
e3bdd932-a52c-4d66-add6-6f64197e632b	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	68547ce3-6e06-4390-a3d3-3f5eaafa1583	basic-flow	f	t
2a314916-4add-4e20-8cf0-8ee8483ada35	clients	Base authentication for clients	68547ce3-6e06-4390-a3d3-3f5eaafa1583	client-flow	t	t
53c39822-4550-4abc-bf22-fcab381a702b	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	68547ce3-6e06-4390-a3d3-3f5eaafa1583	basic-flow	t	t
d4e07a4e-f5cb-444b-97a2-260f016aee9f	User creation or linking	Flow for the existing/non-existing user alternatives	68547ce3-6e06-4390-a3d3-3f5eaafa1583	basic-flow	f	t
408a233f-b529-4bdd-b9a8-1c094d2990bf	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	68547ce3-6e06-4390-a3d3-3f5eaafa1583	basic-flow	f	t
2a4da5a5-05b9-435b-9994-bd0d2f8d5368	Account verification options	Method with which to verity the existing account	68547ce3-6e06-4390-a3d3-3f5eaafa1583	basic-flow	f	t
7b2aa57f-67c4-4297-8612-a5ec9e02ddce	Verify Existing Account by Re-authentication	Reauthentication of existing account	68547ce3-6e06-4390-a3d3-3f5eaafa1583	basic-flow	f	t
b3b40715-073b-482e-9c54-38b183036667	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	68547ce3-6e06-4390-a3d3-3f5eaafa1583	basic-flow	f	t
8622f9cf-20e7-4d7b-bfd2-125095ee56e6	saml ecp	SAML ECP Profile Authentication Flow	68547ce3-6e06-4390-a3d3-3f5eaafa1583	basic-flow	t	t
4245100b-efc8-490e-b954-0ac61c9693cf	docker auth	Used by Docker clients to authenticate against the IDP	68547ce3-6e06-4390-a3d3-3f5eaafa1583	basic-flow	t	t
e9f49562-597a-4481-a8e2-380b99f3be47	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	68547ce3-6e06-4390-a3d3-3f5eaafa1583	basic-flow	t	t
ee693d05-310c-48ac-a747-838f7e42eba4	Authentication Options	Authentication options.	68547ce3-6e06-4390-a3d3-3f5eaafa1583	basic-flow	f	t
638a1c97-a043-4858-adf7-63033439eb76	Account verification options	Method with which to verity the existing account	market	basic-flow	f	t
3a8d4ce3-a196-4b2d-afcc-4302d63f36de	Authentication Options	Authentication options.	market	basic-flow	f	t
885a0c79-c1b5-47c7-ae10-74b2a4884b41	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	market	basic-flow	f	t
4daa1e5e-59aa-49bc-aacb-f9d236dc4229	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	market	basic-flow	f	t
94f70a68-6cff-46e6-ba67-bb7bb5b5f145	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	market	basic-flow	f	t
fadd86ad-3947-4580-93fd-59fa91bd6e28	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	market	basic-flow	f	t
58839284-0c12-44c3-ba07-f45a11e68d4f	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	market	basic-flow	f	t
6c37c950-2502-4e0a-a232-324656d59a4c	User creation or linking	Flow for the existing/non-existing user alternatives	market	basic-flow	f	t
13c8bd61-3794-4329-8bad-36574ba5b539	Verify Existing Account by Re-authentication	Reauthentication of existing account	market	basic-flow	f	t
a4853b54-14b8-49cb-a551-665e551228c6	browser	browser based authentication	market	basic-flow	t	t
23362d0f-da70-430b-a893-1aec95a4eb96	clients	Base authentication for clients	market	client-flow	t	t
059401de-42fd-43d0-ab19-c78c33a0ee7a	direct grant	OpenID Connect Resource Owner Grant	market	basic-flow	t	t
56f3d745-c96e-424e-ad6d-27664cf4d985	docker auth	Used by Docker clients to authenticate against the IDP	market	basic-flow	t	t
895b2a55-bcb2-424d-b59e-d43ee1004b6d	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	market	basic-flow	t	t
32963572-a496-4d2c-9e58-43346e6a62a7	forms	Username, password, otp and other auth forms.	market	basic-flow	f	t
42749845-fcc0-45de-aecb-22980bbd831f	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	market	basic-flow	t	t
b94d42e9-bda5-4e7e-876a-399bc8d57325	registration	registration flow	market	basic-flow	t	t
2de2f644-6d75-46fe-a4b4-5f74f21b7747	registration form	registration form	market	form-flow	f	t
41830241-b538-4106-83e1-e3b89fa74973	reset credentials	Reset credentials for a user if they forgot their password or something	market	basic-flow	t	t
0021e259-182f-4fce-bc48-6d88a8e940c0	saml ecp	SAML ECP Profile Authentication Flow	market	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
d10ca1b0-0d7d-4ee4-bc02-4d44de6445c6	review profile config	68547ce3-6e06-4390-a3d3-3f5eaafa1583
aa6d0334-c251-4a80-9e63-957fb829e84a	create unique user config	68547ce3-6e06-4390-a3d3-3f5eaafa1583
c99851ba-63d2-498a-b64e-914fb1003b34	create unique user config	market
8ba10f5f-1cbd-418a-909e-18be802bd89c	review profile config	market
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
d10ca1b0-0d7d-4ee4-bc02-4d44de6445c6	missing	update.profile.on.first.login
aa6d0334-c251-4a80-9e63-957fb829e84a	false	require.password.update.after.registration
c99851ba-63d2-498a-b64e-914fb1003b34	false	require.password.update.after.registration
8ba10f5f-1cbd-418a-909e-18be802bd89c	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
5418fcfc-96e5-419c-b7d2-911371b10bea	t	f	master-realm	0	f	\N	\N	t	\N	f	68547ce3-6e06-4390-a3d3-3f5eaafa1583	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
f794cd96-d496-4132-80e9-a4811508d5f4	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	68547ce3-6e06-4390-a3d3-3f5eaafa1583	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
3e40bc9a-7869-4df6-9598-4dbc88af9db0	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	68547ce3-6e06-4390-a3d3-3f5eaafa1583	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
d0785922-7d8d-44b3-9460-7f16617f3bbe	t	f	broker	0	f	\N	\N	t	\N	f	68547ce3-6e06-4390-a3d3-3f5eaafa1583	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
3a8a34ee-4f56-4de8-a61a-cb40205b6af9	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	68547ce3-6e06-4390-a3d3-3f5eaafa1583	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
f41302da-16e6-4c1c-88c4-7c791d7d8643	t	f	admin-cli	0	t	\N	\N	f	\N	f	68547ce3-6e06-4390-a3d3-3f5eaafa1583	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
f7a0a240-d1dd-469c-8e9e-f80cc62f409d	t	f	market-realm	0	f	\N	\N	t	\N	f	68547ce3-6e06-4390-a3d3-3f5eaafa1583	\N	0	f	f	market Realm	f	client-secret	\N	\N	\N	t	f	f	f
1a43c414-0d56-4b63-81c3-d645db8ca3e4	t	f	account	0	t	\N	/realms/market/account/	f	\N	f	market	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
62552ade-38be-4219-8acc-e7fcbd6d3286	t	f	account-console	0	t	\N	/realms/market/account/	f	\N	f	market	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
6cf058f8-2e87-45d1-b55a-653e963b6090	t	f	admin-cli	0	t	\N	\N	f	\N	f	market	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
8c477d16-fd00-4245-bad2-d59e6134cf7b	t	f	broker	0	f	\N	\N	t	\N	f	market	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
d3450ecb-384a-4770-ab8d-30659adf7373	t	f	realm-management	0	f	\N	\N	t	\N	f	market	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
bf40a050-cc4a-4e5b-9089-6aaefb033e20	t	f	security-admin-console	0	t	\N	/admin/market/console/	f	\N	f	market	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
66329f4e-8fc4-4053-af79-ad673fd69478	t	t	market-backend	0	f	Nv6qcOAnxtX8TlvtZ0A2sKQhrbxDr56H	\N	f	\N	f	market	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	f	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
3e40bc9a-7869-4df6-9598-4dbc88af9db0	S256	pkce.code.challenge.method
3a8a34ee-4f56-4de8-a61a-cb40205b6af9	S256	pkce.code.challenge.method
62552ade-38be-4219-8acc-e7fcbd6d3286	S256	pkce.code.challenge.method
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.multivalued.roles
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.force.post.binding
66329f4e-8fc4-4053-af79-ad673fd69478	false	frontchannel.logout.session.required
66329f4e-8fc4-4053-af79-ad673fd69478	false	oauth2.device.authorization.grant.enabled
66329f4e-8fc4-4053-af79-ad673fd69478	false	backchannel.logout.revoke.offline.tokens
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.server.signature.keyinfo.ext
66329f4e-8fc4-4053-af79-ad673fd69478	true	use.refresh.tokens
66329f4e-8fc4-4053-af79-ad673fd69478	false	oidc.ciba.grant.enabled
66329f4e-8fc4-4053-af79-ad673fd69478	true	backchannel.logout.session.required
66329f4e-8fc4-4053-af79-ad673fd69478	false	client_credentials.use_refresh_token
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.client.signature
66329f4e-8fc4-4053-af79-ad673fd69478	false	require.pushed.authorization.requests
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.allow.ecp.flow
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.assertion.signature
66329f4e-8fc4-4053-af79-ad673fd69478	false	id.token.as.detached.signature
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.encrypt
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.server.signature
66329f4e-8fc4-4053-af79-ad673fd69478	false	exclude.session.state.from.auth.response
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.artifact.binding
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml_force_name_id_format
66329f4e-8fc4-4053-af79-ad673fd69478	false	tls.client.certificate.bound.access.tokens
66329f4e-8fc4-4053-af79-ad673fd69478	{}	acr.loa.map
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.authnstatement
66329f4e-8fc4-4053-af79-ad673fd69478	false	display.on.consent.screen
66329f4e-8fc4-4053-af79-ad673fd69478	false	token.response.type.bearer.lower-case
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.onetimeuse.condition
bf40a050-cc4a-4e5b-9089-6aaefb033e20	S256	pkce.code.challenge.method
66329f4e-8fc4-4053-af79-ad673fd69478	1655636779	client.secret.creation.time
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
dde3e3b5-1efb-4d3c-ad1d-acfa6665b583	offline_access	68547ce3-6e06-4390-a3d3-3f5eaafa1583	OpenID Connect built-in scope: offline_access	openid-connect
d0d3a2d1-9102-4bb7-a94a-05d7fb861237	role_list	68547ce3-6e06-4390-a3d3-3f5eaafa1583	SAML role list	saml
9dc2f965-7008-4356-89fa-d880a753bdb9	profile	68547ce3-6e06-4390-a3d3-3f5eaafa1583	OpenID Connect built-in scope: profile	openid-connect
beb5e2ad-2fd6-451b-8fae-82547bcb2327	email	68547ce3-6e06-4390-a3d3-3f5eaafa1583	OpenID Connect built-in scope: email	openid-connect
bc8bb6c2-fa14-4580-bfae-a79a7591302c	address	68547ce3-6e06-4390-a3d3-3f5eaafa1583	OpenID Connect built-in scope: address	openid-connect
2972fc4d-cb8b-447a-a490-f80203fd4284	phone	68547ce3-6e06-4390-a3d3-3f5eaafa1583	OpenID Connect built-in scope: phone	openid-connect
4fe67e1f-9b81-4d83-bc47-3825942df3df	roles	68547ce3-6e06-4390-a3d3-3f5eaafa1583	OpenID Connect scope for add user roles to the access token	openid-connect
94efff6f-c7b1-40d3-811f-ea07e0a10517	web-origins	68547ce3-6e06-4390-a3d3-3f5eaafa1583	OpenID Connect scope for add allowed web origins to the access token	openid-connect
083098cd-8e40-4979-a160-608fae61656a	microprofile-jwt	68547ce3-6e06-4390-a3d3-3f5eaafa1583	Microprofile - JWT built-in scope	openid-connect
22d11a31-792b-4ba4-b1bc-620e3974afef	acr	68547ce3-6e06-4390-a3d3-3f5eaafa1583	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
0db1b3ef-62aa-46f9-82d5-b5072649c79e	role_list	market	SAML role list	saml
1ac1e7b3-e35c-49d9-aa38-d1d6fbbac6f5	web-origins	market	OpenID Connect scope for add allowed web origins to the access token	openid-connect
e3c0c50d-beea-4cfa-ad0d-bb34d8fda575	microprofile-jwt	market	Microprofile - JWT built-in scope	openid-connect
e142d712-3271-430d-8bea-681a6bc6fa1a	phone	market	OpenID Connect built-in scope: phone	openid-connect
9182e1f8-2f08-4749-b56d-86db33ca9930	address	market	OpenID Connect built-in scope: address	openid-connect
2bda4696-f2c5-421a-a638-d53fca562ea6	roles	market	OpenID Connect scope for add user roles to the access token	openid-connect
d21fee02-7810-4fe8-95c6-8662b3c6d01b	acr	market	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
fc9062a7-ce90-4f36-90c7-07bacc64f969	profile	market	OpenID Connect built-in scope: profile	openid-connect
695824ed-e61b-4d93-b780-5e956e811dc9	offline_access	market	OpenID Connect built-in scope: offline_access	openid-connect
8730910e-2c6a-4e8f-88d5-8d6e700dbe43	email	market	OpenID Connect built-in scope: email	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
dde3e3b5-1efb-4d3c-ad1d-acfa6665b583	true	display.on.consent.screen
dde3e3b5-1efb-4d3c-ad1d-acfa6665b583	${offlineAccessScopeConsentText}	consent.screen.text
d0d3a2d1-9102-4bb7-a94a-05d7fb861237	true	display.on.consent.screen
d0d3a2d1-9102-4bb7-a94a-05d7fb861237	${samlRoleListScopeConsentText}	consent.screen.text
9dc2f965-7008-4356-89fa-d880a753bdb9	true	display.on.consent.screen
9dc2f965-7008-4356-89fa-d880a753bdb9	${profileScopeConsentText}	consent.screen.text
9dc2f965-7008-4356-89fa-d880a753bdb9	true	include.in.token.scope
beb5e2ad-2fd6-451b-8fae-82547bcb2327	true	display.on.consent.screen
beb5e2ad-2fd6-451b-8fae-82547bcb2327	${emailScopeConsentText}	consent.screen.text
beb5e2ad-2fd6-451b-8fae-82547bcb2327	true	include.in.token.scope
bc8bb6c2-fa14-4580-bfae-a79a7591302c	true	display.on.consent.screen
bc8bb6c2-fa14-4580-bfae-a79a7591302c	${addressScopeConsentText}	consent.screen.text
bc8bb6c2-fa14-4580-bfae-a79a7591302c	true	include.in.token.scope
2972fc4d-cb8b-447a-a490-f80203fd4284	true	display.on.consent.screen
2972fc4d-cb8b-447a-a490-f80203fd4284	${phoneScopeConsentText}	consent.screen.text
2972fc4d-cb8b-447a-a490-f80203fd4284	true	include.in.token.scope
4fe67e1f-9b81-4d83-bc47-3825942df3df	true	display.on.consent.screen
4fe67e1f-9b81-4d83-bc47-3825942df3df	${rolesScopeConsentText}	consent.screen.text
4fe67e1f-9b81-4d83-bc47-3825942df3df	false	include.in.token.scope
94efff6f-c7b1-40d3-811f-ea07e0a10517	false	display.on.consent.screen
94efff6f-c7b1-40d3-811f-ea07e0a10517		consent.screen.text
94efff6f-c7b1-40d3-811f-ea07e0a10517	false	include.in.token.scope
083098cd-8e40-4979-a160-608fae61656a	false	display.on.consent.screen
083098cd-8e40-4979-a160-608fae61656a	true	include.in.token.scope
22d11a31-792b-4ba4-b1bc-620e3974afef	false	display.on.consent.screen
22d11a31-792b-4ba4-b1bc-620e3974afef	false	include.in.token.scope
0db1b3ef-62aa-46f9-82d5-b5072649c79e	${samlRoleListScopeConsentText}	consent.screen.text
0db1b3ef-62aa-46f9-82d5-b5072649c79e	true	display.on.consent.screen
1ac1e7b3-e35c-49d9-aa38-d1d6fbbac6f5	false	include.in.token.scope
1ac1e7b3-e35c-49d9-aa38-d1d6fbbac6f5	false	display.on.consent.screen
1ac1e7b3-e35c-49d9-aa38-d1d6fbbac6f5		consent.screen.text
e3c0c50d-beea-4cfa-ad0d-bb34d8fda575	true	include.in.token.scope
e3c0c50d-beea-4cfa-ad0d-bb34d8fda575	false	display.on.consent.screen
e142d712-3271-430d-8bea-681a6bc6fa1a	true	include.in.token.scope
e142d712-3271-430d-8bea-681a6bc6fa1a	true	display.on.consent.screen
e142d712-3271-430d-8bea-681a6bc6fa1a	${phoneScopeConsentText}	consent.screen.text
9182e1f8-2f08-4749-b56d-86db33ca9930	true	include.in.token.scope
9182e1f8-2f08-4749-b56d-86db33ca9930	true	display.on.consent.screen
9182e1f8-2f08-4749-b56d-86db33ca9930	${addressScopeConsentText}	consent.screen.text
2bda4696-f2c5-421a-a638-d53fca562ea6	false	include.in.token.scope
2bda4696-f2c5-421a-a638-d53fca562ea6	true	display.on.consent.screen
2bda4696-f2c5-421a-a638-d53fca562ea6	${rolesScopeConsentText}	consent.screen.text
d21fee02-7810-4fe8-95c6-8662b3c6d01b	false	include.in.token.scope
d21fee02-7810-4fe8-95c6-8662b3c6d01b	false	display.on.consent.screen
fc9062a7-ce90-4f36-90c7-07bacc64f969	true	include.in.token.scope
fc9062a7-ce90-4f36-90c7-07bacc64f969	true	display.on.consent.screen
fc9062a7-ce90-4f36-90c7-07bacc64f969	${profileScopeConsentText}	consent.screen.text
695824ed-e61b-4d93-b780-5e956e811dc9	${offlineAccessScopeConsentText}	consent.screen.text
695824ed-e61b-4d93-b780-5e956e811dc9	true	display.on.consent.screen
8730910e-2c6a-4e8f-88d5-8d6e700dbe43	true	include.in.token.scope
8730910e-2c6a-4e8f-88d5-8d6e700dbe43	true	display.on.consent.screen
8730910e-2c6a-4e8f-88d5-8d6e700dbe43	${emailScopeConsentText}	consent.screen.text
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
f794cd96-d496-4132-80e9-a4811508d5f4	22d11a31-792b-4ba4-b1bc-620e3974afef	t
f794cd96-d496-4132-80e9-a4811508d5f4	beb5e2ad-2fd6-451b-8fae-82547bcb2327	t
f794cd96-d496-4132-80e9-a4811508d5f4	4fe67e1f-9b81-4d83-bc47-3825942df3df	t
f794cd96-d496-4132-80e9-a4811508d5f4	94efff6f-c7b1-40d3-811f-ea07e0a10517	t
f794cd96-d496-4132-80e9-a4811508d5f4	9dc2f965-7008-4356-89fa-d880a753bdb9	t
f794cd96-d496-4132-80e9-a4811508d5f4	bc8bb6c2-fa14-4580-bfae-a79a7591302c	f
f794cd96-d496-4132-80e9-a4811508d5f4	2972fc4d-cb8b-447a-a490-f80203fd4284	f
f794cd96-d496-4132-80e9-a4811508d5f4	dde3e3b5-1efb-4d3c-ad1d-acfa6665b583	f
f794cd96-d496-4132-80e9-a4811508d5f4	083098cd-8e40-4979-a160-608fae61656a	f
3e40bc9a-7869-4df6-9598-4dbc88af9db0	22d11a31-792b-4ba4-b1bc-620e3974afef	t
3e40bc9a-7869-4df6-9598-4dbc88af9db0	beb5e2ad-2fd6-451b-8fae-82547bcb2327	t
3e40bc9a-7869-4df6-9598-4dbc88af9db0	4fe67e1f-9b81-4d83-bc47-3825942df3df	t
3e40bc9a-7869-4df6-9598-4dbc88af9db0	94efff6f-c7b1-40d3-811f-ea07e0a10517	t
3e40bc9a-7869-4df6-9598-4dbc88af9db0	9dc2f965-7008-4356-89fa-d880a753bdb9	t
3e40bc9a-7869-4df6-9598-4dbc88af9db0	bc8bb6c2-fa14-4580-bfae-a79a7591302c	f
3e40bc9a-7869-4df6-9598-4dbc88af9db0	2972fc4d-cb8b-447a-a490-f80203fd4284	f
3e40bc9a-7869-4df6-9598-4dbc88af9db0	dde3e3b5-1efb-4d3c-ad1d-acfa6665b583	f
3e40bc9a-7869-4df6-9598-4dbc88af9db0	083098cd-8e40-4979-a160-608fae61656a	f
f41302da-16e6-4c1c-88c4-7c791d7d8643	22d11a31-792b-4ba4-b1bc-620e3974afef	t
f41302da-16e6-4c1c-88c4-7c791d7d8643	beb5e2ad-2fd6-451b-8fae-82547bcb2327	t
f41302da-16e6-4c1c-88c4-7c791d7d8643	4fe67e1f-9b81-4d83-bc47-3825942df3df	t
f41302da-16e6-4c1c-88c4-7c791d7d8643	94efff6f-c7b1-40d3-811f-ea07e0a10517	t
f41302da-16e6-4c1c-88c4-7c791d7d8643	9dc2f965-7008-4356-89fa-d880a753bdb9	t
f41302da-16e6-4c1c-88c4-7c791d7d8643	bc8bb6c2-fa14-4580-bfae-a79a7591302c	f
f41302da-16e6-4c1c-88c4-7c791d7d8643	2972fc4d-cb8b-447a-a490-f80203fd4284	f
f41302da-16e6-4c1c-88c4-7c791d7d8643	dde3e3b5-1efb-4d3c-ad1d-acfa6665b583	f
f41302da-16e6-4c1c-88c4-7c791d7d8643	083098cd-8e40-4979-a160-608fae61656a	f
d0785922-7d8d-44b3-9460-7f16617f3bbe	22d11a31-792b-4ba4-b1bc-620e3974afef	t
d0785922-7d8d-44b3-9460-7f16617f3bbe	beb5e2ad-2fd6-451b-8fae-82547bcb2327	t
d0785922-7d8d-44b3-9460-7f16617f3bbe	4fe67e1f-9b81-4d83-bc47-3825942df3df	t
d0785922-7d8d-44b3-9460-7f16617f3bbe	94efff6f-c7b1-40d3-811f-ea07e0a10517	t
d0785922-7d8d-44b3-9460-7f16617f3bbe	9dc2f965-7008-4356-89fa-d880a753bdb9	t
d0785922-7d8d-44b3-9460-7f16617f3bbe	bc8bb6c2-fa14-4580-bfae-a79a7591302c	f
d0785922-7d8d-44b3-9460-7f16617f3bbe	2972fc4d-cb8b-447a-a490-f80203fd4284	f
d0785922-7d8d-44b3-9460-7f16617f3bbe	dde3e3b5-1efb-4d3c-ad1d-acfa6665b583	f
d0785922-7d8d-44b3-9460-7f16617f3bbe	083098cd-8e40-4979-a160-608fae61656a	f
5418fcfc-96e5-419c-b7d2-911371b10bea	22d11a31-792b-4ba4-b1bc-620e3974afef	t
5418fcfc-96e5-419c-b7d2-911371b10bea	beb5e2ad-2fd6-451b-8fae-82547bcb2327	t
5418fcfc-96e5-419c-b7d2-911371b10bea	4fe67e1f-9b81-4d83-bc47-3825942df3df	t
5418fcfc-96e5-419c-b7d2-911371b10bea	94efff6f-c7b1-40d3-811f-ea07e0a10517	t
5418fcfc-96e5-419c-b7d2-911371b10bea	9dc2f965-7008-4356-89fa-d880a753bdb9	t
5418fcfc-96e5-419c-b7d2-911371b10bea	bc8bb6c2-fa14-4580-bfae-a79a7591302c	f
5418fcfc-96e5-419c-b7d2-911371b10bea	2972fc4d-cb8b-447a-a490-f80203fd4284	f
5418fcfc-96e5-419c-b7d2-911371b10bea	dde3e3b5-1efb-4d3c-ad1d-acfa6665b583	f
5418fcfc-96e5-419c-b7d2-911371b10bea	083098cd-8e40-4979-a160-608fae61656a	f
3a8a34ee-4f56-4de8-a61a-cb40205b6af9	22d11a31-792b-4ba4-b1bc-620e3974afef	t
3a8a34ee-4f56-4de8-a61a-cb40205b6af9	beb5e2ad-2fd6-451b-8fae-82547bcb2327	t
3a8a34ee-4f56-4de8-a61a-cb40205b6af9	4fe67e1f-9b81-4d83-bc47-3825942df3df	t
3a8a34ee-4f56-4de8-a61a-cb40205b6af9	94efff6f-c7b1-40d3-811f-ea07e0a10517	t
3a8a34ee-4f56-4de8-a61a-cb40205b6af9	9dc2f965-7008-4356-89fa-d880a753bdb9	t
3a8a34ee-4f56-4de8-a61a-cb40205b6af9	bc8bb6c2-fa14-4580-bfae-a79a7591302c	f
3a8a34ee-4f56-4de8-a61a-cb40205b6af9	2972fc4d-cb8b-447a-a490-f80203fd4284	f
3a8a34ee-4f56-4de8-a61a-cb40205b6af9	dde3e3b5-1efb-4d3c-ad1d-acfa6665b583	f
3a8a34ee-4f56-4de8-a61a-cb40205b6af9	083098cd-8e40-4979-a160-608fae61656a	f
1a43c414-0d56-4b63-81c3-d645db8ca3e4	1ac1e7b3-e35c-49d9-aa38-d1d6fbbac6f5	t
1a43c414-0d56-4b63-81c3-d645db8ca3e4	d21fee02-7810-4fe8-95c6-8662b3c6d01b	t
1a43c414-0d56-4b63-81c3-d645db8ca3e4	2bda4696-f2c5-421a-a638-d53fca562ea6	t
1a43c414-0d56-4b63-81c3-d645db8ca3e4	fc9062a7-ce90-4f36-90c7-07bacc64f969	t
1a43c414-0d56-4b63-81c3-d645db8ca3e4	8730910e-2c6a-4e8f-88d5-8d6e700dbe43	t
1a43c414-0d56-4b63-81c3-d645db8ca3e4	9182e1f8-2f08-4749-b56d-86db33ca9930	f
1a43c414-0d56-4b63-81c3-d645db8ca3e4	e142d712-3271-430d-8bea-681a6bc6fa1a	f
1a43c414-0d56-4b63-81c3-d645db8ca3e4	695824ed-e61b-4d93-b780-5e956e811dc9	f
1a43c414-0d56-4b63-81c3-d645db8ca3e4	e3c0c50d-beea-4cfa-ad0d-bb34d8fda575	f
62552ade-38be-4219-8acc-e7fcbd6d3286	1ac1e7b3-e35c-49d9-aa38-d1d6fbbac6f5	t
62552ade-38be-4219-8acc-e7fcbd6d3286	d21fee02-7810-4fe8-95c6-8662b3c6d01b	t
62552ade-38be-4219-8acc-e7fcbd6d3286	2bda4696-f2c5-421a-a638-d53fca562ea6	t
62552ade-38be-4219-8acc-e7fcbd6d3286	fc9062a7-ce90-4f36-90c7-07bacc64f969	t
62552ade-38be-4219-8acc-e7fcbd6d3286	8730910e-2c6a-4e8f-88d5-8d6e700dbe43	t
62552ade-38be-4219-8acc-e7fcbd6d3286	9182e1f8-2f08-4749-b56d-86db33ca9930	f
62552ade-38be-4219-8acc-e7fcbd6d3286	e142d712-3271-430d-8bea-681a6bc6fa1a	f
62552ade-38be-4219-8acc-e7fcbd6d3286	695824ed-e61b-4d93-b780-5e956e811dc9	f
62552ade-38be-4219-8acc-e7fcbd6d3286	e3c0c50d-beea-4cfa-ad0d-bb34d8fda575	f
6cf058f8-2e87-45d1-b55a-653e963b6090	1ac1e7b3-e35c-49d9-aa38-d1d6fbbac6f5	t
6cf058f8-2e87-45d1-b55a-653e963b6090	d21fee02-7810-4fe8-95c6-8662b3c6d01b	t
6cf058f8-2e87-45d1-b55a-653e963b6090	2bda4696-f2c5-421a-a638-d53fca562ea6	t
6cf058f8-2e87-45d1-b55a-653e963b6090	fc9062a7-ce90-4f36-90c7-07bacc64f969	t
6cf058f8-2e87-45d1-b55a-653e963b6090	8730910e-2c6a-4e8f-88d5-8d6e700dbe43	t
6cf058f8-2e87-45d1-b55a-653e963b6090	9182e1f8-2f08-4749-b56d-86db33ca9930	f
6cf058f8-2e87-45d1-b55a-653e963b6090	e142d712-3271-430d-8bea-681a6bc6fa1a	f
6cf058f8-2e87-45d1-b55a-653e963b6090	695824ed-e61b-4d93-b780-5e956e811dc9	f
6cf058f8-2e87-45d1-b55a-653e963b6090	e3c0c50d-beea-4cfa-ad0d-bb34d8fda575	f
8c477d16-fd00-4245-bad2-d59e6134cf7b	1ac1e7b3-e35c-49d9-aa38-d1d6fbbac6f5	t
8c477d16-fd00-4245-bad2-d59e6134cf7b	d21fee02-7810-4fe8-95c6-8662b3c6d01b	t
8c477d16-fd00-4245-bad2-d59e6134cf7b	2bda4696-f2c5-421a-a638-d53fca562ea6	t
8c477d16-fd00-4245-bad2-d59e6134cf7b	fc9062a7-ce90-4f36-90c7-07bacc64f969	t
8c477d16-fd00-4245-bad2-d59e6134cf7b	8730910e-2c6a-4e8f-88d5-8d6e700dbe43	t
8c477d16-fd00-4245-bad2-d59e6134cf7b	9182e1f8-2f08-4749-b56d-86db33ca9930	f
8c477d16-fd00-4245-bad2-d59e6134cf7b	e142d712-3271-430d-8bea-681a6bc6fa1a	f
8c477d16-fd00-4245-bad2-d59e6134cf7b	695824ed-e61b-4d93-b780-5e956e811dc9	f
8c477d16-fd00-4245-bad2-d59e6134cf7b	e3c0c50d-beea-4cfa-ad0d-bb34d8fda575	f
66329f4e-8fc4-4053-af79-ad673fd69478	1ac1e7b3-e35c-49d9-aa38-d1d6fbbac6f5	t
66329f4e-8fc4-4053-af79-ad673fd69478	d21fee02-7810-4fe8-95c6-8662b3c6d01b	t
66329f4e-8fc4-4053-af79-ad673fd69478	2bda4696-f2c5-421a-a638-d53fca562ea6	t
66329f4e-8fc4-4053-af79-ad673fd69478	fc9062a7-ce90-4f36-90c7-07bacc64f969	t
66329f4e-8fc4-4053-af79-ad673fd69478	8730910e-2c6a-4e8f-88d5-8d6e700dbe43	t
66329f4e-8fc4-4053-af79-ad673fd69478	9182e1f8-2f08-4749-b56d-86db33ca9930	f
66329f4e-8fc4-4053-af79-ad673fd69478	e142d712-3271-430d-8bea-681a6bc6fa1a	f
66329f4e-8fc4-4053-af79-ad673fd69478	695824ed-e61b-4d93-b780-5e956e811dc9	f
66329f4e-8fc4-4053-af79-ad673fd69478	e3c0c50d-beea-4cfa-ad0d-bb34d8fda575	f
d3450ecb-384a-4770-ab8d-30659adf7373	1ac1e7b3-e35c-49d9-aa38-d1d6fbbac6f5	t
d3450ecb-384a-4770-ab8d-30659adf7373	d21fee02-7810-4fe8-95c6-8662b3c6d01b	t
d3450ecb-384a-4770-ab8d-30659adf7373	2bda4696-f2c5-421a-a638-d53fca562ea6	t
d3450ecb-384a-4770-ab8d-30659adf7373	fc9062a7-ce90-4f36-90c7-07bacc64f969	t
d3450ecb-384a-4770-ab8d-30659adf7373	8730910e-2c6a-4e8f-88d5-8d6e700dbe43	t
d3450ecb-384a-4770-ab8d-30659adf7373	9182e1f8-2f08-4749-b56d-86db33ca9930	f
d3450ecb-384a-4770-ab8d-30659adf7373	e142d712-3271-430d-8bea-681a6bc6fa1a	f
d3450ecb-384a-4770-ab8d-30659adf7373	695824ed-e61b-4d93-b780-5e956e811dc9	f
d3450ecb-384a-4770-ab8d-30659adf7373	e3c0c50d-beea-4cfa-ad0d-bb34d8fda575	f
bf40a050-cc4a-4e5b-9089-6aaefb033e20	1ac1e7b3-e35c-49d9-aa38-d1d6fbbac6f5	t
bf40a050-cc4a-4e5b-9089-6aaefb033e20	d21fee02-7810-4fe8-95c6-8662b3c6d01b	t
bf40a050-cc4a-4e5b-9089-6aaefb033e20	2bda4696-f2c5-421a-a638-d53fca562ea6	t
bf40a050-cc4a-4e5b-9089-6aaefb033e20	fc9062a7-ce90-4f36-90c7-07bacc64f969	t
bf40a050-cc4a-4e5b-9089-6aaefb033e20	8730910e-2c6a-4e8f-88d5-8d6e700dbe43	t
bf40a050-cc4a-4e5b-9089-6aaefb033e20	9182e1f8-2f08-4749-b56d-86db33ca9930	f
bf40a050-cc4a-4e5b-9089-6aaefb033e20	e142d712-3271-430d-8bea-681a6bc6fa1a	f
bf40a050-cc4a-4e5b-9089-6aaefb033e20	695824ed-e61b-4d93-b780-5e956e811dc9	f
bf40a050-cc4a-4e5b-9089-6aaefb033e20	e3c0c50d-beea-4cfa-ad0d-bb34d8fda575	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
dde3e3b5-1efb-4d3c-ad1d-acfa6665b583	c4324e1c-fa59-458e-83dd-d60f14644794
695824ed-e61b-4d93-b780-5e956e811dc9	d6b1930d-2ca9-4fe4-9a4c-88f106746e89
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
766e1da1-bdfb-454b-b517-ddcca882012c	Trusted Hosts	68547ce3-6e06-4390-a3d3-3f5eaafa1583	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68547ce3-6e06-4390-a3d3-3f5eaafa1583	anonymous
32c2de01-1742-4716-a272-bc04497f1b25	Consent Required	68547ce3-6e06-4390-a3d3-3f5eaafa1583	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68547ce3-6e06-4390-a3d3-3f5eaafa1583	anonymous
0e9615e3-ac69-4484-92da-62f7092fe105	Full Scope Disabled	68547ce3-6e06-4390-a3d3-3f5eaafa1583	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68547ce3-6e06-4390-a3d3-3f5eaafa1583	anonymous
dbf50086-e347-4390-aaa9-ce40e18b1c5f	Max Clients Limit	68547ce3-6e06-4390-a3d3-3f5eaafa1583	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68547ce3-6e06-4390-a3d3-3f5eaafa1583	anonymous
2828b569-cc5c-4602-93af-b647d444b19f	Allowed Protocol Mapper Types	68547ce3-6e06-4390-a3d3-3f5eaafa1583	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68547ce3-6e06-4390-a3d3-3f5eaafa1583	anonymous
a64d9eb6-855e-4264-aef9-56ddfe814f0a	Allowed Client Scopes	68547ce3-6e06-4390-a3d3-3f5eaafa1583	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68547ce3-6e06-4390-a3d3-3f5eaafa1583	anonymous
cb3d0e84-f473-487d-aa54-c0282d119455	Allowed Protocol Mapper Types	68547ce3-6e06-4390-a3d3-3f5eaafa1583	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68547ce3-6e06-4390-a3d3-3f5eaafa1583	authenticated
f13fe2d2-c1a7-44e9-893f-b3761a59f944	Allowed Client Scopes	68547ce3-6e06-4390-a3d3-3f5eaafa1583	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68547ce3-6e06-4390-a3d3-3f5eaafa1583	authenticated
db532f8e-1078-4100-9820-bde4b2684cc1	rsa-generated	68547ce3-6e06-4390-a3d3-3f5eaafa1583	rsa-generated	org.keycloak.keys.KeyProvider	68547ce3-6e06-4390-a3d3-3f5eaafa1583	\N
8ce5165f-d0e8-4066-8881-6b17c99a97fc	rsa-enc-generated	68547ce3-6e06-4390-a3d3-3f5eaafa1583	rsa-enc-generated	org.keycloak.keys.KeyProvider	68547ce3-6e06-4390-a3d3-3f5eaafa1583	\N
7733435d-adef-40cb-aae9-f6e9da36c2a2	hmac-generated	68547ce3-6e06-4390-a3d3-3f5eaafa1583	hmac-generated	org.keycloak.keys.KeyProvider	68547ce3-6e06-4390-a3d3-3f5eaafa1583	\N
b61308f8-97ed-416a-b5ea-db0cf8895634	aes-generated	68547ce3-6e06-4390-a3d3-3f5eaafa1583	aes-generated	org.keycloak.keys.KeyProvider	68547ce3-6e06-4390-a3d3-3f5eaafa1583	\N
3b146cdb-afe6-454f-90fc-872df492c24f	Allowed Client Scopes	market	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	market	anonymous
851d22b7-bda3-4ea4-916f-9bce673a5917	Allowed Protocol Mapper Types	market	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	market	anonymous
824824ef-1def-4b98-ac76-2204822d1eb6	Allowed Protocol Mapper Types	market	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	market	authenticated
0f101e2e-2044-4b6d-8d0b-243a24553d5c	Trusted Hosts	market	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	market	anonymous
65c9a15f-d2b2-45bd-9ff1-47cccab28917	Allowed Client Scopes	market	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	market	authenticated
7b6f39cc-5d33-4f41-8d01-fe80015e8688	Consent Required	market	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	market	anonymous
1f3ed410-767b-4e84-b96a-8a64e996f334	Full Scope Disabled	market	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	market	anonymous
edb8ea17-ef31-4d62-82a1-e2fa2b5bb2c5	Max Clients Limit	market	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	market	anonymous
a1c16a2d-a0d9-4480-9980-fe43f733fdf9	rsa-generated	market	rsa-generated	org.keycloak.keys.KeyProvider	market	\N
30950374-aa78-4b8e-b8e2-7f83ff230c5d	rsa-enc-generated	market	rsa-enc-generated	org.keycloak.keys.KeyProvider	market	\N
492343e9-09f3-4c2c-a547-f84b5c6963f6	hmac-generated	market	hmac-generated	org.keycloak.keys.KeyProvider	market	\N
3b2e85ad-7aee-4c70-a8be-407c0c00f37b	aes-generated	market	aes-generated	org.keycloak.keys.KeyProvider	market	\N
646ef5a1-8a11-4aea-bf72-ea5d1e318d89	ldap	market	ldap	org.keycloak.storage.UserStorageProvider	market	\N
33633df1-f653-4269-8a98-78433b48bf6c	username	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	market	\N
bb8f7710-41c7-46da-aeb0-ddfe08b9990a	first name	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	market	\N
6ce11988-01cf-4d38-8946-a73df2d9acfc	last name	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	market	\N
12185941-b6cc-4ab9-bf21-d8d73029b1ae	email	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	market	\N
8d8b8fd7-1598-4ff1-bef8-aa8fe3045ae3	creation date	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	market	\N
99261ea0-24b3-462f-95da-e7febc5240f8	modify date	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	market	\N
5801b526-7aa9-4a0b-b877-10e07ea2b5aa	MSAD account controls	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	msad-user-account-control-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	market	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
6bc15fd8-81b5-438f-8cae-8693da25f78a	f13fe2d2-c1a7-44e9-893f-b3761a59f944	allow-default-scopes	true
3800674b-32c5-4753-a7ca-59a11715980f	dbf50086-e347-4390-aaa9-ce40e18b1c5f	max-clients	200
253ac6c0-b3bf-4f85-8478-b0767cd22e95	a64d9eb6-855e-4264-aef9-56ddfe814f0a	allow-default-scopes	true
39983614-55a7-40b8-8d05-96d002e8767e	2828b569-cc5c-4602-93af-b647d444b19f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
fde9036e-2eac-4643-bc1d-9715c66fd792	2828b569-cc5c-4602-93af-b647d444b19f	allowed-protocol-mapper-types	oidc-address-mapper
fd99091f-ebb9-44d6-b864-46b60dd19001	2828b569-cc5c-4602-93af-b647d444b19f	allowed-protocol-mapper-types	saml-user-property-mapper
f1332a3f-83e7-4fed-bc29-92ad333958a6	2828b569-cc5c-4602-93af-b647d444b19f	allowed-protocol-mapper-types	saml-user-attribute-mapper
b0ecfe47-8276-4e43-8ebc-0da598040ab3	2828b569-cc5c-4602-93af-b647d444b19f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
4ced917d-ede6-4754-96d0-48b722e43fb2	2828b569-cc5c-4602-93af-b647d444b19f	allowed-protocol-mapper-types	oidc-full-name-mapper
1ad9d69e-5e5b-4d09-a230-8af0162f39ed	2828b569-cc5c-4602-93af-b647d444b19f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
dd72e6e7-9eea-4f05-b97a-51e508ff8b7b	2828b569-cc5c-4602-93af-b647d444b19f	allowed-protocol-mapper-types	saml-role-list-mapper
27602a34-b070-4fe9-87dd-5d335b84f1d4	cb3d0e84-f473-487d-aa54-c0282d119455	allowed-protocol-mapper-types	oidc-address-mapper
e6824bf7-4672-47da-9ac3-b371a9a4b5d7	cb3d0e84-f473-487d-aa54-c0282d119455	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
2750d2c4-27e2-466c-ac5c-ba6ebc5aee5d	cb3d0e84-f473-487d-aa54-c0282d119455	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
fe1161f1-2c29-443c-96c3-2d64af7d7d9b	cb3d0e84-f473-487d-aa54-c0282d119455	allowed-protocol-mapper-types	saml-user-property-mapper
ef9fd2fb-10d1-40dd-885d-7955f1cc5f2e	cb3d0e84-f473-487d-aa54-c0282d119455	allowed-protocol-mapper-types	oidc-full-name-mapper
3bb37d24-e62f-4bac-baa7-6dd78de480ba	cb3d0e84-f473-487d-aa54-c0282d119455	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
3aee6995-5777-49dc-ade1-28e08e2b3f39	cb3d0e84-f473-487d-aa54-c0282d119455	allowed-protocol-mapper-types	saml-role-list-mapper
a6a312b8-7d5d-4781-b6c0-a5a7881973b6	cb3d0e84-f473-487d-aa54-c0282d119455	allowed-protocol-mapper-types	saml-user-attribute-mapper
9af19deb-938b-4957-9331-2d540a6b4703	766e1da1-bdfb-454b-b517-ddcca882012c	client-uris-must-match	true
b6da5a97-b8a5-49ae-98f2-25a3d6860823	766e1da1-bdfb-454b-b517-ddcca882012c	host-sending-registration-request-must-match	true
6c04bd41-14d2-4768-aab3-1d0941e05e4e	db532f8e-1078-4100-9820-bde4b2684cc1	privateKey	MIIEowIBAAKCAQEAjFdHsCdM+uh2LSYEGF8MQMfd6AFrQVahwBotOMdhjQNJ+aAGRcwHhtINQhzvI9N2C/eGQH5/ooqUS1pJAd/pS38eZ/kFVMxwTYSWzlof5H1KbB8idr0k3CfHD1Rr8x3zIYoIo9lhZ41Q8jcz3FjG8eLTuBvImz4SHW2owdDqpPGyJ8ywDmZF8pZa5Tn4gJO2qS/IFQ8EHlE8Am8e5MGBSYwreAhKIwA/0Igx4ERbr2psM9UZH1Z149GWICUu9+9koztDI3FlxIRNcD4iuuu+SnyvpevTqx7uPBRHtzjYT8WBNV+CMf5sb4/D1YmCioSo+zWrEdzKLNra9+RlIpkATQIDAQABAoIBAAJZX6jSL5avl3LQBReHV8Qp1EwS4gG4+oIlrgYaSEa8/FsCU7iNXr7h+zjVFSerXXl7zjJ8K5TD7xGH1FsErXoHCbJB19YAigyyIHgZyBjiBAHlT4VfSyOoQsu95QSvxqcUEWr0s42xLt6vD94rWkEoQ9T8GhKHKnR1pnKAFb1nC9cHPihun4o3oDp+VOBW300JUGXW7wL9BqbgGqy6V9e9Y1zDJwnewVTOu68W+cbnQQKgvWu7UzjAgLURlAm+me2x1Qyz4afo9GWYgQLBcclJeXWrBCn1icnn3xOh3XadkBgxk3+CEmKQ6LU+CyYVWWnJzr3hMeI8nMV24bf8xL0CgYEA5Y+BFfCPPDbh/+yQw8uMngqL54y8mvkJsMQB3Ev1U4dFD42gc7xcunwu66LhAnkavxclRJsFO0Ns4LmHH5K41YR+IqWdADiRJBKq8lYHX9qOrjxtLPwOObHVDl2x3V07RIrAcUa1/JWlHT96ejoNiq3WRgLaTjlKSWv/Kg0Lom8CgYEAnIEsSa6Tmjj7bWETxE15D8XvYravF0DOvtcahWDJPsZsqCHTdvMr/djiYKa27H4uF42xc8tRtOQiF786n04xvBcX9w+ytWfejdEc9yjPtNgutNXl1ku4yTSuiujTgFG/C3vKxuxRGKhf9/6p5Qv5OCxqtLVpr6hOSpYC00ST9wMCgYANZ7LfCBwlJQNPgY32kQVWGUGQNOyylAZX1ypQpfLefNCwltGe0IoNrcDDq9A957qDHCPl/LNygX5zJQJZ+qRme4UuGsOvRp5bH+fxnMpzc3zPeeHaNaHTBqptW1VOmuoiF4QjWUC5TjfFHHbXelpeFcakcfgzhy7qWK8e0oIyawKBgQCNNY+8O6Q6NsfE/R5UtIJS1QkVTDfXB0aDspnfVmC+H1LSsRKX9PjwZcx74HCUGZWE8vf1vrHOQTjxrD08l9UQHNYmuSdJvppz4wX7i/s89QHPcF+cZ14nTT1fYIvU7+0sc1mW+oqBcQqGPGUWoSMQqCLvQfBF6doaOhf6f5nx+QKBgEzHSKSmQ6YYP/QeGUPpX8FxY9z6ya6fM8IuYxWDz9a9wxu7VKvTbx3Bs4d+CoNrMg9Jz5t9oIEaAP41UXiWHuqykHbRHOqrgp+51WSelI6q8t8eLsp4wx2rTy1eij33Mir2Q7WoJuMkiLSBaY1S6GUWrKdjuE2bCFtMpOHw5tHF
4afceab9-5511-45c8-bf61-c6e78cd4310d	db532f8e-1078-4100-9820-bde4b2684cc1	keyUse	SIG
5d32882d-f81c-4f52-b926-ef13231ac737	db532f8e-1078-4100-9820-bde4b2684cc1	certificate	MIICmzCCAYMCBgGBev0KYDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwNjE5MDgwMTUyWhcNMzIwNjE5MDgwMzMyWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCMV0ewJ0z66HYtJgQYXwxAx93oAWtBVqHAGi04x2GNA0n5oAZFzAeG0g1CHO8j03YL94ZAfn+iipRLWkkB3+lLfx5n+QVUzHBNhJbOWh/kfUpsHyJ2vSTcJ8cPVGvzHfMhigij2WFnjVDyNzPcWMbx4tO4G8ibPhIdbajB0Oqk8bInzLAOZkXyllrlOfiAk7apL8gVDwQeUTwCbx7kwYFJjCt4CEojAD/QiDHgRFuvamwz1RkfVnXj0ZYgJS7372SjO0MjcWXEhE1wPiK6675KfK+l69OrHu48FEe3ONhPxYE1X4Ix/mxvj8PViYKKhKj7NasR3Mos2tr35GUimQBNAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFo2USoU4vh4VnJ/WFmqlfaJEZvtlQLE0S7PUTU+/vro+O93VcsCbtD/1Nr6ERPLGN5ckN/BMSt+ynUWYjvmXauh0kCE6DEMjSbeKgMoRWdIEYni1cQv6bjvxwIxl6w5HX6pgNlAJgXsgobeeT4DjDZUB+Fk9XYIK6J51C74bC2JzCkk/67fxD5mDnqTkR2LvrjASgwkdpqI0BxmPdBHqnlLXQGOse0lsm7vnukjrIQHLPd419V9bwgT6VZGltiZWlEBXJQPxzshpxPwgyRA61uDA420CzxxFYr0wg1DIU5XLL3SP4WUKDY4nPpzogZhdsYId7yQtuxpG7JT4sOykTA=
3bd642e9-54e0-43f5-a6a6-2a46552a7892	db532f8e-1078-4100-9820-bde4b2684cc1	priority	100
6a2cc5b9-d221-495c-a692-d6ef93478439	b61308f8-97ed-416a-b5ea-db0cf8895634	secret	Dwu3kAhlfvYm7a9WC64nog
3e9cfa4e-ec8e-4db5-b669-9116b411854b	b61308f8-97ed-416a-b5ea-db0cf8895634	priority	100
ecb4e508-37c3-4ef2-b6bd-2cfd79161d2d	b61308f8-97ed-416a-b5ea-db0cf8895634	kid	d56bd977-0860-44fa-baf9-c84f96e97447
8a3eebe9-4005-430c-8b00-eb72663ff8bc	8ce5165f-d0e8-4066-8881-6b17c99a97fc	privateKey	MIIEowIBAAKCAQEAi1HC5pgHSmC0jGzInK4KdoaLZjHeZyZU+YV+bOpsCozyDgfEQ7lWh6sSnlQAMWh/RsO4kNwnZzuKKIqIC9Y1NWTW4s14IEm6QauKKw+8HoIrTEtYY3IKJyqsqhRSyA04SSbkHjGI5WPYcZpM3Uj5hzBrvQ2IcvbAGoZkcNQ5gTXHLZsQ6Ll77NUWzYuOz5UxBtAj4NctCvP0PADWxxrweR3XZ9kx9FZzKKlEffC29Ss+JdoGZuFH4qhVLu/4ajzQrHo3zSeaYopJaGlSsj3uAz35ujd8cu3Ya0KfKcJlJX2p0dOlsXXpNpdQWIShN4MUq40XO3veLpSOakhMCI5ojQIDAQABAoIBAFqPQwlxOQv34GSHMb/mwZZZzrMXJ2IVYJbxV0Sk/KW/CHhmRAVhrAV0Bh40rAtxyYnOH2LKODK6WQwRQG2xR9T1P1keBj+2rQOS5bUn/Tg3lL17HHFH56Gd8656l3TCYxvp085slHfHdyIhEmWk0c42g1HYQiG4kxaq1Q8iZF7ACFkv0Wn0RzSfox4YfE6QFBtqbwhKxjFUV1Io7W6kPG/laKAOxzu68flRxOfPJWQFiOkk1BIiPKdFc1lTbEbRj+gf63fsgRlGO/67g61NCNv7nhmrqvxNZfUsbtg+mjPJpFyPSHHCmK6v2P+fhqMCZedNuH60UP3SHVoazGPgsmECgYEAx7gNt9vWq1DghmYGPUscqyU4fym4+UD3q1VOMLCGj6vao9Xj0UXmWsJrOFE92YeejmDBu1453E4ZSu7GEcvCbGFYq6wo2c27JxAA2U+ASPhGlre5jqCILVGVOFvIV3QgtycLkdVkjRdxrCTvaT8jkVJl/jjBKCRYVQTzU0e91pcCgYEAspRqVWLPYrQ9ft7eoKeiqzbvOLjiymI5YmPV/Iekaq4x5CpP6ElGVPLKoT79r8kddY8ScdYvbpmYD/qbOnLWwHF++9s9AN7+N1MG0bHeQCzVGL/+T0UyvkROPJ1XEGsyyP8t930yhFpTBrXpT/4We0LrlPhEo/Nt0ZOH/Qox4nsCgYEAt0Wi8RF/0P4Ky8pb92syB6vESI0U/UYtAMDrW6riEH13ydjBko0+chLvKWMECtZ1HdqUbUhueEgC1cx/Xl1JMQOzxvXZFuW/1HzPCpv18QBEZpJ6aPPPgybWdD1lfztFukzORSk5eHAHFB1gxYf3L6gZiEy0lA2mMX61e7rd7kkCgYA8kuc2q1uZKXYqkMKHUBV3ahze6qfS6lp4q1CsZf45SXkW4dtU+XXn3qso4sr+U4OwmqUxA+v24haYZPM+cjGx+U2PdKBOqVUlwv3vJxwyPILT8Fv824YIz/aRzPT5VsNVNmmLJ2Z5SoIbJp1LSu6pRNvQHh56VloL2rUn+ctN/QKBgBAh3ODSCmG4h9AmoUK0aq0Z/Dfz7gtAFj/+Bff9IDZW2Jc5s4JoGGr8yxE64bZ9ZoxBirnHRj8XzYAzD3RjrttcvTuQn06dymsx1dx4g3DQy0ZrvxOloUy9h5prkf8XZYuJSZJVNhTNVVaGJ/LSQ+9MAUAXZRQOLO0hpujhgwle
17a4d065-08f8-4879-a219-03ae349899bc	8ce5165f-d0e8-4066-8881-6b17c99a97fc	priority	100
95aa85a1-921c-4883-86c5-c23307190129	8ce5165f-d0e8-4066-8881-6b17c99a97fc	certificate	MIICmzCCAYMCBgGBev0K8TANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwNjE5MDgwMTUyWhcNMzIwNjE5MDgwMzMyWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCLUcLmmAdKYLSMbMicrgp2hotmMd5nJlT5hX5s6mwKjPIOB8RDuVaHqxKeVAAxaH9Gw7iQ3CdnO4ooiogL1jU1ZNbizXggSbpBq4orD7wegitMS1hjcgonKqyqFFLIDThJJuQeMYjlY9hxmkzdSPmHMGu9DYhy9sAahmRw1DmBNcctmxDouXvs1RbNi47PlTEG0CPg1y0K8/Q8ANbHGvB5Hddn2TH0VnMoqUR98Lb1Kz4l2gZm4UfiqFUu7/hqPNCsejfNJ5piikloaVKyPe4DPfm6N3xy7dhrQp8pwmUlfanR06Wxdek2l1BYhKE3gxSrjRc7e94ulI5qSEwIjmiNAgMBAAEwDQYJKoZIhvcNAQELBQADggEBABBC7VsCKMNeYTqH33WYiEU01HV2sACy/wbclbPlbrfUa85kOuzgmp7Y8VkW170JpcAaQoN+LrJqscwbh9ytkOtH9JuQBDAtK3Wx1Y4k+TQ/pzN8aFvhuZdigGPtFt0aVHoo1yeHf9WX6gihJPDQ5gdGaYLOf1+ScvPsgSvtQr/OTKzRYzKz11DmZBRyY7av1a4fHBbkpCdHIuwqmSdDelHk5yZy3b5ipdAaoOtTMWF0S5AkzbzHv76Hz0RPt/xRfJSYIutr8S2kK5rxFGTquyM87MGuEbEiLP1QtS5/lFMvPTttaGsMifVABMnKjFQgiSxDV7V8qjPbxDsxgOivdhw=
e117f940-c720-42cf-a9e7-71e28e0a84c1	8ce5165f-d0e8-4066-8881-6b17c99a97fc	algorithm	RSA-OAEP
ee31ea7d-3bc1-4ecb-8150-d17eaa7f06fb	8ce5165f-d0e8-4066-8881-6b17c99a97fc	keyUse	ENC
06bfc4c4-c5d8-43f6-8649-32e72eb33937	7733435d-adef-40cb-aae9-f6e9da36c2a2	priority	100
7ebd421e-3df4-4483-9b52-7bc0af30b319	7733435d-adef-40cb-aae9-f6e9da36c2a2	algorithm	HS256
021ae52e-154e-40a0-a95a-b458827524d4	7733435d-adef-40cb-aae9-f6e9da36c2a2	secret	BrPyk83-ejGVySD12FzKLJ6ugqAgO3aOgILVMi2xNDfAu20w6gFiMNTYfIs1REI3W808Zy1EZkJ3BqxZwaEKmw
8691a43c-a6b6-4c07-b68e-d65ca674ff4f	7733435d-adef-40cb-aae9-f6e9da36c2a2	kid	e78b318e-f56b-4d69-bdf8-812b6fe29166
5f0e30b9-ae9d-459c-a321-e2fcb525fc1a	3b146cdb-afe6-454f-90fc-872df492c24f	allow-default-scopes	true
001e95cb-e976-42ac-bf36-550e29ce779f	851d22b7-bda3-4ea4-916f-9bce673a5917	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d0cb3046-e77c-4820-9c0b-00c4b7a1cd82	851d22b7-bda3-4ea4-916f-9bce673a5917	allowed-protocol-mapper-types	oidc-address-mapper
d3a1bdb0-238b-426a-8120-d97202547800	851d22b7-bda3-4ea4-916f-9bce673a5917	allowed-protocol-mapper-types	saml-user-property-mapper
5cf4e214-e43b-4b35-a6db-2a800c85ee0f	851d22b7-bda3-4ea4-916f-9bce673a5917	allowed-protocol-mapper-types	oidc-full-name-mapper
c7e42209-591d-49a5-9eba-80721a0107db	851d22b7-bda3-4ea4-916f-9bce673a5917	allowed-protocol-mapper-types	saml-role-list-mapper
64fb0b27-cacf-4da9-b6b0-2cba2b0a6cea	851d22b7-bda3-4ea4-916f-9bce673a5917	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
4cb0fc84-14fe-41dd-a3c9-fb6ea62e979f	851d22b7-bda3-4ea4-916f-9bce673a5917	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
531dea4a-4c61-415b-a8e3-2c5f7d294bdd	851d22b7-bda3-4ea4-916f-9bce673a5917	allowed-protocol-mapper-types	saml-user-attribute-mapper
e1e85882-5a40-4c7a-b428-75127a0576a5	824824ef-1def-4b98-ac76-2204822d1eb6	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
3e62720a-71c0-48ea-b94f-fae5ef138556	824824ef-1def-4b98-ac76-2204822d1eb6	allowed-protocol-mapper-types	saml-user-property-mapper
61bdd5b4-2247-4796-8e39-a18f10b15304	824824ef-1def-4b98-ac76-2204822d1eb6	allowed-protocol-mapper-types	oidc-address-mapper
14ef1531-f1ed-4b67-91dd-4123244679e2	824824ef-1def-4b98-ac76-2204822d1eb6	allowed-protocol-mapper-types	saml-user-attribute-mapper
2b397b98-685f-4291-8f94-998f3588f4ef	824824ef-1def-4b98-ac76-2204822d1eb6	allowed-protocol-mapper-types	saml-role-list-mapper
61bd3e6c-374a-4f33-8bfd-b88794c246dd	824824ef-1def-4b98-ac76-2204822d1eb6	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
c989cd79-94f5-4ef5-8f3c-d560e9b8586b	824824ef-1def-4b98-ac76-2204822d1eb6	allowed-protocol-mapper-types	oidc-full-name-mapper
b966a568-4852-4955-be46-891faaa9754f	824824ef-1def-4b98-ac76-2204822d1eb6	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
31b445c5-aa2c-4248-a779-2aedb9ee8bd5	0f101e2e-2044-4b6d-8d0b-243a24553d5c	host-sending-registration-request-must-match	true
dd937a0f-c7e7-4083-bb6a-d78d0a5706ad	0f101e2e-2044-4b6d-8d0b-243a24553d5c	client-uris-must-match	true
1ddb5bd7-7944-4aeb-aae6-a5a25dee9629	a1c16a2d-a0d9-4480-9980-fe43f733fdf9	priority	100
9df9ab95-66f2-4406-9bfa-0063fb475098	a1c16a2d-a0d9-4480-9980-fe43f733fdf9	certificate	MIICmzCCAYMCBgGBev0QuTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXJrZXQwHhcNMjIwNjE5MDgwMTU0WhcNMzIwNjE5MDgwMzM0WjARMQ8wDQYDVQQDDAZtYXJrZXQwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCKlt91OGekwRwGXFsmFGlqa020M4XA4wY4SMZcIvu6AbIWHZLGKsrW9MBwvmViH5+bRdVpSc0F4VLpo8//BNlG0Nr7wD7NHkdfzfr29zXdDqmKEuSB4i65qxKyXRG/dCaR24uW89AoF5doULPM7k9Gvh+rkFuev7JbvchhIZM0C7HPHm7NKUmMRBE7oUhpxnzZsYsi+6bSCexHkIxf0532qCa3nfLUx2F0yinqMEtJzfqNCF7e24aWHWCpPpm8JsYmXmBHoQDrae922C3sifdHm8eLDIaBdIQVW9A5FV2Dlf4/ctPB8RPh8zma8LdWoc3uzyx5My5WRhhRt9jxFnERAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAH4FG7O3x3ARFJQBbsA0Zleqipw/dDmbkOWlbd8CmYfQkgHO3+1Eeo+Mle2533gkgHvdUH4lL5W74qiyFebCwJKMPjsmZqlg13q8gSqWURl+BbcYYY6DrMZoI673mofqCddgDLTrajobN9eeXLZbiN1KHnQvY99RC5Ch888+ZOyo1/DOJ97M/TASWZZnfUih/WypKhdh7TQGPa8DbYTChnNaMRrgWlAOjctyTxgnLdDQH0NXmKTCZpHRoWF6giRU4LxWxm82H3jm/Y08lxYiNRgNxUiFAbvz2EAQMrbHLkfuAA7xpcnd8O7m9L/4SKTAlIqw3ibFH4lIUSg7Bl5lSvg=
50eb6c03-9112-43c8-b802-7a9a71f650cf	a1c16a2d-a0d9-4480-9980-fe43f733fdf9	privateKey	MIIEogIBAAKCAQEAipbfdThnpMEcBlxbJhRpamtNtDOFwOMGOEjGXCL7ugGyFh2SxirK1vTAcL5lYh+fm0XVaUnNBeFS6aPP/wTZRtDa+8A+zR5HX8369vc13Q6pihLkgeIuuasSsl0Rv3QmkduLlvPQKBeXaFCzzO5PRr4fq5Bbnr+yW73IYSGTNAuxzx5uzSlJjEQRO6FIacZ82bGLIvum0gnsR5CMX9Od9qgmt53y1MdhdMop6jBLSc36jQhe3tuGlh1gqT6ZvCbGJl5gR6EA62nvdtgt7In3R5vHiwyGgXSEFVvQORVdg5X+P3LTwfET4fM5mvC3VqHN7s8seTMuVkYYUbfY8RZxEQIDAQABAoIBAFeYmu7NUv0Yraz7jQUZm7OO1RNUCXNsSw8iOHYeCnt7/OLrmEy22XRaSJQ6U3xcvpX24rfk1LilvbE9QAdROj//XJoI3ejp/XT5jWmxwRLS5KgH3vSVULE8BtpD5ybatFI2sRkdS/E7UBC4CZ0691KgcwYOfUpuob5IyzFRdmhLGdridFtV0bjelYyTSJVyMJjROv9gulDsuFd2o3hmaIQ4+JdT1WyWl4ObGvD5bwf7mnjtV3SDRCZ5Z7RgfhoqJCeNHLBsaHYR6JDciWwLE58nbPLht1Ad/EXN/rvj4rljAp0or6i1QKsSIW7mxEAOXEdPoSNHSSXnQ5WT2iEGOpECgYEAvweZptTWeePk1QF0dNA6xJnynVtay/8pBUrQit4opS5tpIAzMTO37mhsw6FwIIi6yZ8WmDr7Ew1oEgLy0iRUKhOX0E12LvSzAdrhreHH2NY+3C+E/k59MyPFTXoGQOn3bKp0p72pFjLa3DUPcLM5L94GtIYGc8Wm2ZRzbkzYlUUCgYEAublx0BLPe5jrdcgryyJ5cd0DUDBI2GQTFVl+2vEznYD0xelyGyiCqkdstFIBlXIR/txhsij5WNTLcYHGvjOMY5BkPCC/0WLSTWDMvTv0jp+SU9fh0pvownF7+3ONautY5M2AkV/yFBdWPL+CZCsKWxl90Nuk8Tb5/1greBpJS10CgYBkl03zqbPer4B6Ia//Kv8nM6Gr9sUTEqO5I7I4zc89W/tkWhWa3Q8HvXk4crQmjZk+PkWZl8VKPQ8GHQNcYMDo/zQ7/e4zv6rbWTTpaTDhH8AuFd/EQfRvj3B/4beVSx583C1dfuOgytqwhkhBIj8E07dYLBMNt5Cqlh9Kf7C0uQKBgHlLxiswvdVpEA7ChueKQmq8/5b1kf3Rji0ZYCI5+Y3aVQKU7nMSSBRRxYsXK/WgpGQhJqUm4YLEp4IgUd6S6BN2kCA8+0oTEmp61/yXFae4S+b6TYAxVxj26RRWaXv07P+xv1Ayq3W3sBjIsq4c9gx9X5Bygw0O7MN5oBo2gLv5AoGAHrNf1fzd4GyyDeL/dwEsQdeVhJ0vySnBkFpz2xBgpe2DH8lMlMoiXciD2QLOEDq1hn2wQE1iH+Ey/8dLTI0SjHMIg1kYx63w5PeL91tLgLBfgJNt/4c/MvoUKlIE8D6yC1FuKJCS4cYjgT53V0LDdCvD57+hZ10nHTEOjYQTpM4=
266f1818-f29c-43d9-8b8b-78cbf6558dca	30950374-aa78-4b8e-b8e2-7f83ff230c5d	privateKey	MIIEogIBAAKCAQEAlIkK8m8HV8ZMJvtYsL4FkvTN7d4HSBnSbhDO/L9EYBZtxuce3FhjNkwC9dFVGIZizvFScxIrlGzCKjm3XtesesjtyC6tAFOnUlSrqsSQLtCKiQ/BzQuyQb7IKIfuA6KRpMg5WIKTGqPXdGUHAcXKj90dfCYoWvdGnZIpyhxw60ioyGcVGuKaIfQK4GP5aiYmAwy/Vc/BFUqjyIHmhMcFTMTFcCgxL6owYAflzrwlZIrY0SjpaPQZJLgjFALHYddly/SlVx9Z9kVntx/+90l9T/19r28EF40cEI79IZUz8tW5OSqX50FTjV/D/tULFQVRbYHCzGPcNfRyELbl22Y9PQIDAQABAoIBAHrbS2mw+jLYut43YWl3Euc1gysvTXiOmyYc0wftMCIGCzDMtBLvLMiZYI1wYuFRLmMa6eZx7gfrWUJR0OEqpOg+T6cXLFMr3ibUD9XElbmTFjM+DD+MYBnPMoGLxQvOqIbScdRK1F/hivEkKwKFVgFek+e/K/vpscfdQKGCmseQZBjuhBbJ1MgEKJKbHS04CEUa2Q9020TY19XELEhdkhCU+SKef6kgQt/Yw1j7bA3DEE3ctP3IhPmAvpUJ33GOJzTeywOXZ0k4pahszDGzbE9JizCCdVchtEBTlRzY9EiCIO85GkauyFZIc68AJ33V8DkV99pRxkXLkLb0eZE4CQECgYEAx2vtzLxah3gjkB7qDxSNEZZmgyFLUpcxRQCkA2BfUkAeIAbiV78k7AWjm0ITpNucyO5W4E5yNguotZjsuRFVi/B602mk1YJ6B/xljHMlST8VtWBe2kGGL+gsmqNXF/KAZWp64N/Aqwjxna9eANJuiKV7ti1IQ+V7ZExLRH43E/0CgYEAvq05JjCqaJQJ4Cu5DtzF5TKIMsvUvJP7t+JzT7CB7UnLdd7Pw2L3i53/frsnVnlliPcgs4NLqbVS/642Flh9ilUtoCPJdPRTd30YgohzRQzNV8cP8mdWcMFN2UBS5KGD1XTOEw490stGioIrAg1eGSRBflFRejuxq8sv5Ccp8kECgYAzAT3PEZWt9GJUKDQBK2ZxSyBpBYj4VMc7ONC6NFns9Y0+78PQYYkV/NM9kIbpsWnGUn9R236GqDC8UaKqKu7QXe9sRybrnPWNOVbXt1OgCkyJGV7pP70MX7uYyZIrA9EnHzbScSgcFquFgybt2uR+eqTLkYVcKEOJAaJ2oDmCGQKBgCPtB2OGr9Tcb6/pDQkb172Dc93+Qar2Rusyo39URmarDMa8oHCz6OhJcKY0JQlJ/jN8PJEWH99t5qF99XroWV8DBYGyvHZowoE09LVDeFR+QQJU41BM4CCGi2Bvmi6xr+E8DMfSWxuoaTYXqHrOgfhCuIRQVgWt0aAIvJFEP8cBAoGAaHp3hqMwzkzPR2pzx0d9ncTEx+414ag3E84qcDpIcQfi6rEO+SirJ7lDejv2Nsd6ZhiS1/LhxlXzv66Sfk8oMjMZ/IPiYg/9ThXs991kvIUCJDjc00wIIaVZtV7+DgwQ86qI9PvZVGl+LNB/6JDnCsLYPaH3d0XFi4A13M1p/K8=
042b170f-adc4-4391-b5a6-40d56e2196ac	30950374-aa78-4b8e-b8e2-7f83ff230c5d	algorithm	RSA-OAEP
e928fe22-2f4f-4e08-a958-27ad6332ccf5	30950374-aa78-4b8e-b8e2-7f83ff230c5d	certificate	MIICmzCCAYMCBgGBev0Q9jANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXJrZXQwHhcNMjIwNjE5MDgwMTU0WhcNMzIwNjE5MDgwMzM0WjARMQ8wDQYDVQQDDAZtYXJrZXQwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUiQrybwdXxkwm+1iwvgWS9M3t3gdIGdJuEM78v0RgFm3G5x7cWGM2TAL10VUYhmLO8VJzEiuUbMIqObde16x6yO3ILq0AU6dSVKuqxJAu0IqJD8HNC7JBvsgoh+4DopGkyDlYgpMao9d0ZQcBxcqP3R18Jiha90adkinKHHDrSKjIZxUa4poh9ArgY/lqJiYDDL9Vz8EVSqPIgeaExwVMxMVwKDEvqjBgB+XOvCVkitjRKOlo9BkkuCMUAsdh12XL9KVXH1n2RWe3H/73SX1P/X2vbwQXjRwQjv0hlTPy1bk5KpfnQVONX8P+1QsVBVFtgcLMY9w19HIQtuXbZj09AgMBAAEwDQYJKoZIhvcNAQELBQADggEBABLWWI7iVzP2OrtAYExdW66VYiDS1HL3bws+E2HQZCAoV0decgwEjxFcu6B5+/9bsWmNJxDOsyalGtW+bhZtXT8LMoaT7s1ApBh/QBF9NeDd2zCt/RGPtHrwkRBOeWJ2fDA+3RTB8a+1xP7ZJ4yP6+jtJHgphA8B76CYlr4B9ILWTkI20e9+meuiQHUJsdl7V8Y4QyHQaHByfVN9iZpqwm8XKzCsvpwP0gC3zv31K7DImXYLDOo0kddfCbTuW1eRmrGWTlPtduWHooevTNWXg2vNVd+P3/iyavV6YAaaoNLgMMhUFcRxu0j20kHfmiCFDdp3xzKclQNeflHX3yIm17o=
cc6e3d48-5fb5-426f-a981-14ca003af613	30950374-aa78-4b8e-b8e2-7f83ff230c5d	priority	100
91375650-216c-4eb5-bb46-a461887cc580	65c9a15f-d2b2-45bd-9ff1-47cccab28917	allow-default-scopes	true
605729f7-e84e-4ad2-9dd5-b0168447a2bc	edb8ea17-ef31-4d62-82a1-e2fa2b5bb2c5	max-clients	200
890019bb-ef0a-4e40-8754-3e19b1514f09	492343e9-09f3-4c2c-a547-f84b5c6963f6	priority	100
3e3a81f9-dfe0-4e1a-aa91-96c2839913dd	492343e9-09f3-4c2c-a547-f84b5c6963f6	algorithm	HS256
127b738b-a7e7-4687-ae0c-42a7e1cc2340	492343e9-09f3-4c2c-a547-f84b5c6963f6	secret	NkeiAKRhop9BI_cf37eR5d_XFHJknD6lXmhXuXbYnDQnrBVNzKFOKoVUQgfN7GS-bLx5RWSVBVhKm9bJCO65-A
49c1de5e-96f4-4294-a2c9-83fc9e6f14b8	492343e9-09f3-4c2c-a547-f84b5c6963f6	kid	fc1da894-c3a0-4d2b-ab21-8b4803b231bc
c5010dd8-c579-42d2-b90f-6350285076df	3b2e85ad-7aee-4c70-a8be-407c0c00f37b	priority	100
ae20796f-bfdc-4f2e-b782-443ed9b70813	3b2e85ad-7aee-4c70-a8be-407c0c00f37b	secret	_-9XP9pDkmJL6xcm7fVWOQ
e46f4c09-5d79-41cf-b07e-e465b9afe9fb	3b2e85ad-7aee-4c70-a8be-407c0c00f37b	kid	04459cb8-232e-4dc5-824f-c7497084837a
b81c55d2-1c73-4b38-bbfc-bb5bee41f3ed	bb8f7710-41c7-46da-aeb0-ddfe08b9990a	is.mandatory.in.ldap	true
09963415-36ed-474f-8272-1b93ecae0176	bb8f7710-41c7-46da-aeb0-ddfe08b9990a	user.model.attribute	firstName
dc81988a-b3db-4ba4-9a9c-fbd218630a89	bb8f7710-41c7-46da-aeb0-ddfe08b9990a	always.read.value.from.ldap	false
b99b984b-a90a-49c9-902c-5993653c888f	bb8f7710-41c7-46da-aeb0-ddfe08b9990a	read.only	true
24951336-691d-43f2-b819-e3912caa57dd	bb8f7710-41c7-46da-aeb0-ddfe08b9990a	ldap.attribute	givenName
e5261e9d-389a-49de-8ae2-e60d17e6c09c	12185941-b6cc-4ab9-bf21-d8d73029b1ae	read.only	true
8e51cfca-fcbe-4c14-83b0-be7348a697e4	12185941-b6cc-4ab9-bf21-d8d73029b1ae	is.mandatory.in.ldap	false
ecae9750-0e82-432e-be21-25a82c997c36	12185941-b6cc-4ab9-bf21-d8d73029b1ae	user.model.attribute	email
2a7097b1-7b96-487d-bbf1-acbd85e790b7	12185941-b6cc-4ab9-bf21-d8d73029b1ae	ldap.attribute	mail
7661d52e-38a1-4475-98a7-fbd626fadd6f	12185941-b6cc-4ab9-bf21-d8d73029b1ae	always.read.value.from.ldap	false
5e2249be-d910-49ca-b29e-02f7765285e4	99261ea0-24b3-462f-95da-e7febc5240f8	user.model.attribute	modifyTimestamp
61778304-2b1a-42e3-9ab5-f847b2e6686f	99261ea0-24b3-462f-95da-e7febc5240f8	is.mandatory.in.ldap	false
971b0af4-80f6-4022-9f0b-117a94960672	99261ea0-24b3-462f-95da-e7febc5240f8	ldap.attribute	whenChanged
3128f6a3-7495-4d06-8408-b619f3da21df	99261ea0-24b3-462f-95da-e7febc5240f8	always.read.value.from.ldap	false
ff9d3824-65bb-4b2e-bf4f-862ce148d4f5	99261ea0-24b3-462f-95da-e7febc5240f8	read.only	true
aa5ec4c7-d3b8-45f1-87cd-a68466df5097	6ce11988-01cf-4d38-8946-a73df2d9acfc	user.model.attribute	lastName
64787e67-8822-49e1-8981-f5fce5da4fcd	6ce11988-01cf-4d38-8946-a73df2d9acfc	always.read.value.from.ldap	false
575ca412-1f59-401a-a430-7eaed9362ba1	6ce11988-01cf-4d38-8946-a73df2d9acfc	ldap.attribute	sn
1cdccd39-c717-4527-88ee-52a6a84a17f0	6ce11988-01cf-4d38-8946-a73df2d9acfc	is.mandatory.in.ldap	true
82ec6111-de90-464b-b2b3-55a4c2bee663	6ce11988-01cf-4d38-8946-a73df2d9acfc	read.only	true
730096f4-5b42-4b00-a568-150e17e2e189	33633df1-f653-4269-8a98-78433b48bf6c	user.model.attribute	username
c4c59b99-66cb-48d9-8abb-b2faec2ac7a3	33633df1-f653-4269-8a98-78433b48bf6c	always.read.value.from.ldap	false
fc1859ec-e1e2-4f3e-a427-04a44510b7c0	33633df1-f653-4269-8a98-78433b48bf6c	ldap.attribute	cn
eb0473b7-a7c3-47c8-8633-05663a80d5a4	33633df1-f653-4269-8a98-78433b48bf6c	is.mandatory.in.ldap	true
19e7d362-10e3-41cb-9a5b-9742d03ffe81	33633df1-f653-4269-8a98-78433b48bf6c	read.only	true
a389ce96-127c-474d-bfb7-3ad40b8d3800	8d8b8fd7-1598-4ff1-bef8-aa8fe3045ae3	ldap.attribute	whenCreated
4d35b1c2-b6a9-4546-9a51-c32135a986a7	8d8b8fd7-1598-4ff1-bef8-aa8fe3045ae3	user.model.attribute	createTimestamp
024f7547-d8c8-4c66-8bbd-33062786144f	8d8b8fd7-1598-4ff1-bef8-aa8fe3045ae3	is.mandatory.in.ldap	false
4f94c137-440f-41d6-90a5-055845693b9a	8d8b8fd7-1598-4ff1-bef8-aa8fe3045ae3	always.read.value.from.ldap	false
66a9a1d1-7600-4a80-a0e6-bdff5970fd6b	8d8b8fd7-1598-4ff1-bef8-aa8fe3045ae3	read.only	true
673d5c0a-970e-46c8-9bf5-764aac28d4c3	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	connectionPooling	true
cd6eb658-7029-49f8-93fc-63223db6efba	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	syncRegistrations	false
3fd72ecf-7ee4-4296-a1f0-2a9d1c83dfcf	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	batchSizeForSync	1000
f678bad8-793f-4c01-a81d-48b2deb5ef0d	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	searchScope	2
72b35cd2-2063-418c-a9f6-961806e53399	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	editMode	UNSYNCED
a10d980f-78c1-4a88-bede-3d79cd514ead	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	priority	0
8058b960-41e9-4aed-8d43-039b32e2d5cb	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	vendor	ad
d8c75946-d7f8-491f-ab2b-d5b22001e387	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	changedSyncPeriod	-1
e659623b-65c7-4fe4-9141-1cafb95d536a	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	usersDn	ou=market-app,dc=trodix,dc=com
0df566fe-2196-448d-8f83-e56a9d39fe1b	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	fullSyncPeriod	-1
29acc25e-1f42-47d1-9174-8a19ede0b897	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	importEnabled	true
284fde08-09a3-419a-b0ff-5a19235ad3ff	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	enabled	true
588b2c45-c289-4a9f-8c04-adbe7d26e0d7	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	connectionUrl	ldap://openldap:1389
d09a78df-8b2e-47fd-8482-4d151ebc986c	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	bindCredential	admin
0d192fa6-234a-4d0d-ae4e-249387831b7c	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	bindDn	cn=admin,dc=trodix,dc=com
174a1804-7257-44c4-b929-1f98e14fc56c	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	rdnLDAPAttribute	cn
1a5f7cc2-815f-4dbc-a2a2-71e878b89bae	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	useTruststoreSpi	ldapsOnly
7039e891-ce01-4a4b-85bc-92dcd6de880b	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	pagination	true
2aa49c19-55ee-4d8c-9629-26766f21d2aa	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	allowKerberosAuthentication	false
ab2a7d8b-29f7-4c1f-ab45-e718d08697ef	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	useKerberosForPasswordAuthentication	false
3b3ed1a6-7622-4202-a0d9-6da2743fe17d	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	trustEmail	false
1192e986-4008-4833-a6df-aa7f53a84b28	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	uuidLDAPAttribute	uid
fe2bbb5d-9b75-4a55-9320-a83397918d5e	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	cachePolicy	DEFAULT
2cce39e3-be0b-455a-a3e9-c26aa329e4b8	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	authType	none
35440f6c-0903-49c8-b9d1-a6a8be2cd9af	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	debug	false
fa76b0ae-7cfc-471a-a3d8-721ee3e2e0ab	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	usernameLDAPAttribute	cn
5c55c7cf-1c6d-4038-b9dc-19698352c8f0	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	userObjectClasses	person
9e273154-e80c-4197-87de-ed7704b0941a	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	lastSync	1655648548
ebb9d8bf-545d-4823-9e82-3a84bcdeba96	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	validatePasswordPolicy	false
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
3293c292-db77-474b-a867-dd140b112976	9e27e451-55b2-46af-bd73-8b516ce7122e
3293c292-db77-474b-a867-dd140b112976	8f31204e-bd3a-4dc3-b3df-892691b13e5a
3293c292-db77-474b-a867-dd140b112976	fa8e2ba7-a7e8-440f-84e3-d355ed4929fc
3293c292-db77-474b-a867-dd140b112976	6aef7562-2cf6-4de2-840e-95065591cf65
3293c292-db77-474b-a867-dd140b112976	972f475d-436c-43b4-acab-8e2f49daea88
3293c292-db77-474b-a867-dd140b112976	5df3dd2c-cd41-4afa-867c-2cbf5372c153
3293c292-db77-474b-a867-dd140b112976	5dd339a5-12b0-4f57-9a84-fb0ed60e9cf1
3293c292-db77-474b-a867-dd140b112976	92bfaeaa-bb3a-492a-b910-93b240717e29
3293c292-db77-474b-a867-dd140b112976	23d55fe1-7835-428d-bb8b-055b7818ab08
3293c292-db77-474b-a867-dd140b112976	30d3e743-7d21-46f7-9501-3befb205abc1
3293c292-db77-474b-a867-dd140b112976	3ed47238-7a34-4f87-b91f-b400d9c2da01
3293c292-db77-474b-a867-dd140b112976	3ecd469e-a254-4c82-8542-34d1b10959a9
3293c292-db77-474b-a867-dd140b112976	1427ec1a-07bb-4204-92e6-76a399fe3a5e
3293c292-db77-474b-a867-dd140b112976	d1762881-4c60-4717-951f-c690e0402d6d
3293c292-db77-474b-a867-dd140b112976	05bae10a-55f2-41b7-a916-16ce68213514
3293c292-db77-474b-a867-dd140b112976	9f560672-29c6-4f4d-a6c5-6b38a84f976c
3293c292-db77-474b-a867-dd140b112976	a0602922-4441-435c-8726-c0b4cea6b5b1
3293c292-db77-474b-a867-dd140b112976	9983bc47-802e-4655-bd8d-3695fc0ce647
972f475d-436c-43b4-acab-8e2f49daea88	9f560672-29c6-4f4d-a6c5-6b38a84f976c
6aef7562-2cf6-4de2-840e-95065591cf65	05bae10a-55f2-41b7-a916-16ce68213514
6aef7562-2cf6-4de2-840e-95065591cf65	9983bc47-802e-4655-bd8d-3695fc0ce647
adab8a7b-3012-4c32-9d41-2e0dec4ec209	99257664-88aa-43e6-a3da-5dc29daaa74f
adab8a7b-3012-4c32-9d41-2e0dec4ec209	57faff0f-53b2-43ad-8711-21a3d131def9
57faff0f-53b2-43ad-8711-21a3d131def9	8342dae0-4abd-4a70-8d2b-cd5aac278d08
52a516d6-0d8e-4ce1-ad60-6c6e350a7ca1	07e812d1-3748-4bda-86dc-503337599e80
3293c292-db77-474b-a867-dd140b112976	aedb271c-c66a-4e71-acc9-27dfbaefe820
adab8a7b-3012-4c32-9d41-2e0dec4ec209	c4324e1c-fa59-458e-83dd-d60f14644794
adab8a7b-3012-4c32-9d41-2e0dec4ec209	952c36e8-962f-48e5-a3c2-01bcd8c98098
3293c292-db77-474b-a867-dd140b112976	4d273774-fd1d-41a9-9731-cc677656195a
3293c292-db77-474b-a867-dd140b112976	bf5c7f45-547c-4c69-b43b-552037308779
3293c292-db77-474b-a867-dd140b112976	61e140ec-7f8a-4d31-812e-98e2f664767b
3293c292-db77-474b-a867-dd140b112976	5f5613b0-f500-42d1-9e67-642ae5e3fd32
3293c292-db77-474b-a867-dd140b112976	2e695d71-8361-4421-95f3-7633b2d75a6a
3293c292-db77-474b-a867-dd140b112976	058dd891-cbdd-48d6-9e85-581536e9b87f
3293c292-db77-474b-a867-dd140b112976	aedfbaca-37cb-4098-9c70-e9dffcc6c8f0
3293c292-db77-474b-a867-dd140b112976	546b904d-57f4-4eef-9fae-15a7001ce173
3293c292-db77-474b-a867-dd140b112976	2344d251-b64e-40d9-9364-f569d1383d40
3293c292-db77-474b-a867-dd140b112976	df312695-64dd-42b9-bac3-345f1719136b
3293c292-db77-474b-a867-dd140b112976	ec48cb90-e636-4eca-9bf1-d0f13985042a
3293c292-db77-474b-a867-dd140b112976	3357cfcf-5487-4a8d-a21a-40564cf10bc1
3293c292-db77-474b-a867-dd140b112976	487abc35-b928-409b-acc6-b05a41cb098c
3293c292-db77-474b-a867-dd140b112976	0ddd623e-2b24-4f2b-a56f-2c078e4fca73
3293c292-db77-474b-a867-dd140b112976	91a48970-22c6-423b-864c-53b0e62ac2e4
3293c292-db77-474b-a867-dd140b112976	9aeb4bfe-18a4-41f8-bdf3-cd12cb0e78c9
3293c292-db77-474b-a867-dd140b112976	a27c5356-0f68-47d0-844a-164792971fd5
5f5613b0-f500-42d1-9e67-642ae5e3fd32	91a48970-22c6-423b-864c-53b0e62ac2e4
61e140ec-7f8a-4d31-812e-98e2f664767b	a27c5356-0f68-47d0-844a-164792971fd5
61e140ec-7f8a-4d31-812e-98e2f664767b	0ddd623e-2b24-4f2b-a56f-2c078e4fca73
4bdc3b47-e92d-45cf-a8c0-455c6f97ad35	b27a49c7-249a-4387-b201-effad86ec1c9
7ecb559e-996b-46ef-9847-576167f7963f	d6b1930d-2ca9-4fe4-9a4c-88f106746e89
7ecb559e-996b-46ef-9847-576167f7963f	5b820d58-db40-46da-9a44-042f3c1ab23d
7ecb559e-996b-46ef-9847-576167f7963f	092435bd-908f-4df3-95e8-02b6206d79f8
7ecb559e-996b-46ef-9847-576167f7963f	07ead9ec-5c3c-42d6-abcf-6a391076c91d
1b16c5d1-769d-467b-8c90-49a65f7aa6a6	65de54e1-aceb-4cf4-afd6-a6865cb32b3f
cf3d58fe-dcd1-40a7-8129-f2fdf6703188	d3c19bf6-037b-4b4d-91c4-c65fcef0debc
cf3d58fe-dcd1-40a7-8129-f2fdf6703188	b6bcd993-f3b6-4489-aebe-bb18c239f8c7
306091d6-7c61-4929-b9d2-c0ee3313805e	d3c19bf6-037b-4b4d-91c4-c65fcef0debc
306091d6-7c61-4929-b9d2-c0ee3313805e	cf3d58fe-dcd1-40a7-8129-f2fdf6703188
306091d6-7c61-4929-b9d2-c0ee3313805e	54308b99-f364-4756-b6be-12c12571135c
306091d6-7c61-4929-b9d2-c0ee3313805e	1f9e1924-2973-4d9e-9d12-0deacc072128
306091d6-7c61-4929-b9d2-c0ee3313805e	7efbe709-93a9-4332-a233-998ce86ddd89
306091d6-7c61-4929-b9d2-c0ee3313805e	b6bcd993-f3b6-4489-aebe-bb18c239f8c7
306091d6-7c61-4929-b9d2-c0ee3313805e	e73c83ca-4723-412d-8cc4-cc08ec3ec344
306091d6-7c61-4929-b9d2-c0ee3313805e	215617db-a5b1-4c07-83f2-6238251d0914
306091d6-7c61-4929-b9d2-c0ee3313805e	a4bafef9-0603-4c17-8612-4eb972114f5a
306091d6-7c61-4929-b9d2-c0ee3313805e	58cbb7f5-b9f0-4b2e-87af-412736daba88
306091d6-7c61-4929-b9d2-c0ee3313805e	47134dad-344b-4897-ba8c-96b8b67cca17
306091d6-7c61-4929-b9d2-c0ee3313805e	8b5b407e-26db-406e-b427-2d4c447788b8
306091d6-7c61-4929-b9d2-c0ee3313805e	6528e0e5-68e5-49a9-87d1-531a01f2819e
306091d6-7c61-4929-b9d2-c0ee3313805e	fa3fbbb3-12ab-41fb-9fa4-81f471d91d9f
306091d6-7c61-4929-b9d2-c0ee3313805e	a830aba9-5787-463b-8408-c2052518997f
306091d6-7c61-4929-b9d2-c0ee3313805e	7d49aae1-d348-4b6e-aa8c-f5870f7b7646
306091d6-7c61-4929-b9d2-c0ee3313805e	4a33a21e-d801-4030-8d10-18980986e787
306091d6-7c61-4929-b9d2-c0ee3313805e	02359504-46a8-4136-8858-bd09149f0b5a
6528e0e5-68e5-49a9-87d1-531a01f2819e	1f9e1924-2973-4d9e-9d12-0deacc072128
07ead9ec-5c3c-42d6-abcf-6a391076c91d	639210a0-4a55-4824-895f-cb697050b489
bd079466-be87-4563-8f74-909d6b619d24	c5c0f995-c845-43e4-85e0-5de50d93ec81
3293c292-db77-474b-a867-dd140b112976	25504930-1790-4518-9e71-341b51845357
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
caedb340-51bd-4399-8df0-d0bc2076b2d1	\N	password	23583b16-bb3e-487d-9f49-387c975da1ff	1655625814453	\N	{"value":"NN8723aUb70uccx3zA/Q44vhxZas3VrywLfUnkMw/9Wxroo0r54zrCKHJ+qyPkWf7+U7Q5fCRoMmJj7hEORNtA==","salt":"Clu6yybAz7U/lirxd49LQA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2022-06-19 08:03:27.351481	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	5625807106
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2022-06-19 08:03:27.359764	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	5625807106
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2022-06-19 08:03:27.394892	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	5625807106
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2022-06-19 08:03:27.397886	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	5625807106
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2022-06-19 08:03:27.483636	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	5625807106
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2022-06-19 08:03:27.486101	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	5625807106
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2022-06-19 08:03:27.567897	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	5625807106
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2022-06-19 08:03:27.571486	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	5625807106
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2022-06-19 08:03:27.576567	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	5625807106
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2022-06-19 08:03:27.657513	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	5625807106
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2022-06-19 08:03:27.705107	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5625807106
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2022-06-19 08:03:27.707042	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5625807106
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2022-06-19 08:03:27.725024	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5625807106
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-06-19 08:03:27.740653	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	5625807106
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-06-19 08:03:27.74244	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5625807106
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-06-19 08:03:27.744255	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	5625807106
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-06-19 08:03:27.745978	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	5625807106
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2022-06-19 08:03:27.78126	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	5625807106
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2022-06-19 08:03:27.817991	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	5625807106
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2022-06-19 08:03:27.822944	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	5625807106
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-06-19 08:03:28.657601	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	5625807106
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2022-06-19 08:03:27.824891	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	5625807106
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2022-06-19 08:03:27.826832	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	5625807106
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2022-06-19 08:03:27.863376	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	5625807106
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2022-06-19 08:03:27.868296	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	5625807106
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2022-06-19 08:03:27.870787	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	5625807106
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2022-06-19 08:03:28.003715	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	5625807106
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2022-06-19 08:03:28.065726	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	5625807106
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2022-06-19 08:03:28.06869	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	5625807106
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2022-06-19 08:03:28.111469	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	5625807106
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2022-06-19 08:03:28.12083	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	5625807106
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2022-06-19 08:03:28.13365	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	5625807106
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2022-06-19 08:03:28.137272	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	5625807106
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-06-19 08:03:28.141358	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5625807106
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-06-19 08:03:28.143193	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	5625807106
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-06-19 08:03:28.162763	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	5625807106
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2022-06-19 08:03:28.165988	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	5625807106
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-06-19 08:03:28.170178	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5625807106
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2022-06-19 08:03:28.172819	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	5625807106
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2022-06-19 08:03:28.175538	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	5625807106
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-06-19 08:03:28.177195	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	5625807106
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-06-19 08:03:28.178717	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	5625807106
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2022-06-19 08:03:28.181832	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	5625807106
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-06-19 08:03:28.65051	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	5625807106
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2022-06-19 08:03:28.654435	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	5625807106
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-06-19 08:03:28.660695	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	5625807106
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-06-19 08:03:28.66202	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	5625807106
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-06-19 08:03:28.710794	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	5625807106
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-06-19 08:03:28.713709	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	5625807106
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2022-06-19 08:03:28.744038	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	5625807106
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2022-06-19 08:03:28.832637	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	5625807106
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2022-06-19 08:03:28.835204	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5625807106
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2022-06-19 08:03:28.837415	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	5625807106
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2022-06-19 08:03:28.839295	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	5625807106
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-06-19 08:03:28.847749	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	5625807106
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-06-19 08:03:28.851795	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	5625807106
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-06-19 08:03:28.88103	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	5625807106
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-06-19 08:03:29.043564	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	5625807106
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2022-06-19 08:03:29.066584	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	5625807106
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2022-06-19 08:03:29.071725	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	5625807106
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-06-19 08:03:29.08013	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	5625807106
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-06-19 08:03:29.084414	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	5625807106
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2022-06-19 08:03:29.08734	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	5625807106
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2022-06-19 08:03:29.089603	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	5625807106
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2022-06-19 08:03:29.091819	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	5625807106
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2022-06-19 08:03:29.108757	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	5625807106
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2022-06-19 08:03:29.121019	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	5625807106
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2022-06-19 08:03:29.131659	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	5625807106
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2022-06-19 08:03:29.146509	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	5625807106
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2022-06-19 08:03:29.15095	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	5625807106
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2022-06-19 08:03:29.154421	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	5625807106
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-06-19 08:03:29.159629	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5625807106
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-06-19 08:03:29.164277	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5625807106
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-06-19 08:03:29.165652	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5625807106
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-06-19 08:03:29.179053	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	5625807106
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-06-19 08:03:29.191798	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	5625807106
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-06-19 08:03:29.194579	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	5625807106
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-06-19 08:03:29.196093	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	5625807106
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-06-19 08:03:29.208211	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	5625807106
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-06-19 08:03:29.209714	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	5625807106
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-06-19 08:03:29.219871	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	5625807106
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-06-19 08:03:29.221464	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5625807106
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-06-19 08:03:29.224474	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5625807106
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-06-19 08:03:29.225971	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5625807106
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-06-19 08:03:29.235502	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	5625807106
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2022-06-19 08:03:29.239418	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	5625807106
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-06-19 08:03:29.244784	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	5625807106
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-06-19 08:03:29.25184	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	5625807106
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-06-19 08:03:29.256205	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	5625807106
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-06-19 08:03:29.260807	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	5625807106
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-06-19 08:03:29.270778	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5625807106
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-06-19 08:03:29.276763	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	5625807106
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-06-19 08:03:29.278225	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	5625807106
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-06-19 08:03:29.284657	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	5625807106
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-06-19 08:03:29.286476	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	5625807106
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-06-19 08:03:29.290429	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	5625807106
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-06-19 08:03:29.320754	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5625807106
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-06-19 08:03:29.322484	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5625807106
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-06-19 08:03:29.328712	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5625807106
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-06-19 08:03:29.343048	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5625807106
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-06-19 08:03:29.344683	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5625807106
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-06-19 08:03:29.355001	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	5625807106
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-06-19 08:03:29.358109	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	5625807106
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2022-06-19 08:03:29.362545	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	5625807106
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2022-06-19 08:03:29.372786	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	5625807106
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2022-06-19 08:03:29.383096	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	5625807106
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
68547ce3-6e06-4390-a3d3-3f5eaafa1583	dde3e3b5-1efb-4d3c-ad1d-acfa6665b583	f
68547ce3-6e06-4390-a3d3-3f5eaafa1583	d0d3a2d1-9102-4bb7-a94a-05d7fb861237	t
68547ce3-6e06-4390-a3d3-3f5eaafa1583	9dc2f965-7008-4356-89fa-d880a753bdb9	t
68547ce3-6e06-4390-a3d3-3f5eaafa1583	beb5e2ad-2fd6-451b-8fae-82547bcb2327	t
68547ce3-6e06-4390-a3d3-3f5eaafa1583	bc8bb6c2-fa14-4580-bfae-a79a7591302c	f
68547ce3-6e06-4390-a3d3-3f5eaafa1583	2972fc4d-cb8b-447a-a490-f80203fd4284	f
68547ce3-6e06-4390-a3d3-3f5eaafa1583	4fe67e1f-9b81-4d83-bc47-3825942df3df	t
68547ce3-6e06-4390-a3d3-3f5eaafa1583	94efff6f-c7b1-40d3-811f-ea07e0a10517	t
68547ce3-6e06-4390-a3d3-3f5eaafa1583	083098cd-8e40-4979-a160-608fae61656a	f
68547ce3-6e06-4390-a3d3-3f5eaafa1583	22d11a31-792b-4ba4-b1bc-620e3974afef	t
market	0db1b3ef-62aa-46f9-82d5-b5072649c79e	t
market	fc9062a7-ce90-4f36-90c7-07bacc64f969	t
market	8730910e-2c6a-4e8f-88d5-8d6e700dbe43	t
market	2bda4696-f2c5-421a-a638-d53fca562ea6	t
market	1ac1e7b3-e35c-49d9-aa38-d1d6fbbac6f5	t
market	d21fee02-7810-4fe8-95c6-8662b3c6d01b	t
market	695824ed-e61b-4d93-b780-5e956e811dc9	f
market	9182e1f8-2f08-4749-b56d-86db33ca9930	f
market	e142d712-3271-430d-8bea-681a6bc6fa1a	f
market	e3c0c50d-beea-4cfa-ad0d-bb34d8fda575	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
adab8a7b-3012-4c32-9d41-2e0dec4ec209	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f	${role_default-roles}	default-roles-master	68547ce3-6e06-4390-a3d3-3f5eaafa1583	\N	\N
3293c292-db77-474b-a867-dd140b112976	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f	${role_admin}	admin	68547ce3-6e06-4390-a3d3-3f5eaafa1583	\N	\N
9e27e451-55b2-46af-bd73-8b516ce7122e	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f	${role_create-realm}	create-realm	68547ce3-6e06-4390-a3d3-3f5eaafa1583	\N	\N
8f31204e-bd3a-4dc3-b3df-892691b13e5a	5418fcfc-96e5-419c-b7d2-911371b10bea	t	${role_create-client}	create-client	68547ce3-6e06-4390-a3d3-3f5eaafa1583	5418fcfc-96e5-419c-b7d2-911371b10bea	\N
fa8e2ba7-a7e8-440f-84e3-d355ed4929fc	5418fcfc-96e5-419c-b7d2-911371b10bea	t	${role_view-realm}	view-realm	68547ce3-6e06-4390-a3d3-3f5eaafa1583	5418fcfc-96e5-419c-b7d2-911371b10bea	\N
6aef7562-2cf6-4de2-840e-95065591cf65	5418fcfc-96e5-419c-b7d2-911371b10bea	t	${role_view-users}	view-users	68547ce3-6e06-4390-a3d3-3f5eaafa1583	5418fcfc-96e5-419c-b7d2-911371b10bea	\N
972f475d-436c-43b4-acab-8e2f49daea88	5418fcfc-96e5-419c-b7d2-911371b10bea	t	${role_view-clients}	view-clients	68547ce3-6e06-4390-a3d3-3f5eaafa1583	5418fcfc-96e5-419c-b7d2-911371b10bea	\N
5df3dd2c-cd41-4afa-867c-2cbf5372c153	5418fcfc-96e5-419c-b7d2-911371b10bea	t	${role_view-events}	view-events	68547ce3-6e06-4390-a3d3-3f5eaafa1583	5418fcfc-96e5-419c-b7d2-911371b10bea	\N
5dd339a5-12b0-4f57-9a84-fb0ed60e9cf1	5418fcfc-96e5-419c-b7d2-911371b10bea	t	${role_view-identity-providers}	view-identity-providers	68547ce3-6e06-4390-a3d3-3f5eaafa1583	5418fcfc-96e5-419c-b7d2-911371b10bea	\N
92bfaeaa-bb3a-492a-b910-93b240717e29	5418fcfc-96e5-419c-b7d2-911371b10bea	t	${role_view-authorization}	view-authorization	68547ce3-6e06-4390-a3d3-3f5eaafa1583	5418fcfc-96e5-419c-b7d2-911371b10bea	\N
23d55fe1-7835-428d-bb8b-055b7818ab08	5418fcfc-96e5-419c-b7d2-911371b10bea	t	${role_manage-realm}	manage-realm	68547ce3-6e06-4390-a3d3-3f5eaafa1583	5418fcfc-96e5-419c-b7d2-911371b10bea	\N
30d3e743-7d21-46f7-9501-3befb205abc1	5418fcfc-96e5-419c-b7d2-911371b10bea	t	${role_manage-users}	manage-users	68547ce3-6e06-4390-a3d3-3f5eaafa1583	5418fcfc-96e5-419c-b7d2-911371b10bea	\N
3ed47238-7a34-4f87-b91f-b400d9c2da01	5418fcfc-96e5-419c-b7d2-911371b10bea	t	${role_manage-clients}	manage-clients	68547ce3-6e06-4390-a3d3-3f5eaafa1583	5418fcfc-96e5-419c-b7d2-911371b10bea	\N
3ecd469e-a254-4c82-8542-34d1b10959a9	5418fcfc-96e5-419c-b7d2-911371b10bea	t	${role_manage-events}	manage-events	68547ce3-6e06-4390-a3d3-3f5eaafa1583	5418fcfc-96e5-419c-b7d2-911371b10bea	\N
1427ec1a-07bb-4204-92e6-76a399fe3a5e	5418fcfc-96e5-419c-b7d2-911371b10bea	t	${role_manage-identity-providers}	manage-identity-providers	68547ce3-6e06-4390-a3d3-3f5eaafa1583	5418fcfc-96e5-419c-b7d2-911371b10bea	\N
d1762881-4c60-4717-951f-c690e0402d6d	5418fcfc-96e5-419c-b7d2-911371b10bea	t	${role_manage-authorization}	manage-authorization	68547ce3-6e06-4390-a3d3-3f5eaafa1583	5418fcfc-96e5-419c-b7d2-911371b10bea	\N
05bae10a-55f2-41b7-a916-16ce68213514	5418fcfc-96e5-419c-b7d2-911371b10bea	t	${role_query-users}	query-users	68547ce3-6e06-4390-a3d3-3f5eaafa1583	5418fcfc-96e5-419c-b7d2-911371b10bea	\N
9f560672-29c6-4f4d-a6c5-6b38a84f976c	5418fcfc-96e5-419c-b7d2-911371b10bea	t	${role_query-clients}	query-clients	68547ce3-6e06-4390-a3d3-3f5eaafa1583	5418fcfc-96e5-419c-b7d2-911371b10bea	\N
a0602922-4441-435c-8726-c0b4cea6b5b1	5418fcfc-96e5-419c-b7d2-911371b10bea	t	${role_query-realms}	query-realms	68547ce3-6e06-4390-a3d3-3f5eaafa1583	5418fcfc-96e5-419c-b7d2-911371b10bea	\N
9983bc47-802e-4655-bd8d-3695fc0ce647	5418fcfc-96e5-419c-b7d2-911371b10bea	t	${role_query-groups}	query-groups	68547ce3-6e06-4390-a3d3-3f5eaafa1583	5418fcfc-96e5-419c-b7d2-911371b10bea	\N
99257664-88aa-43e6-a3da-5dc29daaa74f	f794cd96-d496-4132-80e9-a4811508d5f4	t	${role_view-profile}	view-profile	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f794cd96-d496-4132-80e9-a4811508d5f4	\N
57faff0f-53b2-43ad-8711-21a3d131def9	f794cd96-d496-4132-80e9-a4811508d5f4	t	${role_manage-account}	manage-account	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f794cd96-d496-4132-80e9-a4811508d5f4	\N
8342dae0-4abd-4a70-8d2b-cd5aac278d08	f794cd96-d496-4132-80e9-a4811508d5f4	t	${role_manage-account-links}	manage-account-links	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f794cd96-d496-4132-80e9-a4811508d5f4	\N
ad1030da-50f3-45fe-bd84-801b0bacae11	f794cd96-d496-4132-80e9-a4811508d5f4	t	${role_view-applications}	view-applications	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f794cd96-d496-4132-80e9-a4811508d5f4	\N
07e812d1-3748-4bda-86dc-503337599e80	f794cd96-d496-4132-80e9-a4811508d5f4	t	${role_view-consent}	view-consent	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f794cd96-d496-4132-80e9-a4811508d5f4	\N
52a516d6-0d8e-4ce1-ad60-6c6e350a7ca1	f794cd96-d496-4132-80e9-a4811508d5f4	t	${role_manage-consent}	manage-consent	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f794cd96-d496-4132-80e9-a4811508d5f4	\N
cb19c8cf-e46e-4cf7-888d-f7aa88127544	f794cd96-d496-4132-80e9-a4811508d5f4	t	${role_delete-account}	delete-account	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f794cd96-d496-4132-80e9-a4811508d5f4	\N
abc51566-702b-4379-8989-e4958fb6b22f	d0785922-7d8d-44b3-9460-7f16617f3bbe	t	${role_read-token}	read-token	68547ce3-6e06-4390-a3d3-3f5eaafa1583	d0785922-7d8d-44b3-9460-7f16617f3bbe	\N
aedb271c-c66a-4e71-acc9-27dfbaefe820	5418fcfc-96e5-419c-b7d2-911371b10bea	t	${role_impersonation}	impersonation	68547ce3-6e06-4390-a3d3-3f5eaafa1583	5418fcfc-96e5-419c-b7d2-911371b10bea	\N
c4324e1c-fa59-458e-83dd-d60f14644794	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f	${role_offline-access}	offline_access	68547ce3-6e06-4390-a3d3-3f5eaafa1583	\N	\N
952c36e8-962f-48e5-a3c2-01bcd8c98098	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f	${role_uma_authorization}	uma_authorization	68547ce3-6e06-4390-a3d3-3f5eaafa1583	\N	\N
7ecb559e-996b-46ef-9847-576167f7963f	market	f	${role_default-roles}	default-roles-market	market	\N	\N
4d273774-fd1d-41a9-9731-cc677656195a	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	t	${role_create-client}	create-client	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	\N
bf5c7f45-547c-4c69-b43b-552037308779	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	t	${role_view-realm}	view-realm	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	\N
61e140ec-7f8a-4d31-812e-98e2f664767b	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	t	${role_view-users}	view-users	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	\N
5f5613b0-f500-42d1-9e67-642ae5e3fd32	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	t	${role_view-clients}	view-clients	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	\N
2e695d71-8361-4421-95f3-7633b2d75a6a	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	t	${role_view-events}	view-events	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	\N
058dd891-cbdd-48d6-9e85-581536e9b87f	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	t	${role_view-identity-providers}	view-identity-providers	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	\N
aedfbaca-37cb-4098-9c70-e9dffcc6c8f0	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	t	${role_view-authorization}	view-authorization	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	\N
546b904d-57f4-4eef-9fae-15a7001ce173	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	t	${role_manage-realm}	manage-realm	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	\N
2344d251-b64e-40d9-9364-f569d1383d40	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	t	${role_manage-users}	manage-users	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	\N
df312695-64dd-42b9-bac3-345f1719136b	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	t	${role_manage-clients}	manage-clients	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	\N
ec48cb90-e636-4eca-9bf1-d0f13985042a	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	t	${role_manage-events}	manage-events	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	\N
3357cfcf-5487-4a8d-a21a-40564cf10bc1	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	t	${role_manage-identity-providers}	manage-identity-providers	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	\N
487abc35-b928-409b-acc6-b05a41cb098c	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	t	${role_manage-authorization}	manage-authorization	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	\N
0ddd623e-2b24-4f2b-a56f-2c078e4fca73	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	t	${role_query-users}	query-users	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	\N
91a48970-22c6-423b-864c-53b0e62ac2e4	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	t	${role_query-clients}	query-clients	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	\N
9aeb4bfe-18a4-41f8-bdf3-cd12cb0e78c9	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	t	${role_query-realms}	query-realms	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	\N
a27c5356-0f68-47d0-844a-164792971fd5	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	t	${role_query-groups}	query-groups	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	\N
4bdc3b47-e92d-45cf-a8c0-455c6f97ad35	market	f	\N	app-admin	market	\N	\N
5b820d58-db40-46da-9a44-042f3c1ab23d	market	f	${role_uma_authorization}	uma_authorization	market	\N	\N
d6b1930d-2ca9-4fe4-9a4c-88f106746e89	market	f	${role_offline-access}	offline_access	market	\N	\N
1b16c5d1-769d-467b-8c90-49a65f7aa6a6	market	f	\N	app-user	market	\N	\N
d3c19bf6-037b-4b4d-91c4-c65fcef0debc	d3450ecb-384a-4770-ab8d-30659adf7373	t	${role_query-users}	query-users	market	d3450ecb-384a-4770-ab8d-30659adf7373	\N
cf3d58fe-dcd1-40a7-8129-f2fdf6703188	d3450ecb-384a-4770-ab8d-30659adf7373	t	${role_view-users}	view-users	market	d3450ecb-384a-4770-ab8d-30659adf7373	\N
1f9e1924-2973-4d9e-9d12-0deacc072128	d3450ecb-384a-4770-ab8d-30659adf7373	t	${role_query-clients}	query-clients	market	d3450ecb-384a-4770-ab8d-30659adf7373	\N
54308b99-f364-4756-b6be-12c12571135c	d3450ecb-384a-4770-ab8d-30659adf7373	t	${role_view-identity-providers}	view-identity-providers	market	d3450ecb-384a-4770-ab8d-30659adf7373	\N
7efbe709-93a9-4332-a233-998ce86ddd89	d3450ecb-384a-4770-ab8d-30659adf7373	t	${role_view-authorization}	view-authorization	market	d3450ecb-384a-4770-ab8d-30659adf7373	\N
b6bcd993-f3b6-4489-aebe-bb18c239f8c7	d3450ecb-384a-4770-ab8d-30659adf7373	t	${role_query-groups}	query-groups	market	d3450ecb-384a-4770-ab8d-30659adf7373	\N
e73c83ca-4723-412d-8cc4-cc08ec3ec344	d3450ecb-384a-4770-ab8d-30659adf7373	t	${role_manage-identity-providers}	manage-identity-providers	market	d3450ecb-384a-4770-ab8d-30659adf7373	\N
306091d6-7c61-4929-b9d2-c0ee3313805e	d3450ecb-384a-4770-ab8d-30659adf7373	t	${role_realm-admin}	realm-admin	market	d3450ecb-384a-4770-ab8d-30659adf7373	\N
215617db-a5b1-4c07-83f2-6238251d0914	d3450ecb-384a-4770-ab8d-30659adf7373	t	${role_manage-realm}	manage-realm	market	d3450ecb-384a-4770-ab8d-30659adf7373	\N
a4bafef9-0603-4c17-8612-4eb972114f5a	d3450ecb-384a-4770-ab8d-30659adf7373	t	${role_view-events}	view-events	market	d3450ecb-384a-4770-ab8d-30659adf7373	\N
58cbb7f5-b9f0-4b2e-87af-412736daba88	d3450ecb-384a-4770-ab8d-30659adf7373	t	${role_view-realm}	view-realm	market	d3450ecb-384a-4770-ab8d-30659adf7373	\N
47134dad-344b-4897-ba8c-96b8b67cca17	d3450ecb-384a-4770-ab8d-30659adf7373	t	${role_manage-users}	manage-users	market	d3450ecb-384a-4770-ab8d-30659adf7373	\N
8b5b407e-26db-406e-b427-2d4c447788b8	d3450ecb-384a-4770-ab8d-30659adf7373	t	${role_query-realms}	query-realms	market	d3450ecb-384a-4770-ab8d-30659adf7373	\N
fa3fbbb3-12ab-41fb-9fa4-81f471d91d9f	d3450ecb-384a-4770-ab8d-30659adf7373	t	${role_manage-clients}	manage-clients	market	d3450ecb-384a-4770-ab8d-30659adf7373	\N
6528e0e5-68e5-49a9-87d1-531a01f2819e	d3450ecb-384a-4770-ab8d-30659adf7373	t	${role_view-clients}	view-clients	market	d3450ecb-384a-4770-ab8d-30659adf7373	\N
a830aba9-5787-463b-8408-c2052518997f	d3450ecb-384a-4770-ab8d-30659adf7373	t	${role_create-client}	create-client	market	d3450ecb-384a-4770-ab8d-30659adf7373	\N
7d49aae1-d348-4b6e-aa8c-f5870f7b7646	d3450ecb-384a-4770-ab8d-30659adf7373	t	${role_manage-authorization}	manage-authorization	market	d3450ecb-384a-4770-ab8d-30659adf7373	\N
02359504-46a8-4136-8858-bd09149f0b5a	d3450ecb-384a-4770-ab8d-30659adf7373	t	${role_impersonation}	impersonation	market	d3450ecb-384a-4770-ab8d-30659adf7373	\N
4a33a21e-d801-4030-8d10-18980986e787	d3450ecb-384a-4770-ab8d-30659adf7373	t	${role_manage-events}	manage-events	market	d3450ecb-384a-4770-ab8d-30659adf7373	\N
b27a49c7-249a-4387-b201-effad86ec1c9	66329f4e-8fc4-4053-af79-ad673fd69478	t	\N	market-admin	market	66329f4e-8fc4-4053-af79-ad673fd69478	\N
65de54e1-aceb-4cf4-afd6-a6865cb32b3f	66329f4e-8fc4-4053-af79-ad673fd69478	t	\N	market-customer	market	66329f4e-8fc4-4053-af79-ad673fd69478	\N
439c3654-7a7c-4b93-a552-3d48d5f34993	8c477d16-fd00-4245-bad2-d59e6134cf7b	t	${role_read-token}	read-token	market	8c477d16-fd00-4245-bad2-d59e6134cf7b	\N
092435bd-908f-4df3-95e8-02b6206d79f8	1a43c414-0d56-4b63-81c3-d645db8ca3e4	t	${role_view-profile}	view-profile	market	1a43c414-0d56-4b63-81c3-d645db8ca3e4	\N
3dddd6ae-3742-43b8-b62e-6d18d7c0e97b	1a43c414-0d56-4b63-81c3-d645db8ca3e4	t	${role_delete-account}	delete-account	market	1a43c414-0d56-4b63-81c3-d645db8ca3e4	\N
639210a0-4a55-4824-895f-cb697050b489	1a43c414-0d56-4b63-81c3-d645db8ca3e4	t	${role_manage-account-links}	manage-account-links	market	1a43c414-0d56-4b63-81c3-d645db8ca3e4	\N
07ead9ec-5c3c-42d6-abcf-6a391076c91d	1a43c414-0d56-4b63-81c3-d645db8ca3e4	t	${role_manage-account}	manage-account	market	1a43c414-0d56-4b63-81c3-d645db8ca3e4	\N
c87b5e0d-1c26-4d88-b812-dce50db136a9	1a43c414-0d56-4b63-81c3-d645db8ca3e4	t	${role_view-applications}	view-applications	market	1a43c414-0d56-4b63-81c3-d645db8ca3e4	\N
c5c0f995-c845-43e4-85e0-5de50d93ec81	1a43c414-0d56-4b63-81c3-d645db8ca3e4	t	${role_view-consent}	view-consent	market	1a43c414-0d56-4b63-81c3-d645db8ca3e4	\N
bd079466-be87-4563-8f74-909d6b619d24	1a43c414-0d56-4b63-81c3-d645db8ca3e4	t	${role_manage-consent}	manage-consent	market	1a43c414-0d56-4b63-81c3-d645db8ca3e4	\N
25504930-1790-4518-9e71-341b51845357	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	t	${role_impersonation}	impersonation	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
fafs1	18.0.1	1655625811
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
9094bb66-6142-4a40-9644-02ae73244ef9	66329f4e-8fc4-4053-af79-ad673fd69478	1	1659039743	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1659039743","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
3d99e97d-572a-47e3-8955-60a28a183bd9	66329f4e-8fc4-4053-af79-ad673fd69478	1	1659174108	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1659174108","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
6a71aeea-62b2-47b5-91d3-cea2b70dbe53	66329f4e-8fc4-4053-af79-ad673fd69478	1	1659176974	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1659176974","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
c6114def-2685-42aa-8144-67dc4e9acd1a	66329f4e-8fc4-4053-af79-ad673fd69478	1	1659177328	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1659177328","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
7d53ae72-e4f6-4e3c-ae0b-9d25e12467fd	66329f4e-8fc4-4053-af79-ad673fd69478	1	1659177650	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1659177650","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
cbba0bcd-f095-41d8-9789-2d7e32c00eaf	66329f4e-8fc4-4053-af79-ad673fd69478	1	1659182577	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1659182577","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
ac8687af-d9cb-4fe5-b94d-cfa010d7cfdb	66329f4e-8fc4-4053-af79-ad673fd69478	1	1659182912	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1659182912","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
166d899f-9072-4068-9eb4-3faf39a4ebd0	66329f4e-8fc4-4053-af79-ad673fd69478	1	1659183555	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1659183555","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
d804b28b-3c04-4b0d-805c-fafd7d46dc92	66329f4e-8fc4-4053-af79-ad673fd69478	1	1659184082	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1659184082","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
f4749cc2-7f52-4e29-af83-a7ce09c36e47	66329f4e-8fc4-4053-af79-ad673fd69478	1	1659184399	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1659184399","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
34fe9c55-c197-4e46-9ae3-da3bca14cae5	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657351679	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657351679","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
3ce51051-a58d-4e0b-8e2c-0b218d267237	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657352011	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657352011","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
5a8e09eb-b8dd-44a0-80de-de39bc9d55de	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657352125	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657352125","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
87daad00-ccec-4968-a463-84e376476bf4	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657352167	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657352167","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
01972280-e9ea-417b-a282-ff74557d9d44	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657352585	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657352585","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
acf8795c-8ea3-4601-94b2-960e0fca6bc7	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657358184	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657358184","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
75d17d77-6761-4265-8d5b-b1b980e93618	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657358187	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657358187","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
5d61d1ea-37aa-4020-a665-7200b5ce9b89	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657358680	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657358680","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
9e96d9e4-c784-4214-87d5-f2183cbd6bdf	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657359212	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657359212","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
ec7ff3f0-63e6-406d-bab2-88b9c7d81300	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657359670	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657359670","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
cdf209b5-73e8-4843-b1b2-e99cdd513651	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657360056	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657360056","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
69caf0ca-e4ba-48cb-bdb6-3be649d4c8fa	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657361122	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657361122","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
b3220125-0d41-4f7a-9159-33e2fdf44146	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657361618	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657361618","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
1baf1756-c540-4bbf-bc82-bc2eb3e9cd6e	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657361930	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657361930","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
0142340a-5dac-4c50-86b1-6801f4ef9798	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657362412	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657362412","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
84198ce5-778a-4be9-a314-a49cd136939d	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657372794	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657372794","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
2eb37f16-adc7-45b0-b68d-ea13f8fbaf14	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657441173	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657441173","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
a45efac5-4396-4246-9175-06241b15a20c	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657441218	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657441218","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
b1c45bef-eeaa-4787-b0fc-10629be3b6bd	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657441292	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657441292","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
5c652353-455f-48b6-93ab-c7e170708e72	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657441313	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657441313","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
dada8eb0-0d4a-4cbe-86f4-c8263eb7db78	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657441319	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657441319","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
7b07ba10-b7bc-411d-a5fa-44dfbd80aeaa	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657441325	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657441325","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
7d2e2759-217c-40b3-90c7-75b0eee6c0b9	66329f4e-8fc4-4053-af79-ad673fd69478	1	1657441344	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1657441344","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
5794f217-92ea-4c7f-9bb5-41627cadb44f	66329f4e-8fc4-4053-af79-ad673fd69478	1	1659038807	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:8080/auth/realms/market","startedAt":"1659038807","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
9094bb66-6142-4a40-9644-02ae73244ef9	f1d5fb94-9e8a-4674-b0e5-ee02645d8e08	market	1659039743	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1659039687
3d99e97d-572a-47e3-8955-60a28a183bd9	f1d5fb94-9e8a-4674-b0e5-ee02645d8e08	market	1659174107	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1659174077
6a71aeea-62b2-47b5-91d3-cea2b70dbe53	f1d5fb94-9e8a-4674-b0e5-ee02645d8e08	market	1659176974	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1659176958
c6114def-2685-42aa-8144-67dc4e9acd1a	f1d5fb94-9e8a-4674-b0e5-ee02645d8e08	market	1659177328	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1659177318
7d53ae72-e4f6-4e3c-ae0b-9d25e12467fd	f1d5fb94-9e8a-4674-b0e5-ee02645d8e08	market	1659177650	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1659177618
cbba0bcd-f095-41d8-9789-2d7e32c00eaf	f1d5fb94-9e8a-4674-b0e5-ee02645d8e08	market	1659182577	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1659182538
ac8687af-d9cb-4fe5-b94d-cfa010d7cfdb	f1d5fb94-9e8a-4674-b0e5-ee02645d8e08	market	1659182912	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1659182898
166d899f-9072-4068-9eb4-3faf39a4ebd0	f1d5fb94-9e8a-4674-b0e5-ee02645d8e08	market	1659183555	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1659183498
d804b28b-3c04-4b0d-805c-fafd7d46dc92	f1d5fb94-9e8a-4674-b0e5-ee02645d8e08	market	1659184082	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1659184038
f4749cc2-7f52-4e29-af83-a7ce09c36e47	f1d5fb94-9e8a-4674-b0e5-ee02645d8e08	market	1659184399	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1659184398
34fe9c55-c197-4e46-9ae3-da3bca14cae5	02b994d3-8825-471a-b516-6e997a797ab5	market	1657351679	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657351661
3ce51051-a58d-4e0b-8e2c-0b218d267237	02b994d3-8825-471a-b516-6e997a797ab5	market	1657352011	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657351961
5a8e09eb-b8dd-44a0-80de-de39bc9d55de	f1d5fb94-9e8a-4674-b0e5-ee02645d8e08	market	1657352125	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657352081
87daad00-ccec-4968-a463-84e376476bf4	02b994d3-8825-471a-b516-6e997a797ab5	market	1657352167	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657352141
01972280-e9ea-417b-a282-ff74557d9d44	02b994d3-8825-471a-b516-6e997a797ab5	market	1657352585	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657352561
acf8795c-8ea3-4601-94b2-960e0fca6bc7	02b994d3-8825-471a-b516-6e997a797ab5	market	1657358184	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657358163
75d17d77-6761-4265-8d5b-b1b980e93618	02b994d3-8825-471a-b516-6e997a797ab5	market	1657358187	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657358163
5d61d1ea-37aa-4020-a665-7200b5ce9b89	02b994d3-8825-471a-b516-6e997a797ab5	market	1657358680	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657358643
9e96d9e4-c784-4214-87d5-f2183cbd6bdf	02b994d3-8825-471a-b516-6e997a797ab5	market	1657359212	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657359183
ec7ff3f0-63e6-406d-bab2-88b9c7d81300	02b994d3-8825-471a-b516-6e997a797ab5	market	1657359670	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657359663
cdf209b5-73e8-4843-b1b2-e99cdd513651	02b994d3-8825-471a-b516-6e997a797ab5	market	1657360056	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657360023
69caf0ca-e4ba-48cb-bdb6-3be649d4c8fa	02b994d3-8825-471a-b516-6e997a797ab5	market	1657361122	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657361103
b3220125-0d41-4f7a-9159-33e2fdf44146	f1d5fb94-9e8a-4674-b0e5-ee02645d8e08	market	1657361618	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657361583
1baf1756-c540-4bbf-bc82-bc2eb3e9cd6e	f1d5fb94-9e8a-4674-b0e5-ee02645d8e08	market	1657361930	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657361883
0142340a-5dac-4c50-86b1-6801f4ef9798	f1d5fb94-9e8a-4674-b0e5-ee02645d8e08	market	1657362412	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657362363
84198ce5-778a-4be9-a314-a49cd136939d	f1d5fb94-9e8a-4674-b0e5-ee02645d8e08	market	1657372794	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657372743
2eb37f16-adc7-45b0-b68d-ea13f8fbaf14	02b994d3-8825-471a-b516-6e997a797ab5	market	1657441173	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657441173
a45efac5-4396-4246-9175-06241b15a20c	02b994d3-8825-471a-b516-6e997a797ab5	market	1657441218	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657441173
b1c45bef-eeaa-4787-b0fc-10629be3b6bd	02b994d3-8825-471a-b516-6e997a797ab5	market	1657441292	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657441233
5c652353-455f-48b6-93ab-c7e170708e72	02b994d3-8825-471a-b516-6e997a797ab5	market	1657441313	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657441293
dada8eb0-0d4a-4cbe-86f4-c8263eb7db78	02b994d3-8825-471a-b516-6e997a797ab5	market	1657441319	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657441293
7b07ba10-b7bc-411d-a5fa-44dfbd80aeaa	02b994d3-8825-471a-b516-6e997a797ab5	market	1657441325	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657441293
7d2e2759-217c-40b3-90c7-75b0eee6c0b9	02b994d3-8825-471a-b516-6e997a797ab5	market	1657441344	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1657441293
5794f217-92ea-4c7f-9bb5-41627cadb44f	f1d5fb94-9e8a-4674-b0e5-ee02645d8e08	market	1659038806	1	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1659038787
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
0bac1d0c-c8d6-45d8-9758-e38e881877b4	audience resolve	openid-connect	oidc-audience-resolve-mapper	3e40bc9a-7869-4df6-9598-4dbc88af9db0	\N
fbc71491-07f5-4ebe-a6c3-467a8623d407	locale	openid-connect	oidc-usermodel-attribute-mapper	3a8a34ee-4f56-4de8-a61a-cb40205b6af9	\N
03aa548e-20ce-47fe-b716-10c4e6e08e0a	role list	saml	saml-role-list-mapper	\N	d0d3a2d1-9102-4bb7-a94a-05d7fb861237
9e49d82d-6ff5-4d9c-bd2b-f54608bdc964	full name	openid-connect	oidc-full-name-mapper	\N	9dc2f965-7008-4356-89fa-d880a753bdb9
9467ef96-518c-4b34-a461-b67b43522592	family name	openid-connect	oidc-usermodel-property-mapper	\N	9dc2f965-7008-4356-89fa-d880a753bdb9
9d4c1b10-fd71-4b00-a626-af733691260d	given name	openid-connect	oidc-usermodel-property-mapper	\N	9dc2f965-7008-4356-89fa-d880a753bdb9
0455c1a1-17a9-46cb-b7dd-d3b71eb88eb3	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	9dc2f965-7008-4356-89fa-d880a753bdb9
a85a43ab-3457-4ef4-8778-0dee564a40e1	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	9dc2f965-7008-4356-89fa-d880a753bdb9
c8fff8be-36ad-49d1-b021-1f3293fad0f6	username	openid-connect	oidc-usermodel-property-mapper	\N	9dc2f965-7008-4356-89fa-d880a753bdb9
986d1874-2a96-4ec0-b86b-bafda6f1a15f	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	9dc2f965-7008-4356-89fa-d880a753bdb9
c1838249-ce94-4e0b-83c3-65e9a899bf81	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	9dc2f965-7008-4356-89fa-d880a753bdb9
7f4c8ddb-5499-49ad-aa2c-f70ac2cac5d7	website	openid-connect	oidc-usermodel-attribute-mapper	\N	9dc2f965-7008-4356-89fa-d880a753bdb9
c648d670-1335-4e4e-96cf-d81aab3f5bad	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	9dc2f965-7008-4356-89fa-d880a753bdb9
5a87e9fc-bbbc-40ef-a2d6-7f5136a9ccde	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	9dc2f965-7008-4356-89fa-d880a753bdb9
4dfdde1f-a469-46af-941a-fda0cd1ce69b	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	9dc2f965-7008-4356-89fa-d880a753bdb9
beb6dd6a-a886-4f37-9a11-0a87a88b41e5	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	9dc2f965-7008-4356-89fa-d880a753bdb9
6d82edab-2991-4c09-8fba-49cb428438dc	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	9dc2f965-7008-4356-89fa-d880a753bdb9
df243c34-d59c-4dda-a8a8-3858bae147cc	email	openid-connect	oidc-usermodel-property-mapper	\N	beb5e2ad-2fd6-451b-8fae-82547bcb2327
6c1849e7-190f-4362-a466-1c6750879b8b	email verified	openid-connect	oidc-usermodel-property-mapper	\N	beb5e2ad-2fd6-451b-8fae-82547bcb2327
c8d3ea8f-f76c-4abc-ac37-f7f0a1d5ce98	address	openid-connect	oidc-address-mapper	\N	bc8bb6c2-fa14-4580-bfae-a79a7591302c
84683e2b-9f09-4ab0-8865-d9efc129135f	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	2972fc4d-cb8b-447a-a490-f80203fd4284
bcbca687-efb9-4284-9fb4-154ea090922a	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	2972fc4d-cb8b-447a-a490-f80203fd4284
bf5a4bbb-a1e3-4b66-82eb-e937cc2f48c7	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	4fe67e1f-9b81-4d83-bc47-3825942df3df
3889dc6f-7745-46ea-a8f3-c4c467c7a3fa	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	4fe67e1f-9b81-4d83-bc47-3825942df3df
250c2bb0-81d5-4824-947c-198e76e8a524	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	4fe67e1f-9b81-4d83-bc47-3825942df3df
b3685ce5-919e-43f8-a10e-74bc4906cd88	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	94efff6f-c7b1-40d3-811f-ea07e0a10517
3dca09f4-798b-44c9-8092-d7bb760d76c3	upn	openid-connect	oidc-usermodel-property-mapper	\N	083098cd-8e40-4979-a160-608fae61656a
27a8a04f-aae7-4d97-8185-e6e31cfe7419	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	083098cd-8e40-4979-a160-608fae61656a
13fd76de-03ad-4378-b551-afd6502f3ce8	acr loa level	openid-connect	oidc-acr-mapper	\N	22d11a31-792b-4ba4-b1bc-620e3974afef
892e2ec2-93d3-464b-8b77-b8684ad698b4	role list	saml	saml-role-list-mapper	\N	0db1b3ef-62aa-46f9-82d5-b5072649c79e
7e2b7167-356f-41c8-911a-0bbc1f7e8aee	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	1ac1e7b3-e35c-49d9-aa38-d1d6fbbac6f5
71cebabc-e128-4783-b0f2-2fd917adacbc	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	e3c0c50d-beea-4cfa-ad0d-bb34d8fda575
ceddcbc6-b2fb-4f2f-8d49-ebff86913454	upn	openid-connect	oidc-usermodel-property-mapper	\N	e3c0c50d-beea-4cfa-ad0d-bb34d8fda575
8287226d-7966-4aa3-89db-651524e90e68	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	e142d712-3271-430d-8bea-681a6bc6fa1a
527acbe5-3cd4-4be7-807b-077545af81e5	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	e142d712-3271-430d-8bea-681a6bc6fa1a
c0cbe12a-4989-4390-903f-238a94a6edeb	address	openid-connect	oidc-address-mapper	\N	9182e1f8-2f08-4749-b56d-86db33ca9930
89bea514-5db9-4d4b-9bfa-86e821b156a8	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	2bda4696-f2c5-421a-a638-d53fca562ea6
1b6d5d6e-f385-42b6-9eef-de0237154493	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	2bda4696-f2c5-421a-a638-d53fca562ea6
0ee0bcaf-38e2-4628-aba3-d5a19fc1c1cb	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	2bda4696-f2c5-421a-a638-d53fca562ea6
f1eda575-234d-49a9-b332-870ef8e4ee34	acr loa level	openid-connect	oidc-acr-mapper	\N	d21fee02-7810-4fe8-95c6-8662b3c6d01b
8fa987c1-edc4-4627-9a1c-89b2006f00c2	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	fc9062a7-ce90-4f36-90c7-07bacc64f969
d226370f-9657-4dbc-a08e-dd4d7474aaf0	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	fc9062a7-ce90-4f36-90c7-07bacc64f969
8ba38c26-4e64-499f-b26a-4dac7b65e5e2	username	openid-connect	oidc-usermodel-property-mapper	\N	fc9062a7-ce90-4f36-90c7-07bacc64f969
d33477f1-78dd-4b51-a5cf-45d267fbd840	full name	openid-connect	oidc-full-name-mapper	\N	fc9062a7-ce90-4f36-90c7-07bacc64f969
c5b21a31-a5d4-4baf-be82-3ac1c6f2f7fb	website	openid-connect	oidc-usermodel-attribute-mapper	\N	fc9062a7-ce90-4f36-90c7-07bacc64f969
b457d883-4d2c-4b91-9d3c-c65353040203	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	fc9062a7-ce90-4f36-90c7-07bacc64f969
9ee44d95-5040-4931-987c-c6ff68aa0cb2	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	fc9062a7-ce90-4f36-90c7-07bacc64f969
6fd508f8-286a-423a-b236-6ecf76794809	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	fc9062a7-ce90-4f36-90c7-07bacc64f969
0371cdd6-da33-4fce-8ba5-ffd9c128a56a	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	fc9062a7-ce90-4f36-90c7-07bacc64f969
59a52c19-3552-420e-8182-194d3d6a6db4	family name	openid-connect	oidc-usermodel-property-mapper	\N	fc9062a7-ce90-4f36-90c7-07bacc64f969
b8776830-968d-4d61-bb7f-0a21baa15cbb	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	fc9062a7-ce90-4f36-90c7-07bacc64f969
ccaaf2e7-9cb1-425e-aa23-ae638823b831	given name	openid-connect	oidc-usermodel-property-mapper	\N	fc9062a7-ce90-4f36-90c7-07bacc64f969
743a7b80-0e64-4910-ac17-11e00a14dc25	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	fc9062a7-ce90-4f36-90c7-07bacc64f969
eddffb12-43cd-4ddb-a685-2469e6614f20	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	fc9062a7-ce90-4f36-90c7-07bacc64f969
a9e67344-d1f2-4750-9f0b-2e9a86e4f91d	email	openid-connect	oidc-usermodel-property-mapper	\N	8730910e-2c6a-4e8f-88d5-8d6e700dbe43
aa77e116-1404-4f9a-9c69-a95e1a063723	email verified	openid-connect	oidc-usermodel-property-mapper	\N	8730910e-2c6a-4e8f-88d5-8d6e700dbe43
2550c1ab-4ecd-4b51-a519-686ee2b4111a	audience resolve	openid-connect	oidc-audience-resolve-mapper	62552ade-38be-4219-8acc-e7fcbd6d3286	\N
7c606e13-b5af-4ad6-8f67-9cb6db2d7a39	locale	openid-connect	oidc-usermodel-attribute-mapper	bf40a050-cc4a-4e5b-9089-6aaefb033e20	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
fbc71491-07f5-4ebe-a6c3-467a8623d407	true	userinfo.token.claim
fbc71491-07f5-4ebe-a6c3-467a8623d407	locale	user.attribute
fbc71491-07f5-4ebe-a6c3-467a8623d407	true	id.token.claim
fbc71491-07f5-4ebe-a6c3-467a8623d407	true	access.token.claim
fbc71491-07f5-4ebe-a6c3-467a8623d407	locale	claim.name
fbc71491-07f5-4ebe-a6c3-467a8623d407	String	jsonType.label
03aa548e-20ce-47fe-b716-10c4e6e08e0a	false	single
03aa548e-20ce-47fe-b716-10c4e6e08e0a	Basic	attribute.nameformat
03aa548e-20ce-47fe-b716-10c4e6e08e0a	Role	attribute.name
9e49d82d-6ff5-4d9c-bd2b-f54608bdc964	true	userinfo.token.claim
9e49d82d-6ff5-4d9c-bd2b-f54608bdc964	true	id.token.claim
9e49d82d-6ff5-4d9c-bd2b-f54608bdc964	true	access.token.claim
9467ef96-518c-4b34-a461-b67b43522592	true	userinfo.token.claim
9467ef96-518c-4b34-a461-b67b43522592	lastName	user.attribute
9467ef96-518c-4b34-a461-b67b43522592	true	id.token.claim
9467ef96-518c-4b34-a461-b67b43522592	true	access.token.claim
9467ef96-518c-4b34-a461-b67b43522592	family_name	claim.name
9467ef96-518c-4b34-a461-b67b43522592	String	jsonType.label
9d4c1b10-fd71-4b00-a626-af733691260d	true	userinfo.token.claim
9d4c1b10-fd71-4b00-a626-af733691260d	firstName	user.attribute
9d4c1b10-fd71-4b00-a626-af733691260d	true	id.token.claim
9d4c1b10-fd71-4b00-a626-af733691260d	true	access.token.claim
9d4c1b10-fd71-4b00-a626-af733691260d	given_name	claim.name
9d4c1b10-fd71-4b00-a626-af733691260d	String	jsonType.label
0455c1a1-17a9-46cb-b7dd-d3b71eb88eb3	true	userinfo.token.claim
0455c1a1-17a9-46cb-b7dd-d3b71eb88eb3	middleName	user.attribute
0455c1a1-17a9-46cb-b7dd-d3b71eb88eb3	true	id.token.claim
0455c1a1-17a9-46cb-b7dd-d3b71eb88eb3	true	access.token.claim
0455c1a1-17a9-46cb-b7dd-d3b71eb88eb3	middle_name	claim.name
0455c1a1-17a9-46cb-b7dd-d3b71eb88eb3	String	jsonType.label
a85a43ab-3457-4ef4-8778-0dee564a40e1	true	userinfo.token.claim
a85a43ab-3457-4ef4-8778-0dee564a40e1	nickname	user.attribute
a85a43ab-3457-4ef4-8778-0dee564a40e1	true	id.token.claim
a85a43ab-3457-4ef4-8778-0dee564a40e1	true	access.token.claim
a85a43ab-3457-4ef4-8778-0dee564a40e1	nickname	claim.name
a85a43ab-3457-4ef4-8778-0dee564a40e1	String	jsonType.label
c8fff8be-36ad-49d1-b021-1f3293fad0f6	true	userinfo.token.claim
c8fff8be-36ad-49d1-b021-1f3293fad0f6	username	user.attribute
c8fff8be-36ad-49d1-b021-1f3293fad0f6	true	id.token.claim
c8fff8be-36ad-49d1-b021-1f3293fad0f6	true	access.token.claim
c8fff8be-36ad-49d1-b021-1f3293fad0f6	preferred_username	claim.name
c8fff8be-36ad-49d1-b021-1f3293fad0f6	String	jsonType.label
986d1874-2a96-4ec0-b86b-bafda6f1a15f	true	userinfo.token.claim
986d1874-2a96-4ec0-b86b-bafda6f1a15f	profile	user.attribute
986d1874-2a96-4ec0-b86b-bafda6f1a15f	true	id.token.claim
986d1874-2a96-4ec0-b86b-bafda6f1a15f	true	access.token.claim
986d1874-2a96-4ec0-b86b-bafda6f1a15f	profile	claim.name
986d1874-2a96-4ec0-b86b-bafda6f1a15f	String	jsonType.label
c1838249-ce94-4e0b-83c3-65e9a899bf81	true	userinfo.token.claim
c1838249-ce94-4e0b-83c3-65e9a899bf81	picture	user.attribute
c1838249-ce94-4e0b-83c3-65e9a899bf81	true	id.token.claim
c1838249-ce94-4e0b-83c3-65e9a899bf81	true	access.token.claim
c1838249-ce94-4e0b-83c3-65e9a899bf81	picture	claim.name
c1838249-ce94-4e0b-83c3-65e9a899bf81	String	jsonType.label
7f4c8ddb-5499-49ad-aa2c-f70ac2cac5d7	true	userinfo.token.claim
7f4c8ddb-5499-49ad-aa2c-f70ac2cac5d7	website	user.attribute
7f4c8ddb-5499-49ad-aa2c-f70ac2cac5d7	true	id.token.claim
7f4c8ddb-5499-49ad-aa2c-f70ac2cac5d7	true	access.token.claim
7f4c8ddb-5499-49ad-aa2c-f70ac2cac5d7	website	claim.name
7f4c8ddb-5499-49ad-aa2c-f70ac2cac5d7	String	jsonType.label
c648d670-1335-4e4e-96cf-d81aab3f5bad	true	userinfo.token.claim
c648d670-1335-4e4e-96cf-d81aab3f5bad	gender	user.attribute
c648d670-1335-4e4e-96cf-d81aab3f5bad	true	id.token.claim
c648d670-1335-4e4e-96cf-d81aab3f5bad	true	access.token.claim
c648d670-1335-4e4e-96cf-d81aab3f5bad	gender	claim.name
c648d670-1335-4e4e-96cf-d81aab3f5bad	String	jsonType.label
5a87e9fc-bbbc-40ef-a2d6-7f5136a9ccde	true	userinfo.token.claim
5a87e9fc-bbbc-40ef-a2d6-7f5136a9ccde	birthdate	user.attribute
5a87e9fc-bbbc-40ef-a2d6-7f5136a9ccde	true	id.token.claim
5a87e9fc-bbbc-40ef-a2d6-7f5136a9ccde	true	access.token.claim
5a87e9fc-bbbc-40ef-a2d6-7f5136a9ccde	birthdate	claim.name
5a87e9fc-bbbc-40ef-a2d6-7f5136a9ccde	String	jsonType.label
4dfdde1f-a469-46af-941a-fda0cd1ce69b	true	userinfo.token.claim
4dfdde1f-a469-46af-941a-fda0cd1ce69b	zoneinfo	user.attribute
4dfdde1f-a469-46af-941a-fda0cd1ce69b	true	id.token.claim
4dfdde1f-a469-46af-941a-fda0cd1ce69b	true	access.token.claim
4dfdde1f-a469-46af-941a-fda0cd1ce69b	zoneinfo	claim.name
4dfdde1f-a469-46af-941a-fda0cd1ce69b	String	jsonType.label
beb6dd6a-a886-4f37-9a11-0a87a88b41e5	true	userinfo.token.claim
beb6dd6a-a886-4f37-9a11-0a87a88b41e5	locale	user.attribute
beb6dd6a-a886-4f37-9a11-0a87a88b41e5	true	id.token.claim
beb6dd6a-a886-4f37-9a11-0a87a88b41e5	true	access.token.claim
beb6dd6a-a886-4f37-9a11-0a87a88b41e5	locale	claim.name
beb6dd6a-a886-4f37-9a11-0a87a88b41e5	String	jsonType.label
6d82edab-2991-4c09-8fba-49cb428438dc	true	userinfo.token.claim
6d82edab-2991-4c09-8fba-49cb428438dc	updatedAt	user.attribute
6d82edab-2991-4c09-8fba-49cb428438dc	true	id.token.claim
6d82edab-2991-4c09-8fba-49cb428438dc	true	access.token.claim
6d82edab-2991-4c09-8fba-49cb428438dc	updated_at	claim.name
6d82edab-2991-4c09-8fba-49cb428438dc	long	jsonType.label
df243c34-d59c-4dda-a8a8-3858bae147cc	true	userinfo.token.claim
df243c34-d59c-4dda-a8a8-3858bae147cc	email	user.attribute
df243c34-d59c-4dda-a8a8-3858bae147cc	true	id.token.claim
df243c34-d59c-4dda-a8a8-3858bae147cc	true	access.token.claim
df243c34-d59c-4dda-a8a8-3858bae147cc	email	claim.name
df243c34-d59c-4dda-a8a8-3858bae147cc	String	jsonType.label
6c1849e7-190f-4362-a466-1c6750879b8b	true	userinfo.token.claim
6c1849e7-190f-4362-a466-1c6750879b8b	emailVerified	user.attribute
6c1849e7-190f-4362-a466-1c6750879b8b	true	id.token.claim
6c1849e7-190f-4362-a466-1c6750879b8b	true	access.token.claim
6c1849e7-190f-4362-a466-1c6750879b8b	email_verified	claim.name
6c1849e7-190f-4362-a466-1c6750879b8b	boolean	jsonType.label
c8d3ea8f-f76c-4abc-ac37-f7f0a1d5ce98	formatted	user.attribute.formatted
c8d3ea8f-f76c-4abc-ac37-f7f0a1d5ce98	country	user.attribute.country
c8d3ea8f-f76c-4abc-ac37-f7f0a1d5ce98	postal_code	user.attribute.postal_code
c8d3ea8f-f76c-4abc-ac37-f7f0a1d5ce98	true	userinfo.token.claim
c8d3ea8f-f76c-4abc-ac37-f7f0a1d5ce98	street	user.attribute.street
c8d3ea8f-f76c-4abc-ac37-f7f0a1d5ce98	true	id.token.claim
c8d3ea8f-f76c-4abc-ac37-f7f0a1d5ce98	region	user.attribute.region
c8d3ea8f-f76c-4abc-ac37-f7f0a1d5ce98	true	access.token.claim
c8d3ea8f-f76c-4abc-ac37-f7f0a1d5ce98	locality	user.attribute.locality
84683e2b-9f09-4ab0-8865-d9efc129135f	true	userinfo.token.claim
84683e2b-9f09-4ab0-8865-d9efc129135f	phoneNumber	user.attribute
84683e2b-9f09-4ab0-8865-d9efc129135f	true	id.token.claim
84683e2b-9f09-4ab0-8865-d9efc129135f	true	access.token.claim
84683e2b-9f09-4ab0-8865-d9efc129135f	phone_number	claim.name
84683e2b-9f09-4ab0-8865-d9efc129135f	String	jsonType.label
bcbca687-efb9-4284-9fb4-154ea090922a	true	userinfo.token.claim
bcbca687-efb9-4284-9fb4-154ea090922a	phoneNumberVerified	user.attribute
bcbca687-efb9-4284-9fb4-154ea090922a	true	id.token.claim
bcbca687-efb9-4284-9fb4-154ea090922a	true	access.token.claim
bcbca687-efb9-4284-9fb4-154ea090922a	phone_number_verified	claim.name
bcbca687-efb9-4284-9fb4-154ea090922a	boolean	jsonType.label
bf5a4bbb-a1e3-4b66-82eb-e937cc2f48c7	true	multivalued
bf5a4bbb-a1e3-4b66-82eb-e937cc2f48c7	foo	user.attribute
bf5a4bbb-a1e3-4b66-82eb-e937cc2f48c7	true	access.token.claim
bf5a4bbb-a1e3-4b66-82eb-e937cc2f48c7	realm_access.roles	claim.name
bf5a4bbb-a1e3-4b66-82eb-e937cc2f48c7	String	jsonType.label
3889dc6f-7745-46ea-a8f3-c4c467c7a3fa	true	multivalued
3889dc6f-7745-46ea-a8f3-c4c467c7a3fa	foo	user.attribute
3889dc6f-7745-46ea-a8f3-c4c467c7a3fa	true	access.token.claim
3889dc6f-7745-46ea-a8f3-c4c467c7a3fa	resource_access.${client_id}.roles	claim.name
3889dc6f-7745-46ea-a8f3-c4c467c7a3fa	String	jsonType.label
3dca09f4-798b-44c9-8092-d7bb760d76c3	true	userinfo.token.claim
3dca09f4-798b-44c9-8092-d7bb760d76c3	username	user.attribute
3dca09f4-798b-44c9-8092-d7bb760d76c3	true	id.token.claim
3dca09f4-798b-44c9-8092-d7bb760d76c3	true	access.token.claim
3dca09f4-798b-44c9-8092-d7bb760d76c3	upn	claim.name
3dca09f4-798b-44c9-8092-d7bb760d76c3	String	jsonType.label
27a8a04f-aae7-4d97-8185-e6e31cfe7419	true	multivalued
27a8a04f-aae7-4d97-8185-e6e31cfe7419	foo	user.attribute
27a8a04f-aae7-4d97-8185-e6e31cfe7419	true	id.token.claim
27a8a04f-aae7-4d97-8185-e6e31cfe7419	true	access.token.claim
27a8a04f-aae7-4d97-8185-e6e31cfe7419	groups	claim.name
27a8a04f-aae7-4d97-8185-e6e31cfe7419	String	jsonType.label
13fd76de-03ad-4378-b551-afd6502f3ce8	true	id.token.claim
13fd76de-03ad-4378-b551-afd6502f3ce8	true	access.token.claim
892e2ec2-93d3-464b-8b77-b8684ad698b4	false	single
892e2ec2-93d3-464b-8b77-b8684ad698b4	Basic	attribute.nameformat
892e2ec2-93d3-464b-8b77-b8684ad698b4	Role	attribute.name
71cebabc-e128-4783-b0f2-2fd917adacbc	true	multivalued
71cebabc-e128-4783-b0f2-2fd917adacbc	true	userinfo.token.claim
71cebabc-e128-4783-b0f2-2fd917adacbc	foo	user.attribute
71cebabc-e128-4783-b0f2-2fd917adacbc	true	id.token.claim
71cebabc-e128-4783-b0f2-2fd917adacbc	true	access.token.claim
71cebabc-e128-4783-b0f2-2fd917adacbc	groups	claim.name
71cebabc-e128-4783-b0f2-2fd917adacbc	String	jsonType.label
ceddcbc6-b2fb-4f2f-8d49-ebff86913454	true	userinfo.token.claim
ceddcbc6-b2fb-4f2f-8d49-ebff86913454	username	user.attribute
ceddcbc6-b2fb-4f2f-8d49-ebff86913454	true	id.token.claim
ceddcbc6-b2fb-4f2f-8d49-ebff86913454	true	access.token.claim
ceddcbc6-b2fb-4f2f-8d49-ebff86913454	upn	claim.name
ceddcbc6-b2fb-4f2f-8d49-ebff86913454	String	jsonType.label
8287226d-7966-4aa3-89db-651524e90e68	true	userinfo.token.claim
8287226d-7966-4aa3-89db-651524e90e68	phoneNumber	user.attribute
8287226d-7966-4aa3-89db-651524e90e68	true	id.token.claim
8287226d-7966-4aa3-89db-651524e90e68	true	access.token.claim
8287226d-7966-4aa3-89db-651524e90e68	phone_number	claim.name
8287226d-7966-4aa3-89db-651524e90e68	String	jsonType.label
527acbe5-3cd4-4be7-807b-077545af81e5	true	userinfo.token.claim
527acbe5-3cd4-4be7-807b-077545af81e5	phoneNumberVerified	user.attribute
527acbe5-3cd4-4be7-807b-077545af81e5	true	id.token.claim
527acbe5-3cd4-4be7-807b-077545af81e5	true	access.token.claim
527acbe5-3cd4-4be7-807b-077545af81e5	phone_number_verified	claim.name
527acbe5-3cd4-4be7-807b-077545af81e5	boolean	jsonType.label
c0cbe12a-4989-4390-903f-238a94a6edeb	formatted	user.attribute.formatted
c0cbe12a-4989-4390-903f-238a94a6edeb	country	user.attribute.country
c0cbe12a-4989-4390-903f-238a94a6edeb	postal_code	user.attribute.postal_code
c0cbe12a-4989-4390-903f-238a94a6edeb	true	userinfo.token.claim
c0cbe12a-4989-4390-903f-238a94a6edeb	street	user.attribute.street
c0cbe12a-4989-4390-903f-238a94a6edeb	true	id.token.claim
c0cbe12a-4989-4390-903f-238a94a6edeb	region	user.attribute.region
c0cbe12a-4989-4390-903f-238a94a6edeb	true	access.token.claim
c0cbe12a-4989-4390-903f-238a94a6edeb	locality	user.attribute.locality
89bea514-5db9-4d4b-9bfa-86e821b156a8	foo	user.attribute
89bea514-5db9-4d4b-9bfa-86e821b156a8	true	access.token.claim
89bea514-5db9-4d4b-9bfa-86e821b156a8	realm_access.roles	claim.name
89bea514-5db9-4d4b-9bfa-86e821b156a8	String	jsonType.label
89bea514-5db9-4d4b-9bfa-86e821b156a8	true	multivalued
1b6d5d6e-f385-42b6-9eef-de0237154493	foo	user.attribute
1b6d5d6e-f385-42b6-9eef-de0237154493	true	access.token.claim
1b6d5d6e-f385-42b6-9eef-de0237154493	resource_access.${client_id}.roles	claim.name
1b6d5d6e-f385-42b6-9eef-de0237154493	String	jsonType.label
1b6d5d6e-f385-42b6-9eef-de0237154493	true	multivalued
f1eda575-234d-49a9-b332-870ef8e4ee34	true	id.token.claim
f1eda575-234d-49a9-b332-870ef8e4ee34	true	access.token.claim
f1eda575-234d-49a9-b332-870ef8e4ee34	true	userinfo.token.claim
8fa987c1-edc4-4627-9a1c-89b2006f00c2	true	userinfo.token.claim
8fa987c1-edc4-4627-9a1c-89b2006f00c2	locale	user.attribute
8fa987c1-edc4-4627-9a1c-89b2006f00c2	true	id.token.claim
8fa987c1-edc4-4627-9a1c-89b2006f00c2	true	access.token.claim
8fa987c1-edc4-4627-9a1c-89b2006f00c2	locale	claim.name
8fa987c1-edc4-4627-9a1c-89b2006f00c2	String	jsonType.label
d226370f-9657-4dbc-a08e-dd4d7474aaf0	true	userinfo.token.claim
d226370f-9657-4dbc-a08e-dd4d7474aaf0	updatedAt	user.attribute
d226370f-9657-4dbc-a08e-dd4d7474aaf0	true	id.token.claim
d226370f-9657-4dbc-a08e-dd4d7474aaf0	true	access.token.claim
d226370f-9657-4dbc-a08e-dd4d7474aaf0	updated_at	claim.name
d226370f-9657-4dbc-a08e-dd4d7474aaf0	long	jsonType.label
8ba38c26-4e64-499f-b26a-4dac7b65e5e2	true	userinfo.token.claim
8ba38c26-4e64-499f-b26a-4dac7b65e5e2	username	user.attribute
8ba38c26-4e64-499f-b26a-4dac7b65e5e2	true	id.token.claim
8ba38c26-4e64-499f-b26a-4dac7b65e5e2	true	access.token.claim
8ba38c26-4e64-499f-b26a-4dac7b65e5e2	preferred_username	claim.name
8ba38c26-4e64-499f-b26a-4dac7b65e5e2	String	jsonType.label
d33477f1-78dd-4b51-a5cf-45d267fbd840	true	id.token.claim
d33477f1-78dd-4b51-a5cf-45d267fbd840	true	access.token.claim
d33477f1-78dd-4b51-a5cf-45d267fbd840	true	userinfo.token.claim
c5b21a31-a5d4-4baf-be82-3ac1c6f2f7fb	true	userinfo.token.claim
c5b21a31-a5d4-4baf-be82-3ac1c6f2f7fb	website	user.attribute
c5b21a31-a5d4-4baf-be82-3ac1c6f2f7fb	true	id.token.claim
c5b21a31-a5d4-4baf-be82-3ac1c6f2f7fb	true	access.token.claim
c5b21a31-a5d4-4baf-be82-3ac1c6f2f7fb	website	claim.name
c5b21a31-a5d4-4baf-be82-3ac1c6f2f7fb	String	jsonType.label
b457d883-4d2c-4b91-9d3c-c65353040203	true	userinfo.token.claim
b457d883-4d2c-4b91-9d3c-c65353040203	zoneinfo	user.attribute
b457d883-4d2c-4b91-9d3c-c65353040203	true	id.token.claim
b457d883-4d2c-4b91-9d3c-c65353040203	true	access.token.claim
b457d883-4d2c-4b91-9d3c-c65353040203	zoneinfo	claim.name
b457d883-4d2c-4b91-9d3c-c65353040203	String	jsonType.label
9ee44d95-5040-4931-987c-c6ff68aa0cb2	true	userinfo.token.claim
9ee44d95-5040-4931-987c-c6ff68aa0cb2	profile	user.attribute
9ee44d95-5040-4931-987c-c6ff68aa0cb2	true	id.token.claim
9ee44d95-5040-4931-987c-c6ff68aa0cb2	true	access.token.claim
9ee44d95-5040-4931-987c-c6ff68aa0cb2	profile	claim.name
9ee44d95-5040-4931-987c-c6ff68aa0cb2	String	jsonType.label
6fd508f8-286a-423a-b236-6ecf76794809	true	userinfo.token.claim
6fd508f8-286a-423a-b236-6ecf76794809	picture	user.attribute
6fd508f8-286a-423a-b236-6ecf76794809	true	id.token.claim
6fd508f8-286a-423a-b236-6ecf76794809	true	access.token.claim
6fd508f8-286a-423a-b236-6ecf76794809	picture	claim.name
6fd508f8-286a-423a-b236-6ecf76794809	String	jsonType.label
0371cdd6-da33-4fce-8ba5-ffd9c128a56a	true	userinfo.token.claim
0371cdd6-da33-4fce-8ba5-ffd9c128a56a	nickname	user.attribute
0371cdd6-da33-4fce-8ba5-ffd9c128a56a	true	id.token.claim
0371cdd6-da33-4fce-8ba5-ffd9c128a56a	true	access.token.claim
0371cdd6-da33-4fce-8ba5-ffd9c128a56a	nickname	claim.name
0371cdd6-da33-4fce-8ba5-ffd9c128a56a	String	jsonType.label
59a52c19-3552-420e-8182-194d3d6a6db4	true	userinfo.token.claim
59a52c19-3552-420e-8182-194d3d6a6db4	lastName	user.attribute
59a52c19-3552-420e-8182-194d3d6a6db4	true	id.token.claim
59a52c19-3552-420e-8182-194d3d6a6db4	true	access.token.claim
59a52c19-3552-420e-8182-194d3d6a6db4	family_name	claim.name
59a52c19-3552-420e-8182-194d3d6a6db4	String	jsonType.label
b8776830-968d-4d61-bb7f-0a21baa15cbb	true	userinfo.token.claim
b8776830-968d-4d61-bb7f-0a21baa15cbb	middleName	user.attribute
b8776830-968d-4d61-bb7f-0a21baa15cbb	true	id.token.claim
b8776830-968d-4d61-bb7f-0a21baa15cbb	true	access.token.claim
b8776830-968d-4d61-bb7f-0a21baa15cbb	middle_name	claim.name
b8776830-968d-4d61-bb7f-0a21baa15cbb	String	jsonType.label
ccaaf2e7-9cb1-425e-aa23-ae638823b831	true	userinfo.token.claim
ccaaf2e7-9cb1-425e-aa23-ae638823b831	firstName	user.attribute
ccaaf2e7-9cb1-425e-aa23-ae638823b831	true	id.token.claim
ccaaf2e7-9cb1-425e-aa23-ae638823b831	true	access.token.claim
ccaaf2e7-9cb1-425e-aa23-ae638823b831	given_name	claim.name
ccaaf2e7-9cb1-425e-aa23-ae638823b831	String	jsonType.label
743a7b80-0e64-4910-ac17-11e00a14dc25	true	userinfo.token.claim
743a7b80-0e64-4910-ac17-11e00a14dc25	birthdate	user.attribute
743a7b80-0e64-4910-ac17-11e00a14dc25	true	id.token.claim
743a7b80-0e64-4910-ac17-11e00a14dc25	true	access.token.claim
743a7b80-0e64-4910-ac17-11e00a14dc25	birthdate	claim.name
743a7b80-0e64-4910-ac17-11e00a14dc25	String	jsonType.label
eddffb12-43cd-4ddb-a685-2469e6614f20	true	userinfo.token.claim
eddffb12-43cd-4ddb-a685-2469e6614f20	gender	user.attribute
eddffb12-43cd-4ddb-a685-2469e6614f20	true	id.token.claim
eddffb12-43cd-4ddb-a685-2469e6614f20	true	access.token.claim
eddffb12-43cd-4ddb-a685-2469e6614f20	gender	claim.name
eddffb12-43cd-4ddb-a685-2469e6614f20	String	jsonType.label
a9e67344-d1f2-4750-9f0b-2e9a86e4f91d	true	userinfo.token.claim
a9e67344-d1f2-4750-9f0b-2e9a86e4f91d	email	user.attribute
a9e67344-d1f2-4750-9f0b-2e9a86e4f91d	true	id.token.claim
a9e67344-d1f2-4750-9f0b-2e9a86e4f91d	true	access.token.claim
a9e67344-d1f2-4750-9f0b-2e9a86e4f91d	email	claim.name
a9e67344-d1f2-4750-9f0b-2e9a86e4f91d	String	jsonType.label
aa77e116-1404-4f9a-9c69-a95e1a063723	true	userinfo.token.claim
aa77e116-1404-4f9a-9c69-a95e1a063723	emailVerified	user.attribute
aa77e116-1404-4f9a-9c69-a95e1a063723	true	id.token.claim
aa77e116-1404-4f9a-9c69-a95e1a063723	true	access.token.claim
aa77e116-1404-4f9a-9c69-a95e1a063723	email_verified	claim.name
aa77e116-1404-4f9a-9c69-a95e1a063723	boolean	jsonType.label
7c606e13-b5af-4ad6-8f67-9cb6db2d7a39	true	userinfo.token.claim
7c606e13-b5af-4ad6-8f67-9cb6db2d7a39	locale	user.attribute
7c606e13-b5af-4ad6-8f67-9cb6db2d7a39	true	id.token.claim
7c606e13-b5af-4ad6-8f67-9cb6db2d7a39	true	access.token.claim
7c606e13-b5af-4ad6-8f67-9cb6db2d7a39	locale	claim.name
7c606e13-b5af-4ad6-8f67-9cb6db2d7a39	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
68547ce3-6e06-4390-a3d3-3f5eaafa1583	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	5418fcfc-96e5-419c-b7d2-911371b10bea	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	8c887b64-15ec-4df3-8cf0-dad03d379acd	059d1146-8128-4133-8303-1f9d4a2a0014	3954b6f1-5f92-4097-9202-b55d678e2942	4510dda2-46fa-4174-88c6-a71f0347810a	2a314916-4add-4e20-8cf0-8ee8483ada35	2592000	f	900	t	f	4245100b-efc8-490e-b954-0ac61c9693cf	0	f	0	0	adab8a7b-3012-4c32-9d41-2e0dec4ec209
market	60	300	300	\N	\N	\N	t	f	0	\N	market	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	f7a0a240-d1dd-469c-8e9e-f80cc62f409d	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	a4853b54-14b8-49cb-a551-665e551228c6	b94d42e9-bda5-4e7e-876a-399bc8d57325	059401de-42fd-43d0-ab19-c78c33a0ee7a	41830241-b538-4106-83e1-e3b89fa74973	23362d0f-da70-430b-a893-1aec95a4eb96	2592000	f	900	t	f	56f3d745-c96e-424e-ad6d-27664cf4d985	0	f	0	0	7ecb559e-996b-46ef-9847-576167f7963f
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	68547ce3-6e06-4390-a3d3-3f5eaafa1583	
_browser_header.xContentTypeOptions	68547ce3-6e06-4390-a3d3-3f5eaafa1583	nosniff
_browser_header.xRobotsTag	68547ce3-6e06-4390-a3d3-3f5eaafa1583	none
_browser_header.xFrameOptions	68547ce3-6e06-4390-a3d3-3f5eaafa1583	SAMEORIGIN
_browser_header.contentSecurityPolicy	68547ce3-6e06-4390-a3d3-3f5eaafa1583	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	68547ce3-6e06-4390-a3d3-3f5eaafa1583	1; mode=block
_browser_header.strictTransportSecurity	68547ce3-6e06-4390-a3d3-3f5eaafa1583	max-age=31536000; includeSubDomains
bruteForceProtected	68547ce3-6e06-4390-a3d3-3f5eaafa1583	false
permanentLockout	68547ce3-6e06-4390-a3d3-3f5eaafa1583	false
maxFailureWaitSeconds	68547ce3-6e06-4390-a3d3-3f5eaafa1583	900
minimumQuickLoginWaitSeconds	68547ce3-6e06-4390-a3d3-3f5eaafa1583	60
waitIncrementSeconds	68547ce3-6e06-4390-a3d3-3f5eaafa1583	60
quickLoginCheckMilliSeconds	68547ce3-6e06-4390-a3d3-3f5eaafa1583	1000
maxDeltaTimeSeconds	68547ce3-6e06-4390-a3d3-3f5eaafa1583	43200
failureFactor	68547ce3-6e06-4390-a3d3-3f5eaafa1583	30
displayName	68547ce3-6e06-4390-a3d3-3f5eaafa1583	Keycloak
displayNameHtml	68547ce3-6e06-4390-a3d3-3f5eaafa1583	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	68547ce3-6e06-4390-a3d3-3f5eaafa1583	RS256
offlineSessionMaxLifespanEnabled	68547ce3-6e06-4390-a3d3-3f5eaafa1583	false
offlineSessionMaxLifespan	68547ce3-6e06-4390-a3d3-3f5eaafa1583	5184000
_browser_header.contentSecurityPolicyReportOnly	market	
_browser_header.xContentTypeOptions	market	nosniff
_browser_header.xRobotsTag	market	none
_browser_header.xFrameOptions	market	SAMEORIGIN
_browser_header.contentSecurityPolicy	market	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	market	1; mode=block
_browser_header.strictTransportSecurity	market	max-age=31536000; includeSubDomains
bruteForceProtected	market	false
permanentLockout	market	false
maxFailureWaitSeconds	market	900
minimumQuickLoginWaitSeconds	market	60
waitIncrementSeconds	market	60
quickLoginCheckMilliSeconds	market	1000
maxDeltaTimeSeconds	market	43200
failureFactor	market	30
defaultSignatureAlgorithm	market	RS256
offlineSessionMaxLifespanEnabled	market	false
offlineSessionMaxLifespan	market	5184000
clientSessionIdleTimeout	market	0
clientSessionMaxLifespan	market	0
clientOfflineSessionIdleTimeout	market	0
clientOfflineSessionMaxLifespan	market	0
actionTokenGeneratedByAdminLifespan	market	43200
actionTokenGeneratedByUserLifespan	market	300
oauth2DeviceCodeLifespan	market	600
oauth2DevicePollingInterval	market	5
webAuthnPolicyRpEntityName	market	keycloak
webAuthnPolicySignatureAlgorithms	market	ES256
webAuthnPolicyRpId	market	
webAuthnPolicyAttestationConveyancePreference	market	not specified
webAuthnPolicyAuthenticatorAttachment	market	not specified
webAuthnPolicyRequireResidentKey	market	not specified
webAuthnPolicyUserVerificationRequirement	market	not specified
webAuthnPolicyCreateTimeout	market	0
webAuthnPolicyAvoidSameAuthenticatorRegister	market	false
webAuthnPolicyRpEntityNamePasswordless	market	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	market	ES256
webAuthnPolicyRpIdPasswordless	market	
webAuthnPolicyAttestationConveyancePreferencePasswordless	market	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	market	not specified
webAuthnPolicyRequireResidentKeyPasswordless	market	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	market	not specified
webAuthnPolicyCreateTimeoutPasswordless	market	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	market	false
cibaBackchannelTokenDeliveryMode	market	poll
cibaExpiresIn	market	120
cibaInterval	market	5
cibaAuthRequestedUserHint	market	login_hint
parRequestUriLifespan	market	60
client-policies.profiles	market	{"profiles":[]}
client-policies.policies	market	{"policies":[]}
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
68547ce3-6e06-4390-a3d3-3f5eaafa1583	jboss-logging
market	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	68547ce3-6e06-4390-a3d3-3f5eaafa1583
password	password	t	t	market
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
f794cd96-d496-4132-80e9-a4811508d5f4	/realms/master/account/*
3e40bc9a-7869-4df6-9598-4dbc88af9db0	/realms/master/account/*
3a8a34ee-4f56-4de8-a61a-cb40205b6af9	/admin/master/console/*
1a43c414-0d56-4b63-81c3-d645db8ca3e4	/realms/market/account/*
62552ade-38be-4219-8acc-e7fcbd6d3286	/realms/market/account/*
bf40a050-cc4a-4e5b-9089-6aaefb033e20	/admin/market/console/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
f3dd7979-0f33-442b-9cf2-cb3e3300f983	VERIFY_EMAIL	Verify Email	68547ce3-6e06-4390-a3d3-3f5eaafa1583	t	f	VERIFY_EMAIL	50
a5f081b4-aa0e-4c29-a909-4bbfee50287e	UPDATE_PROFILE	Update Profile	68547ce3-6e06-4390-a3d3-3f5eaafa1583	t	f	UPDATE_PROFILE	40
71980793-e2c4-4c71-a990-4ed093400167	CONFIGURE_TOTP	Configure OTP	68547ce3-6e06-4390-a3d3-3f5eaafa1583	t	f	CONFIGURE_TOTP	10
85c3058f-ef55-4c16-a161-84b4fff3778b	UPDATE_PASSWORD	Update Password	68547ce3-6e06-4390-a3d3-3f5eaafa1583	t	f	UPDATE_PASSWORD	30
dc1b692a-bc04-4b4a-9729-05bf2edd071d	terms_and_conditions	Terms and Conditions	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f	f	terms_and_conditions	20
3211c7bc-2c52-46b8-b12f-757f7dbe2021	update_user_locale	Update User Locale	68547ce3-6e06-4390-a3d3-3f5eaafa1583	t	f	update_user_locale	1000
a144a783-bd2d-4475-add2-c3baf76b080f	delete_account	Delete Account	68547ce3-6e06-4390-a3d3-3f5eaafa1583	f	f	delete_account	60
88308862-0a0f-47fe-acab-918aec2a3dec	CONFIGURE_TOTP	Configure OTP	market	t	f	CONFIGURE_TOTP	10
ed1abfa0-131a-4371-b418-69dc3ad79138	terms_and_conditions	Terms and Conditions	market	f	f	terms_and_conditions	20
480e184a-b487-49d0-9b46-40a5aa8f0012	UPDATE_PASSWORD	Update Password	market	t	f	UPDATE_PASSWORD	30
01463a02-5214-4091-8fca-3b87d04c4162	UPDATE_PROFILE	Update Profile	market	t	f	UPDATE_PROFILE	40
a1b8f10a-9d6d-4009-8e09-eacff46909fd	VERIFY_EMAIL	Verify Email	market	t	f	VERIFY_EMAIL	50
0000f790-db0b-400b-b992-aa2af35f3812	delete_account	Delete Account	market	f	f	delete_account	60
7807a840-0a13-4587-8da6-c8fb86d0723c	update_user_locale	Update User Locale	market	t	f	update_user_locale	1000
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
3e40bc9a-7869-4df6-9598-4dbc88af9db0	57faff0f-53b2-43ad-8711-21a3d131def9
62552ade-38be-4219-8acc-e7fcbd6d3286	07ead9ec-5c3c-42d6-abcf-6a391076c91d
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
LDAP_ID	user3	730c8a31-0ca7-4ff4-925d-e090acf55264	d57479b5-31ad-4958-8c5f-708ed971f77b
LDAP_ENTRY_DN	cn=user3,ou=market-app,dc=trodix,dc=com	730c8a31-0ca7-4ff4-925d-e090acf55264	f314046a-3e55-4b7b-b1fd-9f1c9780cbe8
LDAP_ID	user1	02b994d3-8825-471a-b516-6e997a797ab5	348a055b-7d95-4a38-9ab0-e84f9aa4e5de
LDAP_ENTRY_DN	cn=user1,ou=market-app,dc=trodix,dc=com	02b994d3-8825-471a-b516-6e997a797ab5	0b4c8812-f6b0-48fa-bc7e-f560c7457914
LDAP_ID	user2	f1d5fb94-9e8a-4674-b0e5-ee02645d8e08	0b6c5bf8-5e61-4fd9-b4aa-394c65199b68
LDAP_ENTRY_DN	cn=user2,ou=market-app,dc=trodix,dc=com	f1d5fb94-9e8a-4674-b0e5-ee02645d8e08	d4c56f62-3d8c-47cf-a247-645fea6e9aaa
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
23583b16-bb3e-487d-9f49-387c975da1ff	\N	19fc1fee-0824-49f3-ae5a-998aeb19ca67	f	t	\N	\N	\N	68547ce3-6e06-4390-a3d3-3f5eaafa1583	admin	1655625814437	\N	0
02b994d3-8825-471a-b516-6e997a797ab5	\N	a75ff9ea-8d06-4d66-831c-8d0e94a46d27	f	t	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	\N	Bar1	market	user1	1655647991709	\N	0
f1d5fb94-9e8a-4674-b0e5-ee02645d8e08	\N	35d10161-4e5b-4a8a-9297-586bd189c27e	f	t	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	\N	Bar2	market	user2	1655647991716	\N	0
730c8a31-0ca7-4ff4-925d-e090acf55264	\N	b92d117a-2b76-49dc-880f-ad2629730961	f	t	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	\N	Bar3	market	user3	1655647406560	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
adab8a7b-3012-4c32-9d41-2e0dec4ec209	23583b16-bb3e-487d-9f49-387c975da1ff
3293c292-db77-474b-a867-dd140b112976	23583b16-bb3e-487d-9f49-387c975da1ff
7ecb559e-996b-46ef-9847-576167f7963f	730c8a31-0ca7-4ff4-925d-e090acf55264
7ecb559e-996b-46ef-9847-576167f7963f	02b994d3-8825-471a-b516-6e997a797ab5
7ecb559e-996b-46ef-9847-576167f7963f	f1d5fb94-9e8a-4674-b0e5-ee02645d8e08
65de54e1-aceb-4cf4-afd6-a6865cb32b3f	02b994d3-8825-471a-b516-6e997a797ab5
b27a49c7-249a-4387-b201-effad86ec1c9	f1d5fb94-9e8a-4674-b0e5-ee02645d8e08
65de54e1-aceb-4cf4-afd6-a6865cb32b3f	730c8a31-0ca7-4ff4-925d-e090acf55264
b27a49c7-249a-4387-b201-effad86ec1c9	730c8a31-0ca7-4ff4-925d-e090acf55264
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
3a8a34ee-4f56-4de8-a61a-cb40205b6af9	+
bf40a050-cc4a-4e5b-9089-6aaefb033e20	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

