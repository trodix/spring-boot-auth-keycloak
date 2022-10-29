package com.trodix.keycloakdemo.market.mapper;

import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;
import com.trodix.keycloakdemo.market.dto.request.CreateProductRequest;
import com.trodix.keycloakdemo.market.dto.response.ProductResponse;
import com.trodix.keycloakdemo.market.entity.Product;
import com.trodix.keycloakdemo.market.entity.ProductIndex;
import com.trodix.keycloakdemo.market.model.ProductModel;

@Mapper(componentModel = "spring")
public interface ProductMapper {
    ProductMapper INSTANCE = Mappers.getMapper(ProductMapper.class);

    @Mapping(source = "productId", target = "id")
    ProductResponse productModelToProductResponse(ProductModel product);

    List<ProductResponse> productModelListToProductResponseList(List<ProductModel> products);

    ProductModel createProductRequestToProductModel(CreateProductRequest createProductRequest);

    Product productModelToProduct(ProductModel productModel);

    ProductModel productToProductModel(Product product);

    List<Product> productModelListToProductList(List<ProductModel> products);

    List<ProductModel> productListToProductModelList(List<Product> products);

    @Mapping(source = "productId", target = "id")
    ProductIndex productToProductIndex(Product product);
}
