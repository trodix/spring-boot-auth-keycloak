package com.trodix.keycloakdemo.market.controller;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import java.util.ArrayList;
import java.util.List;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mapstruct.factory.Mappers;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import com.trodix.keycloakdemo.market.dto.request.CreateProductRequest;
import com.trodix.keycloakdemo.market.dto.response.ProductResponse;
import com.trodix.keycloakdemo.market.mapper.ProductMapper;
import com.trodix.keycloakdemo.market.model.ProductModel;
import com.trodix.keycloakdemo.market.service.ProductService;

@ExtendWith(MockitoExtension.class)
public class ProductControllerTest {

    private ProductMapper productMapper;

    @Mock
    ProductService productService;

    private ProductController productController;

    @BeforeEach
    void initUseCase() {
        productMapper = Mappers.getMapper(ProductMapper.class);
        productController = new ProductController(productService, productMapper);
    }

    @Test
    public void save_product_success() throws Exception {
        final ProductModel productModel = new ProductModel(1L, "Tomates", "Du jardin");

        final CreateProductRequest request = new CreateProductRequest();
        request.setName("Tomates");
        request.setDescription("Du jardin");

        when(productService.saveProduct(any(ProductModel.class))).thenReturn(productModel);

        final ProductResponse response = productController.createProduct(request);
        Assertions.assertThat(response.getId()).isEqualTo(1L);
        Assertions.assertThat(response.getName()).isEqualTo("Tomates");
        Assertions.assertThat(response.getDescription()).isEqualTo("Du jardin");
    }

    @Test
    public void product_fetch_in_db_success() throws Exception {
        final List<ProductModel> productModelList = new ArrayList<>();
        productModelList.add(new ProductModel(1L, "Tomates", "Du jardin"));

        final CreateProductRequest request = new CreateProductRequest();
        request.setName("Tomates");
        request.setDescription("Du jardin");

        when(productService.findProductByNameOrDescriptionContaining("Tomates", 0)).thenReturn(productModelList);

        final List<ProductResponse> response = productController.searchProducts("Tomates", 0).getItems();
        Assertions.assertThat(response.size()).isEqualTo(1);
    }

}
