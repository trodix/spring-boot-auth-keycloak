package com.trodix.keycloakdemo.market.mapper;

import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;
import com.trodix.keycloakdemo.market.entity.Product;
import com.trodix.keycloakdemo.market.model.response.ProductResponse;

@Mapper(componentModel = "spring")
public interface ProductMapper {
    ProductMapper INSTANCE = Mappers.getMapper(ProductMapper.class);

    ProductResponse productToProductResponse(Product product);

    List<ProductResponse> productListToProductResponseList(List<Product> products);
}
