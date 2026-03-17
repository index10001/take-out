package com.dihaozhe.rtmsbackend.pojo.dto;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;


@Data
public class AccountHandledDTO implements Serializable {
    private static final long serialVersionUID = -1745861753744476202L;
    /**
     * 账号id
     */
    private Long id;
    /**
     * 账号
     */
    private String username;
    /**
     * 角色
     */
    private String role;
    /**
     * 电话号码
     */
    private String phone;
    /**
     * 昵称
     */
    private String nickname;
    /**
     * 头像
     */
    private String avatar;
    /**
     * 账号余额
     */
    private Long money;
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
}
