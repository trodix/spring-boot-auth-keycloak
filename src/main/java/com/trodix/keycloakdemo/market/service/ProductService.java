package com.trodix.keycloakdemo.market.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.trodix.keycloakdemo.market.entity.Product;
import com.trodix.keycloakdemo.market.repository.ProductRepository;

@Service
public class ProductService {

    private final ProductRepository productRepository;

    public ProductService(final ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public List<Product> getAllProducts() {
        return this.productRepository.findAll();
    }

}
