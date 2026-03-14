package com.dihaozhe.rtmsbackend.util;

import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpResponse;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import lombok.extern.slf4j.Slf4j;

import java.util.HashMap;
import java.util.Map;

/**
 * 百度地图API工具类
 */
@Slf4j
public class BaiduMapUtil {
    
    /**
     * 百度地图API Key
     */
    private static final String API_KEY = "lTcHO1Eu2GTygXb8drykAeHSh9QF1cUQ"; // 请替换为您自己的百度地图API密钥
    
    /**
     * 地理编码（地址转经纬度）API URL
     */
    private static final String GEOCODING_API_URL = "https://api.map.baidu.com/geocoding/v3";
    
    /**
     * 逆地理编码（经纬度转地址）API URL
     */
    private static final String REVERSE_GEOCODING_API_URL = "https://api.map.baidu.com/reverse_geocoding/v3";
    
    /**
     * 路线规划API URL
     */
    private static final String DIRECTION_API_URL = "https://api.map.baidu.com/directionlite/v1/driving";
    
    /**
     * 地址解析（地址转经纬度）
     * @param address 地址
     * @param city 城市
     * @return 经纬度信息
     */
    public static JSONObject geocoding(String address, String city) {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("address", address);
            params.put("city", city);
            params.put("output", "json");
            params.put("ak", API_KEY);
            
            HttpResponse response = HttpRequest.get(GEOCODING_API_URL)
                    .form(params)
                    .execute();
            
            String result = response.body();
            JSONObject json = JSONUtil.parseObj(result);
            
            // 添加详细日志
            log.info("地址解析请求：地址={}, 城市={}", address, city);
            log.info("地址解析API返回结果：{}", result);
            
            // 检查API调用是否成功
            if (json.getInt("status") == 0) {
                JSONObject resultObj = json.getJSONObject("result");
                JSONObject location = resultObj.getJSONObject("location");
                log.info("地址解析成功：地址={}, 纬度={}, 经度={}", address, location.getDouble("lat"), location.getDouble("lng"));
                return resultObj;
            } else {
                log.error("百度地图API调用失败：{}", json.getStr("message"));
                return null;
            }
        } catch (Exception e) {
            log.error("百度地图API调用异常：{}", e.getMessage(), e);
            return null;
        }
    }
    
    /**
     * 逆地理编码（经纬度转地址）
     * @param latitude 纬度
     * @param longitude 经度
     * @return 地址信息
     */
    public static JSONObject reverseGeocoding(double latitude, double longitude) {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("location", latitude + "," + longitude);
            params.put("output", "json");
            params.put("ak", API_KEY);
            
            HttpResponse response = HttpRequest.get(REVERSE_GEOCODING_API_URL)
                    .form(params)
                    .execute();
            
            String result = response.body();
            JSONObject json = JSONUtil.parseObj(result);
            
            // 检查API调用是否成功
            if (json.getInt("status") == 0) {
                return json.getJSONObject("result");
            } else {
                log.error("百度地图API调用失败：{}", json.getStr("message"));
                return null;
            }
        } catch (Exception e) {
            log.error("百度地图API调用异常：{}", e.getMessage(), e);
            return null;
        }
    }
    
    /**
     * 计算两个地址之间的距离（米）
     * @param originAddress 起点地址
     * @param destinationAddress 终点地址
     * @param city 城市
     * @return 距离（米），-1表示计算失败
     */
    public static long calculateDistance(String originAddress, String destinationAddress, String city) {
        try {
            log.info("开始计算距离：起点地址={}, 终点地址={}, 城市={}", originAddress, destinationAddress, city);
            
            // 1. 将起点地址转换为经纬度
            JSONObject originGeo = geocoding(originAddress, city);
            if (originGeo == null) {
                log.error("起点地址解析失败: {}", originAddress);
                return -1;
            }
            JSONObject originLocation = originGeo.getJSONObject("location");
            double originLat = originLocation.getDouble("lat");
            double originLng = originLocation.getDouble("lng");
            String origin = originLat + "," + originLng;
            
            // 2. 将终点地址转换为经纬度
            JSONObject destinationGeo = geocoding(destinationAddress, city);
            if (destinationGeo == null) {
                log.error("终点地址解析失败: {}", destinationAddress);
                return -1;
            }
            JSONObject destinationLocation = destinationGeo.getJSONObject("location");
            double destLat = destinationLocation.getDouble("lat");
            double destLng = destinationLocation.getDouble("lng");
            String destination = destLat + "," + destLng;
            
            // 添加坐标日志
            log.info("起点坐标：纬度={}, 经度={}, 坐标字符串={}", originLat, originLng, origin);
            log.info("终点坐标：纬度={}, 经度={}, 坐标字符串={}", destLat, destLng, destination);
            
            // 3. 调用路线规划API计算距离
            Map<String, Object> params = new HashMap<>();
            params.put("origin", origin);
            params.put("destination", destination);
            params.put("output", "json");
            params.put("ak", API_KEY);
            
            log.info("路线规划API请求参数：origin={}, destination={}", origin, destination);
            
            HttpResponse response = HttpRequest.get(DIRECTION_API_URL)
                    .form(params)
                    .execute();
            
            String result = response.body();
            JSONObject json = JSONUtil.parseObj(result);
            
            log.info("路线规划API返回结果：{}", result);
            
            // 检查API调用是否成功
            if (json.getInt("status") == 0) {
                JSONObject resultObj = json.getJSONObject("result");
                JSONObject routeObj = resultObj.getJSONArray("routes").getJSONObject(0);
                long distance = routeObj.getLong("distance");
                log.info("距离计算成功：{}", distance);
                return distance;
            } else {
                log.error("百度地图路线规划API调用失败：{}", json.getStr("message"));
                return -1;
            }
        } catch (Exception e) {
            log.error("距离计算异常：{}", e.getMessage(), e);
            return -1;
        }
    }
}
