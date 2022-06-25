package com.trodix.keycloakdemo.market.repository;

import static org.junit.jupiter.api.Assertions.assertEquals;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import com.trodix.keycloakdemo.market.entity.Product;

@DataJpaTest
public class ProductRepositoryTest {

    @Autowired
    private ProductRepository productRepository;

    @BeforeEach
    void initUseCase() {
        final List<Product> products = Arrays.asList(
                new Product(0L, "Pain", "Il est bien frais"));

        productRepository.saveAll(products);
    }

    @AfterEach
    public void destroyAll() {
        productRepository.deleteAll();
    }

    @Test
    void saveAll_success() {
        final List<Product> products = Arrays.asList(
                new Product(1L, "Brioche tranchée", "Moelleuse et fondante"),
                new Product(2L, "Compotes de pomme", "Sans sucre ajouté"),
                new Product(3L, "Yaourts aux fruits rouges", "Pack de 8"));
        final Iterable<Product> allProducts = productRepository.saveAll(products);

        final AtomicInteger validIdFound = new AtomicInteger();
        allProducts.forEach(product -> {
            if (product.getProductId() > 0) {
                validIdFound.getAndIncrement();
            }
        });

        assertEquals(3, validIdFound.intValue());
    }

    @Test
    void findAll_success() {
        final List<Product> allProducts = productRepository.findAll();
        Assertions.assertThat(allProducts.size()).isGreaterThanOrEqualTo(1);
    }


}
