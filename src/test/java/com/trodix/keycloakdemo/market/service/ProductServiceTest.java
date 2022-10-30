package com.trodix.keycloakdemo.market.service;

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
import com.trodix.keycloakdemo.market.entity.Product;
import com.trodix.keycloakdemo.market.entity.ProductIndex;
import com.trodix.keycloakdemo.market.mapper.ProductMapper;
import com.trodix.keycloakdemo.market.model.ProductModel;
import com.trodix.keycloakdemo.market.repository.ProductRepository;

@ExtendWith(MockitoExtension.class)
public class ProductServiceTest {

    @Mock
    private ProductRepository productRepository;

    @Mock
    private ProductSearchService productSearchService;

    @Mock
    private ProductIndexerService productIndexerService;

    @Mock
    private JmsProducer jmsProducer;

    private ProductMapper productMapper;

    ProductService productService;

    @BeforeEach
    void initUseCase() {
        productMapper = Mappers.getMapper(ProductMapper.class);
        productService = new ProductService(productRepository, productSearchService, productIndexerService, productMapper, jmsProducer);
    }

    @Test
    public void savedProduct_Success() {
        final Product product = new Product(1L, "Tomates", "Du jardin");
        final ProductModel productModel = new ProductModel(null, "Tomates", "Du jardin");

        // providing knowledge
        when(productRepository.saveAndFlush(any(Product.class))).thenReturn(product);

        final ProductModel savedProduct = productService.saveProduct(productModel);

        Assertions.assertThat(savedProduct.getProductId()).isNotNull();
        Assertions.assertThat(savedProduct.getProductId()).isEqualTo(1L);
        Assertions.assertThat(savedProduct.getName()).isNotBlank();
        Assertions.assertThat(savedProduct.getDescription()).isNotBlank();
    }

    @Test
    public void product_exists_in_db_success() {
        final Product product = new Product(1L, "Tomates", "Du jardin");
        final List<Product> productList = new ArrayList<>();
        productList.add(product);

        final ProductIndex productIndex = new ProductIndex();
        productIndex.setId(1L);
        productIndex.setName("Tomates");
        productIndex.setDescription("Du jardin");

        final List<ProductIndex> productIndexList = new ArrayList<>();
        productIndexList.add(productIndex);

        // providing knowledge
        when(productSearchService.findByNameOrDescriptionContaining("Tomates", 0)).thenReturn(productIndexList);
        when(productRepository.findAllById(List.of(1L))).thenReturn(productList);

        final List<ProductModel> fetchedProducts = productService.findProductByNameOrDescriptionContaining("Tomates", 0);
        Assertions.assertThat(fetchedProducts.size()).isGreaterThan(0);
    }

}
