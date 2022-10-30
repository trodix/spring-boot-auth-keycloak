package com.trodix.keycloakdemo.core.model;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class SearchResult<T> {

    private Integer resultCount;

    private List<T> items;
    
}
