package com.trodix.keycloakdemo.market.model;

import java.io.Serializable;
import com.opencsv.bean.CsvBindByName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductModel implements Serializable {

    private static final long serialVersionUID = 1L;

    @CsvBindByName(column = "grp_id")
    private Long productId;

    @CsvBindByName(column = "name")
    private String name;

    @CsvBindByName(column = "brand")
    private String description;

}
