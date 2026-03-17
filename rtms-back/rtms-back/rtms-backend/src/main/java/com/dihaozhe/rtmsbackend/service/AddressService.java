package com.dihaozhe.rtmsbackend.service;

import com.dihaozhe.response.CommonResponse;
import com.dihaozhe.rtmsbackend.pojo.entity.Address;
import jakarta.servlet.http.HttpServletRequest;

public interface AddressService {
    /**
     * 新增地址
     */
    CommonResponse createAddress(Address address, HttpServletRequest request);

    /**
     * 查询地址列表
     */
    CommonResponse selectAddresses(HttpServletRequest request);

    /**
     * 修改地址
     */
    CommonResponse updateAddress(Address address, HttpServletRequest request);

    /**
     * 删除地址
     */
    CommonResponse deleteAddress(Long id, HttpServletRequest request);
}
