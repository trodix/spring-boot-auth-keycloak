package com.trodix.keycloakdemo.market.controller;

import java.util.List;
import javax.annotation.security.RolesAllowed;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.trodix.keycloakdemo.market.dto.request.CreateProductRequest;
import com.trodix.keycloakdemo.market.dto.response.ProductResponse;
import com.trodix.keycloakdemo.market.mapper.ProductMapper;
import com.trodix.keycloakdemo.market.model.ProductModel;
import com.trodix.keycloakdemo.market.service.ProductService;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/products")
public class ProductController {

    private final ProductService productService;

    private final ProductMapper productMapper;

    public ProductController(final ProductService productService, final ProductMapper productMapper) {
        this.productService = productService;
        this.productMapper = productMapper;
    }

    @GetMapping
    @RolesAllowed({"market-customer", "market-admin"})
    public List<ProductResponse> getProducts() {
        return productMapper.productModelListToProductResponseList(productService.getAllProducts());
    }

    @PostMapping
    @RolesAllowed({"market-admin"})
    public ProductResponse createProduct(@RequestBody final CreateProductRequest productRequest) {
        final ProductModel productModel = productMapper.createProductRequestToProductModel(productRequest);
        return productMapper.productModelToProductResponse(productService.saveProduct(productModel));
    }

}
