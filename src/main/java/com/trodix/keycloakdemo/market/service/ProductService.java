package com.trodix.keycloakdemo.market.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.trodix.keycloakdemo.core.performancelogging.annotation.PerformanceLogging;
import com.trodix.keycloakdemo.market.entity.Product;
import com.trodix.keycloakdemo.market.entity.ProductIndex;
import com.trodix.keycloakdemo.market.mapper.ProductMapper;
import com.trodix.keycloakdemo.market.model.ProductModel;
import com.trodix.keycloakdemo.market.repository.ProductRepository;

@Service
public class ProductService {

    private final ProductRepository productRepository;

    private final ProductSearchService productSearchService;

    private final ProductIndexerService productIndexerService;

    private final ProductMapper productMapper;

    private final JmsProducer jmsProducer;

    public ProductService(final ProductRepository productRepository, final ProductSearchService productSearchService,
            final ProductIndexerService productIndexerService, final ProductMapper productMapper,
            final JmsProducer jmsProducer) {
        this.productRepository = productRepository;
        this.productSearchService = productSearchService;
        this.productIndexerService = productIndexerService;
        this.productMapper = productMapper;
        this.jmsProducer = jmsProducer;
    }

    @PerformanceLogging
    public List<ProductModel> findProductByNameOrDescriptionContaining(final String searchTerms, final Integer limit) {
        final List<ProductIndex> productIndexList = productSearchService.findByNameOrDescriptionContaining(searchTerms, limit);
        final List<Product> productList = productRepository.findAllById(productIndexList.stream().map(ProductIndex::getId).toList());
        return productMapper.productListToProductModelList(productList);
    }

    @PerformanceLogging
    public ProductModel saveProduct(final ProductModel productModel) {
        final Product product = productMapper.productModelToProduct(productModel);
        final Product saveAndFlush = productRepository.saveAndFlush(product);

        final ProductIndex productIndex = productMapper.productToProductIndex(saveAndFlush);
        productIndexerService.createProductIndex(productIndex);

        final ProductModel response = productMapper.productToProductModel(saveAndFlush);
        jmsProducer.sendMessage(response);

        return response;
    }

    public void deleteProduct(final Long productId) {
        Product product = productRepository.findById(productId).orElseThrow();
        productRepository.delete(product);
        productIndexerService.deleteProductIndex(productMapper.productToProductIndex(product));
    }

}
