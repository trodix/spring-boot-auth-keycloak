package com.trodix.keycloakdemo.market.dto.request;

import javax.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreateProductRequest {

    @NotBlank(message = "A product must have a name")
    private String name;

    private String description;

}
