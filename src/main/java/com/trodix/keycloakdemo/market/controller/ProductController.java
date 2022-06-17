package com.trodix.keycloakdemo.market.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.security.RolesAllowed;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.trodix.keycloakdemo.market.model.Product;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/products")
public class ProductController {

    @GetMapping
    @RolesAllowed({ "market-customer", "market-admin" })
    public List<Product> getProducts() {
        final List<Product> products = new ArrayList<>();
        final Product p1 = new Product(0, "Saumon", "Péché en Norvège");

        products.add(p1);

        return products;
    }

}
