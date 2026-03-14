package com.dihaozhe.rtmsbackend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.dihaozhe.enumeration.StateCode;
import com.dihaozhe.response.CommonResponse;
import com.dihaozhe.response.ResponseUtils;
import com.dihaozhe.rtmsbackend.mapper.CategoryMapper;
import com.dihaozhe.rtmsbackend.pojo.entity.Category;
import com.dihaozhe.rtmsbackend.service.CategoryService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

import static com.dihaozhe.constant.AccountConstant.*;
import static com.dihaozhe.constant.StatusConstant.DELETED;
import static com.dihaozhe.constant.StatusConstant.NORMAL;

@Slf4j
@Service
public class CategoryServiceImpl implements CategoryService {

    @Resource
    CategoryMapper categoryMapper;

    @Override
    public CommonResponse createCategory(Category category, HttpServletRequest request) {
        // 1. 校验数据是否合法
        String storeId = String.valueOf(category.getStoreId());
        String name = category.getName();
        // 店铺id为空
        if (storeId.isEmpty()) {
            return ResponseUtils.error(StateCode.STORE_ID_EMPTY);
        }
        // 分类名称为空
        if (name.isEmpty()) {
            return ResponseUtils.error(StateCode.CATEGORY_NAME_EMPTY);
        }
        //2. 如果id不为空查询分类名称是否存在
        if (category.getId() == null) {
            QueryWrapper<Category> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("store_id",storeId);
            queryWrapper.eq("name",name);
            // 分类已存在
            if (categoryMapper.selectOne(queryWrapper) != null){
                log.info("this category can not be existed");
                return ResponseUtils.error(StateCode.CATEGORY_NAME_EXIST);
            }
            log.info("this category can be created");
            // 将表单信息传入实体类
            category.setStatus(NORMAL);
            categoryMapper.insert(category);
        }
        return ResponseUtils.success();
    }

    @Override
    public CommonResponse selectCategories(HttpServletRequest request) {
        // 将数据库分类表内容取出
        QueryWrapper<Category> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("status",NORMAL);
        List<Category> categories = categoryMapper.selectList(queryWrapper);
        return ResponseUtils.success(categories);
    }

    @Override
    public CommonResponse selectCategoriesByStoreId(Long storeId, HttpServletRequest request) {
        // 将数据库分类表内容取出
        QueryWrapper<Category> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("store_id",storeId);
        queryWrapper.eq("status",NORMAL);
        List<Category> categories = categoryMapper.selectList(queryWrapper);
        return ResponseUtils.success(categories);
    }

    @Override
    public CommonResponse updateCategory(Category category, HttpServletRequest request) {
        UpdateWrapper<Category> updateWrapper = new UpdateWrapper<>();
        updateWrapper.set("name", category.getName());  // 设置要更新的字段及值
        updateWrapper.eq("id", category.getId());  // 设置更新条件，这里假设使用 ID 作为更新条件
        categoryMapper.update(null, updateWrapper);
        return ResponseUtils.success();
    }

    @Override
    public CommonResponse deleteCategory(Long id, HttpServletRequest request) {
        // 先获取分类信息，以便删除相关缓存
        Category category = categoryMapper.selectById(id);
        
        UpdateWrapper<Category> updateWrapper = new UpdateWrapper<>();
        updateWrapper.set("status", DELETED);  // 设置要更新的字段及值
        updateWrapper.eq("id", id);  // 设置更新条件，这里假设使用 ID 作为更新条件
        categoryMapper.update(null, updateWrapper);
        
        // 删除相关列表缓存
        if (category != null) {
            // 可以在这里添加缓存删除逻辑
        }
        
        return ResponseUtils.success();
    }
    
    @Override
    public CommonResponse batchCreateCategories(List<String> categoryNames, Long storeId, HttpServletRequest request) {
        try {
            for (String categoryName : categoryNames) {
                // 创建分类对象
                Category category = new Category();
                category.setStoreId(storeId);
                category.setName(categoryName);
                category.setStatus(NORMAL);
                
                // 检查分类是否已存在
                QueryWrapper<Category> queryWrapper = new QueryWrapper<>();
                queryWrapper.eq("store_id", storeId);
                queryWrapper.eq("name", categoryName);
                queryWrapper.eq("status", NORMAL);
                
                if (categoryMapper.selectOne(queryWrapper) == null) {
                    // 分类不存在，创建新分类
                    categoryMapper.insert(category);
                    log.info("批量创建分类: {}", categoryName);
                } else {
                    log.info("分类已存在，跳过: {}", categoryName);
                }
            }
            return ResponseUtils.success();
        } catch (Exception e) {
            log.error("批量创建分类失败: {}", e.getMessage(), e);
            return ResponseUtils.error(500, "批量创建分类失败");
        }
    }
}
