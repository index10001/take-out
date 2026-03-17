package com.dihaozhe.response;

import com.dihaozhe.enumeration.StateCode;

/**
 * 返回工具类
 */
public class ResponseUtils {

    /**
     * 成功
     *
     * @param data
     * @return <T>
     */
    public static <T> CommonResponse<T> success(T data) {
        return new CommonResponse<>(200, "ok", data);
    }

    /**
     * 成功
     *
     * @param <T>
     * @return
     */
    public static <T> CommonResponse<T> success() {
        return new CommonResponse<>(200, "ok");
    }

    /**
     * 失败
     *
     * @param code
     * @param message
     * @return
     */
    public static <T> CommonResponse<T> error(int code, String message) {
        return new CommonResponse<>(code, message, null);
    }

    /**
     * 失败
     *
     * @param stateCode
     */
    public static <T> CommonResponse<T> error(StateCode stateCode) {
        return new CommonResponse<>(stateCode);
    }

    /**
     * 失败
     *
     * @param stateCode
     * @param message
     */
    public static <T> CommonResponse<T> error(StateCode stateCode, String message) {
        return new CommonResponse<>(stateCode.getCode(), message, null);
    }
}
