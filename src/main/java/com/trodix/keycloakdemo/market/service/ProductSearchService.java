package com.trodix.keycloakdemo.market.service;

import java.util.ArrayList;
import java.util.List;
import org.elasticsearch.common.unit.Fuzziness;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.elasticsearch.core.ElasticsearchOperations;
import org.springframework.data.elasticsearch.core.SearchHits;
import org.springframework.data.elasticsearch.core.mapping.IndexCoordinates;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;
import org.springframework.data.elasticsearch.core.query.Query;
import org.springframework.stereotype.Service;
import com.trodix.keycloakdemo.market.entity.ProductIndex;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ProductSearchService {

    private static final String PRODUCT_INDEX = "product";

    @Autowired
    private ElasticsearchOperations elasticsearchOperations;

    public List<ProductIndex> findByNameOrDescriptionContaining(final String query, final Integer limit) {
        log.debug("Search with query [{}] with limit [{}]", query, limit);

        // 1. Create query on multiple fields enabling fuzzy search
        final QueryBuilder queryBuilder =
                QueryBuilders
                        .multiMatchQuery(query, "name", "description")
                        .fuzziness(Fuzziness.AUTO);

        final NativeSearchQueryBuilder nativeBuilder = new NativeSearchQueryBuilder();
        nativeBuilder.withFilter(queryBuilder);

        if (limit > 0) {
            nativeBuilder.withMaxResults(limit);
        }

        final Query searchQuery = nativeBuilder.build();

        // 2. Execute search
        final SearchHits<ProductIndex> productHits =
                elasticsearchOperations
                        .search(searchQuery, ProductIndex.class,
                                IndexCoordinates.of(PRODUCT_INDEX));

        // 3. Map searchHits to product list
        final List<ProductIndex> productMatches = new ArrayList<>();
        productHits.forEach(searchHit -> productMatches.add(searchHit.getContent()));

        log.debug("Results found: {}", productMatches.size());

        return productMatches;
    }

}
