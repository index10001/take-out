package com.dihaozhe.rtmsbackend.service;

import com.dihaozhe.response.CommonResponse;
import com.dihaozhe.rtmsbackend.pojo.entity.Category;
import jakarta.servlet.http.HttpServletRequest;
import java.util.List;

public interface CategoryService {
    /**
     * 新增分类
     */
    CommonResponse createCategory(Category category, HttpServletRequest request);

    /**
     * 查询分类列表
     */
    CommonResponse selectCategories(HttpServletRequest request);

    /**
     * 根据店铺id查询分类列表
     */
    CommonResponse selectCategoriesByStoreId(Long storeId, HttpServletRequest request);

    /**
     * 修改分类
     */
    CommonResponse updateCategory(Category category, HttpServletRequest request);

    /**
     * 批量添加分类
     */
    CommonResponse batchCreateCategories(List<String> categoryNames, Long storeId, HttpServletRequest request);
    
    /**
     * 删除分类
     */
    CommonResponse deleteCategory(Long id, HttpServletRequest request);
}
