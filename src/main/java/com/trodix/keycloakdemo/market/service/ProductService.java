package com.trodix.keycloakdemo.market.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.trodix.keycloakdemo.core.performancelogging.annotation.PerformanceLogging;
import com.trodix.keycloakdemo.market.entity.Product;
import com.trodix.keycloakdemo.market.mapper.ProductMapper;
import com.trodix.keycloakdemo.market.model.ProductModel;
import com.trodix.keycloakdemo.market.repository.ProductRepository;

@Service
public class ProductService {

    private final ProductRepository productRepository;

    private final ProductMapper productMapper;

    private final JmsProducer jmsProducer;

    public ProductService(final ProductRepository productRepository, final ProductMapper productMapper, final JmsProducer jmsProducer) {
        this.productRepository = productRepository;
        this.productMapper = productMapper;
        this.jmsProducer = jmsProducer;
    }

    @PerformanceLogging
    public List<ProductModel> getAllProducts() {
        final List<Product> productList = productRepository.findAll();
        return productMapper.productListToProductModelList(productList);
    }

    @PerformanceLogging
    public ProductModel saveProduct(final ProductModel productModel) {
        final Product product = productMapper.productModelToProduct(productModel);
        final Product saveAndFlush = productRepository.saveAndFlush(product);
        final ProductModel response = productMapper.productToProductModel(saveAndFlush);
        jmsProducer.sendMessage(response);
        return response;
    }

}
