package com.trodix.keycloakdemo.core.config;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import javax.annotation.PostConstruct;
import org.apache.commons.collections.SetUtils;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.convert.converter.Converter;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.security.oauth2.server.resource.authentication.JwtGrantedAuthoritiesConverter;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

/**
 * <p>Convert Keycloak realm client roles to spring roles.</p>
 * 
 * <p>Roles are mapped <code>to ROLE_client-id_client-role-name</code></p>
 * 
 * <p>The property app.keycloak.jwt.role.locations holds the list of keycloak client ids where the
 * mapper will extract the roles from.</p>
 * 
 */
@Component
public class KeycloakJwtAuthenticationConverter implements Converter<Jwt, AbstractAuthenticationToken>, InitializingBean {

    @Value("${app.keycloak.jwt.role.locations}")
    private List<String> clientIds;

    @Override
    public void afterPropertiesSet() throws IllegalArgumentException {
        if (CollectionUtils.isEmpty(clientIds)) {
            throw new IllegalArgumentException("The property value app.keycloak.jwt.role.locations is mandatory.");
        }
    }

    @Override
    public AbstractAuthenticationToken convert(final Jwt source) {
        return new JwtAuthenticationToken(source, Stream.concat(new JwtGrantedAuthoritiesConverter().convert(source)
                .stream(), extractResourceRoles(source).stream())
                .collect(Collectors.toSet()));
    }

    private Collection<? extends GrantedAuthority> extractResourceRoles(final Jwt jwt) {
        final var resourceAccess = new HashMap<>(jwt.getClaim("resource_access"));
        final var resourceRoles = new ArrayList<>();

        clientIds.stream().forEach(id -> {
            if (resourceAccess.containsKey(id)) {
                final Map<String, List<String>> resource = (Map<String, List<String>>) resourceAccess.get(id);
                resource.get("roles").forEach(role -> resourceRoles.add(id + "_" + role));
            }
        });
        return resourceRoles.isEmpty() ? SetUtils.EMPTY_SET
                : resourceRoles.stream().map(r -> new SimpleGrantedAuthority("ROLE_" + r)).collect(Collectors.toSet());
    }

}
