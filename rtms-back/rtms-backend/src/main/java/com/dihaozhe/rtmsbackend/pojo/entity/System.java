package com.dihaozhe.rtmsbackend.pojo.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;


@Data
@TableName("tb_system")
public class System implements Serializable {
    private static final long serialVersionUID = 3561876985601843537L;
    /**
     * 键
     */
    private String tableKey;

    /**
     * 值
     */
    private String tableValue;

    /**
     * 备注
     */
    private String note;
}
