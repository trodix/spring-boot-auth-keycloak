package com.trodix.keycloakdemo.market.controller;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.given;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import java.util.ArrayList;
import java.util.List;
import org.apache.http.entity.ContentType;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.RequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.trodix.keycloakdemo.market.dto.request.CreateProductRequest;
import com.trodix.keycloakdemo.market.dto.response.ProductResponse;
import com.trodix.keycloakdemo.market.model.ProductModel;
import com.trodix.keycloakdemo.market.service.ProductService;


@SpringBootTest
@ActiveProfiles(value = "test")
@AutoConfigureMockMvc(addFilters = false)
public class ProductControllerIT {

    @Autowired
    private MockMvc mvc;

    @MockBean
    private ProductService productService;

    @Autowired
    ObjectMapper objectMapper;

    @Test
    @WithMockUser(username = "foo", roles = "market-customer")
    void getAllProducts_success_customer() throws Exception {
        final List<ProductModel> productModelList = new ArrayList<>();
        productModelList.add(new ProductModel(1L, "Riz Basmati", "Provenance Camargue"));

        final List<ProductResponse> productResponseList = new ArrayList<>();
        final ProductResponse productResponse = new ProductResponse(1L, "Riz Basmati", "Provenance Camargue");
        productResponseList.add(productResponse);

        given(productService.findProductByNameOrDescriptionContaining("Riz Basmati", 0)).willReturn(productModelList);

        final RequestBuilder request = MockMvcRequestBuilders
                .get("/api/products/search?query=Riz Basmati")
                .accept(MediaType.APPLICATION_JSON);

        mvc.perform(request)
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(jsonPath("$.resultCount").value(1))
                .andExpect(jsonPath("$.items[0].id").value(1L))
                .andExpect(jsonPath("$.items[0].name").value("Riz Basmati"))
                .andExpect(jsonPath("$.items[0].description").value("Provenance Camargue"))
                .andDo(MockMvcResultHandlers.print());
    }

    @Test
    @WithMockUser(username = "foo", roles = "market-admin")
    void getAllProducts_success_admin() throws Exception {
        final List<ProductModel> productModelList = new ArrayList<>();
        productModelList.add(new ProductModel(1L, "Riz Basmati", "Provenance Camargue"));

        final List<ProductResponse> productResponseList = new ArrayList<>();
        final ProductResponse productResponse = new ProductResponse(1L, "Riz Basmati", "Provenance Camargue");
        productResponseList.add(productResponse);

        given(productService.findProductByNameOrDescriptionContaining("Riz Basmati", 0)).willReturn(productModelList);

        final RequestBuilder request = MockMvcRequestBuilders
                .get("/api/products/search?query=Riz Basmati")
                .accept(MediaType.APPLICATION_JSON);

        mvc.perform(request)
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(jsonPath("$.resultCount").value(1))
                .andExpect(jsonPath("$.items[0].id").value(1L))
                .andExpect(jsonPath("$.items[0].name").value("Riz Basmati"))
                .andExpect(jsonPath("$.items[0].description").value("Provenance Camargue"))
                .andDo(MockMvcResultHandlers.print());
    }

    @Test
    @WithMockUser(username = "foo", roles = "bar")
    void getAllProducts_403() throws Exception {
        final RequestBuilder request = MockMvcRequestBuilders
                .get("/api/products/search?query=Tomates")
                .accept(MediaType.APPLICATION_JSON);

        mvc.perform(request)
                .andExpect(MockMvcResultMatchers.status().isForbidden())
                .andDo(MockMvcResultHandlers.print());
    }

    @Test
    @WithMockUser(username = "foo", roles = "market-admin")
    void createProduct_success() throws Exception {
        final CreateProductRequest productRequest = new CreateProductRequest();
        productRequest.setName("Riz Basmati");
        productRequest.setDescription("Provenance Camargue");
        final ProductModel productModel = new ProductModel(1L, "Riz Basmati", "Provenance Camargue");

        given(productService.saveProduct(any(ProductModel.class))).willReturn(productModel);

        final RequestBuilder request = MockMvcRequestBuilders
                .post("/api/products")
                .contentType(ContentType.APPLICATION_JSON.toString())
                .content(objectMapper.writeValueAsString(productRequest));

        mvc.perform(request)
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(jsonPath("$.id").value(1L))
                .andExpect(jsonPath("$.name").value("Riz Basmati"))
                .andExpect(jsonPath("$.description").value("Provenance Camargue"))
                .andDo(MockMvcResultHandlers.print());
    }

    @Test
    @WithMockUser(username = "foo", roles = "market-customer")
    void createProduct_403() throws Exception {
        final CreateProductRequest productRequest = new CreateProductRequest();
        productRequest.setName("Riz Basmati");
        productRequest.setDescription("Provenance Camargue");

        final RequestBuilder request = MockMvcRequestBuilders
                .post("/api/products")
                .contentType(ContentType.APPLICATION_JSON.toString())
                .content(objectMapper.writeValueAsString(productRequest));

        mvc.perform(request)
                .andExpect(MockMvcResultMatchers.status().isForbidden())
                .andDo(MockMvcResultHandlers.print());
    }

    @Test
    @WithMockUser(username = "foo", roles = "market-admin")
    void createProduct_validation_name() throws Exception {
        final CreateProductRequest productRequest = new CreateProductRequest();
        productRequest.setName("");
        productRequest.setDescription("Provenance Camargue");

        final RequestBuilder request = MockMvcRequestBuilders
                .post("/api/products")
                .contentType(ContentType.APPLICATION_JSON.toString())
                .content(objectMapper.writeValueAsString(productRequest));

        mvc.perform(request)
                .andExpect(MockMvcResultMatchers.status().isBadRequest())
                .andDo(MockMvcResultHandlers.print());
    }

}
