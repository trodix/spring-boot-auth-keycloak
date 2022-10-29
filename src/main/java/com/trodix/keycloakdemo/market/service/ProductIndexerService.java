package com.trodix.keycloakdemo.market.service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.ElasticsearchOperations;
import org.springframework.data.elasticsearch.core.IndexedObjectInformation;
import org.springframework.data.elasticsearch.core.mapping.IndexCoordinates;
import org.springframework.data.elasticsearch.core.query.IndexQuery;
import org.springframework.data.elasticsearch.core.query.IndexQueryBuilder;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import com.trodix.keycloakdemo.market.entity.Product;
import com.trodix.keycloakdemo.market.entity.ProductIndex;
import com.trodix.keycloakdemo.market.mapper.ProductMapper;
import com.trodix.keycloakdemo.market.repository.ProductRepository;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ProductIndexerService {

    private static final String PRODUCT_INDEX = "product";

    private final ProductRepository productRepository;

    private final ProductMapper productMapper;

    private final ElasticsearchOperations elasticsearchOperations;

    public ProductIndexerService(final ProductRepository productRepository, final ProductMapper productMapper, final ElasticsearchOperations elasticsearchOperations) {
        this.productRepository = productRepository;
        this.productMapper = productMapper;
        this.elasticsearchOperations = elasticsearchOperations;
    }

    @Async
    @Scheduled(fixedDelayString = "${app.indexes.synchronization.fixed-delay}", timeUnit = TimeUnit.MINUTES)
    public List<Future<?>> synchronizeIndexes() {
        log.info("Starting to synchronize indexes");

        final int MAX_THREAD_NUMBER = 4;
        final int BATCH_SIZE = 100;
        final int count = (int) productRepository.count();
        final int pageCount = (count > 0 && count >= BATCH_SIZE)
                ? (count / BATCH_SIZE)
                : 1;

        final ThreadPoolExecutor executor = (ThreadPoolExecutor) Executors.newFixedThreadPool(MAX_THREAD_NUMBER);
        final List<Future<?>> runningTasks = new ArrayList<>();

        for (int pageIndex = 0; pageIndex < pageCount; pageIndex++) {
            final Pageable pageable = PageRequest.of(pageIndex, 100);
            final Page<Product> page = productRepository.findAll(pageable);

            final List<ProductIndex> productIndexList = page.getContent().stream().map(productMapper::productToProductIndex).toList();
            
            final Runnable task = () -> createProductIndexBulk(productIndexList);
            log.info("Adding new task to thread pool with page {}/{} ({} records)", pageIndex + 1, pageCount, count);
            final Future<?> pendingTask = executor.submit(task);
            runningTasks.add(pendingTask);
        }

        return runningTasks;
    }

    public List<IndexedObjectInformation> createProductIndexBulk(final List<ProductIndex> products) {

        final List<IndexQuery> queries = products.stream()
                .map(product -> new IndexQueryBuilder()
                        .withId(product.getId().toString())
                        .withObject(product).build())
                .collect(Collectors.toList());

        log.info("Running Bulk index query for {} items", products.size());

        List<IndexedObjectInformation> result = elasticsearchOperations.bulkIndex(queries, IndexCoordinates.of(PRODUCT_INDEX));
        log.info("{} items indexed from bulk query", result.size());

        return result;
    }

    public String createProductIndex(final ProductIndex product) {

        final IndexQuery indexQuery = new IndexQueryBuilder()
                .withId(product.getId().toString())
                .withObject(product).build();

        final String documentId = elasticsearchOperations
                .index(
                        indexQuery,
                        IndexCoordinates.of(PRODUCT_INDEX));

        return documentId;
    }

    public void deleteProductIndex(final ProductIndex product) {

        final IndexQuery indexQuery = new IndexQueryBuilder()
                .withId(product.getId().toString())
                .withObject(product).build();

        elasticsearchOperations.delete(indexQuery, IndexCoordinates.of(PRODUCT_INDEX));
    }

}
