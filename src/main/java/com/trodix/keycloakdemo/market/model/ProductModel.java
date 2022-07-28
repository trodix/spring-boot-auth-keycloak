package com.trodix.keycloakdemo.market.model;

import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductModel implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long productId;

    private String name;

    private String description;

}
