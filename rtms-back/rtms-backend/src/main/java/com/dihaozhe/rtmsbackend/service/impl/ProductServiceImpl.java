package com.dihaozhe.rtmsbackend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.dihaozhe.enumeration.StateCode;
import com.dihaozhe.response.CommonResponse;
import com.dihaozhe.response.ResponseUtils;
import com.dihaozhe.rtmsbackend.mapper.ProductMapper;
import com.dihaozhe.rtmsbackend.mapper.ProductVOMapper;
import com.dihaozhe.rtmsbackend.pojo.entity.Product;
import com.dihaozhe.rtmsbackend.pojo.vo.ProductVO;
import com.dihaozhe.rtmsbackend.service.ProductService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import java.util.concurrent.TimeUnit;
import java.util.LinkedHashMap;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.List;

import static com.dihaozhe.constant.StatusConstant.DELETED;
import static com.dihaozhe.constant.StatusConstant.NORMAL;

@Slf4j
@Service
public class ProductServiceImpl implements ProductService {

    @Resource
    ProductMapper productMapper;

    @Resource
    ProductVOMapper productVOMapper;
    
    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    @Override
    public CommonResponse createProduct(Product product, HttpServletRequest request) {
        // 1. 校验数据是否合法
        String storeId = String.valueOf(product.getStoreId());
        String categoryId = String.valueOf(product.getCategoryId());
        // 店铺id为空
        if (storeId.isEmpty()) {
            return ResponseUtils.error(StateCode.STORE_ID_EMPTY);
        }
        // 分类id为空
        if (categoryId.isEmpty()) {
            return ResponseUtils.error(StateCode.CATEGORY_ID_EMPTY);
        }
        
        // 产品名称不能为空
        String productName = product.getName();
        if (productName == null || productName.isEmpty()) {
            return ResponseUtils.error(StateCode.PRODUCT_NAME_EMPTY);
        }
        
        // 产品单位不能为空
        String productUnit = product.getUnit();
        if (productUnit == null || productUnit.isEmpty()) {
            return ResponseUtils.error(StateCode.PRODUCT_UNIT_EMPTY);
        }
        
        // 产品价格不能为0.00
        Long productPrice = product.getPrice();
        if (productPrice == null || productPrice <= 0) {
            return ResponseUtils.error(StateCode.PRODUCT_PRICE_INVALID);
        }

        // 2. 如果分类存在则查询产品名是否存在
        if (product.getId() == null) {
            QueryWrapper<Product> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("store_id",storeId);
            queryWrapper.eq("name",product.getName());
            queryWrapper.eq("price",product.getPrice());
            queryWrapper.eq("unit",product.getUnit());
            queryWrapper.eq("description",product.getDescription());
            queryWrapper.eq("picture",product.getPicture());
            // 产品已存在
            if (productMapper.selectOne(queryWrapper) != null){
                log.info("this product can not be existed");
                return ResponseUtils.error(StateCode.PRODUCT_EXIST);
            }
            log.info("this product can be created");
            // 将表单信息传入实体类
        product.setStatus(NORMAL);
        productMapper.insert(product);
        
        // 删除相关列表缓存，确保新增产品能立即显示
        redisTemplate.delete("products:store:" + storeId);
        }
        return ResponseUtils.success();
    }

    @Override
    public CommonResponse selectProductById(Long id, HttpServletRequest request) {
        // 尝试从Redis获取
        String key = "product:" + id;
        Object redisObject = redisTemplate.opsForValue().get(key);
        if (redisObject != null) {
            Product product;
            if (redisObject instanceof LinkedHashMap) {
                // 将LinkedHashMap转换为Product对象
                ObjectMapper mapper = new ObjectMapper();
                product = mapper.convertValue(redisObject, Product.class);
            } else {
                product = (Product) redisObject;
            }
            return ResponseUtils.success(product);
        }
        
        // Redis中没有，从数据库获取
        QueryWrapper<Product> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("id", id);
        Product product = productMapper.selectOne(queryWrapper);
        
        if (product != null) {
            // 存入Redis，设置过期时间30分钟
            redisTemplate.opsForValue().set(key, product, 30, TimeUnit.MINUTES);
        }
        return ResponseUtils.success(product);
    }

