package com.trodix.keycloakdemo.market.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.trodix.keycloakdemo.market.entity.Product;
import com.trodix.keycloakdemo.market.mapper.ProductMapper;
import com.trodix.keycloakdemo.market.model.ProductModel;
import com.trodix.keycloakdemo.market.repository.ProductRepository;

@Service
public class ProductService {

    private final ProductRepository productRepository;

    private final ProductMapper productMapper;

    public ProductService(final ProductRepository productRepository, final ProductMapper productMapper) {
        this.productRepository = productRepository;
        this.productMapper = productMapper;
    }

    public List<ProductModel> getAllProducts() {
        final List<Product> productList = productRepository.findAll();
        return productMapper.productListToProductModelList(productList);
    }

    public ProductModel saveProduct(final ProductModel productModel) {
        final Product product = productMapper.productModelToProduct(productModel);
        return productMapper.productToProductModel(productRepository.saveAndFlush(product));
    }

}
