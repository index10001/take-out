package com.dihaozhe.rtmsbackend.controller;

import com.dihaozhe.response.CommonResponse;
import com.dihaozhe.response.ResponseUtils;
import com.dihaozhe.rtmsbackend.util.BaiduMapUtil;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * 百度地图API控制器
 */
@Slf4j
@RestController
@Tag(name = "BaiduMap", description = "百度地图API相关接口")
@RequestMapping("/api/baidu")
public class BaiduMapController {

    /**
     * 地址解析（地址转经纬度）
     * @param address 地址
     * @param city 城市
     * @param request HTTP请求
     * @return 经纬度信息
     */
    @GetMapping("/geocoding")
    @Operation(summary = "地址转经纬度接口")
    public CommonResponse geocoding(@RequestParam String address, @RequestParam String city, HttpServletRequest request) {
        log.info("Geocoding API is requested, address: {}, city: {}", address, city);
        
        // 调用百度地图API工具类
        var result = BaiduMapUtil.geocoding(address, city);
        
        if (result != null) {
            return ResponseUtils.success(result);
        } else {
            return ResponseUtils.error(400, "地址解析失败");
        }
    }
    
    /**
     * 逆地理编码（经纬度转地址）
     * @param latitude 纬度
     * @param longitude 经度
     * @param request HTTP请求
     * @return 地址信息
     */
    @GetMapping("/reverse_geocoding")
    @Operation(summary = "经纬度转地址接口")
    public CommonResponse reverseGeocoding(@RequestParam double latitude, @RequestParam double longitude, HttpServletRequest request) {
        log.info("ReverseGeocoding API is requested, latitude: {}, longitude: {}", latitude, longitude);
        
        // 调用百度地图API工具类
        var result = BaiduMapUtil.reverseGeocoding(latitude, longitude);
        
        if (result != null) {
            return ResponseUtils.success(result);
        } else {
            return ResponseUtils.error(400, "逆地理编码失败");
        }
    }
}
