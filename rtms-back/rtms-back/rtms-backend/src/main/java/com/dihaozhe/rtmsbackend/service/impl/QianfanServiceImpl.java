package com.dihaozhe.rtmsbackend.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import lombok.extern.slf4j.Slf4j;

import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.entity.ContentType;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.apache.http.entity.StringEntity;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.SignatureException;
import java.util.*;

@Slf4j
@Service
public class QianfanServiceImpl {

    // 百度千帆API配置
    private static final String API_KEY = "66666666666666666666666666666666"; // 请替换为您自己的百度AI API密钥
    private static final String API_URL = "https://aip.baidubce.com/rpc/2.0/ai_custom/v1/wenxinworkshop/chat/eb-instant";
    
    public List<String> generateCategories(String storeName) {
        try {
            // 构建请求参数
            Map<String, Object> params = new HashMap<>();
            params.put("messages", buildMessages(storeName));
            params.put("temperature", 0.7);
            params.put("top_p", 0.9);
            
            // 调用百度千帆API
            String response = callQianfanAPI(params);
            log.info("百度千帆API响应: {}", response);
            
            // 检查是否达到每日请求限制
            if (response.contains("Open api daily request limit reached")) {
                log.warn("百度千帆API每日请求次数已达上限，使用默认分类");
                return getDefaultCategories();
            }
            
            // 解析响应
            List<String> categories = parseCategoriesFromResponse(response);
            if (categories.isEmpty() || (categories.size() == 1 && "套餐".equals(categories.get(0)))) {
                return getDefaultCategories();
            }
            return categories;
        } catch (Exception e) {
            log.error("生成分类失败: {}", e.getMessage(), e);
            return getDefaultCategories(); // 返回默认分类
        }
    }
    
    private List<String> getDefaultCategories() {
        return Arrays.asList("套餐", "主食", "小吃", "饮品", "甜品", "小菜", "汤品", "早餐");
    }
    
    private List<Map<String, String>> buildMessages(String storeName) {
        List<Map<String, String>> messages = new ArrayList<>();
        
        // 系统提示
        Map<String, String> systemMsg = new HashMap<>();
        systemMsg.put("role", "system");
        systemMsg.put("content", "你是一个专业的餐饮店铺分类助手，根据店铺名称生成合适的产品分类。");
        messages.add(systemMsg);
        
        // 用户请求
        Map<String, String> userMsg = new HashMap<>();
        userMsg.put("role", "user");
        userMsg.put("content", String.format(
            "请为名为\"%s\"的店铺生成6-8个合适的产品分类，要求：\n" +
            "1. 分类名称简洁明确（2-4字最佳）\n" +
            "2. 符合餐饮行业习惯\n" +
            "3. 覆盖店铺主要产品类型\n" +
            "4. 只返回分类名称列表，格式为逗号分隔，不要包含其他内容。",
            storeName
        ));
        messages.add(userMsg);
        
        return messages;
    }
    
    private String callQianfanAPI(Map<String, Object> params) throws IOException {
        HttpClient httpClient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(API_URL);
        
        // 添加公共请求头
        httpPost.addHeader("Content-Type", "application/json");
        httpPost.addHeader("Authorization", getAuthHeader());
        // 添加appid参数（如果需要）
        // httpPost.addHeader("appid", "your_app_id");
        
        // 构建请求体
        String requestBody = JSON.toJSONString(params);
        StringEntity entity = new StringEntity(requestBody, "UTF-8");
        entity.setContentType(ContentType.APPLICATION_JSON.toString());
        httpPost.setEntity(entity);
        
        // 执行请求并获取响应
        HttpResponse response = httpClient.execute(httpPost);
        int statusCode = response.getStatusLine().getStatusCode();
        
        // 检查HTTP状态码
        if (statusCode != 200) {
            String errorMsg = String.format("API请求失败，状态码: %d", statusCode);
            log.error(errorMsg);
            throw new IOException(errorMsg);
        }
        
        HttpEntity responseEntity = response.getEntity();
        if (responseEntity != null) {
            return EntityUtils.toString(responseEntity, "UTF-8");
        }
        
        return "";
    }
    
    private String getAuthHeader() {
        // 百度千帆API使用Bearer认证格式
        return "Bearer " + API_KEY;
    }
    
    private List<String> parseCategoriesFromResponse(String response) {
        try {
            JSONObject jsonResponse = JSON.parseObject(response);
            String content = jsonResponse.getString("result");
            
            if (content != null && !content.isEmpty()) {
                // 解析逗号分隔的分类列表
                return Arrays.stream(content.split(","))
                           .map(String::trim)
                           .filter(s -> !s.isEmpty())
                           .collect(java.util.stream.Collectors.toList());
            }
        } catch (Exception e) {
            log.error("解析分类失败: {}", e.getMessage(), e);
        }
        
        // 解析失败时返回默认分类
        return Arrays.asList("套餐");
    }
}