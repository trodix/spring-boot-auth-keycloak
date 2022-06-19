package com.trodix.keycloakdemo.market.controller;

import java.util.List;
import javax.annotation.security.RolesAllowed;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.trodix.keycloakdemo.market.mapper.ProductMapper;
import com.trodix.keycloakdemo.market.model.response.ProductResponse;
import com.trodix.keycloakdemo.market.service.ProductService;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/products")
public class ProductController {

    private final ProductService productService;

    private final ProductMapper mapper;

    public ProductController(final ProductService productService, final ProductMapper mapper) {
        this.productService = productService;
        this.mapper = mapper;
    }

    @GetMapping
    @RolesAllowed({"market-customer", "market-admin"})
    public List<ProductResponse> getProducts() {
        return mapper.productListToProductResponseList(this.productService.getAllProducts());
    }

}
