package com.dihaozhe.rtmsbackend.pojo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;


@TableName("tb_store")
public class Store implements Serializable {
    private static final long serialVersionUID = 3257034215554567632L;
    /**
     * 店铺id
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 账号id
     */
    private Long accountId;

    /**
     * 店铺名称
     */
    private String name;

    /**
     * 店铺logo
     */
    private String logo;

    /**
     * 店铺简介
     */
    private String description;

    /**
     * 电话号码
     */
    private String phone;

    /**
     * 店铺地址
     */
    private String address;

    /**
     * 营业时段
     */
    private String businessHour;

    /**
     * 营业执照
     */
    private String businessLicense;

    /**
     * 打包费用
     */
    private Long packagePrice;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新时间
     */
    private Date updateTime;

    /**
     * 状态
     */
    private String status;

    /**
     * 店铺类型
     */
    private String type;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getAccountId() {
        return accountId;
    }

    public void setAccountId(Long accountId) {
        this.accountId = accountId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getBusinessHour() {
        return businessHour;
    }

    public void setBusinessHour(String businessHour) {
        this.businessHour = businessHour;
    }

    public String getBusinessLicense() {
        return businessLicense;
    }

    public void setBusinessLicense(String businessLicense) {
        this.businessLicense = businessLicense;
    }

    public Long getPackagePrice() {
        return packagePrice;
    }

    public void setPackagePrice(Long packagePrice) {
        this.packagePrice = packagePrice;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}