    @Override
    public CommonResponse selectProducts(HttpServletRequest request) {
        return null;
    }

    @Override
    public CommonResponse selectProductsByStoreId(Long storeId, HttpServletRequest request) {
        // 尝试从Redis获取
        String key = "products:store:" + storeId;
        List<ProductVO> products = (List<ProductVO>) redisTemplate.opsForValue().get(key);
        if (products != null) {
            return ResponseUtils.success(products);
        }
        
        // Redis中没有，从数据库获取
        QueryWrapper<ProductVO> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("store_id", storeId);
        queryWrapper.eq("status", NORMAL);
        products = productVOMapper.selectList(queryWrapper);
        
        if (products != null && !products.isEmpty()) {
            // 存入Redis，设置过期时间15分钟
            redisTemplate.opsForValue().set(key, products, 15, TimeUnit.MINUTES);
        }
        return ResponseUtils.success(products);
    }

    @Override
    public CommonResponse selectProductsByCategoryId(Long categoryId, HttpServletRequest request) {
        // 尝试从Redis获取
        String key = "products:category:" + categoryId;
        List<Product> products = (List<Product>) redisTemplate.opsForValue().get(key);
        if (products != null) {
            return ResponseUtils.success(products);
        }
        
        // Redis中没有，从数据库获取
        QueryWrapper<Product> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("category_id", categoryId);
        queryWrapper.eq("status", NORMAL);
        products = productMapper.selectList(queryWrapper);
        
        if (products != null && !products.isEmpty()) {
            // 存入Redis，设置过期时间15分钟
            redisTemplate.opsForValue().set(key, products, 15, TimeUnit.MINUTES);
        }
        return ResponseUtils.success(products);
    }

    @Override
    public CommonResponse updateProduct(Product product, HttpServletRequest request) {
        UpdateWrapper<Product> updateWrapper = new UpdateWrapper<>();
        updateWrapper.set("category_id", product.getCategoryId());  // 设置要更新的字段及值
        updateWrapper.set("name", product.getName());
        updateWrapper.set("price", product.getPrice());
        updateWrapper.set("unit", product.getUnit());
        updateWrapper.set("description", product.getDescription());
        updateWrapper.set("picture", product.getPicture());
        updateWrapper.eq("id", product.getId());  // 设置更新条件，这里假设使用 ID 作为更新条件
        productMapper.update(null, updateWrapper);
        
        // 更新Redis缓存
        String key = "product:" + product.getId();
        redisTemplate.opsForValue().set(key, product, 30, TimeUnit.MINUTES);
        
        // 删除相关列表缓存
        redisTemplate.delete("products:store:" + product.getStoreId());
        redisTemplate.delete("products:category:" + product.getCategoryId());
        
        return ResponseUtils.success();
    }

    @Override
    public CommonResponse deleteProduct(Long id, HttpServletRequest request) {
        // 先获取产品信息，以便删除相关缓存
        Product product = productMapper.selectById(id);
        
        UpdateWrapper<Product> updateWrapper = new UpdateWrapper<>();
        updateWrapper.set("status", DELETED);  // 设置要更新的字段及值
        updateWrapper.eq("id", id);  // 设置更新条件，这里假设使用 ID 作为更新条件
        productMapper.update(null, updateWrapper);
        
        // 删除Redis缓存
        String key = "product:" + id;
        redisTemplate.delete(key);
        
        // 删除相关列表缓存
        if (product != null) {
            redisTemplate.delete("products:store:" + product.getStoreId());
            redisTemplate.delete("products:category:" + product.getCategoryId());
        }
        
        return ResponseUtils.success();
    }
}
