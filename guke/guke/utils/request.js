"use strict";
const common_vendor = require("../common/vendor.js");
const config = require("../config.js");
const baseUrl = config.apiConfig.dev.baseUrl;
const request = (options = {}) => {
  return new Promise((resolve, reject) => {
    common_vendor.index.request({
      url: baseUrl + (options.url || ""),
      method: options.method || "GET",
      data: options.data || {},
      header: options.header || { "Content-Type": "application/json" }
    }).then((res) => {
  let { data } = res;
  // 不管code是什么，都直接返回数据给调用方处理
  resolve(data);
}).catch((error) => {
  // 只有网络错误才进入这里
  common_vendor.index.showToast({
    title: "网络请求失败，请稍后重试",
    icon: "none",
    duration: 2e3
  });
  reject(error);
});
  });
};
const get = (url, data, options = {}) => {
  options.method = "GET";
  options.data = data;
  options.url = url;
  return request(options);
};
const post = (url, data, options = {}) => {
  options.method = "POST";
  options.data = data;
  options.url = url;
  return request(options);
};
const put = (url, data, options = {}) => {
  options.method = "PUT";
  options.data = data;
  options.url = url;
  return request(options);
};
const del = (url, data, options = {}) => {
  options.method = "DELETE";
  options.data = data;
  options.url = url;
  return request(options);
};
const request$1 = { request, get, post, put, del };
exports.request = request$1;
