"use strict";
const common_vendor = require("../../common/vendor.js");
const utils_request = require("../../utils/request.js");
const utils_img = require("../../utils/img.js");
const stores_account = require("../../stores/account.js");
const stores_order = require("../../stores/order.js");
require("../../config.js");
if (!Math) {
  product();
}
const product = () => "../../components/store/product.js";
const _sfc_main = {
  __name: "store",
  setup(__props) {
    const logoUrl = common_vendor.ref("");
    const businessLicenseUrl = common_vendor.ref("");
    const isBusinessLicenseShow = common_vendor.ref(false);
    const store = common_vendor.ref([]);
    const categories = common_vendor.ref([]);
    const accountStore = stores_account.useAccountStore();
    const orderStore = stores_order.useOrderStore();
    common_vendor.ref([]);
    common_vendor.onLoad((option) => {
      const getStore = async () => {
        const response = await utils_request.request.get("/select_store_by_store_id/" + option.storeId);
        if (response.code === 200) {
          store.value = response.data;
          orderStore.$reset();
          orderStore.accountId = accountStore.id;
          orderStore.phone = accountStore.phone;
          orderStore.storeId = store.value.id;
          orderStore.packagePrice = store.value.packagePrice;
          common_vendor.index.setNavigationBarTitle({
            title: store.value.name
          });
          logoUrl.value = utils_img.imgUrl + store.value.logo;
          businessLicenseUrl.value = utils_img.imgUrl + store.value.businessLicense;
        }
      };
      getStore();
    });
    function getBusinessLicense() {
      isBusinessLicenseShow.value = !isBusinessLicenseShow.value;
    }
    return (_ctx, _cache) => {
      return {
        a: logoUrl.value,
        b: common_vendor.t(store.value.name),
        c: common_vendor.t(store.value.businessHour),
        d: common_vendor.t(store.value.phone),
        e: common_vendor.t(store.value.address),
        f: common_vendor.o(getBusinessLicense),
        g: common_vendor.p({
          categories: categories.value
        }),
        h: isBusinessLicenseShow.value,
        i: common_vendor.o(getBusinessLicense),
        j: businessLicenseUrl.value
      };
    };
  }
};
const MiniProgramPage = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__scopeId", "data-v-c1a2745a"], ["__file", "E:/bishe/rtms-master/rtms-frontend/rtms-frontend-wx-account/pages/store/store.vue"]]);
wx.createPage(MiniProgramPage);
