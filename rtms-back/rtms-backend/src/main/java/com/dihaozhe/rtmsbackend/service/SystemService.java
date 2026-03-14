package com.dihaozhe.rtmsbackend.service;

import com.dihaozhe.response.CommonResponse;
import com.dihaozhe.rtmsbackend.pojo.vo.SystemVO;
import jakarta.servlet.http.HttpServletRequest;

public interface SystemService {

    /**
     * 查询系统信息
     */
    CommonResponse selectSystem(HttpServletRequest request);

    /**
     * 修改系统信息
     */
    CommonResponse updateSystem(SystemVO systemVO, HttpServletRequest request);
}
