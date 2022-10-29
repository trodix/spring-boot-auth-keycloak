package com.trodix.keycloakdemo.market.listener;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Iterator;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;
import org.springframework.util.ResourceUtils;
import com.opencsv.bean.CsvToBean;
import com.opencsv.bean.CsvToBeanBuilder;
import com.trodix.keycloakdemo.market.model.ProductModel;
import com.trodix.keycloakdemo.market.repository.ProductRepository;
import com.trodix.keycloakdemo.market.service.ProductService;
import lombok.extern.slf4j.Slf4j;

@Component
@Profile("dev")
@Slf4j
public class ApplicationReadyListener implements ApplicationListener<ApplicationReadyEvent> {

    private final ProductService productService;

    private final ProductRepository productRepository;

    @Value("${app.init-products-dataset-file}")
    private String initProductsDataset;

    /**
     * @param productService
     */
    public ApplicationReadyListener(final ProductService productService, final ProductRepository productRepository) {
        this.productService = productService;
        this.productRepository = productRepository;
    }

    @Override
    public void onApplicationEvent(final ApplicationReadyEvent event) {
        final long count = productRepository.count();

        if (count < 1) {
            initProductsDataset();
        } else {
            log.info("Product dataset already loaded. Skipping...");
        }

    }

    private void initProductsDataset() {

        log.info("Loading product dataset...");

        File csv = null;
        try {
            csv = ResourceUtils.getFile(initProductsDataset);
            log.info("Configured product dataset found: {}", initProductsDataset);
        } catch (final FileNotFoundException e1) {
            e1.printStackTrace();
        }
        if (csv != null) {

            try (
                    final InputStream is = new FileInputStream(csv);
                    final BufferedReader reader = new BufferedReader(new InputStreamReader(is))) {


                final CsvToBean<ProductModel> csvToBean = new CsvToBeanBuilder(reader)
                        .withType(ProductModel.class)
                        .withSeparator(';')
                        .withIgnoreLeadingWhiteSpace(true)
                        .build();

                final Iterator<ProductModel> products = csvToBean.iterator();

                log.info("Processing dataset... please wait, this can take several minutes", products);

                int counter = 1;
                while (products.hasNext()) {
                    try {
                        final ProductModel p = products.next();
                        final long newId = Long.parseLong(String.valueOf(counter) + String.valueOf(p.getProductId()));
                        p.setProductId(newId);
                        productService.saveProduct(p);
                        log.debug("Saved product: " + p.getProductId() + " " + p.getName());
                    } catch (final RuntimeException e) {
                        log.error("Error while parsing a row", e.getMessage());
                    }
                    counter++;
                }

                log.info("Dataset {} loaded successfully", initProductsDataset);

            } catch (final IOException e) {
                log.error("Errow while processing dataset: {}.", e.getMessage(), e);
            }

        }

    }

}

