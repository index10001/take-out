<script setup>
import UpdateProduct from "@/components/store/UpdateProduct.vue";
import CreateProduct from "@/components/store/CreateProduct.vue"; // 添加组件导入
import {useStoreStore} from "@/stores/store.js";
import {ref, onMounted} from "vue";
import axios from "axios";
import getProductsByStoreId from "@/api/getProductsByStoreId.js";
import toMoney from "@/utils/money.js";
import imgUrl from "@/config/img.js";
import UpdateSpecification from "@/components/store/UpdateSpecification.vue";

const storeStore = useStoreStore()
console.log('Product.vue - storeStore.id:', storeStore.id) // 添加调试信息

// 确保products是响应式的
const products = ref([])

// 改进的数据加载函数
const loadProducts = async () => {
  try {
    console.log('开始加载产品...')
    if (!storeStore.id) {
      console.error('storeStore.id为空，无法获取产品')
      return
    }
    
    const { data } = await axios.get(`/api/select_products_by_store_id/${storeStore.id}`)
    console.log('API响应:', data)
    
    if (data && data.code === 200 && data.data) {
      products.value = data.data
      console.log('产品加载成功:', products.value.length)
    } else {
      console.error('API返回错误:', data.message || '未知错误')
    }
  } catch (error) {
    console.error('加载产品失败:', error)
  }
}

// 组件挂载时加载数据
onMounted(() => {
  loadProducts()
})

const open = ref(false);
let selectProductId = ref("")

const deleteProduct = (productId) => {
  open.value = true;
  selectProductId = productId
};

const handleOk = e => {
  axios.delete(`/api/delete_product/${selectProductId}`)
    .then(() => {
      open.value = false;
      setTimeout(() => {
        loadProducts() // 重新加载产品
      }, 200)
    })
    .catch(error => {
      console.error('删除产品失败:', error)
    })
};
</script>

<template>
  <div id="product">
    <div id="create-product">
      <CreateProduct @reload="loadProducts"/>
    </div>
    
    <div v-if="products.length === 0">
      <p style="text-align: center; padding: 20px;">暂无产品数据</p>
    </div>
    
    <table v-else>
      <thead>
      <tr>
        <th>序号</th>
        <th>图片</th>
        <th>名称</th>
        <th>分类</th>
        <th>单价</th>
        <th>单位</th>
        <th>简介</th>
        <th>状态</th>
        <th>操作</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="(product, index) in products" :key="product.id">
        <td>{{ index + 1 }}</td>
        <td>
          <a-image
              :width="100"
              :src="imgUrl + product.picture"
          />
        </td>
        <td>{{ product.name }}</td>
        <td>{{ product.categoryName }}</td>
        <td>￥{{ toMoney(product.price) }}</td>
        <td>{{ product.unit }}</td>
        <td>{{ product.description }}</td>
        <td>{{ product.status }}</td>
        <td width="100px">
          <UpdateProduct @reload="loadProducts" :product="product"/>
          <UpdateSpecification @reload="loadProducts" :product="product"/>
          <a-button type="primary" size="small" danger @click="deleteProduct(product.id)">删除</a-button>
        </td>
      </tr>
      </tbody>
    </table>
  </div>
  
  <div>
    <a-modal v-model:open="open" title="删除" @ok="handleOk">
      <p>确定要删除这个产品吗？</p>
    </a-modal>
  </div>
</template>

<style scoped>
#product {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 1200px;
  background: #ffffff;
  margin-top: 70px;
  margin-left: 200px;
}

#create-product {
  margin-top: 20px;
  margin-bottom: 10px;
  width: 90%;
  display: flex;
  justify-content: flex-end;
}

table {
  margin-top: 10px;
  margin-bottom: 10px;
  width: 90%;
  max-height: 650px; /* 使用最大高度替代固定高度 */
  color: #393939;
  table-layout: auto;
  border-collapse: collapse;
  display: table;
}

thead tr {
  background-color: #fafafa;
  width: 100%;
  table-layout: fixed;
}

tbody {
  overflow-y: auto; /* 保持滚动功能 */
  display: table-row-group; /* 恢复表格默认布局 */
}

tbody tr {
  width: 100%;
  table-layout: fixed;
  display: table-row; /* 恢复表格默认布局 */
}

tr {
  transition: 0.5s;
  display: table-row; /* 恢复表格默认布局 */
}

th {
  background-color: #fafafa;
  border: 1px solid #ebebeb;
  border-top: none;
  border-left:none;
  border-right:none;
  height: 47px;
}

td {
  padding-left: 10px;
  border: 1px solid #ebebeb;
  border-left:none;
  border-right:none;
  height: 47px;
  text-align: center;
}

tr:hover {
  background-color: #fafafa;
}
</style>