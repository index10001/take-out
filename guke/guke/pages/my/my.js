"use strict";
const common_vendor = require("../../common/vendor.js");
const stores_account = require("../../stores/account.js");
const utils_request = require("../../utils/request.js");
const utils_img = require("../../utils/img.js");
const config = require("../../config.js");
const _sfc_main = {
  __name: "my",
  setup(__props) {
    const accountStore = stores_account.useAccountStore();
    const isQRCodeModalVisible = common_vendor.ref(false);
    const handlePhone = (phone) => {
      const prefix = phone.substring(0, 3);
      const suffix = phone.substring(phone.length - 4);
      const maskedPhone = prefix + "****" + suffix;
      return maskedPhone;
    };
    const uploadAvatarAndUpdateAccount = (tempFilePath) => {
      common_vendor.index.uploadFile({
        url: "http://localhost:8090/api/upload_img",
        filePath: tempFilePath,
        name: "file",
        formData: {
          // 这里可以添加其他请求参数
        },
        success: function(res) {
          const data = JSON.parse(res.data);
          if (data.code === 200) {
            const updateAccountAvatar = async (avatar) => {
              const response = await utils_request.request.post(
                "/update_account_avatar",
                {
                  id: accountStore.id,
                  avatar
                }
              );
              if (response.code === 200) {
                accountStore.avatar = avatar;
                common_vendor.index.showToast({
                  title: "上传成功",
                  icon: "success",
                  duration: 2e3
                });
              }
            };
            updateAccountAvatar(data.data);
          }
        },
        fail: function(err) {
          console.log(err);
        }
      });
    };
    const uploadAvatar = () => {
      common_vendor.index.chooseImage({
        count: 1,
        sizeType: ["original"],
        sourceType: ["album"],
        success: function(res) {
          const tempFilePath = res.tempFilePaths[0];
          uploadAvatarAndUpdateAccount(tempFilePath);
        }
      });
    };
    const logout = () => {
      common_vendor.index.showModal({
        content: "确定要退出登录吗？",
        success: function(res) {
          if (res.confirm) {
            const logoutApi = async () => {
              const response = await utils_request.request.get("/logout");
              if (response.code === 200) {
                accountStore.$reset;
                common_vendor.index.showToast({
                  title: "退出成功",
                  icon: "none",
                  duration: 1e3
                });
                setTimeout(() => {
                  common_vendor.index.redirectTo({
                    url: "/pages/login/login"
                  });
                }, 300);
              }
            };
            logoutApi();
          }
        }
      });
    };
    // 新的充值函数，显示二维码弹出层
const showQRCodeModal = () => {
  isQRCodeModalVisible.value = true;
};
// 取消支付，关闭弹出层
const cancelPayment = () => {
  isQRCodeModalVisible.value = false;
};
// 已经支付，执行充值操作
const confirmPayment = async () => {
  try {
    const response = await utils_request.request.post("/add_money", {
      id: accountStore.id,
      money: config.apiConfig.addMoney * 100 + accountStore.money
    });
    if (response.code === 200) {
      common_vendor.index.showToast({
        title: "充值成功",
        icon: "none",
        duration: 1e3
      });
      accountStore.money = config.apiConfig.addMoney * 100 + accountStore.money;
      isQRCodeModalVisible.value = false;
    }
  } catch (error) {
    common_vendor.index.showToast({
      title: "充值失败，请稍后重试",
      icon: "none",
      duration: 1e3
    });
    console.error("充值失败:", error);
  }
};
    const getMoney = () => {
      common_vendor.index.showToast({
        title: "可接入微信、支付宝等充值、提现接口",
        icon: "none",
        duration: 1e3
      });
    };
    // 添加页面显示时刷新余额的逻辑
common_vendor.onShow(() => {
  const refreshAccountMoney = async () => {
    try {
      const response = await utils_request.request.get(`/select_account_by_id/${accountStore.id}`);
      if (response.code === 200) {
        accountStore.money = response.data.money;
      }
    } catch (error) {
      console.error("刷新余额失败:", error);
    }
  };
  refreshAccountMoney();
});
    return (_ctx, _cache) => {
      return {
        a: common_vendor.unref(utils_img.imgUrl) + common_vendor.unref(accountStore).avatar,
        b: common_vendor.o(uploadAvatar),
        c: common_vendor.t(common_vendor.unref(accountStore).nickname),
        d: common_vendor.t(handlePhone(common_vendor.unref(accountStore).phone)),
        e: common_vendor.t(common_vendor.unref(accountStore).money / 100),
        f: common_vendor.o(showQRCodeModal),
        g: common_vendor.o(getMoney),
        h: common_vendor.o(logout),
        i: isQRCodeModalVisible.value ? 1 : "",
        j: common_vendor.o(cancelPayment),
        k: common_vendor.o(confirmPayment)
      };
    };
  }
};
const MiniProgramPage = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__scopeId", "data-v-2f1ef635"], ["__file", "E:/bishe/rtms-master/rtms-frontend/rtms-frontend-wx-account/pages/my/my.vue"]]);
wx.createPage(MiniProgramPage);
