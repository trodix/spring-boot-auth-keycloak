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
6f44424d-4626-48e2-8d1b-1512a51d9c9b	\N	auth-cookie	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	2c439e32-72d1-440c-bf9e-5c2bea18a197	2	10	f	\N	\N
a2931e9d-c8a3-4c4e-893a-0cd6b518c164	\N	auth-spnego	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	2c439e32-72d1-440c-bf9e-5c2bea18a197	3	20	f	\N	\N
622e1828-626a-47d6-b74a-351f6b4f2edc	\N	identity-provider-redirector	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	2c439e32-72d1-440c-bf9e-5c2bea18a197	2	25	f	\N	\N
8e6bc342-52d1-4cb4-9e9d-99d9ecbe9885	\N	\N	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	2c439e32-72d1-440c-bf9e-5c2bea18a197	2	30	t	50db6c63-29c5-49e3-95aa-4dc383a8e51c	\N
b7581771-5524-4f06-9ede-f39a3e8b8b9c	\N	auth-username-password-form	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	50db6c63-29c5-49e3-95aa-4dc383a8e51c	0	10	f	\N	\N
8df8ad39-9209-4ca8-b392-be6483456718	\N	\N	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	50db6c63-29c5-49e3-95aa-4dc383a8e51c	1	20	t	ee9a3888-ec65-465b-b33a-f478672169c3	\N
b6db8461-707e-43c6-a29f-4f8e35529246	\N	conditional-user-configured	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	ee9a3888-ec65-465b-b33a-f478672169c3	0	10	f	\N	\N
99f2b9d2-ab82-4d4c-83a8-d7690d90a0ee	\N	auth-otp-form	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	ee9a3888-ec65-465b-b33a-f478672169c3	0	20	f	\N	\N
13182baf-cd2d-4e00-b496-867ca503e800	\N	direct-grant-validate-username	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	5fe39cc7-c6c3-471b-914c-182bd0d63655	0	10	f	\N	\N
0a040b60-0c53-477e-adf2-f08a2a278fba	\N	direct-grant-validate-password	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	5fe39cc7-c6c3-471b-914c-182bd0d63655	0	20	f	\N	\N
8794bd82-8c6f-446a-85c9-e060dd4abcd5	\N	\N	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	5fe39cc7-c6c3-471b-914c-182bd0d63655	1	30	t	73c02db9-b557-421d-ad4e-209d08649811	\N
c3e4c5ad-2a8d-4203-9dff-e0b55486dce6	\N	conditional-user-configured	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	73c02db9-b557-421d-ad4e-209d08649811	0	10	f	\N	\N
4c0f45c3-8e3f-4da9-a766-41b6a1c10d96	\N	direct-grant-validate-otp	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	73c02db9-b557-421d-ad4e-209d08649811	0	20	f	\N	\N
2d8378f6-75fe-48aa-880b-9c1165432b3f	\N	registration-page-form	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dd472481-336c-4bee-808f-68893c640193	0	10	t	77028d48-b46c-4727-b865-8a0809da5f51	\N
9d7deefc-6919-4281-bb29-6f3bff1eaf13	\N	registration-user-creation	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	77028d48-b46c-4727-b865-8a0809da5f51	0	20	f	\N	\N
e7ac69a1-da8c-44a9-a36f-5e8ed47ac57c	\N	registration-profile-action	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	77028d48-b46c-4727-b865-8a0809da5f51	0	40	f	\N	\N
baa85dc7-a98a-4587-80f6-6c2e07ba5471	\N	registration-password-action	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	77028d48-b46c-4727-b865-8a0809da5f51	0	50	f	\N	\N
3987a6cb-e019-487e-87fe-ad72b848fcfd	\N	registration-recaptcha-action	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	77028d48-b46c-4727-b865-8a0809da5f51	3	60	f	\N	\N
f656259d-e04f-40cc-be56-72806eba13c2	\N	reset-credentials-choose-user	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	008f0acc-86a4-40bb-911a-937f93b5435e	0	10	f	\N	\N
4867286d-6f78-4457-a583-7948086b8232	\N	reset-credential-email	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	008f0acc-86a4-40bb-911a-937f93b5435e	0	20	f	\N	\N
26d0bf06-f79e-4993-ad30-2240ebac6795	\N	reset-password	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	008f0acc-86a4-40bb-911a-937f93b5435e	0	30	f	\N	\N
35ab0891-1d58-4d2e-a121-a824cc93d849	\N	\N	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	008f0acc-86a4-40bb-911a-937f93b5435e	1	40	t	05e7712c-e707-4f92-a2b1-596c11f075ee	\N
0410f24b-af44-4e8e-b84e-baee957d06a0	\N	conditional-user-configured	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	05e7712c-e707-4f92-a2b1-596c11f075ee	0	10	f	\N	\N
129c00bf-b6af-480b-8905-e8f7046c139f	\N	reset-otp	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	05e7712c-e707-4f92-a2b1-596c11f075ee	0	20	f	\N	\N
341cfeb3-0e8b-4821-9235-7eed5c70f758	\N	client-secret	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	26d5e591-986b-473e-902f-272c29777475	2	10	f	\N	\N
afa81500-ab1a-446a-b957-2e27a98e1aa3	\N	client-jwt	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	26d5e591-986b-473e-902f-272c29777475	2	20	f	\N	\N
e35b15ac-a2aa-45b5-a40d-bd80074c480a	\N	client-secret-jwt	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	26d5e591-986b-473e-902f-272c29777475	2	30	f	\N	\N
9bc617e2-5dfc-4022-be49-ed473a1d2789	\N	client-x509	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	26d5e591-986b-473e-902f-272c29777475	2	40	f	\N	\N
4236c2bf-7755-43d2-8177-b6bead2b9b6a	\N	idp-review-profile	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	bb7417dd-0efb-4919-97d7-824a29a07df8	0	10	f	\N	0df2a430-40c6-4f40-8d49-6fb92b4dd4b8
c10410c8-ffaf-4b30-9a97-0fc54f9ec437	\N	\N	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	bb7417dd-0efb-4919-97d7-824a29a07df8	0	20	t	7122ec8b-1f8b-4ac6-96ee-2063e0e35f6b	\N
052167be-2aab-4a4e-8c63-2df6a3734b6c	\N	idp-create-user-if-unique	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	7122ec8b-1f8b-4ac6-96ee-2063e0e35f6b	2	10	f	\N	689cdf05-647c-4a2a-bc0e-1ea492bf1417
4ef12a0e-5e1b-4087-be9d-ac7337badfb4	\N	\N	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	7122ec8b-1f8b-4ac6-96ee-2063e0e35f6b	2	20	t	7031273e-c7e4-4748-9e4b-19f48fb9b3d0	\N
449c5f71-19c3-4f42-848d-ee4ea15bfc5f	\N	idp-confirm-link	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	7031273e-c7e4-4748-9e4b-19f48fb9b3d0	0	10	f	\N	\N
350d7727-c36f-43a5-a1e2-a26dce1be1b9	\N	\N	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	7031273e-c7e4-4748-9e4b-19f48fb9b3d0	0	20	t	dee9ff5c-cf4d-481d-9f09-d71daaa468bd	\N
c5f296d2-74fd-41e5-b94c-20f6098a9819	\N	idp-email-verification	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dee9ff5c-cf4d-481d-9f09-d71daaa468bd	2	10	f	\N	\N
1b0c17aa-cf24-42a3-9806-bb1c02fc4a6e	\N	\N	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dee9ff5c-cf4d-481d-9f09-d71daaa468bd	2	20	t	63ed944a-9770-4f88-9550-44b1e8a935f6	\N
d83ec502-e2cc-41ff-96e9-686ac2047922	\N	idp-username-password-form	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	63ed944a-9770-4f88-9550-44b1e8a935f6	0	10	f	\N	\N
b76dfbe3-d6c3-4078-a74c-8103cfa20541	\N	\N	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	63ed944a-9770-4f88-9550-44b1e8a935f6	1	20	t	c078b97b-8e12-4a36-9ea8-8b76baf70b2f	\N
1948181e-33a0-4b40-b082-afc2a54cf178	\N	conditional-user-configured	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	c078b97b-8e12-4a36-9ea8-8b76baf70b2f	0	10	f	\N	\N
80557135-3f6d-4556-ab48-30ed8269d8e6	\N	auth-otp-form	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	c078b97b-8e12-4a36-9ea8-8b76baf70b2f	0	20	f	\N	\N
696eb19a-97ee-4ad3-8e23-5f23b677e4b5	\N	http-basic-authenticator	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	01e4f310-9e53-4553-b92e-1a6d72b532f4	0	10	f	\N	\N
e6e85a19-5a26-4c49-ba98-07c4d14292c6	\N	docker-http-basic-authenticator	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	6aef893f-4214-4a66-b87d-37e3a0e08ddb	0	10	f	\N	\N
0bbfd3f6-49db-41f4-ae7a-628846620f81	\N	no-cookie-redirect	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	aead0d06-ba45-4859-bedf-2faeac00240b	0	10	f	\N	\N
8e53be18-9cfe-421b-8090-185109265c6d	\N	\N	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	aead0d06-ba45-4859-bedf-2faeac00240b	0	20	t	12733c73-4746-4f25-af77-ecd2fb587132	\N
587ca3d8-bfb4-4d13-afe3-4e57a565de2b	\N	basic-auth	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	12733c73-4746-4f25-af77-ecd2fb587132	0	10	f	\N	\N
a343657b-9297-43d8-a794-9d8c499ed627	\N	basic-auth-otp	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	12733c73-4746-4f25-af77-ecd2fb587132	3	20	f	\N	\N
73acc6ec-b404-414c-82f9-fcaad1cf9aff	\N	auth-spnego	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	12733c73-4746-4f25-af77-ecd2fb587132	3	30	f	\N	\N
aeb1d7ac-6613-4583-bad1-c813eefb327f	\N	idp-email-verification	market	276a37be-b1b8-45ec-b7d9-43e76a6cab11	2	10	f	\N	\N
fadbed02-f796-42f6-bff8-31f6fd526527	\N	\N	market	276a37be-b1b8-45ec-b7d9-43e76a6cab11	2	20	t	d6a0ae26-a6e4-430a-a8f1-bccc8a380257	\N
9d32266e-ff59-4f18-8594-206d413f4aa5	\N	basic-auth	market	1e441945-a317-4b05-8af3-d9fd6b6f73e0	0	10	f	\N	\N
b62d8da6-b56f-4d99-b498-df0a7484aab5	\N	basic-auth-otp	market	1e441945-a317-4b05-8af3-d9fd6b6f73e0	3	20	f	\N	\N
01ea8d3f-aa97-42c7-90d3-8fd0c349867e	\N	auth-spnego	market	1e441945-a317-4b05-8af3-d9fd6b6f73e0	3	30	f	\N	\N
ddf6c911-0e01-496e-afae-1b9e48622b9e	\N	conditional-user-configured	market	6899fdc3-2fcd-4492-9651-78da4d09c629	0	10	f	\N	\N
5b8d6d76-de98-4fe6-8fae-5a11194fa4db	\N	auth-otp-form	market	6899fdc3-2fcd-4492-9651-78da4d09c629	0	20	f	\N	\N
da1fdff0-3315-471c-a76e-f316f707229c	\N	conditional-user-configured	market	6919b0ee-27c1-4e58-bfab-9acd29193c0d	0	10	f	\N	\N
f48c25c5-8279-4993-b74f-15431476c400	\N	direct-grant-validate-otp	market	6919b0ee-27c1-4e58-bfab-9acd29193c0d	0	20	f	\N	\N
63abc20c-a7e2-421e-b7e1-1d26bd27582d	\N	conditional-user-configured	market	20deb05a-1899-40f0-a13a-3c53cc02ce7f	0	10	f	\N	\N
99c6f53f-9e23-485d-adc1-e46ee039a02e	\N	auth-otp-form	market	20deb05a-1899-40f0-a13a-3c53cc02ce7f	0	20	f	\N	\N
3597a2b8-ca1c-49d3-b16b-4ff2d4e86271	\N	idp-confirm-link	market	521262d9-1273-44e1-9783-a5a678ef9934	0	10	f	\N	\N
f1cf6d58-2394-466b-a403-ee922c694f01	\N	\N	market	521262d9-1273-44e1-9783-a5a678ef9934	0	20	t	276a37be-b1b8-45ec-b7d9-43e76a6cab11	\N
c13df02a-6391-4e08-b46b-2edd76b5ba77	\N	conditional-user-configured	market	1d6460a7-bcf5-4cf3-a904-31344712e67d	0	10	f	\N	\N
220f3586-78a5-4ad7-b281-a1cdd6fadcb4	\N	reset-otp	market	1d6460a7-bcf5-4cf3-a904-31344712e67d	0	20	f	\N	\N
978ca35f-2c31-4080-837a-bc989cd46502	\N	idp-create-user-if-unique	market	ae72208b-9102-43a0-841f-eebd3a7da90a	2	10	f	\N	5e303f5d-af07-47f7-b465-5931b30ecfbe
beda7e10-36e8-4633-8a74-8d11c7411f4a	\N	\N	market	ae72208b-9102-43a0-841f-eebd3a7da90a	2	20	t	521262d9-1273-44e1-9783-a5a678ef9934	\N
60cbd31a-78d6-48e1-82d8-aded28377200	\N	idp-username-password-form	market	d6a0ae26-a6e4-430a-a8f1-bccc8a380257	0	10	f	\N	\N
ad6ee490-dbca-431b-8f8c-e762593f375a	\N	\N	market	d6a0ae26-a6e4-430a-a8f1-bccc8a380257	1	20	t	20deb05a-1899-40f0-a13a-3c53cc02ce7f	\N
9b24f827-c6bf-4574-9092-24bedafa50b0	\N	auth-cookie	market	ffa09e26-5c68-4667-be30-7c9c88a81906	2	10	f	\N	\N
96f50506-6e92-4276-95fe-3a320181f9a5	\N	auth-spnego	market	ffa09e26-5c68-4667-be30-7c9c88a81906	3	20	f	\N	\N
256f5b3e-b62f-4a55-b16c-0d41c0d029a2	\N	identity-provider-redirector	market	ffa09e26-5c68-4667-be30-7c9c88a81906	2	25	f	\N	\N
268a3d2c-fcbf-4478-9284-3e201091fe35	\N	\N	market	ffa09e26-5c68-4667-be30-7c9c88a81906	2	30	t	a8fddd7f-339f-4eb1-a509-90dabd7b3f40	\N
70739d0b-9cd9-4558-8b96-ba4665a55804	\N	client-secret	market	1027b577-57a8-42f2-8f78-cc3445dc515c	2	10	f	\N	\N
4229bf05-c75d-4761-8d3a-5dee3f29f06d	\N	client-jwt	market	1027b577-57a8-42f2-8f78-cc3445dc515c	2	20	f	\N	\N
9baf7227-29bf-487b-a856-f2868a027405	\N	client-secret-jwt	market	1027b577-57a8-42f2-8f78-cc3445dc515c	2	30	f	\N	\N
ed290d2a-cea5-460d-9748-ac3baddbce6e	\N	client-x509	market	1027b577-57a8-42f2-8f78-cc3445dc515c	2	40	f	\N	\N
57c552a3-8ea0-4b74-8d2d-2635fcb0810a	\N	direct-grant-validate-username	market	b7cebff7-81ff-4093-aa31-1d381fd31b6b	0	10	f	\N	\N
f6416acd-92d2-4d9f-85bb-f68ba9c6b419	\N	direct-grant-validate-password	market	b7cebff7-81ff-4093-aa31-1d381fd31b6b	0	20	f	\N	\N
2ca61aaa-2c8d-4344-8941-b53653bffb10	\N	\N	market	b7cebff7-81ff-4093-aa31-1d381fd31b6b	1	30	t	6919b0ee-27c1-4e58-bfab-9acd29193c0d	\N
42c3e371-9b13-4d13-9c74-19a2f3779881	\N	docker-http-basic-authenticator	market	74bdd1dc-0ad8-4ef6-9bf5-92f73ec55566	0	10	f	\N	\N
5f5b306a-da18-4377-8ff5-fb81e2b75f9c	\N	idp-review-profile	market	284215f5-8628-4641-9d0e-bde48832b25c	0	10	f	\N	6e8fe09c-9f91-422c-8e00-197ac0369b6c
f06410a9-b597-482f-bc9b-3ff663ff4330	\N	\N	market	284215f5-8628-4641-9d0e-bde48832b25c	0	20	t	ae72208b-9102-43a0-841f-eebd3a7da90a	\N
4864880a-798b-4094-b93b-438712f5aec1	\N	auth-username-password-form	market	a8fddd7f-339f-4eb1-a509-90dabd7b3f40	0	10	f	\N	\N
ceaddc51-ccd1-43c0-beb2-a1e4d92e83b5	\N	\N	market	a8fddd7f-339f-4eb1-a509-90dabd7b3f40	1	20	t	6899fdc3-2fcd-4492-9651-78da4d09c629	\N
8a7f38c2-805a-4ef2-a3e6-4557b9460d00	\N	no-cookie-redirect	market	b9ed0682-f8f5-4667-ad4e-7e1a3792e840	0	10	f	\N	\N
531aa5be-f05f-4b8a-80ef-14fdf6df43d8	\N	\N	market	b9ed0682-f8f5-4667-ad4e-7e1a3792e840	0	20	t	1e441945-a317-4b05-8af3-d9fd6b6f73e0	\N
3d80257a-bf75-4fd2-a2b8-89a525e01b3c	\N	registration-page-form	market	a4488f78-6eae-4c18-a681-292cdab07df3	0	10	t	2b77668e-22b4-4da4-91fc-84c1d50baf93	\N
74d59d96-cee0-4585-87a0-ca7b8d03b9b0	\N	registration-user-creation	market	2b77668e-22b4-4da4-91fc-84c1d50baf93	0	20	f	\N	\N
9d639bea-1304-4ddb-8fca-9f309e8d4a1a	\N	registration-profile-action	market	2b77668e-22b4-4da4-91fc-84c1d50baf93	0	40	f	\N	\N
22d67c8b-e2fc-4cac-a8fe-e218be4ee404	\N	registration-password-action	market	2b77668e-22b4-4da4-91fc-84c1d50baf93	0	50	f	\N	\N
5d63d347-2476-4e23-9dcc-47c008c67607	\N	registration-recaptcha-action	market	2b77668e-22b4-4da4-91fc-84c1d50baf93	3	60	f	\N	\N
aec6bda4-a3dd-4945-8a56-2ecd08680d86	\N	reset-credentials-choose-user	market	3aca266d-d64f-452d-8eee-b46d6da92723	0	10	f	\N	\N
0639a6fc-41ff-4de9-823a-d1e3fe8f30e9	\N	reset-credential-email	market	3aca266d-d64f-452d-8eee-b46d6da92723	0	20	f	\N	\N
c08c789a-1bb8-4ee3-9620-3e042f266baf	\N	reset-password	market	3aca266d-d64f-452d-8eee-b46d6da92723	0	30	f	\N	\N
0a0879ec-2e32-4c87-bd01-e4da13bfcd62	\N	\N	market	3aca266d-d64f-452d-8eee-b46d6da92723	1	40	t	1d6460a7-bcf5-4cf3-a904-31344712e67d	\N
5a35e158-a669-4393-99bc-54800f0ed367	\N	http-basic-authenticator	market	21e67e7e-c626-443e-8db0-d9708d5f0b8c	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
2c439e32-72d1-440c-bf9e-5c2bea18a197	browser	browser based authentication	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	basic-flow	t	t
50db6c63-29c5-49e3-95aa-4dc383a8e51c	forms	Username, password, otp and other auth forms.	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	basic-flow	f	t
ee9a3888-ec65-465b-b33a-f478672169c3	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	basic-flow	f	t
5fe39cc7-c6c3-471b-914c-182bd0d63655	direct grant	OpenID Connect Resource Owner Grant	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	basic-flow	t	t
73c02db9-b557-421d-ad4e-209d08649811	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	basic-flow	f	t
dd472481-336c-4bee-808f-68893c640193	registration	registration flow	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	basic-flow	t	t
77028d48-b46c-4727-b865-8a0809da5f51	registration form	registration form	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	form-flow	f	t
008f0acc-86a4-40bb-911a-937f93b5435e	reset credentials	Reset credentials for a user if they forgot their password or something	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	basic-flow	t	t
05e7712c-e707-4f92-a2b1-596c11f075ee	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	basic-flow	f	t
26d5e591-986b-473e-902f-272c29777475	clients	Base authentication for clients	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	client-flow	t	t
bb7417dd-0efb-4919-97d7-824a29a07df8	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	basic-flow	t	t
7122ec8b-1f8b-4ac6-96ee-2063e0e35f6b	User creation or linking	Flow for the existing/non-existing user alternatives	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	basic-flow	f	t
7031273e-c7e4-4748-9e4b-19f48fb9b3d0	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	basic-flow	f	t
dee9ff5c-cf4d-481d-9f09-d71daaa468bd	Account verification options	Method with which to verity the existing account	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	basic-flow	f	t
63ed944a-9770-4f88-9550-44b1e8a935f6	Verify Existing Account by Re-authentication	Reauthentication of existing account	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	basic-flow	f	t
c078b97b-8e12-4a36-9ea8-8b76baf70b2f	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	basic-flow	f	t
01e4f310-9e53-4553-b92e-1a6d72b532f4	saml ecp	SAML ECP Profile Authentication Flow	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	basic-flow	t	t
6aef893f-4214-4a66-b87d-37e3a0e08ddb	docker auth	Used by Docker clients to authenticate against the IDP	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	basic-flow	t	t
aead0d06-ba45-4859-bedf-2faeac00240b	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	basic-flow	t	t
12733c73-4746-4f25-af77-ecd2fb587132	Authentication Options	Authentication options.	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	basic-flow	f	t
276a37be-b1b8-45ec-b7d9-43e76a6cab11	Account verification options	Method with which to verity the existing account	market	basic-flow	f	t
1e441945-a317-4b05-8af3-d9fd6b6f73e0	Authentication Options	Authentication options.	market	basic-flow	f	t
6899fdc3-2fcd-4492-9651-78da4d09c629	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	market	basic-flow	f	t
6919b0ee-27c1-4e58-bfab-9acd29193c0d	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	market	basic-flow	f	t
20deb05a-1899-40f0-a13a-3c53cc02ce7f	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	market	basic-flow	f	t
521262d9-1273-44e1-9783-a5a678ef9934	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	market	basic-flow	f	t
1d6460a7-bcf5-4cf3-a904-31344712e67d	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	market	basic-flow	f	t
ae72208b-9102-43a0-841f-eebd3a7da90a	User creation or linking	Flow for the existing/non-existing user alternatives	market	basic-flow	f	t
d6a0ae26-a6e4-430a-a8f1-bccc8a380257	Verify Existing Account by Re-authentication	Reauthentication of existing account	market	basic-flow	f	t
ffa09e26-5c68-4667-be30-7c9c88a81906	browser	browser based authentication	market	basic-flow	t	t
1027b577-57a8-42f2-8f78-cc3445dc515c	clients	Base authentication for clients	market	client-flow	t	t
b7cebff7-81ff-4093-aa31-1d381fd31b6b	direct grant	OpenID Connect Resource Owner Grant	market	basic-flow	t	t
74bdd1dc-0ad8-4ef6-9bf5-92f73ec55566	docker auth	Used by Docker clients to authenticate against the IDP	market	basic-flow	t	t
284215f5-8628-4641-9d0e-bde48832b25c	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	market	basic-flow	t	t
a8fddd7f-339f-4eb1-a509-90dabd7b3f40	forms	Username, password, otp and other auth forms.	market	basic-flow	f	t
b9ed0682-f8f5-4667-ad4e-7e1a3792e840	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	market	basic-flow	t	t
a4488f78-6eae-4c18-a681-292cdab07df3	registration	registration flow	market	basic-flow	t	t
2b77668e-22b4-4da4-91fc-84c1d50baf93	registration form	registration form	market	form-flow	f	t
3aca266d-d64f-452d-8eee-b46d6da92723	reset credentials	Reset credentials for a user if they forgot their password or something	market	basic-flow	t	t
21e67e7e-c626-443e-8db0-d9708d5f0b8c	saml ecp	SAML ECP Profile Authentication Flow	market	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
0df2a430-40c6-4f40-8d49-6fb92b4dd4b8	review profile config	878919f1-9bad-42a5-b5d2-3e86c0fcbacf
689cdf05-647c-4a2a-bc0e-1ea492bf1417	create unique user config	878919f1-9bad-42a5-b5d2-3e86c0fcbacf
5e303f5d-af07-47f7-b465-5931b30ecfbe	create unique user config	market
6e8fe09c-9f91-422c-8e00-197ac0369b6c	review profile config	market
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
0df2a430-40c6-4f40-8d49-6fb92b4dd4b8	missing	update.profile.on.first.login
689cdf05-647c-4a2a-bc0e-1ea492bf1417	false	require.password.update.after.registration
5e303f5d-af07-47f7-b465-5931b30ecfbe	false	require.password.update.after.registration
6e8fe09c-9f91-422c-8e00-197ac0369b6c	missing	update.profile.on.first.login
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
a8e7a68a-8305-40d2-8eea-d073c3354b2b	t	f	master-realm	0	f	\N	\N	t	\N	f	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
7cc240b3-97af-4269-bec0-fb96efb94b37	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
31690c0b-414a-48ed-9234-0211a5cae584	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
3d8ec0d2-8af9-4c49-be44-3ae83531dfb6	t	f	broker	0	f	\N	\N	t	\N	f	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
94c44dac-e118-4431-b031-d78411616990	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
684b5529-c4df-4abd-9235-1052082369ac	t	f	admin-cli	0	t	\N	\N	f	\N	f	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
dd7ede58-ac30-4667-8961-0f78928cdb52	t	f	market-realm	0	f	\N	\N	t	\N	f	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	\N	0	f	f	market Realm	f	client-secret	\N	\N	\N	t	f	f	f
1a43c414-0d56-4b63-81c3-d645db8ca3e4	t	f	account	0	t	\N	/realms/market/account/	f	\N	f	market	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
62552ade-38be-4219-8acc-e7fcbd6d3286	t	f	account-console	0	t	\N	/realms/market/account/	f	\N	f	market	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
6cf058f8-2e87-45d1-b55a-653e963b6090	t	f	admin-cli	0	t	\N	\N	f	\N	f	market	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
8c477d16-fd00-4245-bad2-d59e6134cf7b	t	f	broker	0	f	\N	\N	t	\N	f	market	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
d3450ecb-384a-4770-ab8d-30659adf7373	t	f	realm-management	0	f	\N	\N	t	\N	f	market	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
bf40a050-cc4a-4e5b-9089-6aaefb033e20	t	f	security-admin-console	0	t	\N	/admin/market/console/	f	\N	f	market	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
66329f4e-8fc4-4053-af79-ad673fd69478	t	t	market-backend	0	f	0bTrXrAExmKgL8KpD7Jh5ugdlfTPWN9x	\N	f	\N	f	market	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	f	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
7cc240b3-97af-4269-bec0-fb96efb94b37	+	post.logout.redirect.uris
31690c0b-414a-48ed-9234-0211a5cae584	+	post.logout.redirect.uris
31690c0b-414a-48ed-9234-0211a5cae584	S256	pkce.code.challenge.method
94c44dac-e118-4431-b031-d78411616990	+	post.logout.redirect.uris
94c44dac-e118-4431-b031-d78411616990	S256	pkce.code.challenge.method
1a43c414-0d56-4b63-81c3-d645db8ca3e4	+	post.logout.redirect.uris
62552ade-38be-4219-8acc-e7fcbd6d3286	S256	pkce.code.challenge.method
62552ade-38be-4219-8acc-e7fcbd6d3286	+	post.logout.redirect.uris
6cf058f8-2e87-45d1-b55a-653e963b6090	+	post.logout.redirect.uris
8c477d16-fd00-4245-bad2-d59e6134cf7b	+	post.logout.redirect.uris
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.force.post.binding
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.multivalued.roles
66329f4e-8fc4-4053-af79-ad673fd69478	false	frontchannel.logout.session.required
66329f4e-8fc4-4053-af79-ad673fd69478	false	oauth2.device.authorization.grant.enabled
66329f4e-8fc4-4053-af79-ad673fd69478	false	backchannel.logout.revoke.offline.tokens
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.server.signature.keyinfo.ext
66329f4e-8fc4-4053-af79-ad673fd69478	true	use.refresh.tokens
66329f4e-8fc4-4053-af79-ad673fd69478	false	oidc.ciba.grant.enabled
66329f4e-8fc4-4053-af79-ad673fd69478	true	backchannel.logout.session.required
66329f4e-8fc4-4053-af79-ad673fd69478	false	client_credentials.use_refresh_token
66329f4e-8fc4-4053-af79-ad673fd69478	false	require.pushed.authorization.requests
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.client.signature
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.allow.ecp.flow
66329f4e-8fc4-4053-af79-ad673fd69478	false	id.token.as.detached.signature
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.assertion.signature
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.encrypt
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.server.signature
66329f4e-8fc4-4053-af79-ad673fd69478	false	exclude.session.state.from.auth.response
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.artifact.binding
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml_force_name_id_format
66329f4e-8fc4-4053-af79-ad673fd69478	{}	acr.loa.map
66329f4e-8fc4-4053-af79-ad673fd69478	false	tls.client.certificate.bound.access.tokens
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.authnstatement
66329f4e-8fc4-4053-af79-ad673fd69478	false	display.on.consent.screen
66329f4e-8fc4-4053-af79-ad673fd69478	false	token.response.type.bearer.lower-case
66329f4e-8fc4-4053-af79-ad673fd69478	false	saml.onetimeuse.condition
66329f4e-8fc4-4053-af79-ad673fd69478	+	post.logout.redirect.uris
d3450ecb-384a-4770-ab8d-30659adf7373	+	post.logout.redirect.uris
bf40a050-cc4a-4e5b-9089-6aaefb033e20	S256	pkce.code.challenge.method
bf40a050-cc4a-4e5b-9089-6aaefb033e20	+	post.logout.redirect.uris
66329f4e-8fc4-4053-af79-ad673fd69478	1667301985	client.secret.creation.time
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
971e33c6-cc9c-42da-b35d-f61913c0d50b	offline_access	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	OpenID Connect built-in scope: offline_access	openid-connect
9f49137f-33fc-40f7-ae93-e50ad5d77e56	role_list	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	SAML role list	saml
c5e3d6ac-4965-4309-aa84-8ac032304ec2	profile	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	OpenID Connect built-in scope: profile	openid-connect
d23d25f6-008c-4967-b296-67d2ffbfee79	email	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	OpenID Connect built-in scope: email	openid-connect
ef16b222-39de-4dba-b2bc-ee22e6dbaaee	address	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	OpenID Connect built-in scope: address	openid-connect
49c83832-d333-4e1c-b7d0-732163fcd939	phone	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	OpenID Connect built-in scope: phone	openid-connect
a5179348-e18c-45ab-93af-3e179075e674	roles	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	OpenID Connect scope for add user roles to the access token	openid-connect
6a543ac6-12b3-4c25-9364-90a080e5f543	web-origins	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	OpenID Connect scope for add allowed web origins to the access token	openid-connect
acfbea6a-1560-4409-917d-6a7314dcecde	microprofile-jwt	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	Microprofile - JWT built-in scope	openid-connect
eb553833-8859-439b-92ea-6ba522d9ebaa	acr	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
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
971e33c6-cc9c-42da-b35d-f61913c0d50b	true	display.on.consent.screen
971e33c6-cc9c-42da-b35d-f61913c0d50b	${offlineAccessScopeConsentText}	consent.screen.text
9f49137f-33fc-40f7-ae93-e50ad5d77e56	true	display.on.consent.screen
9f49137f-33fc-40f7-ae93-e50ad5d77e56	${samlRoleListScopeConsentText}	consent.screen.text
c5e3d6ac-4965-4309-aa84-8ac032304ec2	true	display.on.consent.screen
c5e3d6ac-4965-4309-aa84-8ac032304ec2	${profileScopeConsentText}	consent.screen.text
c5e3d6ac-4965-4309-aa84-8ac032304ec2	true	include.in.token.scope
d23d25f6-008c-4967-b296-67d2ffbfee79	true	display.on.consent.screen
d23d25f6-008c-4967-b296-67d2ffbfee79	${emailScopeConsentText}	consent.screen.text
d23d25f6-008c-4967-b296-67d2ffbfee79	true	include.in.token.scope
ef16b222-39de-4dba-b2bc-ee22e6dbaaee	true	display.on.consent.screen
ef16b222-39de-4dba-b2bc-ee22e6dbaaee	${addressScopeConsentText}	consent.screen.text
ef16b222-39de-4dba-b2bc-ee22e6dbaaee	true	include.in.token.scope
49c83832-d333-4e1c-b7d0-732163fcd939	true	display.on.consent.screen
49c83832-d333-4e1c-b7d0-732163fcd939	${phoneScopeConsentText}	consent.screen.text
49c83832-d333-4e1c-b7d0-732163fcd939	true	include.in.token.scope
a5179348-e18c-45ab-93af-3e179075e674	true	display.on.consent.screen
a5179348-e18c-45ab-93af-3e179075e674	${rolesScopeConsentText}	consent.screen.text
a5179348-e18c-45ab-93af-3e179075e674	false	include.in.token.scope
6a543ac6-12b3-4c25-9364-90a080e5f543	false	display.on.consent.screen
6a543ac6-12b3-4c25-9364-90a080e5f543		consent.screen.text
6a543ac6-12b3-4c25-9364-90a080e5f543	false	include.in.token.scope
acfbea6a-1560-4409-917d-6a7314dcecde	false	display.on.consent.screen
acfbea6a-1560-4409-917d-6a7314dcecde	true	include.in.token.scope
eb553833-8859-439b-92ea-6ba522d9ebaa	false	display.on.consent.screen
eb553833-8859-439b-92ea-6ba522d9ebaa	false	include.in.token.scope
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
7cc240b3-97af-4269-bec0-fb96efb94b37	c5e3d6ac-4965-4309-aa84-8ac032304ec2	t
7cc240b3-97af-4269-bec0-fb96efb94b37	a5179348-e18c-45ab-93af-3e179075e674	t
7cc240b3-97af-4269-bec0-fb96efb94b37	6a543ac6-12b3-4c25-9364-90a080e5f543	t
7cc240b3-97af-4269-bec0-fb96efb94b37	d23d25f6-008c-4967-b296-67d2ffbfee79	t
7cc240b3-97af-4269-bec0-fb96efb94b37	eb553833-8859-439b-92ea-6ba522d9ebaa	t
7cc240b3-97af-4269-bec0-fb96efb94b37	ef16b222-39de-4dba-b2bc-ee22e6dbaaee	f
7cc240b3-97af-4269-bec0-fb96efb94b37	49c83832-d333-4e1c-b7d0-732163fcd939	f
7cc240b3-97af-4269-bec0-fb96efb94b37	971e33c6-cc9c-42da-b35d-f61913c0d50b	f
7cc240b3-97af-4269-bec0-fb96efb94b37	acfbea6a-1560-4409-917d-6a7314dcecde	f
31690c0b-414a-48ed-9234-0211a5cae584	c5e3d6ac-4965-4309-aa84-8ac032304ec2	t
31690c0b-414a-48ed-9234-0211a5cae584	a5179348-e18c-45ab-93af-3e179075e674	t
31690c0b-414a-48ed-9234-0211a5cae584	6a543ac6-12b3-4c25-9364-90a080e5f543	t
31690c0b-414a-48ed-9234-0211a5cae584	d23d25f6-008c-4967-b296-67d2ffbfee79	t
31690c0b-414a-48ed-9234-0211a5cae584	eb553833-8859-439b-92ea-6ba522d9ebaa	t
31690c0b-414a-48ed-9234-0211a5cae584	ef16b222-39de-4dba-b2bc-ee22e6dbaaee	f
31690c0b-414a-48ed-9234-0211a5cae584	49c83832-d333-4e1c-b7d0-732163fcd939	f
31690c0b-414a-48ed-9234-0211a5cae584	971e33c6-cc9c-42da-b35d-f61913c0d50b	f
31690c0b-414a-48ed-9234-0211a5cae584	acfbea6a-1560-4409-917d-6a7314dcecde	f
684b5529-c4df-4abd-9235-1052082369ac	c5e3d6ac-4965-4309-aa84-8ac032304ec2	t
684b5529-c4df-4abd-9235-1052082369ac	a5179348-e18c-45ab-93af-3e179075e674	t
684b5529-c4df-4abd-9235-1052082369ac	6a543ac6-12b3-4c25-9364-90a080e5f543	t
684b5529-c4df-4abd-9235-1052082369ac	d23d25f6-008c-4967-b296-67d2ffbfee79	t
684b5529-c4df-4abd-9235-1052082369ac	eb553833-8859-439b-92ea-6ba522d9ebaa	t
684b5529-c4df-4abd-9235-1052082369ac	ef16b222-39de-4dba-b2bc-ee22e6dbaaee	f
684b5529-c4df-4abd-9235-1052082369ac	49c83832-d333-4e1c-b7d0-732163fcd939	f
684b5529-c4df-4abd-9235-1052082369ac	971e33c6-cc9c-42da-b35d-f61913c0d50b	f
684b5529-c4df-4abd-9235-1052082369ac	acfbea6a-1560-4409-917d-6a7314dcecde	f
3d8ec0d2-8af9-4c49-be44-3ae83531dfb6	c5e3d6ac-4965-4309-aa84-8ac032304ec2	t
3d8ec0d2-8af9-4c49-be44-3ae83531dfb6	a5179348-e18c-45ab-93af-3e179075e674	t
3d8ec0d2-8af9-4c49-be44-3ae83531dfb6	6a543ac6-12b3-4c25-9364-90a080e5f543	t
3d8ec0d2-8af9-4c49-be44-3ae83531dfb6	d23d25f6-008c-4967-b296-67d2ffbfee79	t
3d8ec0d2-8af9-4c49-be44-3ae83531dfb6	eb553833-8859-439b-92ea-6ba522d9ebaa	t
3d8ec0d2-8af9-4c49-be44-3ae83531dfb6	ef16b222-39de-4dba-b2bc-ee22e6dbaaee	f
3d8ec0d2-8af9-4c49-be44-3ae83531dfb6	49c83832-d333-4e1c-b7d0-732163fcd939	f
3d8ec0d2-8af9-4c49-be44-3ae83531dfb6	971e33c6-cc9c-42da-b35d-f61913c0d50b	f
3d8ec0d2-8af9-4c49-be44-3ae83531dfb6	acfbea6a-1560-4409-917d-6a7314dcecde	f
a8e7a68a-8305-40d2-8eea-d073c3354b2b	c5e3d6ac-4965-4309-aa84-8ac032304ec2	t
a8e7a68a-8305-40d2-8eea-d073c3354b2b	a5179348-e18c-45ab-93af-3e179075e674	t
a8e7a68a-8305-40d2-8eea-d073c3354b2b	6a543ac6-12b3-4c25-9364-90a080e5f543	t
a8e7a68a-8305-40d2-8eea-d073c3354b2b	d23d25f6-008c-4967-b296-67d2ffbfee79	t
a8e7a68a-8305-40d2-8eea-d073c3354b2b	eb553833-8859-439b-92ea-6ba522d9ebaa	t
a8e7a68a-8305-40d2-8eea-d073c3354b2b	ef16b222-39de-4dba-b2bc-ee22e6dbaaee	f
a8e7a68a-8305-40d2-8eea-d073c3354b2b	49c83832-d333-4e1c-b7d0-732163fcd939	f
a8e7a68a-8305-40d2-8eea-d073c3354b2b	971e33c6-cc9c-42da-b35d-f61913c0d50b	f
a8e7a68a-8305-40d2-8eea-d073c3354b2b	acfbea6a-1560-4409-917d-6a7314dcecde	f
94c44dac-e118-4431-b031-d78411616990	c5e3d6ac-4965-4309-aa84-8ac032304ec2	t
94c44dac-e118-4431-b031-d78411616990	a5179348-e18c-45ab-93af-3e179075e674	t
94c44dac-e118-4431-b031-d78411616990	6a543ac6-12b3-4c25-9364-90a080e5f543	t
94c44dac-e118-4431-b031-d78411616990	d23d25f6-008c-4967-b296-67d2ffbfee79	t
94c44dac-e118-4431-b031-d78411616990	eb553833-8859-439b-92ea-6ba522d9ebaa	t
94c44dac-e118-4431-b031-d78411616990	ef16b222-39de-4dba-b2bc-ee22e6dbaaee	f
94c44dac-e118-4431-b031-d78411616990	49c83832-d333-4e1c-b7d0-732163fcd939	f
94c44dac-e118-4431-b031-d78411616990	971e33c6-cc9c-42da-b35d-f61913c0d50b	f
94c44dac-e118-4431-b031-d78411616990	acfbea6a-1560-4409-917d-6a7314dcecde	f
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
971e33c6-cc9c-42da-b35d-f61913c0d50b	22084e22-07f9-4710-bbef-4898841b6374
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
4241e4cd-2b87-4d1b-851d-cf9dce2750c1	Trusted Hosts	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	anonymous
51a311d2-437e-4d88-a98c-5e4933388cd9	Consent Required	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	anonymous
e7c49b65-6a1e-40a1-bbd0-4c026c67eb55	Full Scope Disabled	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	anonymous
f12ba2f8-f71b-438a-9232-18d1c58146b6	Max Clients Limit	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	anonymous
19da8f40-45b1-430d-951f-ca685b8e1a07	Allowed Protocol Mapper Types	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	anonymous
f06eee29-d036-453a-9ce1-a221b4a76bd9	Allowed Client Scopes	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	anonymous
480afeb3-d666-472d-829e-2d478b4b40f1	Allowed Protocol Mapper Types	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	authenticated
265e9997-af71-4bf6-87f4-c25132899a53	Allowed Client Scopes	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	authenticated
f87c34be-71b9-44df-9b86-e0df31500f99	rsa-generated	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	rsa-generated	org.keycloak.keys.KeyProvider	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	\N
c57f3a59-25ed-4b17-abcb-2537b62f21a1	rsa-enc-generated	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	rsa-enc-generated	org.keycloak.keys.KeyProvider	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	\N
9b2a9532-283e-43e1-be2f-732ebe6be5bb	hmac-generated	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	hmac-generated	org.keycloak.keys.KeyProvider	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	\N
2c0ad816-9070-4085-be66-819958f8b8ce	aes-generated	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	aes-generated	org.keycloak.keys.KeyProvider	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	\N
3b146cdb-afe6-454f-90fc-872df492c24f	Allowed Client Scopes	market	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	market	anonymous
824824ef-1def-4b98-ac76-2204822d1eb6	Allowed Protocol Mapper Types	market	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	market	authenticated
0f101e2e-2044-4b6d-8d0b-243a24553d5c	Trusted Hosts	market	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	market	anonymous
7b6f39cc-5d33-4f41-8d01-fe80015e8688	Consent Required	market	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	market	anonymous
1f3ed410-767b-4e84-b96a-8a64e996f334	Full Scope Disabled	market	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	market	anonymous
edb8ea17-ef31-4d62-82a1-e2fa2b5bb2c5	Max Clients Limit	market	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	market	anonymous
851d22b7-bda3-4ea4-916f-9bce673a5917	Allowed Protocol Mapper Types	market	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	market	anonymous
65c9a15f-d2b2-45bd-9ff1-47cccab28917	Allowed Client Scopes	market	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	market	authenticated
646ef5a1-8a11-4aea-bf72-ea5d1e318d89	ldap	market	ldap	org.keycloak.storage.UserStorageProvider	market	\N
bb8f7710-41c7-46da-aeb0-ddfe08b9990a	first name	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	market	\N
12185941-b6cc-4ab9-bf21-d8d73029b1ae	email	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	market	\N
99261ea0-24b3-462f-95da-e7febc5240f8	modify date	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	market	\N
5801b526-7aa9-4a0b-b877-10e07ea2b5aa	MSAD account controls	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	msad-user-account-control-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	market	\N
6ce11988-01cf-4d38-8946-a73df2d9acfc	last name	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	market	\N
33633df1-f653-4269-8a98-78433b48bf6c	username	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	market	\N
8d8b8fd7-1598-4ff1-bef8-aa8fe3045ae3	creation date	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	market	\N
30950374-aa78-4b8e-b8e2-7f83ff230c5d	rsa-enc-generated	market	rsa-enc-generated	org.keycloak.keys.KeyProvider	market	\N
3b2e85ad-7aee-4c70-a8be-407c0c00f37b	aes-generated	market	aes-generated	org.keycloak.keys.KeyProvider	market	\N
a1c16a2d-a0d9-4480-9980-fe43f733fdf9	rsa-generated	market	rsa-generated	org.keycloak.keys.KeyProvider	market	\N
492343e9-09f3-4c2c-a547-f84b5c6963f6	hmac-generated	market	hmac-generated	org.keycloak.keys.KeyProvider	market	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
61053c75-b018-47c3-9c1d-d1deb2de2c18	4241e4cd-2b87-4d1b-851d-cf9dce2750c1	client-uris-must-match	true
b424a2da-c782-4120-9568-89a06f4689bf	4241e4cd-2b87-4d1b-851d-cf9dce2750c1	host-sending-registration-request-must-match	true
62d56c12-30d3-4c90-8b30-8d9088a2a4d8	19da8f40-45b1-430d-951f-ca685b8e1a07	allowed-protocol-mapper-types	oidc-full-name-mapper
72ab3943-6ff4-4109-85ae-9aabcbd56abf	19da8f40-45b1-430d-951f-ca685b8e1a07	allowed-protocol-mapper-types	oidc-address-mapper
fcebb432-8757-4dbd-9637-576804d36964	19da8f40-45b1-430d-951f-ca685b8e1a07	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
79e40248-260b-43bc-a5c9-7f9323f0f928	19da8f40-45b1-430d-951f-ca685b8e1a07	allowed-protocol-mapper-types	saml-role-list-mapper
a67beac1-82f2-4006-be9e-9c29c20ce3af	19da8f40-45b1-430d-951f-ca685b8e1a07	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
8b6c3254-3292-4df2-9330-23c7ee2b7370	19da8f40-45b1-430d-951f-ca685b8e1a07	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
f7e88363-dc23-47b2-8ba7-de181a1c57f5	19da8f40-45b1-430d-951f-ca685b8e1a07	allowed-protocol-mapper-types	saml-user-attribute-mapper
3ab0f0a8-02e8-4f46-8073-e5598f4ab341	19da8f40-45b1-430d-951f-ca685b8e1a07	allowed-protocol-mapper-types	saml-user-property-mapper
78d6d092-08e9-41d7-95d1-691a380bbc81	f06eee29-d036-453a-9ce1-a221b4a76bd9	allow-default-scopes	true
446ccf93-0d17-4ab3-b53f-3b8c8dd47f3f	265e9997-af71-4bf6-87f4-c25132899a53	allow-default-scopes	true
78ca8c55-bc23-41cf-ab04-5ff1908b4535	f12ba2f8-f71b-438a-9232-18d1c58146b6	max-clients	200
a5445278-e2b4-4599-89a5-5958057f1646	480afeb3-d666-472d-829e-2d478b4b40f1	allowed-protocol-mapper-types	saml-user-property-mapper
d034a38f-660c-4785-8114-c8047d4065f3	480afeb3-d666-472d-829e-2d478b4b40f1	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d3c0926c-9d42-48a4-8ea2-3052736172b5	480afeb3-d666-472d-829e-2d478b4b40f1	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
041fde62-4e49-4a5c-9e4b-2f789619aa8c	480afeb3-d666-472d-829e-2d478b4b40f1	allowed-protocol-mapper-types	saml-user-attribute-mapper
fae7312a-9b4b-4452-858d-def678364672	480afeb3-d666-472d-829e-2d478b4b40f1	allowed-protocol-mapper-types	oidc-full-name-mapper
e4cd394b-b8bd-4baa-8cc1-5581e7073362	480afeb3-d666-472d-829e-2d478b4b40f1	allowed-protocol-mapper-types	oidc-address-mapper
8048d149-540e-475d-8a55-cdf402e3f992	480afeb3-d666-472d-829e-2d478b4b40f1	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
dbec1ed0-8cae-4506-8a0c-d6b3017f6952	480afeb3-d666-472d-829e-2d478b4b40f1	allowed-protocol-mapper-types	saml-role-list-mapper
e991c520-f07e-4f77-a2f8-1f074641444f	c57f3a59-25ed-4b17-abcb-2537b62f21a1	certificate	MIICmzCCAYMCBgGEMtxv/jANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIxMTAxMTEwMTU4WhcNMzIxMTAxMTEwMzM4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCrc2N6sDixPuWCUWdy+Oyln72rnPzhiiWgMONT1lFoOxRIAIEqQKhYFlZRfbNjiv2fzVYUa/huqxQvTXkv2egUFSY/tIatPwNJ+ILHhJfi1T7Zd2LV2myqOLj6UbRO5ZuLvcKpaBo4duJuNapoWSlppbEXNtGlkrWvP/PJJLyqFlW0V9f7J4EeIFp9FPUk1JC/DjBErqJF6+28HMWZFvxjYDRpuKw7dgkAJuxI7lxC0XiSD27Ep69oKzSZT5ehcynrqe2SsW/x/T074ttck/tgMmvS5JcIIZPgeeo+sYzH5RMudFJeYNuQmh+YCN+O5DkvKDr8uDS+QBBDqVZiC/evAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAgmswvlCx+CxZ3PFCuCT4q3/5byg5S7zzaRvdrxjbWQiH2BFvzylDY0Cx7awQdLVL8L/VnMPafO3t7az4cs5Qc71EFRswKFX/Bzykeeg///BtQSHhi9rACRrBk73ofug730QNssUAyGvNLUZrYAlOasDZxlaNoHXMpxT+5d3QPb3LYcwteYTh8YyyraoijyrpxcpfVKRVDtmk45mTq0o1grwGR4gVkrKZ6ABoJ0uQ5/NLOTmVfDfoNWQsWT7e1bpkaYbqnE2QKVB8Z5VqZ9zGYjuY/CerVIG8x8bkzt6cYX7TXgaejOMyMAdkFFHzsKscBAyluq0eqSq6BoLPqpHCg=
106f96a8-2969-42d3-a27e-5411dd2ea9ee	c57f3a59-25ed-4b17-abcb-2537b62f21a1	priority	100
a9504fab-f2e2-4098-a276-0b8e5b6baaaf	c57f3a59-25ed-4b17-abcb-2537b62f21a1	privateKey	MIIEogIBAAKCAQEAq3NjerA4sT7lglFncvjspZ+9q5z84YoloDDjU9ZRaDsUSACBKkCoWBZWUX2zY4r9n81WFGv4bqsUL015L9noFBUmP7SGrT8DSfiCx4SX4tU+2Xdi1dpsqji4+lG0TuWbi73CqWgaOHbibjWqaFkpaaWxFzbRpZK1rz/zySS8qhZVtFfX+yeBHiBafRT1JNSQvw4wRK6iRevtvBzFmRb8Y2A0abisO3YJACbsSO5cQtF4kg9uxKevaCs0mU+XoXMp66ntkrFv8f09O+LbXJP7YDJr0uSXCCGT4HnqPrGMx+UTLnRSXmDbkJofmAjfjuQ5Lyg6/Lg0vkAQQ6lWYgv3rwIDAQABAoIBABLcAYBYbBQLMCHSpIeAHD/nv2xmO2bv1E23svng5FmLziJRc+Pa8umlo18Zbacwfc+bPbHHYq+BwBmn8wGxfZbf8LInQH1EJi9316Ls0exQurYfLM8LVNKwpKBcZnIbTa3kdMo/ukqlwSiQXKtXy3dkk4NTM2J8LeIWLdHdaadn2WBLqRfyAapqHIphqCOEZGDByRhU0027wETVnGamCPA4l/BMEcbl0DJu+xjzrd62gEhqjDnwkq12xxFeEdLlfk8ZKg4D7La6E6Z1OQcoAPbiDtHL+PS8ZC8aao8SufT+z4gqwW1vXZBGE4c5SaZCi66E5ZhP43EbZAySbThaS8kCgYEA3hOa+u73sGSTV7rdQGXQI6NrO5v47iLjkNzIylluTFfuFltQMion+d7xBA46NZbjWmqzBlozWY97LByCXLtcFY05lrDR5tRt0hLeS6dD5iqIf2w0i2v99rvCwwIqbJT1ZstiYlvBPzF4JNSBkNYuHBTDIvkSc2Ep5hxlW+TF3wUCgYEAxaQJ+tsAEQ5cAchIcub76EFhDV7iiB5g9os966+A7gnCAwlCOooOtC1HLqZ88AGIzfj0Mf7TxHZgZfKfcwsLx5u22++wERmgPMyWNf5bsNLV3H9N5rljUt87+h6wNgxYBaCZyDshDJBvXYuRya1gWzW3y5Y4bNjia1prlK/JsiMCgYB9k7KIgQbY3Ragfk9McgYvkOI7U+iAqIPsT5zPJ6ECVJqSU9JWe5Ydap75Px5VXVx0rW9MgUcWNtdcy0ZAL8ZTfYd6GcSn9amgKAFB4HS5u4VyIHrZ+BglJGluolPhEJ5wIUQiAGaXWF7q3KvjfemXAXqS1StEyUXLFHWQcB4gDQKBgEnWMvRJBQlaN/1iec6ThOEMK9n27OK1lrwE4Sk/9Ab6FkVUHC4Kjdu6XrGK+Xog2J86tuBGt47aOsFblz4/jjMQdYxNS5XX4QlV1XhugorY+ZTa6pub/wNi6uFSvbozel7/1PP9QyeSfkiQb/LMlwb8VqH0iTgA/vXkXfS6h7vJAoGAG1UPnX8LwzwD7gpomRMux6n2FAfhC1UbjSU6uPyDpArvfn6Xty2Q9P0nwMNpoZGCyZ6f0rPV1F7dwEuRmqfR090XY93IVsObI89nzl3+E7NIeWpr1T9qC+uaUmliqn1YbRZUJsIIkSmqItO/Lg4tY4bwLylMWTl/9rnukIPRuOQ=
ef31f65b-4c03-4bc4-9a8a-0c29fa65afbc	c57f3a59-25ed-4b17-abcb-2537b62f21a1	algorithm	RSA-OAEP
b185cc1b-d990-4677-8b93-829be7cd1af5	c57f3a59-25ed-4b17-abcb-2537b62f21a1	keyUse	ENC
15e34e45-13d9-43ca-b4eb-a667e13e419d	f87c34be-71b9-44df-9b86-e0df31500f99	keyUse	SIG
491d4bb0-818b-42fc-a371-acd8123a5654	f87c34be-71b9-44df-9b86-e0df31500f99	certificate	MIICmzCCAYMCBgGEMtxvTjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIxMTAxMTEwMTU4WhcNMzIxMTAxMTEwMzM4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC26cp1hq85mJCWYe3mR8roEqidqFrwHGuVIicFVf4m0C0M1nGR3UFahO1+w64t8jh+mZXXJgl8b+EvgbGjiwjdM/QEb1FkgyYIzjOG4sSzXmc3A/Dt294MqkprZo/NSFKtQjWnccwHmm5S5PK1nJT4d2/EzyIeWc0/9iGMNXPuvEzbesV/zvbgYCUUmS1RWiAjrZvy7xnNdAGdseoNZGR1ihEi5XGVLC01LgmpysW1CRnWOvreMJt8s2Mtf+W96w5NUuq49vMUWwX+mu70Uvam7iIg427N3y2FnjG72HwWBrjeBVRel5tkGoF0h91hfnjBRk6ybMq6t+fU9OFdkT0xAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAEPdNyoxJGRe5xvq7DqCmpDVvhqQ/Fhvs4STX7kr5/MZerkTCv7wsBXC4o4un1WCkU7X/FgahMcJALtBjm/X3l6f0/+V0tVB1RpD/3PcjXMsnyMHUK++fTFUKzBnU75s3bN+hetyE7poHwrNj6sG4GkipPt9XfqWvGoRr+UZSZqu8HqnI+kF14ESWc7HQFL6h3hs473pnNYJEWf2WwhW2gUcLgVHja0o9p/N0SXgEENLj++OI0XUul40ED+eurHxRzCt+la1w5SjulmTGLeBtdsxK7NtYwNz1w+y8Vrqw+D/gcTSGQNyTInpJkSiZMM1IZfr8NXVKqQQIG6tM+41kXo=
2e137797-eb1b-4903-9fe9-2becd0132a06	12185941-b6cc-4ab9-bf21-d8d73029b1ae	always.read.value.from.ldap	false
3319c626-697d-40d8-9fe4-f0072cb75580	12185941-b6cc-4ab9-bf21-d8d73029b1ae	user.model.attribute	email
68316e9f-4b92-4509-97b0-aef536a2f4b1	12185941-b6cc-4ab9-bf21-d8d73029b1ae	ldap.attribute	mail
5b3cb75d-2559-4855-b383-4181621f933b	12185941-b6cc-4ab9-bf21-d8d73029b1ae	is.mandatory.in.ldap	false
eb8f6363-3722-4db3-81e4-0e635cc36e73	12185941-b6cc-4ab9-bf21-d8d73029b1ae	read.only	true
f3214005-d738-41cb-97e3-68d1809d60d5	f87c34be-71b9-44df-9b86-e0df31500f99	privateKey	MIIEogIBAAKCAQEAtunKdYavOZiQlmHt5kfK6BKonaha8BxrlSInBVX+JtAtDNZxkd1BWoTtfsOuLfI4fpmV1yYJfG/hL4Gxo4sI3TP0BG9RZIMmCM4zhuLEs15nNwPw7dveDKpKa2aPzUhSrUI1p3HMB5puUuTytZyU+HdvxM8iHlnNP/YhjDVz7rxM23rFf8724GAlFJktUVogI62b8u8ZzXQBnbHqDWRkdYoRIuVxlSwtNS4JqcrFtQkZ1jr63jCbfLNjLX/lvesOTVLquPbzFFsF/pru9FL2pu4iIONuzd8thZ4xu9h8Fga43gVUXpebZBqBdIfdYX54wUZOsmzKurfn1PThXZE9MQIDAQABAoIBACwSkvzUcf4Pu67wc7EL1WErtcMfIKJARs/NRdesS6uwd1pjhUPfKvMTmmHz5lEdzuz6Nrd7a8e28WxP9KxyQLWD4iT7aYItc4mlnZa/pyOM+JOx+GhnlM46beoI8VdGON2UWXc6HS4r0K9aiPyneOGRbbXfLtpfSuxBcv3kl0WLYx7WiF3gPazxejGAsn7DkXZCqhGVHlODS4ixbzq/Vj6t+YXnKF8WwyAUA5s59gM983aN4MuvbFp6JtBwqfz26iis3IRJt9xxinyi7QbJsEk7iSC6UloXOsUGhhAlDIndUacpNvYvofH73eOg7jvutgBl6jyQgCrIA/Hce63vDF0CgYEA4YjDa1N5u+hTxmZPE1/Zd5vRexvF+0FxKp4EFecFCDBHWQT2JTW2GCWGX7mP6KHr7/GBa2Gq88u/eDKvCSVbe1KJOmcv0Qky5M6Da1LiSMR38Q2A0/L565gTVWd0bHbTeLPPe9GdUaHWUFdA/narvM126FTTfB9zpnyfW4cTFy8CgYEAz58k5E6YQc6sZNuaZfPu7VYSTXvSDCLmb6H5u8Oy0ZhHC2HunOzXhxjo20AtWvSrN0a0Bs/lSaHV0voL0SPnDQMi9r2t+EuwdJxY6vw7DK0USHLlygpzkRHR0XDTEXBiB4eHBCdil63HGpq59dfKnPhNWuFCRTtGF3SynkMh2Z8CgYAXTRz7krVKD7fQELPsyYNbUzLyaC0tR1ac05SSerrPXMWSUevobkMw/XeDnlVa8JfCw43efUm/RHa0wW/KHxzzgdSBvzV2gF/MufVj+j08zWei9QUxYLIngB/HPBgQOLqihtlR7pc1XuYYiNtDLxmROR0m5dSvx0QYmFmSiEMVqwKBgH04yABnIs+1/iYKiTHqkPVWT02qW4J0XjWAJOZJXwWo6ViFJWxCMK/Lp03thC1ymf2JyDS/mNPzJsrLgusN02H2vVTCDDZQOEnsrnhzzo2TqkMUAWH9MbySWdEPUk4XURindhhcRMukxQxXu8b58rr/y2//on+tA1ZMTRrE9JqTAoGAWY+ieynIY/91QNUYjuVTlY8OjHJHnVs/n7wO0XtYMrkJAqVa4TQLErbp6NTnzsAZG+/+qEstNs7Gm3gMA2Na5kKCacQXAq3+7+6sTiTHijDv+24tY0rk1iGbOuEHl0wrDaTv2AxNGYdIGDCaQUcYhdwx/UVr1pY7lKaQ6XLxVJA=
7b645022-fb99-4099-9ae6-186dd681b4b5	f87c34be-71b9-44df-9b86-e0df31500f99	priority	100
7f6f16dc-079a-426e-94b6-d7d8988ca356	9b2a9532-283e-43e1-be2f-732ebe6be5bb	algorithm	HS256
39dd6f6d-d571-407c-9f49-856ccf9b458f	9b2a9532-283e-43e1-be2f-732ebe6be5bb	kid	668f2ccb-3183-40bf-abfd-023b69a9a1e9
785ca298-72ba-4f65-a459-2f6f5c3c6ac1	9b2a9532-283e-43e1-be2f-732ebe6be5bb	priority	100
afb91514-33c2-4122-a3cc-34559685137e	9b2a9532-283e-43e1-be2f-732ebe6be5bb	secret	MLyIisW4WwrEm3TNASj7Saf_nAxqytZ6R-AlZOiJc8T0rbHhhQ4RpOsd4hYF-3B-QwJ1UC76znb_j_jrhKUc1Q
e1a588cd-296a-43c0-8673-b95a7a9d6037	2c0ad816-9070-4085-be66-819958f8b8ce	kid	8ff6414a-5d3c-49a2-947f-78355ecc3733
6ff811a0-c630-4774-ab4f-eb92073c09e6	2c0ad816-9070-4085-be66-819958f8b8ce	secret	jFRjqmGUuHmvuLdBmenkyA
3d33a190-4cfe-46f8-9b6f-33c04f9bbf1c	2c0ad816-9070-4085-be66-819958f8b8ce	priority	100
74ab20da-edf5-41ec-86da-1ad75c8ecbd0	3b146cdb-afe6-454f-90fc-872df492c24f	allow-default-scopes	true
195ab93b-5eb9-413a-8efb-b44a2f9a908f	824824ef-1def-4b98-ac76-2204822d1eb6	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
db42ff95-17fc-4a84-994a-96ba822a09a6	824824ef-1def-4b98-ac76-2204822d1eb6	allowed-protocol-mapper-types	oidc-full-name-mapper
1b261a29-f8a7-4c5b-bfc2-5161502e4a29	824824ef-1def-4b98-ac76-2204822d1eb6	allowed-protocol-mapper-types	saml-user-property-mapper
4093db3f-3cb3-404a-b5a0-0688d16c751a	824824ef-1def-4b98-ac76-2204822d1eb6	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
6c429d0d-f211-4f33-ab39-ae6dceb6ad16	824824ef-1def-4b98-ac76-2204822d1eb6	allowed-protocol-mapper-types	saml-user-attribute-mapper
605590d3-735b-4fd9-9fcc-0f3570033492	824824ef-1def-4b98-ac76-2204822d1eb6	allowed-protocol-mapper-types	saml-role-list-mapper
3100840a-e363-4062-bea4-1638b3091a37	824824ef-1def-4b98-ac76-2204822d1eb6	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
975ef624-5272-4512-b4fe-cfc420a7499d	824824ef-1def-4b98-ac76-2204822d1eb6	allowed-protocol-mapper-types	oidc-address-mapper
44637e33-bb74-44a1-bfb1-fdb9e18e2f1a	0f101e2e-2044-4b6d-8d0b-243a24553d5c	host-sending-registration-request-must-match	true
47c50626-162e-4eac-b4b4-eff881ee278e	0f101e2e-2044-4b6d-8d0b-243a24553d5c	client-uris-must-match	true
040063fc-d1ab-46a2-b410-6673cae1362c	30950374-aa78-4b8e-b8e2-7f83ff230c5d	privateKey	MIIEowIBAAKCAQEApOGaQTdwrCEw2eVIlJX9qr8nt+NXDFcsUVtZYjuk7Lvwhu6uUb3j8o5GMu1m8lFTwexDSU4JIkuiFa1R4/rwr9cQBQuGH5FFBZCJNpxpNTUNgz3eIkqDLMMTVj36OX8fI5pj3ySx7Pr0IjNv2xyLH8kAvjC/1iYX96mi9NF51783nEPfF/dxfbL+jrBwwkx6Yr/ua7eUIoqMy1BxP9DPMryUwmYve8HmKJjvmYZ93XJ1G7wt+JLXV0piJ4b7tKt2+tzYrZ8cYxeFgT+zvGY5agfMqGWkNojleSjeyB912GBytXG8UkckBncchsD3JFAyQnVZ5PvYID0o0F1FdILExQIDAQABAoIBAEDKakxAVeU98a1eHQROYGztStVG35j41HBv3hLs7yUbwSu0tQln/h/9anZutap47NniVpqCsLIqWFn+TpSwsk3Wy/O/kIftFNtX7aNpGSqQW2v8LsL41s0LJxkXp7FaU8kwzRgNmmFOSAr8fXLzp3PpD4KtM2UaeQaYQXHEswVk+8AL0BP6EyDHc7LkE7ymXlVVGsVY0/i56ircSi0fQkA4F6zds5Md3qYJm0x7U9e1v73CxYxGWf6oF7PcphQZyoC7VC5/d5qAOzqyytQST0WoKrx/uHGsUkUnQZCB/DFy3JzCwi73d54XAR1dsXNcJyq8m+6fh2oenuyp53+IB80CgYEA3E0hFwLgkqQB+teOr6AXmJh0o1S2vD1hTGfEYWuzJhbztXUP0zrUnG66yd8cDRpTIxrwuXr1jIE+pv61yb/KibDWAH9QpWNgKrjGzlUjg0Q7z+mMpix2R0kj1UNa+BGSJOvCkZiLIWhaVxh7j8R+M8mJI6FPO1tIylOLHWu52rcCgYEAv5l0wByzyqcMX6weskj719KhQi24thTqt2FEJCxBNuBgVAFJwFZYLnW+C74bgkwJw7+KJG3AD9QldCoJT3PpJEuRtyFRURiCe7oWh1tXJ+h4DhNEvSxPeYq2XsLzTfVB+NHFrtGdfJ91R7pyoBhDDZVJEf+vnTNGXlsDwiEGUGMCgYAh36Yv4JxhT+CSDmT9MjOOnhqJJrR2W0XDtszmYeYI/Ex64UYOp6QbbZdBBRJOHXcdFb5f9r0c3p6glNek7t2YsF0ndGwVEiOuTf0bqtGsFGjR/kpHHt0M9v0QhKvPKvx6utmPA5KZD2+cpsIRCBiTo/B3Tw1cxht6KMBiRLcuHwKBgGlFP0hufLpTnhDS2OrL/tNN/xwFUv937p5i6rWVOx+TmFmPe54Z0sl0F78L7MFiVdsfWh85zdTkks+IaSUmYmp2utELlUohVU/1pnsoTHK4332cSKBHwELfW+Qk6Nlkb6LuXtb2hLj8Q8vtPR2JNw43f7ZL7YlJqtgc2avHyVhRAoGBAMaA9tJTyP4NleNJST6aP5xG1VoAsO/wQIHUU+lF7KHH99yHiBQxfLFOIFs8B26bDQRaPL0yF4n5OPgXFpDIyFTthZvV3ZMAV5hJkmXGQxIiwp0hpQc9u037FD41WVKevGpMmkfpf3N8V/W7JFakICe6my+GVV18hQnD8daf+Ay1
80b4f25d-3838-4652-9a61-ed41ad855080	30950374-aa78-4b8e-b8e2-7f83ff230c5d	algorithm	RSA-OAEP
f9f72732-83ce-44ee-9e41-7472918f1326	30950374-aa78-4b8e-b8e2-7f83ff230c5d	certificate	MIICmzCCAYMCBgGEMt6+WTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXJrZXQwHhcNMjIxMTAxMTEwNDI5WhcNMzIxMTAxMTEwNjA5WjARMQ8wDQYDVQQDDAZtYXJrZXQwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCk4ZpBN3CsITDZ5UiUlf2qvye341cMVyxRW1liO6Tsu/CG7q5RvePyjkYy7WbyUVPB7ENJTgkiS6IVrVHj+vCv1xAFC4YfkUUFkIk2nGk1NQ2DPd4iSoMswxNWPfo5fx8jmmPfJLHs+vQiM2/bHIsfyQC+ML/WJhf3qaL00XnXvzecQ98X93F9sv6OsHDCTHpiv+5rt5QiiozLUHE/0M8yvJTCZi97weYomO+Zhn3dcnUbvC34ktdXSmInhvu0q3b63NitnxxjF4WBP7O8ZjlqB8yoZaQ2iOV5KN7IH3XYYHK1cbxSRyQGdxyGwPckUDJCdVnk+9ggPSjQXUV0gsTFAgMBAAEwDQYJKoZIhvcNAQELBQADggEBACLBDpsMIu1GHN6CeZFgwCNpAGxhD/1mSHmI2Y2QgpfhX24t+sPLL99elUcvken1QYE/fplVsLyIVD79NV8HslasKE/jnyu2PhgnuBhjE5Xc13Z2bTiKHJFWqb8W6Q8EePyt3KysicY3j+LoRdK0iIW/GcjEgbx3a2IdYeu4bsgL9gGxzxCqEru4IEDhgUETV7RKX4sUej65S3EcXDO0W1jn5duatbOVHk0M3OPiTB0latiXfR3Djrf9UAQlXyTvQBl8JyxGnnkdYkKvKPoh+7MG4te+h+Y96WJ59cLZer5QdfeVzY49b+zyVfeLax5TJ8bMDchyxbGkgIPVdzTuOJI=
4f7a34bb-b6eb-48f6-964b-1af21d27ca4d	30950374-aa78-4b8e-b8e2-7f83ff230c5d	priority	100
9714e000-5082-40ee-bdad-9df6924d8e82	bb8f7710-41c7-46da-aeb0-ddfe08b9990a	always.read.value.from.ldap	false
40aa156c-2504-4abb-a1d5-deec8abe338e	bb8f7710-41c7-46da-aeb0-ddfe08b9990a	is.mandatory.in.ldap	true
9a75d228-6aab-4d68-b586-2ad051ebd6cd	bb8f7710-41c7-46da-aeb0-ddfe08b9990a	read.only	true
6ea1f5c5-c78c-4ebd-bd8e-0d72c6929f40	bb8f7710-41c7-46da-aeb0-ddfe08b9990a	ldap.attribute	givenName
160061e2-1742-453f-9a56-9497e16ef206	bb8f7710-41c7-46da-aeb0-ddfe08b9990a	user.model.attribute	firstName
18e5a0b1-1e52-4d3f-9eaa-61ed81025d9c	99261ea0-24b3-462f-95da-e7febc5240f8	is.mandatory.in.ldap	false
b29602ba-7ade-4522-8a11-40516587b0fe	99261ea0-24b3-462f-95da-e7febc5240f8	ldap.attribute	whenChanged
98682825-3693-4171-8de4-6df364356775	99261ea0-24b3-462f-95da-e7febc5240f8	read.only	true
26df6846-b1a6-4558-8bbb-8ac985ca4b24	99261ea0-24b3-462f-95da-e7febc5240f8	user.model.attribute	modifyTimestamp
db62a90d-2c7a-4350-bcdf-f116bb8c633e	99261ea0-24b3-462f-95da-e7febc5240f8	always.read.value.from.ldap	false
5cd56717-c501-4b40-a99b-6d6d417fa414	edb8ea17-ef31-4d62-82a1-e2fa2b5bb2c5	max-clients	200
2dfb8685-9890-431d-beb2-acd2b4b6cc20	3b2e85ad-7aee-4c70-a8be-407c0c00f37b	priority	100
adc0341a-1087-4b4d-9c9c-ec903430f137	3b2e85ad-7aee-4c70-a8be-407c0c00f37b	secret	uxY-qCk9K-2ZxRjZUU3J7A
58478f22-9968-412a-9a2e-acabc45d9e90	3b2e85ad-7aee-4c70-a8be-407c0c00f37b	kid	98be3780-139e-4696-994a-73106366a090
83cc0d0c-2471-43c9-aaaf-0d5330bec688	6ce11988-01cf-4d38-8946-a73df2d9acfc	user.model.attribute	lastName
48dc0c5b-cc20-4469-ab15-30567fb546ba	6ce11988-01cf-4d38-8946-a73df2d9acfc	always.read.value.from.ldap	false
83a62ff1-357b-477e-8544-bd79710518ff	6ce11988-01cf-4d38-8946-a73df2d9acfc	is.mandatory.in.ldap	true
48649d3a-4ec8-4167-8721-aded6d6ba203	6ce11988-01cf-4d38-8946-a73df2d9acfc	read.only	true
114629a7-76ed-4c42-8bbc-05849bd3d155	6ce11988-01cf-4d38-8946-a73df2d9acfc	ldap.attribute	sn
42691bcf-c242-461e-b98f-baa2deb90e65	851d22b7-bda3-4ea4-916f-9bce673a5917	allowed-protocol-mapper-types	saml-user-property-mapper
8b430c5b-5bc4-42b0-b116-b2cb9dbd9eb1	851d22b7-bda3-4ea4-916f-9bce673a5917	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
122e5256-7ca9-4de0-85bd-76910dc38d5c	851d22b7-bda3-4ea4-916f-9bce673a5917	allowed-protocol-mapper-types	oidc-full-name-mapper
7e7cb2e3-bec4-4b22-85d5-681ec4110d17	851d22b7-bda3-4ea4-916f-9bce673a5917	allowed-protocol-mapper-types	saml-user-attribute-mapper
7b58a236-c49d-45ac-a8e5-1b320594468b	851d22b7-bda3-4ea4-916f-9bce673a5917	allowed-protocol-mapper-types	oidc-address-mapper
4ae2f127-9515-4690-bec0-4d5634cf698a	851d22b7-bda3-4ea4-916f-9bce673a5917	allowed-protocol-mapper-types	saml-role-list-mapper
aa86af96-2040-45da-9b91-8083e3caf89f	851d22b7-bda3-4ea4-916f-9bce673a5917	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
baefddd2-3b0c-47c8-bb17-be67f46fdfa3	851d22b7-bda3-4ea4-916f-9bce673a5917	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
0b22928c-dc8b-4ece-bc53-f4d5986645e4	a1c16a2d-a0d9-4480-9980-fe43f733fdf9	certificate	MIICmzCCAYMCBgGEMt6/wDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXJrZXQwHhcNMjIxMTAxMTEwNDI5WhcNMzIxMTAxMTEwNjA5WjARMQ8wDQYDVQQDDAZtYXJrZXQwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDKf4dDP2Q6Cicb6CxX/MwHOAIouWiQfaEsoBhOYAAf+tuyG2p+TnROsdzeCMJLeom9rX8fbFewBpaoGVDFnaE0FBdBdxTb+00TOm9q1q3pmyLwuSCLlVsRH8mMH46J+fozKcPBX0E9AnsT/4gGFqA0few2++LGkt5BC7sa0aOTOOZGzg5lwINc7bHVew+wjhSW+QoFDXn6jkD/TRtQHGr61mVJChshoJe1RfL7MI3O7mkCNI4SBjhLznw8EPMi0cKag1nVOXkjM+IncK46a6324N/GbsWc9ixwOVWNtGOQzsdDpqscXPqwn4BmcXIRvfaW8LSnF5GiwOSfUVMccKRrAgMBAAEwDQYJKoZIhvcNAQELBQADggEBABjipOBvj9ds/sDf3k2gkJFoPtEDXuEuqcxiB/BY9dJUbClbV24YLqM/c2pFv5iQHiW1kHxtsVF7cpRCfdDKQQARTofEL87IQbLE8AjavO1ya91QaRvZD9yqBITQXiz5xEGmG1cHyYQ0fqZfMbtm5mhDX6VEgi/6+R8Ys2YuFUteeAAhCpM8UZvcU1pGxPWpfJUv9JL16uucFW72MplkrCsxRO8Asq/4u4P5Xt7/dIyGIFCoItC+k0ULuWNwvzRI+dXntwl5LrmPjd/Z8pVKNjdEUprRJD8Zv3YakpVGsfoZwEgpp0bds6xbFllKgDoZtCrpyQTALO+4VnB/CRR7g5I=
c57567de-b59a-4b15-a7ca-18661130e1b8	a1c16a2d-a0d9-4480-9980-fe43f733fdf9	priority	100
408f77e4-598b-4b21-aaec-262cc8b66973	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	searchScope	2
873c7488-d477-4128-a609-0cd02e0fb285	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	bindCredential	admin
cd93828b-0844-4425-ae22-b04294a94d1f	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	syncRegistrations	false
0c5f74bb-7a80-4193-a02f-0991baaa1e8f	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	debug	false
39278d8b-ba11-44a8-a3cb-8a8442104588	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	usePasswordModifyExtendedOp	false
f475d4e6-34c6-43fd-b171-c801e6920ddc	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	editMode	UNSYNCED
1d195f3c-acb1-42ed-8368-8ca8ee279cfc	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	authType	simple
08af80f9-0c6d-40c1-9093-82b5f22a356e	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	validatePasswordPolicy	false
58e1e7d8-094e-417a-b585-80a3e9ffb81a	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	connectionUrl	ldap://openldap:1389
5acd5a78-0895-4d56-855a-2e0c29183c09	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	priority	0
dbb3dab2-c150-4a58-97bc-ce76cba6da41	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	useKerberosForPasswordAuthentication	false
5781ec7c-5d96-4581-bb37-a83b91fe677e	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	vendor	ad
3d312434-314a-468a-820a-bfd843ac771b	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	connectionPooling	true
e2c2c546-aa71-4951-b15c-27b549353566	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	cachePolicy	DEFAULT
2da81e30-4a88-47ae-9a33-7768b4bcabe6	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	pagination	true
206fc164-e3c2-493c-ab0a-1892b0a81a73	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	usernameLDAPAttribute	cn
9e8db70f-8a80-4e65-9b31-402c5faaff9f	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	lastSync	1667301818
df5302cc-d28c-49f6-995f-9a914d7db475	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	batchSizeForSync	1000
282462e9-1927-47ec-a2b2-51ab452861d7	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	rdnLDAPAttribute	cn
2e3b34fd-92ec-452b-a4b2-d66a56324558	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	usersDn	ou=market-app,dc=trodix,dc=com
596367a2-33e8-49a9-b990-74cbfb54b36d	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	uuidLDAPAttribute	uid
e637c1eb-f95a-4a33-935b-2e2d1c16d296	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	fullSyncPeriod	-1
c3beff8b-5a17-44ac-adce-cbf9ec2a6400	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	bindDn	cn=admin,dc=trodix,dc=com
0f3a219d-5699-40ea-832f-fe8499e81d05	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	useTruststoreSpi	ldapsOnly
8d8129ef-6ebf-482e-b25b-de5e13fc8016	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	importEnabled	true
f5f85581-5a44-45b8-ab8c-dc6ab148b4ca	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	enabled	true
063e65b6-937f-42fe-902f-55a4695a690d	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	trustEmail	false
46fd5e11-d256-4ec4-a313-82f487e4e73a	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	allowKerberosAuthentication	false
bb0b4067-449d-4e5e-9dcd-f3e3532433a3	a1c16a2d-a0d9-4480-9980-fe43f733fdf9	privateKey	MIIEpAIBAAKCAQEAyn+HQz9kOgonG+gsV/zMBzgCKLlokH2hLKAYTmAAH/rbshtqfk50TrHc3gjCS3qJva1/H2xXsAaWqBlQxZ2hNBQXQXcU2/tNEzpvatat6Zsi8Lkgi5VbER/JjB+Oifn6MynDwV9BPQJ7E/+IBhagNH3sNvvixpLeQQu7GtGjkzjmRs4OZcCDXO2x1XsPsI4UlvkKBQ15+o5A/00bUBxq+tZlSQobIaCXtUXy+zCNzu5pAjSOEgY4S858PBDzItHCmoNZ1Tl5IzPiJ3CuOmut9uDfxm7FnPYscDlVjbRjkM7HQ6arHFz6sJ+AZnFyEb32lvC0pxeRosDkn1FTHHCkawIDAQABAoIBACRy/RFtNSi/UBfVXDoAPmdkPPtAmGI9wseqD4X4AL3A5U+zYKFYlNXfbQ6oS/TTGz0BoDqzQTtljDO4ztGrVGtv3FnDygTowJBf+dMkzkwYyRrEb+fAHBLCgoBO49TRIqiX8Wz6rN8C9c19NupFo1OfgOfKwiCVKh1SM70ZlBR5HOInK1QUGgPJ5pSPSKEI/BDqmpceCyYaeVX4UdILQzfYPAJpFRPEyCN2zNgJcWxzofI3lZTzeWOB4lX82c00TtkfifLTgYMXjAvcGbhswx6iCaFmUwgAHomlr75iV+xOK2VqXxQitduzBuWMxBsY1sukL3vNaB10A3hR8Q5r2BUCgYEA7+KKUzlqEPW8HVEnqaixrHz2xZE1EjkO+sdOBD+eZtJ40LGDT9udO2GeivBGLcMslGGRsijH7KYHfcvWQ6wxUXIe0neDJoXiKTPiTrvY93y4Q7R3TL+Cl5TYeWQlXEQtBxILcll9+XlEMhxYFhmGH0PRH1KPEXZwaFt73AomsYcCgYEA2BoF6k2bfNrMcZ86QOHFyqkSQtpIngGLyVQjxRnzxd9aNYPfvL9nF1rDMDVmilKLtam06HbuJSDJF2tf+9cQriajKEYPB87O0SDzwo+AIq6xtowUyAOAZTHrIe4/PKCPT6NLPdQNZDsJm+cVRqluvK0FifsM0MvyXknFZeBHvv0CgYEAqVu6JumpDZJAHj6WjvxPfCS5oGBVJKlt/vVJCkzUC2na7BP3TiERj8Pqx9K86UAbMCL2Vt7dzyCkt1Z6zko6g3LbeeHwkPkC4+4Cf221z3yZJwu5ElE+5L+sWX+vtMVZON2vgSrXepL3550FP40DmP0rHj8OTNjeoX69Imt0R+8CgYBqRnH+RmhfQKMmha36Vo4VGoy2f+8SdaQvQMfOmPK/rxYIF3CivGaQn7w6KyjggbPfhTRI1qRLchIzCEVN7vhvDOVUWw/tQRGI23HFjxju9YbERaO6sa4lFiWSrD5BLJ0OBzprj6t+TWJuX3ihJZYmB9kfgG1PCd2J7TG85k2iaQKBgQDirDnDmmrbZRb1Q3UQ87BhlXUSyiq02WogEm3jDahicYh8SneTxRMufy2n9YJsea9J6oVdjZF+QLJQgWW6AWoqlzS/OpdA78sJQ4KWytuhkS+3r6fs8YhAh00vC0Fnx4wQEzL1oXZWEmNF0FUhR8V7EmhXn4J0g9dE58Na5BFNCw==
e5b07ead-6a34-40c4-ac69-344a0185476e	65c9a15f-d2b2-45bd-9ff1-47cccab28917	allow-default-scopes	true
c2a94a56-daf7-43bf-909c-d98396edadda	33633df1-f653-4269-8a98-78433b48bf6c	always.read.value.from.ldap	false
774a777e-5408-41bd-9ee0-a732e92be134	33633df1-f653-4269-8a98-78433b48bf6c	is.mandatory.in.ldap	true
7c7115e6-7361-46a0-b0a5-c615f8edd757	33633df1-f653-4269-8a98-78433b48bf6c	read.only	true
665fc65d-ca83-4be6-aafd-d4d0dd162d81	33633df1-f653-4269-8a98-78433b48bf6c	ldap.attribute	cn
5c7e4d6c-040f-416a-ad5c-6e92ef5ceaf0	33633df1-f653-4269-8a98-78433b48bf6c	user.model.attribute	username
c9327fb6-68d6-48fa-ae79-6ab7892d26bd	8d8b8fd7-1598-4ff1-bef8-aa8fe3045ae3	ldap.attribute	whenCreated
e88f6959-1b85-4493-91a0-b74f9f53bc4e	8d8b8fd7-1598-4ff1-bef8-aa8fe3045ae3	always.read.value.from.ldap	false
8033ccac-e9d2-43da-93d1-ac4155e7272e	8d8b8fd7-1598-4ff1-bef8-aa8fe3045ae3	user.model.attribute	createTimestamp
1fe2d7aa-e265-4979-8e10-8898dea7b695	8d8b8fd7-1598-4ff1-bef8-aa8fe3045ae3	is.mandatory.in.ldap	false
b8b21623-200b-4aeb-ace3-8f3e09c22dbf	8d8b8fd7-1598-4ff1-bef8-aa8fe3045ae3	read.only	true
dc549f44-59df-41c6-99aa-8bd35c687a15	492343e9-09f3-4c2c-a547-f84b5c6963f6	kid	0c700e8e-d8a5-45e3-9f4e-19fb06d182f3
b21bbc85-dd08-4f94-94c2-56430b7c3f35	492343e9-09f3-4c2c-a547-f84b5c6963f6	algorithm	HS256
0b7c729f-9879-45c9-9569-504b2066fa3c	492343e9-09f3-4c2c-a547-f84b5c6963f6	secret	alVIcf7JLZocMEaMCUvXmIjADFJU7fQDzKeCY25SrIQAepzgP-beqnjoljF5RlxO6yd53gb5pCtV7yaGcwXkPw
2d9d5ffa-87d1-409d-b712-09578be26a5a	492343e9-09f3-4c2c-a547-f84b5c6963f6	priority	100
c2513400-50f2-44a2-9d2f-948a15631907	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	changedSyncPeriod	-1
0e89af60-2c61-4c33-999d-b1149a4b87b7	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	userObjectClasses	person
b48f6eef-367d-41db-baf6-ff73039b9b2c	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	startTls	false
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
f8f149be-d8ad-4085-bc3c-06ead12d429b	c7d7c9f2-9de5-42e9-8998-6fa804521d80
f8f149be-d8ad-4085-bc3c-06ead12d429b	891dfbb0-69c5-4464-a5a8-70bf6b0286df
f8f149be-d8ad-4085-bc3c-06ead12d429b	00141589-6720-4050-a239-5d7a7c66dfa6
f8f149be-d8ad-4085-bc3c-06ead12d429b	4284b9c5-4809-4fca-ade7-487ffbb00251
f8f149be-d8ad-4085-bc3c-06ead12d429b	a471cfb8-b38e-4a20-a7d1-377235050056
f8f149be-d8ad-4085-bc3c-06ead12d429b	35a89faa-dbbc-4982-9fb8-72b1ec23dade
f8f149be-d8ad-4085-bc3c-06ead12d429b	827dce3b-d9be-4851-9b10-5423545c20e8
f8f149be-d8ad-4085-bc3c-06ead12d429b	5df88d1a-351a-490c-9115-893da080fc54
f8f149be-d8ad-4085-bc3c-06ead12d429b	6459cae6-faf2-41b5-a4c4-8eecc6eab060
f8f149be-d8ad-4085-bc3c-06ead12d429b	701dbe7c-d207-4e0d-a22f-80103e4c8935
f8f149be-d8ad-4085-bc3c-06ead12d429b	a8207229-81ae-4607-bcba-7124f1877f4c
f8f149be-d8ad-4085-bc3c-06ead12d429b	63d36372-a7d9-4928-be28-05018d4de7ba
f8f149be-d8ad-4085-bc3c-06ead12d429b	79d61158-95b5-4828-8297-919d0f34f4c6
f8f149be-d8ad-4085-bc3c-06ead12d429b	09df9c4d-7103-484f-a3bc-0e0c2af5db67
f8f149be-d8ad-4085-bc3c-06ead12d429b	ebdbbef7-4830-4753-8875-c7d4f05092fa
f8f149be-d8ad-4085-bc3c-06ead12d429b	7a7dacf5-81da-4daf-a55d-972ccb9b7758
f8f149be-d8ad-4085-bc3c-06ead12d429b	5c3ad464-337e-46c9-b3e9-192f8a0b4c1c
f8f149be-d8ad-4085-bc3c-06ead12d429b	32a1d7ed-a373-4764-ab1b-1e795ecb10d8
25c74a80-0a91-47a7-b9f6-ceb486d0135d	42e26bc4-8ba3-4370-97fc-a970d66e0dfd
4284b9c5-4809-4fca-ade7-487ffbb00251	ebdbbef7-4830-4753-8875-c7d4f05092fa
4284b9c5-4809-4fca-ade7-487ffbb00251	32a1d7ed-a373-4764-ab1b-1e795ecb10d8
a471cfb8-b38e-4a20-a7d1-377235050056	7a7dacf5-81da-4daf-a55d-972ccb9b7758
25c74a80-0a91-47a7-b9f6-ceb486d0135d	06f33e9b-a59f-489b-a156-e9536726f6be
06f33e9b-a59f-489b-a156-e9536726f6be	f5d709fe-00f6-4a2e-b72f-be6edd9a2c57
bb9d82a5-a4e0-4ca8-90df-45fe8f3617cf	930d1c9f-64df-4a4d-916b-90b0d0636d10
f8f149be-d8ad-4085-bc3c-06ead12d429b	76bda522-00f1-4714-856d-0f972bd95514
25c74a80-0a91-47a7-b9f6-ceb486d0135d	22084e22-07f9-4710-bbef-4898841b6374
25c74a80-0a91-47a7-b9f6-ceb486d0135d	1d7c40ca-e8cc-44dc-9e4d-0ed5e247d249
f8f149be-d8ad-4085-bc3c-06ead12d429b	335c76c0-44b3-410f-a5e5-afc5f7236d8c
f8f149be-d8ad-4085-bc3c-06ead12d429b	40f6113e-39a6-4b7a-ac10-da93de1e3120
f8f149be-d8ad-4085-bc3c-06ead12d429b	7eb0df42-db7d-4817-8926-88d132c897f8
f8f149be-d8ad-4085-bc3c-06ead12d429b	eb9f3620-7ff4-4638-89a6-7fbba4c54b7f
f8f149be-d8ad-4085-bc3c-06ead12d429b	e726c448-63d6-44ec-a955-12c3e2288cc8
f8f149be-d8ad-4085-bc3c-06ead12d429b	1a4784a5-ee05-40d7-b67e-1d3635820a52
f8f149be-d8ad-4085-bc3c-06ead12d429b	4a406840-200d-4c19-b6fd-04d8208d184f
f8f149be-d8ad-4085-bc3c-06ead12d429b	0f520643-51f9-42ee-8815-f106278fa2b9
f8f149be-d8ad-4085-bc3c-06ead12d429b	daa3849c-f90e-4b2d-8c02-91949bd42959
f8f149be-d8ad-4085-bc3c-06ead12d429b	6dbeec2f-01f7-41ab-a299-bf62dd44e3ab
f8f149be-d8ad-4085-bc3c-06ead12d429b	6cd5aee0-6798-4b1f-ae95-7cff38b975ca
f8f149be-d8ad-4085-bc3c-06ead12d429b	760568bc-bad0-4665-9968-559b4721ee93
f8f149be-d8ad-4085-bc3c-06ead12d429b	4877114a-6a10-4fd5-8935-7eef6b2969bf
f8f149be-d8ad-4085-bc3c-06ead12d429b	6f821e11-2358-47ec-8561-1c5a968597e4
f8f149be-d8ad-4085-bc3c-06ead12d429b	013dbec4-ee00-40b8-b4de-ec952d3ec118
f8f149be-d8ad-4085-bc3c-06ead12d429b	25f74529-e8e1-49c3-be34-9d2875f1b36e
f8f149be-d8ad-4085-bc3c-06ead12d429b	6dda8e77-36f4-4501-925f-6ac406be9122
7eb0df42-db7d-4817-8926-88d132c897f8	6dda8e77-36f4-4501-925f-6ac406be9122
7eb0df42-db7d-4817-8926-88d132c897f8	6f821e11-2358-47ec-8561-1c5a968597e4
eb9f3620-7ff4-4638-89a6-7fbba4c54b7f	013dbec4-ee00-40b8-b4de-ec952d3ec118
07ead9ec-5c3c-42d6-abcf-6a391076c91d	639210a0-4a55-4824-895f-cb697050b489
1b16c5d1-769d-467b-8c90-49a65f7aa6a6	65de54e1-aceb-4cf4-afd6-a6865cb32b3f
306091d6-7c61-4929-b9d2-c0ee3313805e	d3c19bf6-037b-4b4d-91c4-c65fcef0debc
306091d6-7c61-4929-b9d2-c0ee3313805e	cf3d58fe-dcd1-40a7-8129-f2fdf6703188
306091d6-7c61-4929-b9d2-c0ee3313805e	1f9e1924-2973-4d9e-9d12-0deacc072128
306091d6-7c61-4929-b9d2-c0ee3313805e	54308b99-f364-4756-b6be-12c12571135c
306091d6-7c61-4929-b9d2-c0ee3313805e	7efbe709-93a9-4332-a233-998ce86ddd89
306091d6-7c61-4929-b9d2-c0ee3313805e	b6bcd993-f3b6-4489-aebe-bb18c239f8c7
306091d6-7c61-4929-b9d2-c0ee3313805e	e73c83ca-4723-412d-8cc4-cc08ec3ec344
306091d6-7c61-4929-b9d2-c0ee3313805e	215617db-a5b1-4c07-83f2-6238251d0914
306091d6-7c61-4929-b9d2-c0ee3313805e	a4bafef9-0603-4c17-8612-4eb972114f5a
306091d6-7c61-4929-b9d2-c0ee3313805e	58cbb7f5-b9f0-4b2e-87af-412736daba88
306091d6-7c61-4929-b9d2-c0ee3313805e	47134dad-344b-4897-ba8c-96b8b67cca17
306091d6-7c61-4929-b9d2-c0ee3313805e	8b5b407e-26db-406e-b427-2d4c447788b8
306091d6-7c61-4929-b9d2-c0ee3313805e	fa3fbbb3-12ab-41fb-9fa4-81f471d91d9f
306091d6-7c61-4929-b9d2-c0ee3313805e	6528e0e5-68e5-49a9-87d1-531a01f2819e
306091d6-7c61-4929-b9d2-c0ee3313805e	a830aba9-5787-463b-8408-c2052518997f
306091d6-7c61-4929-b9d2-c0ee3313805e	7d49aae1-d348-4b6e-aa8c-f5870f7b7646
306091d6-7c61-4929-b9d2-c0ee3313805e	02359504-46a8-4136-8858-bd09149f0b5a
306091d6-7c61-4929-b9d2-c0ee3313805e	4a33a21e-d801-4030-8d10-18980986e787
4bdc3b47-e92d-45cf-a8c0-455c6f97ad35	b27a49c7-249a-4387-b201-effad86ec1c9
6528e0e5-68e5-49a9-87d1-531a01f2819e	1f9e1924-2973-4d9e-9d12-0deacc072128
7ecb559e-996b-46ef-9847-576167f7963f	5b820d58-db40-46da-9a44-042f3c1ab23d
7ecb559e-996b-46ef-9847-576167f7963f	092435bd-908f-4df3-95e8-02b6206d79f8
7ecb559e-996b-46ef-9847-576167f7963f	07ead9ec-5c3c-42d6-abcf-6a391076c91d
7ecb559e-996b-46ef-9847-576167f7963f	d6b1930d-2ca9-4fe4-9a4c-88f106746e89
bd079466-be87-4563-8f74-909d6b619d24	c5c0f995-c845-43e4-85e0-5de50d93ec81
cf3d58fe-dcd1-40a7-8129-f2fdf6703188	d3c19bf6-037b-4b4d-91c4-c65fcef0debc
cf3d58fe-dcd1-40a7-8129-f2fdf6703188	b6bcd993-f3b6-4489-aebe-bb18c239f8c7
f8f149be-d8ad-4085-bc3c-06ead12d429b	23749d06-490b-4b35-b79b-1381a943f6ed
7ecb559e-996b-46ef-9847-576167f7963f	1b16c5d1-769d-467b-8c90-49a65f7aa6a6
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
2c9713e0-f691-4119-baf3-e7d4bc36adb3	\N	password	d69c209f-a529-48a9-b653-4c60dee05761	1667300618838	\N	{"value":"RwV0PsuSiV9wPEYihOL7ucPsWtsSm1ZhaLNvFImT0zBnOilSF4EpzPkDIsoaMlVeZHVLzQG/ochqNyBT9DNEGg==","salt":"IkkEXlKih7bUwYrFHsT+OQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
c5666bb5-1794-4f21-8039-963233de624b	\N	password	adb1f8b1-d362-4bd8-bd5b-f7564a6acd4c	1667301904283	My password	{"value":"4FiQCB88QdOnvFGgw71eBXeIGNl/jsgktATybtUqTpNHAK6Rk2GZF7hYgjylre//s76C1RKyM/cX/Fo85cMjOA==","salt":"WXM7lbLVC2PbS0LVqkf92g==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
94706e53-e572-499d-ac14-76c527e6a198	\N	password	1adf1de8-4ffe-4290-9cc5-17698593b280	1667303568086	My password	{"value":"FRag+n8srdVrQleWPw2voJzYjqxZmb+nsa4a3H4HEuKZ68q5vSzuwBEzo6jK3OKvkzj40eJjhtRXMMRAOcHbAw==","salt":"UawtVPdqQ/Zwk6nvYRkU3Q==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
77b6b5ff-c104-40f1-8a0b-c813fc6b7ee2	\N	password	4da3f610-c71d-43e6-976a-32e919b3b94f	1667303601163	My password	{"value":"RwxKZ4dwvDRiSesdGV4KJ+61SamGJ+JjYJQ20S4ttFrpYNoHm5pyzdaHcPl6yIbtdDCCstUGiRpkQbsQX3qMvg==","salt":"WH21A+Zsfh2F3hnmrCA5/A==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2022-11-01 11:03:33.98314	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	7300613313
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2022-11-01 11:03:33.993963	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	7300613313
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2022-11-01 11:03:34.052019	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	7300613313
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2022-11-01 11:03:34.057032	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	7300613313
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2022-11-01 11:03:34.209137	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	7300613313
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2022-11-01 11:03:34.213433	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	7300613313
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2022-11-01 11:03:34.354618	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	7300613313
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2022-11-01 11:03:34.359872	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	7300613313
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2022-11-01 11:03:34.367674	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	7300613313
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2022-11-01 11:03:34.52157	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	7300613313
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2022-11-01 11:03:34.661942	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	7300613313
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2022-11-01 11:03:34.665979	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	7300613313
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2022-11-01 11:03:34.707529	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	7300613313
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-11-01 11:03:34.734287	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	7300613313
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-11-01 11:03:34.737249	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	7300613313
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-11-01 11:03:34.74003	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	7300613313
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-11-01 11:03:34.74306	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	7300613313
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2022-11-01 11:03:34.834089	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	7300613313
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2022-11-01 11:03:34.920465	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	7300613313
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2022-11-01 11:03:34.926478	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	7300613313
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-11-01 11:03:35.484315	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	7300613313
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2022-11-01 11:03:34.938517	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	7300613313
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2022-11-01 11:03:34.94233	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	7300613313
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2022-11-01 11:03:34.976532	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	7300613313
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2022-11-01 11:03:34.984152	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	7300613313
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2022-11-01 11:03:34.988918	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	7300613313
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2022-11-01 11:03:35.027899	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	7300613313
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2022-11-01 11:03:35.133769	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	7300613313
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2022-11-01 11:03:35.137522	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	7300613313
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2022-11-01 11:03:35.218612	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	7300613313
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2022-11-01 11:03:35.237025	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	7300613313
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2022-11-01 11:03:35.261919	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	7300613313
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2022-11-01 11:03:35.267578	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	7300613313
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-11-01 11:03:35.279078	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	7300613313
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-11-01 11:03:35.28269	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	7300613313
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-11-01 11:03:35.316961	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	7300613313
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2022-11-01 11:03:35.321466	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	7300613313
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-11-01 11:03:35.327802	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	7300613313
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2022-11-01 11:03:35.332622	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	7300613313
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2022-11-01 11:03:35.337367	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	7300613313
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-11-01 11:03:35.33963	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	7300613313
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-11-01 11:03:35.342122	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	7300613313
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2022-11-01 11:03:35.346718	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	7300613313
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-11-01 11:03:35.475812	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	7300613313
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2022-11-01 11:03:35.479693	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	7300613313
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-11-01 11:03:35.48946	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	7300613313
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-11-01 11:03:35.49186	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	7300613313
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-11-01 11:03:35.534028	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	7300613313
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-11-01 11:03:35.538547	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	7300613313
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2022-11-01 11:03:35.580064	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	7300613313
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2022-11-01 11:03:35.612374	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	7300613313
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2022-11-01 11:03:35.615888	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	7300613313
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2022-11-01 11:03:35.618966	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	7300613313
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2022-11-01 11:03:35.621939	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	7300613313
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-11-01 11:03:35.628638	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	7300613313
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-11-01 11:03:35.634224	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	7300613313
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-11-01 11:03:35.660687	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	7300613313
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-11-01 11:03:35.768477	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	7300613313
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2022-11-01 11:03:35.798708	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	7300613313
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2022-11-01 11:03:35.805272	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	7300613313
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-11-01 11:03:35.813546	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	7300613313
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-11-01 11:03:35.819064	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	7300613313
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2022-11-01 11:03:35.823671	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	7300613313
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2022-11-01 11:03:35.828361	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	7300613313
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2022-11-01 11:03:35.832481	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	7300613313
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2022-11-01 11:03:35.846633	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	7300613313
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2022-11-01 11:03:35.852553	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	7300613313
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2022-11-01 11:03:35.857457	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	7300613313
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2022-11-01 11:03:35.871308	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	7300613313
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2022-11-01 11:03:35.878413	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	7300613313
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2022-11-01 11:03:35.88319	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	7300613313
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-11-01 11:03:35.891167	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	7300613313
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-11-01 11:03:35.899098	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	7300613313
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-11-01 11:03:35.901412	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	7300613313
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-11-01 11:03:35.922463	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	7300613313
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-11-01 11:03:35.93131	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	7300613313
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-11-01 11:03:35.93603	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	7300613313
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-11-01 11:03:35.938384	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	7300613313
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-11-01 11:03:35.960543	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	7300613313
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-11-01 11:03:35.963205	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	7300613313
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-11-01 11:03:35.969301	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	7300613313
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-11-01 11:03:35.971384	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	7300613313
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-11-01 11:03:35.976058	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	7300613313
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-11-01 11:03:35.978653	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	7300613313
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-11-01 11:03:35.984538	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	7300613313
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2022-11-01 11:03:35.990927	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	7300613313
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-11-01 11:03:35.999226	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	7300613313
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-11-01 11:03:36.00827	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	7300613313
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-01 11:03:36.015457	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	7300613313
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-01 11:03:36.022191	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	7300613313
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-01 11:03:36.028433	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	7300613313
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-01 11:03:36.039359	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	7300613313
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-01 11:03:36.041886	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	7300613313
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-01 11:03:36.051179	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	7300613313
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-01 11:03:36.053485	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	7300613313
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-01 11:03:36.059065	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	7300613313
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-01 11:03:36.069372	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	7300613313
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-01 11:03:36.071137	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	7300613313
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-01 11:03:36.083643	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	7300613313
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-01 11:03:36.090176	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	7300613313
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-01 11:03:36.094996	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	7300613313
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-01 11:03:36.100495	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	7300613313
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-01 11:03:36.105574	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	7300613313
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2022-11-01 11:03:36.114417	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	7300613313
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2022-11-01 11:03:36.125417	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	7300613313
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2022-11-01 11:03:36.138676	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	7300613313
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2022-11-01 11:03:36.149516	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	7300613313
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
878919f1-9bad-42a5-b5d2-3e86c0fcbacf	971e33c6-cc9c-42da-b35d-f61913c0d50b	f
878919f1-9bad-42a5-b5d2-3e86c0fcbacf	9f49137f-33fc-40f7-ae93-e50ad5d77e56	t
878919f1-9bad-42a5-b5d2-3e86c0fcbacf	c5e3d6ac-4965-4309-aa84-8ac032304ec2	t
878919f1-9bad-42a5-b5d2-3e86c0fcbacf	d23d25f6-008c-4967-b296-67d2ffbfee79	t
878919f1-9bad-42a5-b5d2-3e86c0fcbacf	ef16b222-39de-4dba-b2bc-ee22e6dbaaee	f
878919f1-9bad-42a5-b5d2-3e86c0fcbacf	49c83832-d333-4e1c-b7d0-732163fcd939	f
878919f1-9bad-42a5-b5d2-3e86c0fcbacf	a5179348-e18c-45ab-93af-3e179075e674	t
878919f1-9bad-42a5-b5d2-3e86c0fcbacf	6a543ac6-12b3-4c25-9364-90a080e5f543	t
878919f1-9bad-42a5-b5d2-3e86c0fcbacf	acfbea6a-1560-4409-917d-6a7314dcecde	f
878919f1-9bad-42a5-b5d2-3e86c0fcbacf	eb553833-8859-439b-92ea-6ba522d9ebaa	t
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
25c74a80-0a91-47a7-b9f6-ceb486d0135d	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	f	${role_default-roles}	default-roles-master	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	\N	\N
c7d7c9f2-9de5-42e9-8998-6fa804521d80	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	f	${role_create-realm}	create-realm	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	\N	\N
f8f149be-d8ad-4085-bc3c-06ead12d429b	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	f	${role_admin}	admin	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	\N	\N
891dfbb0-69c5-4464-a5a8-70bf6b0286df	a8e7a68a-8305-40d2-8eea-d073c3354b2b	t	${role_create-client}	create-client	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	a8e7a68a-8305-40d2-8eea-d073c3354b2b	\N
00141589-6720-4050-a239-5d7a7c66dfa6	a8e7a68a-8305-40d2-8eea-d073c3354b2b	t	${role_view-realm}	view-realm	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	a8e7a68a-8305-40d2-8eea-d073c3354b2b	\N
4284b9c5-4809-4fca-ade7-487ffbb00251	a8e7a68a-8305-40d2-8eea-d073c3354b2b	t	${role_view-users}	view-users	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	a8e7a68a-8305-40d2-8eea-d073c3354b2b	\N
a471cfb8-b38e-4a20-a7d1-377235050056	a8e7a68a-8305-40d2-8eea-d073c3354b2b	t	${role_view-clients}	view-clients	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	a8e7a68a-8305-40d2-8eea-d073c3354b2b	\N
35a89faa-dbbc-4982-9fb8-72b1ec23dade	a8e7a68a-8305-40d2-8eea-d073c3354b2b	t	${role_view-events}	view-events	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	a8e7a68a-8305-40d2-8eea-d073c3354b2b	\N
827dce3b-d9be-4851-9b10-5423545c20e8	a8e7a68a-8305-40d2-8eea-d073c3354b2b	t	${role_view-identity-providers}	view-identity-providers	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	a8e7a68a-8305-40d2-8eea-d073c3354b2b	\N
5df88d1a-351a-490c-9115-893da080fc54	a8e7a68a-8305-40d2-8eea-d073c3354b2b	t	${role_view-authorization}	view-authorization	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	a8e7a68a-8305-40d2-8eea-d073c3354b2b	\N
6459cae6-faf2-41b5-a4c4-8eecc6eab060	a8e7a68a-8305-40d2-8eea-d073c3354b2b	t	${role_manage-realm}	manage-realm	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	a8e7a68a-8305-40d2-8eea-d073c3354b2b	\N
701dbe7c-d207-4e0d-a22f-80103e4c8935	a8e7a68a-8305-40d2-8eea-d073c3354b2b	t	${role_manage-users}	manage-users	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	a8e7a68a-8305-40d2-8eea-d073c3354b2b	\N
a8207229-81ae-4607-bcba-7124f1877f4c	a8e7a68a-8305-40d2-8eea-d073c3354b2b	t	${role_manage-clients}	manage-clients	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	a8e7a68a-8305-40d2-8eea-d073c3354b2b	\N
63d36372-a7d9-4928-be28-05018d4de7ba	a8e7a68a-8305-40d2-8eea-d073c3354b2b	t	${role_manage-events}	manage-events	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	a8e7a68a-8305-40d2-8eea-d073c3354b2b	\N
79d61158-95b5-4828-8297-919d0f34f4c6	a8e7a68a-8305-40d2-8eea-d073c3354b2b	t	${role_manage-identity-providers}	manage-identity-providers	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	a8e7a68a-8305-40d2-8eea-d073c3354b2b	\N
09df9c4d-7103-484f-a3bc-0e0c2af5db67	a8e7a68a-8305-40d2-8eea-d073c3354b2b	t	${role_manage-authorization}	manage-authorization	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	a8e7a68a-8305-40d2-8eea-d073c3354b2b	\N
ebdbbef7-4830-4753-8875-c7d4f05092fa	a8e7a68a-8305-40d2-8eea-d073c3354b2b	t	${role_query-users}	query-users	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	a8e7a68a-8305-40d2-8eea-d073c3354b2b	\N
7a7dacf5-81da-4daf-a55d-972ccb9b7758	a8e7a68a-8305-40d2-8eea-d073c3354b2b	t	${role_query-clients}	query-clients	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	a8e7a68a-8305-40d2-8eea-d073c3354b2b	\N
5c3ad464-337e-46c9-b3e9-192f8a0b4c1c	a8e7a68a-8305-40d2-8eea-d073c3354b2b	t	${role_query-realms}	query-realms	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	a8e7a68a-8305-40d2-8eea-d073c3354b2b	\N
32a1d7ed-a373-4764-ab1b-1e795ecb10d8	a8e7a68a-8305-40d2-8eea-d073c3354b2b	t	${role_query-groups}	query-groups	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	a8e7a68a-8305-40d2-8eea-d073c3354b2b	\N
42e26bc4-8ba3-4370-97fc-a970d66e0dfd	7cc240b3-97af-4269-bec0-fb96efb94b37	t	${role_view-profile}	view-profile	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	7cc240b3-97af-4269-bec0-fb96efb94b37	\N
06f33e9b-a59f-489b-a156-e9536726f6be	7cc240b3-97af-4269-bec0-fb96efb94b37	t	${role_manage-account}	manage-account	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	7cc240b3-97af-4269-bec0-fb96efb94b37	\N
f5d709fe-00f6-4a2e-b72f-be6edd9a2c57	7cc240b3-97af-4269-bec0-fb96efb94b37	t	${role_manage-account-links}	manage-account-links	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	7cc240b3-97af-4269-bec0-fb96efb94b37	\N
a0282ed2-8b0d-4dc5-91a6-7c58ebfc63d0	7cc240b3-97af-4269-bec0-fb96efb94b37	t	${role_view-applications}	view-applications	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	7cc240b3-97af-4269-bec0-fb96efb94b37	\N
930d1c9f-64df-4a4d-916b-90b0d0636d10	7cc240b3-97af-4269-bec0-fb96efb94b37	t	${role_view-consent}	view-consent	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	7cc240b3-97af-4269-bec0-fb96efb94b37	\N
bb9d82a5-a4e0-4ca8-90df-45fe8f3617cf	7cc240b3-97af-4269-bec0-fb96efb94b37	t	${role_manage-consent}	manage-consent	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	7cc240b3-97af-4269-bec0-fb96efb94b37	\N
166b01c2-35a5-44a3-8a1b-5d6d9dc3256c	7cc240b3-97af-4269-bec0-fb96efb94b37	t	${role_delete-account}	delete-account	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	7cc240b3-97af-4269-bec0-fb96efb94b37	\N
ca6c9c6e-bdf1-47df-9399-9b13685f6cc4	3d8ec0d2-8af9-4c49-be44-3ae83531dfb6	t	${role_read-token}	read-token	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	3d8ec0d2-8af9-4c49-be44-3ae83531dfb6	\N
76bda522-00f1-4714-856d-0f972bd95514	a8e7a68a-8305-40d2-8eea-d073c3354b2b	t	${role_impersonation}	impersonation	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	a8e7a68a-8305-40d2-8eea-d073c3354b2b	\N
22084e22-07f9-4710-bbef-4898841b6374	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	f	${role_offline-access}	offline_access	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	\N	\N
1d7c40ca-e8cc-44dc-9e4d-0ed5e247d249	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	f	${role_uma_authorization}	uma_authorization	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	\N	\N
7ecb559e-996b-46ef-9847-576167f7963f	market	f	${role_default-roles}	default-roles-market	market	\N	\N
335c76c0-44b3-410f-a5e5-afc5f7236d8c	dd7ede58-ac30-4667-8961-0f78928cdb52	t	${role_create-client}	create-client	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dd7ede58-ac30-4667-8961-0f78928cdb52	\N
40f6113e-39a6-4b7a-ac10-da93de1e3120	dd7ede58-ac30-4667-8961-0f78928cdb52	t	${role_view-realm}	view-realm	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dd7ede58-ac30-4667-8961-0f78928cdb52	\N
7eb0df42-db7d-4817-8926-88d132c897f8	dd7ede58-ac30-4667-8961-0f78928cdb52	t	${role_view-users}	view-users	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dd7ede58-ac30-4667-8961-0f78928cdb52	\N
eb9f3620-7ff4-4638-89a6-7fbba4c54b7f	dd7ede58-ac30-4667-8961-0f78928cdb52	t	${role_view-clients}	view-clients	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dd7ede58-ac30-4667-8961-0f78928cdb52	\N
e726c448-63d6-44ec-a955-12c3e2288cc8	dd7ede58-ac30-4667-8961-0f78928cdb52	t	${role_view-events}	view-events	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dd7ede58-ac30-4667-8961-0f78928cdb52	\N
1a4784a5-ee05-40d7-b67e-1d3635820a52	dd7ede58-ac30-4667-8961-0f78928cdb52	t	${role_view-identity-providers}	view-identity-providers	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dd7ede58-ac30-4667-8961-0f78928cdb52	\N
4a406840-200d-4c19-b6fd-04d8208d184f	dd7ede58-ac30-4667-8961-0f78928cdb52	t	${role_view-authorization}	view-authorization	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dd7ede58-ac30-4667-8961-0f78928cdb52	\N
0f520643-51f9-42ee-8815-f106278fa2b9	dd7ede58-ac30-4667-8961-0f78928cdb52	t	${role_manage-realm}	manage-realm	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dd7ede58-ac30-4667-8961-0f78928cdb52	\N
daa3849c-f90e-4b2d-8c02-91949bd42959	dd7ede58-ac30-4667-8961-0f78928cdb52	t	${role_manage-users}	manage-users	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dd7ede58-ac30-4667-8961-0f78928cdb52	\N
6dbeec2f-01f7-41ab-a299-bf62dd44e3ab	dd7ede58-ac30-4667-8961-0f78928cdb52	t	${role_manage-clients}	manage-clients	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dd7ede58-ac30-4667-8961-0f78928cdb52	\N
6cd5aee0-6798-4b1f-ae95-7cff38b975ca	dd7ede58-ac30-4667-8961-0f78928cdb52	t	${role_manage-events}	manage-events	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dd7ede58-ac30-4667-8961-0f78928cdb52	\N
760568bc-bad0-4665-9968-559b4721ee93	dd7ede58-ac30-4667-8961-0f78928cdb52	t	${role_manage-identity-providers}	manage-identity-providers	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dd7ede58-ac30-4667-8961-0f78928cdb52	\N
4877114a-6a10-4fd5-8935-7eef6b2969bf	dd7ede58-ac30-4667-8961-0f78928cdb52	t	${role_manage-authorization}	manage-authorization	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dd7ede58-ac30-4667-8961-0f78928cdb52	\N
6f821e11-2358-47ec-8561-1c5a968597e4	dd7ede58-ac30-4667-8961-0f78928cdb52	t	${role_query-users}	query-users	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dd7ede58-ac30-4667-8961-0f78928cdb52	\N
013dbec4-ee00-40b8-b4de-ec952d3ec118	dd7ede58-ac30-4667-8961-0f78928cdb52	t	${role_query-clients}	query-clients	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dd7ede58-ac30-4667-8961-0f78928cdb52	\N
25f74529-e8e1-49c3-be34-9d2875f1b36e	dd7ede58-ac30-4667-8961-0f78928cdb52	t	${role_query-realms}	query-realms	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dd7ede58-ac30-4667-8961-0f78928cdb52	\N
6dda8e77-36f4-4501-925f-6ac406be9122	dd7ede58-ac30-4667-8961-0f78928cdb52	t	${role_query-groups}	query-groups	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dd7ede58-ac30-4667-8961-0f78928cdb52	\N
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
23749d06-490b-4b35-b79b-1381a943f6ed	dd7ede58-ac30-4667-8961-0f78928cdb52	t	${role_impersonation}	impersonation	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	dd7ede58-ac30-4667-8961-0f78928cdb52	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
3rqup	19.0.3	1667300616
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
e228932d-04e3-46eb-a7ca-54537441dd30	66329f4e-8fc4-4053-af79-ad673fd69478	1	1667301995	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:7080/realms/market","startedAt":"1667301995","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
b5945831-29ba-4a06-aea4-0854bb1d90e9	66329f4e-8fc4-4053-af79-ad673fd69478	1	1667302222	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:7080/realms/market","startedAt":"1667302222","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
d2f38738-d891-437b-bdcc-faff525ad085	66329f4e-8fc4-4053-af79-ad673fd69478	1	1667303371	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:7080/realms/market","startedAt":"1667303371","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
4c36fb5d-eda5-4579-9059-870fee2c3462	66329f4e-8fc4-4053-af79-ad673fd69478	1	1667303438	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:7080/realms/market","startedAt":"1667303438","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
121dcd53-ad9e-4ea9-8ae3-a8f7e9b78686	66329f4e-8fc4-4053-af79-ad673fd69478	1	1667303637	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:7080/realms/market","startedAt":"1667303637","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
56aef9b2-950c-4fac-9441-275224757de5	66329f4e-8fc4-4053-af79-ad673fd69478	1	1667303657	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:7080/realms/market","startedAt":"1667303657","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
d179184e-5902-41ac-8e34-d32f0d1cee10	66329f4e-8fc4-4053-af79-ad673fd69478	1	1667303665	{"authMethod":"openid-connect","notes":{"iss":"http://localhost:7080/realms/market","startedAt":"1667303665","level-of-authentication":"-1","scope":"openid profile email offline_access"}}	local	local
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
e228932d-04e3-46eb-a7ca-54537441dd30	adb1f8b1-d362-4bd8-bd5b-f7564a6acd4c	market	1667301995	1	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1667301938
b5945831-29ba-4a06-aea4-0854bb1d90e9	adb1f8b1-d362-4bd8-bd5b-f7564a6acd4c	market	1667302222	1	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1667302178
d2f38738-d891-437b-bdcc-faff525ad085	adb1f8b1-d362-4bd8-bd5b-f7564a6acd4c	market	1667303371	1	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1667303318
4c36fb5d-eda5-4579-9059-870fee2c3462	adb1f8b1-d362-4bd8-bd5b-f7564a6acd4c	market	1667303438	1	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1667303438
121dcd53-ad9e-4ea9-8ae3-a8f7e9b78686	4da3f610-c71d-43e6-976a-32e919b3b94f	market	1667303637	1	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1667303618
56aef9b2-950c-4fac-9441-275224757de5	1adf1de8-4ffe-4290-9cc5-17698593b280	market	1667303657	1	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1667303618
d179184e-5902-41ac-8e34-d32f0d1cee10	adb1f8b1-d362-4bd8-bd5b-f7564a6acd4c	market	1667303665	1	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0="},"state":"LOGGED_IN"}	1667303618
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
cfdd2e29-198a-42f9-ae44-13b0ad1064da	audience resolve	openid-connect	oidc-audience-resolve-mapper	31690c0b-414a-48ed-9234-0211a5cae584	\N
c99e8914-7e0a-4ad9-8612-62b8e5e04c82	locale	openid-connect	oidc-usermodel-attribute-mapper	94c44dac-e118-4431-b031-d78411616990	\N
5296fb6a-728e-465b-a75c-5fdfc1ea1661	role list	saml	saml-role-list-mapper	\N	9f49137f-33fc-40f7-ae93-e50ad5d77e56
86a48017-8033-4b2b-bffd-bdef0acc0036	full name	openid-connect	oidc-full-name-mapper	\N	c5e3d6ac-4965-4309-aa84-8ac032304ec2
cdee585c-40a7-40b5-a3c8-fe7500a088ea	family name	openid-connect	oidc-usermodel-property-mapper	\N	c5e3d6ac-4965-4309-aa84-8ac032304ec2
61b0d3e0-9785-48ec-bdf1-587a0a58c283	given name	openid-connect	oidc-usermodel-property-mapper	\N	c5e3d6ac-4965-4309-aa84-8ac032304ec2
0e5673ca-b982-4f13-baf4-e88b3ce804a0	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e3d6ac-4965-4309-aa84-8ac032304ec2
3ef43062-5837-4745-8f76-9b2087742e59	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e3d6ac-4965-4309-aa84-8ac032304ec2
73696c3e-8b7d-4538-8904-bb5dd40681e8	username	openid-connect	oidc-usermodel-property-mapper	\N	c5e3d6ac-4965-4309-aa84-8ac032304ec2
7b2b220e-ed9f-46a1-a110-17f3376be2e7	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e3d6ac-4965-4309-aa84-8ac032304ec2
b072a519-72fa-4c54-9b4c-d0074cb4033f	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e3d6ac-4965-4309-aa84-8ac032304ec2
22cfbbdf-dc8b-40b6-97e1-b28d7f5f366e	website	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e3d6ac-4965-4309-aa84-8ac032304ec2
5d44bd4f-81ba-4800-84d9-6bc916fe2295	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e3d6ac-4965-4309-aa84-8ac032304ec2
66a7a6b6-af9a-4313-b380-c788279755d9	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e3d6ac-4965-4309-aa84-8ac032304ec2
52a26831-87f9-46a0-b59c-a6323bb9ea7f	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e3d6ac-4965-4309-aa84-8ac032304ec2
e78bc461-a760-4545-b48f-2cd47b355324	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e3d6ac-4965-4309-aa84-8ac032304ec2
5573f489-5b6c-41c5-a096-f2bc9d4d60e7	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e3d6ac-4965-4309-aa84-8ac032304ec2
7a820e86-54ef-46d0-ab9d-85277b100688	email	openid-connect	oidc-usermodel-property-mapper	\N	d23d25f6-008c-4967-b296-67d2ffbfee79
45879116-4186-4459-82fa-e0dbc350dbfc	email verified	openid-connect	oidc-usermodel-property-mapper	\N	d23d25f6-008c-4967-b296-67d2ffbfee79
69dd1098-eb44-4240-8db1-f1c14f95294d	address	openid-connect	oidc-address-mapper	\N	ef16b222-39de-4dba-b2bc-ee22e6dbaaee
4e90d2a7-7df3-4ac5-a364-67bbf7d4db4b	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	49c83832-d333-4e1c-b7d0-732163fcd939
225d6820-a0b0-4fa8-8dc8-6c05d2705e1a	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	49c83832-d333-4e1c-b7d0-732163fcd939
5fb22b5d-f494-4eb0-b7f8-3487c988f056	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	a5179348-e18c-45ab-93af-3e179075e674
e65e0072-de20-4f2c-85f3-7b259205effa	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	a5179348-e18c-45ab-93af-3e179075e674
2702a7d7-15bb-4078-8712-c32b8cb2fb9f	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	a5179348-e18c-45ab-93af-3e179075e674
ffe22e51-a47e-48c8-a23b-f0b83feed482	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	6a543ac6-12b3-4c25-9364-90a080e5f543
54ae129d-0e04-4b17-8e8a-fe5000fd491a	upn	openid-connect	oidc-usermodel-property-mapper	\N	acfbea6a-1560-4409-917d-6a7314dcecde
a5c04f1c-d96f-4320-b10b-54a442951373	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	acfbea6a-1560-4409-917d-6a7314dcecde
5f740547-16ff-4520-aa69-4447e3123a6c	acr loa level	openid-connect	oidc-acr-mapper	\N	eb553833-8859-439b-92ea-6ba522d9ebaa
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
c99e8914-7e0a-4ad9-8612-62b8e5e04c82	true	userinfo.token.claim
c99e8914-7e0a-4ad9-8612-62b8e5e04c82	locale	user.attribute
c99e8914-7e0a-4ad9-8612-62b8e5e04c82	true	id.token.claim
c99e8914-7e0a-4ad9-8612-62b8e5e04c82	true	access.token.claim
c99e8914-7e0a-4ad9-8612-62b8e5e04c82	locale	claim.name
c99e8914-7e0a-4ad9-8612-62b8e5e04c82	String	jsonType.label
5296fb6a-728e-465b-a75c-5fdfc1ea1661	false	single
5296fb6a-728e-465b-a75c-5fdfc1ea1661	Basic	attribute.nameformat
5296fb6a-728e-465b-a75c-5fdfc1ea1661	Role	attribute.name
0e5673ca-b982-4f13-baf4-e88b3ce804a0	true	userinfo.token.claim
0e5673ca-b982-4f13-baf4-e88b3ce804a0	middleName	user.attribute
0e5673ca-b982-4f13-baf4-e88b3ce804a0	true	id.token.claim
0e5673ca-b982-4f13-baf4-e88b3ce804a0	true	access.token.claim
0e5673ca-b982-4f13-baf4-e88b3ce804a0	middle_name	claim.name
0e5673ca-b982-4f13-baf4-e88b3ce804a0	String	jsonType.label
22cfbbdf-dc8b-40b6-97e1-b28d7f5f366e	true	userinfo.token.claim
22cfbbdf-dc8b-40b6-97e1-b28d7f5f366e	website	user.attribute
22cfbbdf-dc8b-40b6-97e1-b28d7f5f366e	true	id.token.claim
22cfbbdf-dc8b-40b6-97e1-b28d7f5f366e	true	access.token.claim
22cfbbdf-dc8b-40b6-97e1-b28d7f5f366e	website	claim.name
22cfbbdf-dc8b-40b6-97e1-b28d7f5f366e	String	jsonType.label
3ef43062-5837-4745-8f76-9b2087742e59	true	userinfo.token.claim
3ef43062-5837-4745-8f76-9b2087742e59	nickname	user.attribute
3ef43062-5837-4745-8f76-9b2087742e59	true	id.token.claim
3ef43062-5837-4745-8f76-9b2087742e59	true	access.token.claim
3ef43062-5837-4745-8f76-9b2087742e59	nickname	claim.name
3ef43062-5837-4745-8f76-9b2087742e59	String	jsonType.label
52a26831-87f9-46a0-b59c-a6323bb9ea7f	true	userinfo.token.claim
52a26831-87f9-46a0-b59c-a6323bb9ea7f	zoneinfo	user.attribute
52a26831-87f9-46a0-b59c-a6323bb9ea7f	true	id.token.claim
52a26831-87f9-46a0-b59c-a6323bb9ea7f	true	access.token.claim
52a26831-87f9-46a0-b59c-a6323bb9ea7f	zoneinfo	claim.name
52a26831-87f9-46a0-b59c-a6323bb9ea7f	String	jsonType.label
5573f489-5b6c-41c5-a096-f2bc9d4d60e7	true	userinfo.token.claim
5573f489-5b6c-41c5-a096-f2bc9d4d60e7	updatedAt	user.attribute
5573f489-5b6c-41c5-a096-f2bc9d4d60e7	true	id.token.claim
5573f489-5b6c-41c5-a096-f2bc9d4d60e7	true	access.token.claim
5573f489-5b6c-41c5-a096-f2bc9d4d60e7	updated_at	claim.name
5573f489-5b6c-41c5-a096-f2bc9d4d60e7	long	jsonType.label
5d44bd4f-81ba-4800-84d9-6bc916fe2295	true	userinfo.token.claim
5d44bd4f-81ba-4800-84d9-6bc916fe2295	gender	user.attribute
5d44bd4f-81ba-4800-84d9-6bc916fe2295	true	id.token.claim
5d44bd4f-81ba-4800-84d9-6bc916fe2295	true	access.token.claim
5d44bd4f-81ba-4800-84d9-6bc916fe2295	gender	claim.name
5d44bd4f-81ba-4800-84d9-6bc916fe2295	String	jsonType.label
61b0d3e0-9785-48ec-bdf1-587a0a58c283	true	userinfo.token.claim
61b0d3e0-9785-48ec-bdf1-587a0a58c283	firstName	user.attribute
61b0d3e0-9785-48ec-bdf1-587a0a58c283	true	id.token.claim
61b0d3e0-9785-48ec-bdf1-587a0a58c283	true	access.token.claim
61b0d3e0-9785-48ec-bdf1-587a0a58c283	given_name	claim.name
61b0d3e0-9785-48ec-bdf1-587a0a58c283	String	jsonType.label
66a7a6b6-af9a-4313-b380-c788279755d9	true	userinfo.token.claim
66a7a6b6-af9a-4313-b380-c788279755d9	birthdate	user.attribute
66a7a6b6-af9a-4313-b380-c788279755d9	true	id.token.claim
66a7a6b6-af9a-4313-b380-c788279755d9	true	access.token.claim
66a7a6b6-af9a-4313-b380-c788279755d9	birthdate	claim.name
66a7a6b6-af9a-4313-b380-c788279755d9	String	jsonType.label
73696c3e-8b7d-4538-8904-bb5dd40681e8	true	userinfo.token.claim
73696c3e-8b7d-4538-8904-bb5dd40681e8	username	user.attribute
73696c3e-8b7d-4538-8904-bb5dd40681e8	true	id.token.claim
73696c3e-8b7d-4538-8904-bb5dd40681e8	true	access.token.claim
73696c3e-8b7d-4538-8904-bb5dd40681e8	preferred_username	claim.name
73696c3e-8b7d-4538-8904-bb5dd40681e8	String	jsonType.label
7b2b220e-ed9f-46a1-a110-17f3376be2e7	true	userinfo.token.claim
7b2b220e-ed9f-46a1-a110-17f3376be2e7	profile	user.attribute
7b2b220e-ed9f-46a1-a110-17f3376be2e7	true	id.token.claim
7b2b220e-ed9f-46a1-a110-17f3376be2e7	true	access.token.claim
7b2b220e-ed9f-46a1-a110-17f3376be2e7	profile	claim.name
7b2b220e-ed9f-46a1-a110-17f3376be2e7	String	jsonType.label
86a48017-8033-4b2b-bffd-bdef0acc0036	true	userinfo.token.claim
86a48017-8033-4b2b-bffd-bdef0acc0036	true	id.token.claim
86a48017-8033-4b2b-bffd-bdef0acc0036	true	access.token.claim
b072a519-72fa-4c54-9b4c-d0074cb4033f	true	userinfo.token.claim
b072a519-72fa-4c54-9b4c-d0074cb4033f	picture	user.attribute
b072a519-72fa-4c54-9b4c-d0074cb4033f	true	id.token.claim
b072a519-72fa-4c54-9b4c-d0074cb4033f	true	access.token.claim
b072a519-72fa-4c54-9b4c-d0074cb4033f	picture	claim.name
b072a519-72fa-4c54-9b4c-d0074cb4033f	String	jsonType.label
cdee585c-40a7-40b5-a3c8-fe7500a088ea	true	userinfo.token.claim
cdee585c-40a7-40b5-a3c8-fe7500a088ea	lastName	user.attribute
cdee585c-40a7-40b5-a3c8-fe7500a088ea	true	id.token.claim
cdee585c-40a7-40b5-a3c8-fe7500a088ea	true	access.token.claim
cdee585c-40a7-40b5-a3c8-fe7500a088ea	family_name	claim.name
cdee585c-40a7-40b5-a3c8-fe7500a088ea	String	jsonType.label
e78bc461-a760-4545-b48f-2cd47b355324	true	userinfo.token.claim
e78bc461-a760-4545-b48f-2cd47b355324	locale	user.attribute
e78bc461-a760-4545-b48f-2cd47b355324	true	id.token.claim
e78bc461-a760-4545-b48f-2cd47b355324	true	access.token.claim
e78bc461-a760-4545-b48f-2cd47b355324	locale	claim.name
e78bc461-a760-4545-b48f-2cd47b355324	String	jsonType.label
45879116-4186-4459-82fa-e0dbc350dbfc	true	userinfo.token.claim
45879116-4186-4459-82fa-e0dbc350dbfc	emailVerified	user.attribute
45879116-4186-4459-82fa-e0dbc350dbfc	true	id.token.claim
45879116-4186-4459-82fa-e0dbc350dbfc	true	access.token.claim
45879116-4186-4459-82fa-e0dbc350dbfc	email_verified	claim.name
45879116-4186-4459-82fa-e0dbc350dbfc	boolean	jsonType.label
7a820e86-54ef-46d0-ab9d-85277b100688	true	userinfo.token.claim
7a820e86-54ef-46d0-ab9d-85277b100688	email	user.attribute
7a820e86-54ef-46d0-ab9d-85277b100688	true	id.token.claim
7a820e86-54ef-46d0-ab9d-85277b100688	true	access.token.claim
7a820e86-54ef-46d0-ab9d-85277b100688	email	claim.name
7a820e86-54ef-46d0-ab9d-85277b100688	String	jsonType.label
69dd1098-eb44-4240-8db1-f1c14f95294d	formatted	user.attribute.formatted
69dd1098-eb44-4240-8db1-f1c14f95294d	country	user.attribute.country
69dd1098-eb44-4240-8db1-f1c14f95294d	postal_code	user.attribute.postal_code
69dd1098-eb44-4240-8db1-f1c14f95294d	true	userinfo.token.claim
69dd1098-eb44-4240-8db1-f1c14f95294d	street	user.attribute.street
69dd1098-eb44-4240-8db1-f1c14f95294d	true	id.token.claim
69dd1098-eb44-4240-8db1-f1c14f95294d	region	user.attribute.region
69dd1098-eb44-4240-8db1-f1c14f95294d	true	access.token.claim
69dd1098-eb44-4240-8db1-f1c14f95294d	locality	user.attribute.locality
225d6820-a0b0-4fa8-8dc8-6c05d2705e1a	true	userinfo.token.claim
225d6820-a0b0-4fa8-8dc8-6c05d2705e1a	phoneNumberVerified	user.attribute
225d6820-a0b0-4fa8-8dc8-6c05d2705e1a	true	id.token.claim
225d6820-a0b0-4fa8-8dc8-6c05d2705e1a	true	access.token.claim
225d6820-a0b0-4fa8-8dc8-6c05d2705e1a	phone_number_verified	claim.name
225d6820-a0b0-4fa8-8dc8-6c05d2705e1a	boolean	jsonType.label
4e90d2a7-7df3-4ac5-a364-67bbf7d4db4b	true	userinfo.token.claim
4e90d2a7-7df3-4ac5-a364-67bbf7d4db4b	phoneNumber	user.attribute
4e90d2a7-7df3-4ac5-a364-67bbf7d4db4b	true	id.token.claim
4e90d2a7-7df3-4ac5-a364-67bbf7d4db4b	true	access.token.claim
4e90d2a7-7df3-4ac5-a364-67bbf7d4db4b	phone_number	claim.name
4e90d2a7-7df3-4ac5-a364-67bbf7d4db4b	String	jsonType.label
5fb22b5d-f494-4eb0-b7f8-3487c988f056	true	multivalued
5fb22b5d-f494-4eb0-b7f8-3487c988f056	foo	user.attribute
5fb22b5d-f494-4eb0-b7f8-3487c988f056	true	access.token.claim
5fb22b5d-f494-4eb0-b7f8-3487c988f056	realm_access.roles	claim.name
5fb22b5d-f494-4eb0-b7f8-3487c988f056	String	jsonType.label
e65e0072-de20-4f2c-85f3-7b259205effa	true	multivalued
e65e0072-de20-4f2c-85f3-7b259205effa	foo	user.attribute
e65e0072-de20-4f2c-85f3-7b259205effa	true	access.token.claim
e65e0072-de20-4f2c-85f3-7b259205effa	resource_access.${client_id}.roles	claim.name
e65e0072-de20-4f2c-85f3-7b259205effa	String	jsonType.label
54ae129d-0e04-4b17-8e8a-fe5000fd491a	true	userinfo.token.claim
54ae129d-0e04-4b17-8e8a-fe5000fd491a	username	user.attribute
54ae129d-0e04-4b17-8e8a-fe5000fd491a	true	id.token.claim
54ae129d-0e04-4b17-8e8a-fe5000fd491a	true	access.token.claim
54ae129d-0e04-4b17-8e8a-fe5000fd491a	upn	claim.name
54ae129d-0e04-4b17-8e8a-fe5000fd491a	String	jsonType.label
a5c04f1c-d96f-4320-b10b-54a442951373	true	multivalued
a5c04f1c-d96f-4320-b10b-54a442951373	foo	user.attribute
a5c04f1c-d96f-4320-b10b-54a442951373	true	id.token.claim
a5c04f1c-d96f-4320-b10b-54a442951373	true	access.token.claim
a5c04f1c-d96f-4320-b10b-54a442951373	groups	claim.name
a5c04f1c-d96f-4320-b10b-54a442951373	String	jsonType.label
5f740547-16ff-4520-aa69-4447e3123a6c	true	id.token.claim
5f740547-16ff-4520-aa69-4447e3123a6c	true	access.token.claim
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
527acbe5-3cd4-4be7-807b-077545af81e5	true	userinfo.token.claim
527acbe5-3cd4-4be7-807b-077545af81e5	phoneNumberVerified	user.attribute
527acbe5-3cd4-4be7-807b-077545af81e5	true	id.token.claim
527acbe5-3cd4-4be7-807b-077545af81e5	true	access.token.claim
527acbe5-3cd4-4be7-807b-077545af81e5	phone_number_verified	claim.name
527acbe5-3cd4-4be7-807b-077545af81e5	boolean	jsonType.label
8287226d-7966-4aa3-89db-651524e90e68	true	userinfo.token.claim
8287226d-7966-4aa3-89db-651524e90e68	phoneNumber	user.attribute
8287226d-7966-4aa3-89db-651524e90e68	true	id.token.claim
8287226d-7966-4aa3-89db-651524e90e68	true	access.token.claim
8287226d-7966-4aa3-89db-651524e90e68	phone_number	claim.name
8287226d-7966-4aa3-89db-651524e90e68	String	jsonType.label
c0cbe12a-4989-4390-903f-238a94a6edeb	formatted	user.attribute.formatted
c0cbe12a-4989-4390-903f-238a94a6edeb	country	user.attribute.country
c0cbe12a-4989-4390-903f-238a94a6edeb	postal_code	user.attribute.postal_code
c0cbe12a-4989-4390-903f-238a94a6edeb	true	userinfo.token.claim
c0cbe12a-4989-4390-903f-238a94a6edeb	street	user.attribute.street
c0cbe12a-4989-4390-903f-238a94a6edeb	true	id.token.claim
c0cbe12a-4989-4390-903f-238a94a6edeb	region	user.attribute.region
c0cbe12a-4989-4390-903f-238a94a6edeb	true	access.token.claim
c0cbe12a-4989-4390-903f-238a94a6edeb	locality	user.attribute.locality
1b6d5d6e-f385-42b6-9eef-de0237154493	foo	user.attribute
1b6d5d6e-f385-42b6-9eef-de0237154493	true	access.token.claim
1b6d5d6e-f385-42b6-9eef-de0237154493	resource_access.${client_id}.roles	claim.name
1b6d5d6e-f385-42b6-9eef-de0237154493	String	jsonType.label
1b6d5d6e-f385-42b6-9eef-de0237154493	true	multivalued
89bea514-5db9-4d4b-9bfa-86e821b156a8	foo	user.attribute
89bea514-5db9-4d4b-9bfa-86e821b156a8	true	access.token.claim
89bea514-5db9-4d4b-9bfa-86e821b156a8	realm_access.roles	claim.name
89bea514-5db9-4d4b-9bfa-86e821b156a8	String	jsonType.label
89bea514-5db9-4d4b-9bfa-86e821b156a8	true	multivalued
f1eda575-234d-49a9-b332-870ef8e4ee34	true	id.token.claim
f1eda575-234d-49a9-b332-870ef8e4ee34	true	access.token.claim
f1eda575-234d-49a9-b332-870ef8e4ee34	true	userinfo.token.claim
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
6fd508f8-286a-423a-b236-6ecf76794809	true	userinfo.token.claim
6fd508f8-286a-423a-b236-6ecf76794809	picture	user.attribute
6fd508f8-286a-423a-b236-6ecf76794809	true	id.token.claim
6fd508f8-286a-423a-b236-6ecf76794809	true	access.token.claim
6fd508f8-286a-423a-b236-6ecf76794809	picture	claim.name
6fd508f8-286a-423a-b236-6ecf76794809	String	jsonType.label
743a7b80-0e64-4910-ac17-11e00a14dc25	true	userinfo.token.claim
743a7b80-0e64-4910-ac17-11e00a14dc25	birthdate	user.attribute
743a7b80-0e64-4910-ac17-11e00a14dc25	true	id.token.claim
743a7b80-0e64-4910-ac17-11e00a14dc25	true	access.token.claim
743a7b80-0e64-4910-ac17-11e00a14dc25	birthdate	claim.name
743a7b80-0e64-4910-ac17-11e00a14dc25	String	jsonType.label
8ba38c26-4e64-499f-b26a-4dac7b65e5e2	true	userinfo.token.claim
8ba38c26-4e64-499f-b26a-4dac7b65e5e2	username	user.attribute
8ba38c26-4e64-499f-b26a-4dac7b65e5e2	true	id.token.claim
8ba38c26-4e64-499f-b26a-4dac7b65e5e2	true	access.token.claim
8ba38c26-4e64-499f-b26a-4dac7b65e5e2	preferred_username	claim.name
8ba38c26-4e64-499f-b26a-4dac7b65e5e2	String	jsonType.label
8fa987c1-edc4-4627-9a1c-89b2006f00c2	true	userinfo.token.claim
8fa987c1-edc4-4627-9a1c-89b2006f00c2	locale	user.attribute
8fa987c1-edc4-4627-9a1c-89b2006f00c2	true	id.token.claim
8fa987c1-edc4-4627-9a1c-89b2006f00c2	true	access.token.claim
8fa987c1-edc4-4627-9a1c-89b2006f00c2	locale	claim.name
8fa987c1-edc4-4627-9a1c-89b2006f00c2	String	jsonType.label
9ee44d95-5040-4931-987c-c6ff68aa0cb2	true	userinfo.token.claim
9ee44d95-5040-4931-987c-c6ff68aa0cb2	profile	user.attribute
9ee44d95-5040-4931-987c-c6ff68aa0cb2	true	id.token.claim
9ee44d95-5040-4931-987c-c6ff68aa0cb2	true	access.token.claim
9ee44d95-5040-4931-987c-c6ff68aa0cb2	profile	claim.name
9ee44d95-5040-4931-987c-c6ff68aa0cb2	String	jsonType.label
b457d883-4d2c-4b91-9d3c-c65353040203	true	userinfo.token.claim
b457d883-4d2c-4b91-9d3c-c65353040203	zoneinfo	user.attribute
b457d883-4d2c-4b91-9d3c-c65353040203	true	id.token.claim
b457d883-4d2c-4b91-9d3c-c65353040203	true	access.token.claim
b457d883-4d2c-4b91-9d3c-c65353040203	zoneinfo	claim.name
b457d883-4d2c-4b91-9d3c-c65353040203	String	jsonType.label
b8776830-968d-4d61-bb7f-0a21baa15cbb	true	userinfo.token.claim
b8776830-968d-4d61-bb7f-0a21baa15cbb	middleName	user.attribute
b8776830-968d-4d61-bb7f-0a21baa15cbb	true	id.token.claim
b8776830-968d-4d61-bb7f-0a21baa15cbb	true	access.token.claim
b8776830-968d-4d61-bb7f-0a21baa15cbb	middle_name	claim.name
b8776830-968d-4d61-bb7f-0a21baa15cbb	String	jsonType.label
c5b21a31-a5d4-4baf-be82-3ac1c6f2f7fb	true	userinfo.token.claim
c5b21a31-a5d4-4baf-be82-3ac1c6f2f7fb	website	user.attribute
c5b21a31-a5d4-4baf-be82-3ac1c6f2f7fb	true	id.token.claim
c5b21a31-a5d4-4baf-be82-3ac1c6f2f7fb	true	access.token.claim
c5b21a31-a5d4-4baf-be82-3ac1c6f2f7fb	website	claim.name
c5b21a31-a5d4-4baf-be82-3ac1c6f2f7fb	String	jsonType.label
ccaaf2e7-9cb1-425e-aa23-ae638823b831	true	userinfo.token.claim
ccaaf2e7-9cb1-425e-aa23-ae638823b831	firstName	user.attribute
ccaaf2e7-9cb1-425e-aa23-ae638823b831	true	id.token.claim
ccaaf2e7-9cb1-425e-aa23-ae638823b831	true	access.token.claim
ccaaf2e7-9cb1-425e-aa23-ae638823b831	given_name	claim.name
ccaaf2e7-9cb1-425e-aa23-ae638823b831	String	jsonType.label
d226370f-9657-4dbc-a08e-dd4d7474aaf0	true	userinfo.token.claim
d226370f-9657-4dbc-a08e-dd4d7474aaf0	updatedAt	user.attribute
d226370f-9657-4dbc-a08e-dd4d7474aaf0	true	id.token.claim
d226370f-9657-4dbc-a08e-dd4d7474aaf0	true	access.token.claim
d226370f-9657-4dbc-a08e-dd4d7474aaf0	updated_at	claim.name
d226370f-9657-4dbc-a08e-dd4d7474aaf0	long	jsonType.label
d33477f1-78dd-4b51-a5cf-45d267fbd840	true	id.token.claim
d33477f1-78dd-4b51-a5cf-45d267fbd840	true	access.token.claim
d33477f1-78dd-4b51-a5cf-45d267fbd840	true	userinfo.token.claim
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
878919f1-9bad-42a5-b5d2-3e86c0fcbacf	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	a8e7a68a-8305-40d2-8eea-d073c3354b2b	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	2c439e32-72d1-440c-bf9e-5c2bea18a197	dd472481-336c-4bee-808f-68893c640193	5fe39cc7-c6c3-471b-914c-182bd0d63655	008f0acc-86a4-40bb-911a-937f93b5435e	26d5e591-986b-473e-902f-272c29777475	2592000	f	900	t	f	6aef893f-4214-4a66-b87d-37e3a0e08ddb	0	f	0	0	25c74a80-0a91-47a7-b9f6-ceb486d0135d
market	60	300	300	\N	\N	\N	t	f	0	\N	market	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	dd7ede58-ac30-4667-8961-0f78928cdb52	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	ffa09e26-5c68-4667-be30-7c9c88a81906	a4488f78-6eae-4c18-a681-292cdab07df3	b7cebff7-81ff-4093-aa31-1d381fd31b6b	3aca266d-d64f-452d-8eee-b46d6da92723	1027b577-57a8-42f2-8f78-cc3445dc515c	2592000	f	900	t	f	74bdd1dc-0ad8-4ef6-9bf5-92f73ec55566	0	f	0	0	7ecb559e-996b-46ef-9847-576167f7963f
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	
_browser_header.xContentTypeOptions	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	nosniff
_browser_header.xRobotsTag	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	none
_browser_header.xFrameOptions	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	SAMEORIGIN
_browser_header.contentSecurityPolicy	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	1; mode=block
_browser_header.strictTransportSecurity	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	max-age=31536000; includeSubDomains
bruteForceProtected	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	false
permanentLockout	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	false
maxFailureWaitSeconds	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	900
minimumQuickLoginWaitSeconds	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	60
waitIncrementSeconds	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	60
quickLoginCheckMilliSeconds	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	1000
maxDeltaTimeSeconds	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	43200
failureFactor	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	30
displayName	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	Keycloak
displayNameHtml	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	RS256
offlineSessionMaxLifespanEnabled	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	false
offlineSessionMaxLifespan	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	5184000
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
878919f1-9bad-42a5-b5d2-3e86c0fcbacf	jboss-logging
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
password	password	t	t	878919f1-9bad-42a5-b5d2-3e86c0fcbacf
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
7cc240b3-97af-4269-bec0-fb96efb94b37	/realms/master/account/*
31690c0b-414a-48ed-9234-0211a5cae584	/realms/master/account/*
94c44dac-e118-4431-b031-d78411616990	/admin/master/console/*
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
d6656132-cfc7-4fc0-ac56-a7683090d7aa	VERIFY_EMAIL	Verify Email	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	t	f	VERIFY_EMAIL	50
29ea081a-3015-4a35-841e-9247bde0e114	UPDATE_PROFILE	Update Profile	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	t	f	UPDATE_PROFILE	40
e2447666-56dd-4318-8abb-9a869334cf2d	CONFIGURE_TOTP	Configure OTP	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	t	f	CONFIGURE_TOTP	10
dcd92793-71c9-45b2-8fb2-a4a0773294ac	UPDATE_PASSWORD	Update Password	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	t	f	UPDATE_PASSWORD	30
5cb58b4d-2ee7-460e-80a5-78ed3bc3357d	terms_and_conditions	Terms and Conditions	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	f	f	terms_and_conditions	20
8b745b5b-a68c-43bf-89ee-82c82a0c4155	update_user_locale	Update User Locale	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	t	f	update_user_locale	1000
ca6b30f4-ee8b-429e-8d44-8c8ce5437a1d	delete_account	Delete Account	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	f	f	delete_account	60
8d9b9464-c6b4-44eb-aa54-ad549e23afd8	webauthn-register	Webauthn Register	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	t	f	webauthn-register	70
a7f611d0-7a84-4c39-8e0b-44b0cd0cc3fa	webauthn-register-passwordless	Webauthn Register Passwordless	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	t	f	webauthn-register-passwordless	80
fff480e3-b6ba-4e4e-9e04-12ee5caa8be5	CONFIGURE_TOTP	Configure OTP	market	t	f	CONFIGURE_TOTP	10
d4b1f38e-52dd-4a53-a39a-e6b965b2cdef	terms_and_conditions	Terms and Conditions	market	f	f	terms_and_conditions	20
611169cd-9ffa-420b-b710-66aeee6e08f8	UPDATE_PASSWORD	Update Password	market	t	f	UPDATE_PASSWORD	30
3c79a82e-c914-4c5f-b900-6ad85483c9b3	UPDATE_PROFILE	Update Profile	market	t	f	UPDATE_PROFILE	40
3cfcdd51-8b32-4722-b922-d779e208752a	VERIFY_EMAIL	Verify Email	market	t	f	VERIFY_EMAIL	50
505ecdbe-0bdd-47ec-9413-949a02773ea1	delete_account	Delete Account	market	f	f	delete_account	60
a855d634-0ac7-4b84-b25d-ef0c11cf7b82	update_user_locale	Update User Locale	market	t	f	update_user_locale	1000
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
31690c0b-414a-48ed-9234-0211a5cae584	06f33e9b-a59f-489b-a156-e9536726f6be
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
LDAP_ID	user1	adb1f8b1-d362-4bd8-bd5b-f7564a6acd4c	7687ca6d-7e80-4e11-bd67-4c61650cae50
LDAP_ENTRY_DN	cn=user1,ou=market-app,dc=trodix,dc=com	adb1f8b1-d362-4bd8-bd5b-f7564a6acd4c	add26492-7ea2-4810-8888-caaed4a1f961
LDAP_ID	user2	1adf1de8-4ffe-4290-9cc5-17698593b280	6bd28880-72fa-45b0-82bc-b530df4bc286
LDAP_ENTRY_DN	cn=user2,ou=market-app,dc=trodix,dc=com	1adf1de8-4ffe-4290-9cc5-17698593b280	ec29ea88-42f7-4e2e-9ec0-2056d93eca83
LDAP_ID	user3	4da3f610-c71d-43e6-976a-32e919b3b94f	809aa880-eafd-4a60-8029-7dd7ea1554f3
LDAP_ENTRY_DN	cn=user3,ou=market-app,dc=trodix,dc=com	4da3f610-c71d-43e6-976a-32e919b3b94f	ca08911f-8536-433f-8d81-42142ebfe3c4
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
d69c209f-a529-48a9-b653-4c60dee05761	\N	8bc82ecc-6229-4e18-8f2f-ea1b61557cda	f	t	\N	\N	\N	878919f1-9bad-42a5-b5d2-3e86c0fcbacf	admin	1667300618656	\N	0
adb1f8b1-d362-4bd8-bd5b-f7564a6acd4c	\N	c14799f2-c265-4743-9e29-b7ca80e036ee	f	t	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	\N	Bar1	market	user1	1667301818567	\N	0
1adf1de8-4ffe-4290-9cc5-17698593b280	\N	24cc4622-e291-44ae-9a4a-dd6780eb0275	f	t	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	\N	Bar2	market	user2	1667301818574	\N	0
4da3f610-c71d-43e6-976a-32e919b3b94f	\N	0ea26344-18b7-4bda-9ac6-a5a9785802b5	f	t	646ef5a1-8a11-4aea-bf72-ea5d1e318d89	\N	Bar3	market	user3	1667301818580	\N	0
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
25c74a80-0a91-47a7-b9f6-ceb486d0135d	d69c209f-a529-48a9-b653-4c60dee05761
f8f149be-d8ad-4085-bc3c-06ead12d429b	d69c209f-a529-48a9-b653-4c60dee05761
335c76c0-44b3-410f-a5e5-afc5f7236d8c	d69c209f-a529-48a9-b653-4c60dee05761
40f6113e-39a6-4b7a-ac10-da93de1e3120	d69c209f-a529-48a9-b653-4c60dee05761
7eb0df42-db7d-4817-8926-88d132c897f8	d69c209f-a529-48a9-b653-4c60dee05761
eb9f3620-7ff4-4638-89a6-7fbba4c54b7f	d69c209f-a529-48a9-b653-4c60dee05761
e726c448-63d6-44ec-a955-12c3e2288cc8	d69c209f-a529-48a9-b653-4c60dee05761
1a4784a5-ee05-40d7-b67e-1d3635820a52	d69c209f-a529-48a9-b653-4c60dee05761
4a406840-200d-4c19-b6fd-04d8208d184f	d69c209f-a529-48a9-b653-4c60dee05761
0f520643-51f9-42ee-8815-f106278fa2b9	d69c209f-a529-48a9-b653-4c60dee05761
daa3849c-f90e-4b2d-8c02-91949bd42959	d69c209f-a529-48a9-b653-4c60dee05761
6dbeec2f-01f7-41ab-a299-bf62dd44e3ab	d69c209f-a529-48a9-b653-4c60dee05761
6cd5aee0-6798-4b1f-ae95-7cff38b975ca	d69c209f-a529-48a9-b653-4c60dee05761
760568bc-bad0-4665-9968-559b4721ee93	d69c209f-a529-48a9-b653-4c60dee05761
4877114a-6a10-4fd5-8935-7eef6b2969bf	d69c209f-a529-48a9-b653-4c60dee05761
6f821e11-2358-47ec-8561-1c5a968597e4	d69c209f-a529-48a9-b653-4c60dee05761
013dbec4-ee00-40b8-b4de-ec952d3ec118	d69c209f-a529-48a9-b653-4c60dee05761
25f74529-e8e1-49c3-be34-9d2875f1b36e	d69c209f-a529-48a9-b653-4c60dee05761
6dda8e77-36f4-4501-925f-6ac406be9122	d69c209f-a529-48a9-b653-4c60dee05761
7ecb559e-996b-46ef-9847-576167f7963f	adb1f8b1-d362-4bd8-bd5b-f7564a6acd4c
7ecb559e-996b-46ef-9847-576167f7963f	1adf1de8-4ffe-4290-9cc5-17698593b280
7ecb559e-996b-46ef-9847-576167f7963f	4da3f610-c71d-43e6-976a-32e919b3b94f
1b16c5d1-769d-467b-8c90-49a65f7aa6a6	adb1f8b1-d362-4bd8-bd5b-f7564a6acd4c
4bdc3b47-e92d-45cf-a8c0-455c6f97ad35	1adf1de8-4ffe-4290-9cc5-17698593b280
4bdc3b47-e92d-45cf-a8c0-455c6f97ad35	4da3f610-c71d-43e6-976a-32e919b3b94f
1b16c5d1-769d-467b-8c90-49a65f7aa6a6	4da3f610-c71d-43e6-976a-32e919b3b94f
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
94c44dac-e118-4431-b031-d78411616990	+
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

