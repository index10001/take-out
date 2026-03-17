"use strict";
const common_vendor = require("../../common/vendor.js");
const utils_request = require("../../utils/request.js");
const utils_img = require("../../utils/img.js");
const stores_account = require("../../stores/account.js");
require("../../config.js");
const _sfc_main = {
  __name: "order-detail",
  setup(__props) {
    const order = common_vendor.ref({});
    const store = common_vendor.ref({});
    const rider = common_vendor.ref({});
    const getOrder = async (option) => {
      const response = await utils_request.request.get("/select_order_by_id/" + option.orderId);
      if (response.code === 200) {
        order.value = response.data;
        const getStore = async () => {
          const response2 = await utils_request.request.get("/select_store_by_store_id/" + order.value.storeId);
          if (response2.code === 200) {
            store.value = response2.data;
          }
        };
        const getRider = async () => {
          const response2 = await utils_request.request.get("/select_rider_by_id/" + order.value.riderId);
          if (response2.code === 200) {
            rider.value = response2.data;
          }
        };
        getStore();
        getRider();
        getOrderProducts(option.orderId);
      }
    };
    const createTime = common_vendor.computed(() => {
      var date = new Date(order.value.createTime);
      var year = date.getFullYear();
      var month = ("0" + (date.getMonth() + 1)).slice(-2);
      var day = ("0" + date.getDate()).slice(-2);
      var hours = ("0" + date.getHours()).slice(-2);
      var minutes = ("0" + date.getMinutes()).slice(-2);
      var seconds = ("0" + date.getSeconds()).slice(-2);
      var formattedDate = year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;
      return formattedDate;
    });
    common_vendor.onLoad((option) => {
      getOrder(option);
    });
    const goStore = (storeId) => {
      common_vendor.index.navigateTo({
        url: "/pages/store/store?storeId=" + storeId
      });
    };
    const orderProducts = common_vendor.ref([]);
    const orderProductsImgs = common_vendor.ref([]);
    const getProduct = async (productId, productName, specification, number, totalPrice) => {
      const response = await utils_request.request.get("/select_product_by_id/" + productId);
      if (response.code === 200) {
        let product = {
          name: productName,
          specification,
          number,
          totalPrice,
          picture: response.data.picture
        };
        orderProductsImgs.value.push(product);
      }
    };
    const getOrderProducts = async (orderId) => {
      const response = await utils_request.request.get("/select_order_products_by_order_id/" + orderId);
      if (response.code === 200) {
        orderProducts.value = response.data;
        for (let i = 0; i < orderProducts.value.length; i++) {
          getProduct(
            orderProducts.value[i].productId,
            orderProducts.value[i].name,
            orderProducts.value[i].specification,
            orderProducts.value[i].number,
            orderProducts.value[i].totalPrice
          );
        }
      }
    };
    const accountStore = stores_account.useAccountStore();
    const payment = () => {
      console.log(accountStore.money);
      console.log(order.value.id);
      console.log(order.value.totalPrice);
      common_vendor.index.showModal({
        title: "支付订单",
        content: "确认要支付该订单吗？",
        success: function(res) {
          if (res.confirm) {
            if (accountStore.money < order.value.totalPrice) {
              common_vendor.index.showToast({
                title: "余额不足",
                icon: "error"
              });
            } else {
              const customerPayment = async (orderId) => {
                const response = await utils_request.request.post("/update_account_money", {
                  id: accountStore.id,
                  money: accountStore.money - order.value.totalPrice
                });
                if (response.code === 200) {
                  const response2 = await utils_request.request.post("/customer_payment_order_by_id/" + orderId);
                  if (response2.code === 200) {
                    accountStore.money -= order.value.totalPrice;
                    order.value.progress = "已支付";
                    common_vendor.index.showToast({
                      title: "支付成功",
                      icon: "success"
                    });
                  }
                }
              };
              customerPayment(order.value.id);
            }
          }
        }
      });
    };
    function add30Minutes(time) {
      const [hours, minutes] = time.split(":").map(Number);
      const totalMinutes = hours * 60 + minutes;
      const newTotalMinutes = totalMinutes + 30;
      const newHours = Math.floor(newTotalMinutes / 60);
      const newMinutes = newTotalMinutes % 60;
      const newTime = `${newHours.toString().padStart(2, "0")}:${newMinutes.toString().padStart(2, "0")}`;
      return newTime;
    }
    return (_ctx, _cache) => {
      return common_vendor.e({
        a: common_vendor.t(order.value.progress),
        b: order.value.progress === "待支付"
      }, order.value.progress === "待支付" ? {
        c: common_vendor.o(payment)
      } : {}, {
        d: order.value.progress === "配送中"
      }, order.value.progress === "配送中" ? {
        e: common_vendor.t(add30Minutes(order.value.expectedTime))
      } : {}, {
        f: common_vendor.t(common_vendor.unref(createTime)),
        g: common_vendor.t(store.value.phone),
        h: common_vendor.unref(utils_img.imgUrl) + store.value.logo,
        i: common_vendor.t(store.value.name),
        j: common_vendor.o(($event) => goStore(store.value.id)),
        k: common_vendor.f(orderProductsImgs.value, (orderProduct, index, i0) => {
          return {
            a: common_vendor.unref(utils_img.imgUrl) + orderProduct.picture,
            b: common_vendor.t(orderProduct.name),
            c: common_vendor.t(orderProduct.specification),
            d: common_vendor.t(orderProduct.number),
            e: common_vendor.t(orderProduct.totalPrice / 100),
            f: index
          };
        }),
        l: common_vendor.t(order.value.packagePrice / 100),
        m: common_vendor.t(order.value.deliveryPrice / 100),
        n: common_vendor.t(order.value.totalPrice / 100),
        o: order.value.riderId !== 0
      }, order.value.riderId !== 0 ? {
        p: common_vendor.t(rider.value.name),
        q: common_vendor.t(rider.value.gender),
        r: common_vendor.t(rider.value.phone)
      } : {}, {
        s: common_vendor.t(order.value.address),
        t: common_vendor.t(order.value.code),
        v: common_vendor.t(order.value.payment),
        w: order.value.progress === "待支付" || order.value.progress === "已取消"
      }, order.value.progress === "待支付" || order.value.progress === "已取消" ? {} : {}, {
        x: common_vendor.t(order.value.note)
      });
    };
  }
};
const MiniProgramPage = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__scopeId", "data-v-71729483"], ["__file", "E:/bishe/rtms-master/rtms-frontend/rtms-frontend-wx-account/pages/order-detail/order-detail.vue"]]);
wx.createPage(MiniProgramPage);
