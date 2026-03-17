"use strict";
const common_vendor = require("../../common/vendor.js");
const utils_request = require("../../utils/request.js");
const utils_img = require("../../utils/img.js");
require("../../config.js");
const _sfc_main = {
  __name: "order-detail",
  setup(__props) {
    const order = common_vendor.ref([]);
    const orderProducts = common_vendor.ref([]);
    const store = common_vendor.ref([]);
    const customer = common_vendor.ref([]);
    const getOrder = async (orderId) => {
      const response = await utils_request.request.get("/select_order_by_id/" + orderId);
      if (response.code === 200) {
        order.value = response.data;
        getStore(order.value.storeId);
        getCustomer(order.value.accountId);
      }
    };
    const getOrderProducts = async (orderId) => {
      const response = await utils_request.request.get(
        "/select_order_products_by_order_id/" + orderId
      );
      if (response.code === 200) {
        orderProducts.value = response.data;
      }
    };
    const getStore = async (storeId) => {
      const response = await utils_request.request.get("/select_store_by_store_id/" + storeId);
      if (response.code === 200) {
        store.value = response.data;
      }
    };
    const getCustomer = async (accountId) => {
      const response = await utils_request.request.get(
        "/select_account_by_account_id/" + accountId
      );
      if (response.code === 200) {
        customer.value = response.data;
      }
    };
    const riderDeliveredOrderByOrderId = async (orderId) => {
      const response = await utils_request.request.post(
        "/rider_delivered_order_by_id/" + orderId
      );
      if (response.code === 200) {
        getOrder(orderId);
        getOrderProducts(orderId);
        common_vendor.index.showToast({
          title: "送达成功",
          icon: "success",
          mask: true
        });
      }
    };
    const riderDeliveredOrder = (orderId) => {
      common_vendor.index.showModal({
        title: "确认送达",
        content: "确定外卖已送至【" + order.value.address + "】吗？",
        success: function(res) {
          if (res.confirm) {
            riderDeliveredOrderByOrderId(orderId);
          }
        }
      });
    };
    common_vendor.onLoad((option) => {
      getOrder(option.orderId);
      getOrderProducts(option.orderId);
    });
    return (_ctx, _cache) => {
      return common_vendor.e({
        a: order.value.progress === "配送中"
      }, order.value.progress === "配送中" ? {
        b: common_vendor.t(store.value.address),
        c: common_vendor.t(order.value.address)
      } : {}, {
        d: order.value.progress === "已送达"
      }, order.value.progress === "已送达" ? {
        e: common_vendor.t(order.value.address)
      } : {}, {
        f: order.value.progress === "已完成"
      }, order.value.progress === "已完成" ? {
        g: common_vendor.t(order.value.address)
      } : {}, {
        h: order.value.progress === "配送中"
      }, order.value.progress === "配送中" ? {} : {}, {
        i: order.value.progress === "已送达"
      }, order.value.progress === "已送达" ? {} : {}, {
        j: order.value.progress === "已完成"
      }, order.value.progress === "已完成" ? {} : {}, {
        k: common_vendor.unref(utils_img.imgUrl) + store.value.logo,
        l: common_vendor.t(store.value.name),
        m: common_vendor.t(store.value.phone),
        n: common_vendor.t(store.value.address),
        o: common_vendor.t(order.value.address),
        p: common_vendor.t(order.value.expectedTime),
        q: common_vendor.t(order.value.code),
        r: common_vendor.t(order.value.note),
        s: common_vendor.unref(utils_img.imgUrl) + customer.value.avatar,
        t: common_vendor.t(customer.value.nickname),
        v: common_vendor.t(customer.value.phone),
        w: order.value.progress === "配送中"
      }, order.value.progress === "配送中" ? {
        x: common_vendor.o(($event) => riderDeliveredOrder(order.value.id))
      } : {});
    };
  }
};
const MiniProgramPage = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__scopeId", "data-v-71729483"], ["__file", "E:/bishe/rtms-master/rtms-frontend/rtms-frontend-wx-rider/pages/order-detail/order-detail.vue"]]);
wx.createPage(MiniProgramPage);
