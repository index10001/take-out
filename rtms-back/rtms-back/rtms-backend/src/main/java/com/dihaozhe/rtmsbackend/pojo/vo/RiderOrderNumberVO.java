package com.dihaozhe.rtmsbackend.pojo.vo;

import lombok.Data;

@Data
public class RiderOrderNumberVO {
    private static final long serialVersionUID = 8541179553605848537L;
    int dayNumber;
    int monthNumber;

    public RiderOrderNumberVO(int dayNumber, int monthNumber) {
        this.dayNumber = dayNumber;
        this.monthNumber = monthNumber;
    }
}
