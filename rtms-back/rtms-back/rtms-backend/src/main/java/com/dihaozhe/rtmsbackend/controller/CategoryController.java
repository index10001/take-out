package com.dihaozhe.rtmsbackend.controller;

import com.github.xiaoymin.knife4j.annotations.ApiOperationSupport;
import com.dihaozhe.response.CommonResponse;
import com.dihaozhe.response.ResponseUtils;
import com.dihaozhe.rtmsbackend.pojo.entity.Category;
import com.dihaozhe.rtmsbackend.service.CategoryService;
import com.dihaozhe.rtmsbackend.service.impl.QianfanServiceImpl;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@Tag(name = "Category", description = "Category相关接口")
public class CategoryController {

    @Resource
    CategoryService categoryService;
    
    @Resource
    QianfanServiceImpl qianfanService;

    @PostMapping("/api/create_category")
    @Operation(summary = "新增分类接口")
    public CommonResponse createCategory(@RequestBody Category category, HttpServletRequest request) {
        log.info("CreateCategory API is requested");
        return categoryService.createCategory(category, request);
    }

    @GetMapping("/api/select_categories_by_store_id/{storeId}")
    @Operation(summary = "根据店铺id查询分类接口")
    public CommonResponse selectCategoriesByStoreId(@PathVariable Long storeId, HttpServletRequest request) {
        log.info("SelectCategoriesByStoreId API is requested");
        return categoryService.selectCategoriesByStoreId(storeId, request);
    }

    @PostMapping("/api/update_category")
    @Operation(summary = "更新分类接口")
    public CommonResponse updateCategory(@RequestBody Category category, HttpServletRequest request) {
        log.info("UpdateCategory API is requested");
        return categoryService.updateCategory(category, request);
    }

    @DeleteMapping("/api/delete_category/{id}")
    @Operation(summary = "删除分类接口")
    public CommonResponse deleteCategory(@PathVariable Long id, HttpServletRequest request) {
        log.info("DeleteCategory API is requested");
        return categoryService.deleteCategory(id, request);
    }
    
    @PostMapping("/api/ai/generate_categories")
    @Operation(summary = "AI智能生成分类接口")
    public CommonResponse generateCategories(@RequestParam String storeName, @RequestParam Long storeId) {
        log.info("GenerateCategories API is requested, storeName: {}, storeId: {}", storeName, storeId);
        try {
            // 调用AI服务生成分类
            List<String> categories = qianfanService.generateCategories(storeName);
            log.info("AI生成分类结果: {}", categories);
            return ResponseUtils.success(categories);
        } catch (Exception e) {
            log.error("生成分类失败: {}", e.getMessage(), e);
            return ResponseUtils.error(500, "生成分类失败，请重试");
        }
    }
    
    @PostMapping("/api/ai/batch_create_categories")
    @Operation(summary = "批量创建AI生成的分类")
    public CommonResponse batchCreateCategories(@RequestBody Map<String, Object> requestBody, HttpServletRequest request) {
        // 从请求体中获取参数
        List<String> categoryNames = (List<String>) requestBody.get("categoryNames");
        Object storeIdObj = requestBody.get("storeId");
        Long storeId = null;
        
        // 验证并转换storeId
        if (storeIdObj != null) {
            if (storeIdObj instanceof Long) {
                storeId = (Long) storeIdObj;
            } else if (storeIdObj instanceof String) {
                storeId = Long.valueOf((String) storeIdObj);
            } else if (storeIdObj instanceof Integer) {
                storeId = Long.valueOf((Integer) storeIdObj);
            }
        }
        
        // 验证参数
        if (categoryNames == null || categoryNames.isEmpty()) {
            log.error("BatchCreateCategories API 未收到有效分类名称");
            return ResponseUtils.error(400, "未收到有效分类名称");
        }
        
        if (storeId == null) {
            log.error("BatchCreateCategories API 未收到有效店铺ID");
            return ResponseUtils.error(400, "未收到有效店铺ID");
        }
        
        log.info("BatchCreateCategories API is requested, categoryCount: {}, storeId: {}", categoryNames.size(), storeId);
        return categoryService.batchCreateCategories(categoryNames, storeId, request);
    }
}
