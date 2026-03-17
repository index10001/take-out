package com.dihaozhe.rtmsbackend.service;

import com.dihaozhe.response.CommonResponse;
import com.dihaozhe.rtmsbackend.pojo.entity.OrderProduct;
import jakarta.servlet.http.HttpServletRequest;

public interface OrderProductService {

    /**
     * 新增订单产品
     */
    CommonResponse createOrderProduct(OrderProduct orderProduct, HttpServletRequest request);

    /**
     * 根据订单id查询订单产品
     */
    CommonResponse selectOrderProductsByOrderId(Long orderId, HttpServletRequest request);
}
