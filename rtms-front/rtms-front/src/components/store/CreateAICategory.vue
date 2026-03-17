<script setup>
import { reactive, ref } from 'vue';
import axios from "axios";
import {useStoreStore} from "@/stores/store.js";
import {message} from "ant-design-vue";
import { RobotOutlined } from '@ant-design/icons-vue';

const storeStore = useStoreStore()

const [messageApi, contextHolder] = message.useMessage()

const emit = defineEmits(['reload'])

const form = reactive({
  storeName: '',
});
const open = ref(false);
const categories = ref([]);
const isGenerating = ref(false);

const showDrawer = () => {
  open.value = true;
};

const onClose = () => {
  open.value = false;
  categories.value = [];
};

// 生成AI分类
const generateCategories = () => {
  if (!form.storeName) {
    messageApi.error('请输入店铺名称');
    return;
  }
  
  isGenerating.value = true;
  axios.post(
      '/api/ai/generate_categories',
      {},
      {
        params: {
          storeName: form.storeName,
          storeId: storeStore.id
        },
        withCredentials: true
      }
  ).then(({data}) => {
    if (data.code === 200) {
      categories.value = data.data;
      messageApi.success('分类生成成功');
    } else {
      messageApi.error(data.message);
    }
    isGenerating.value = false;
  }).catch(() => {
    messageApi.error('生成失败，请重试');
    isGenerating.value = false;
  });
};

// 批量创建分类
const createCategories = () => {
  if (categories.value.length === 0) {
    messageApi.error('请先生成分类');
    return;
  }
  
  // 将参数作为请求体传递，避免URL中包含特殊字符
  axios.post(
      '/api/ai/batch_create_categories',
      { 
        categoryNames: categories.value, 
        storeId: storeStore.id 
      },
      {
        withCredentials: true
      }
  ).then(({data}) => {
    if (data.code === 200) {
      messageApi.success('批量创建成功');
      emit('reload');
      open.value = false;
    } else {
      messageApi.error(data.message);
    }
  }).catch((error) => {
    console.error('批量创建分类请求失败:', error);
    messageApi.error('批量创建失败，请检查网络连接或重试');
  });
};
</script>

<template>
  <context-holder />
  <a-button type="primary" style="margin-left: 10px;" @click="showDrawer">
   <template #icon><RobotOutlined /></template>
    智能生成分类
  </a-button>
  <a-drawer
      title="AI智能生成分类"
      :width="520"
      :open="open"
      :body-style="{ paddingBottom: '80px' }"
      :footer-style="{ textAlign: 'right' }"
      @close="onClose"
  >
    <a-form :model="form" layout="vertical">
      <a-row :gutter="0">
        <a-col :span="20">
          <a-form-item label="店铺名称" name="storeName">
            <a-input v-model:value="form.storeName" placeholder="请输入店铺名称（如：肯德基、星巴克）" />
          </a-form-item>
        </a-col>
      </a-row>
      
      <a-form-item>
        <a-button type="primary" @click="generateCategories" :loading="isGenerating">
          {{ isGenerating ? '生成中...' : '生成分类' }}
        </a-button>
      </a-form-item>
      
      <a-form-item v-if="categories.length > 0">
        <div style="margin-bottom: 10px;"><strong>生成的分类：</strong></div>
        <a-checkbox-group v-model:value="categories">
          <a-checkbox v-for="category in categories" :key="category" :value="category">
            {{ category }}
          </a-checkbox>
        </a-checkbox-group>
      </a-form-item>
    </a-form>
    <template #extra>
      <a-space>
        <a-button @click="onClose">取消</a-button>
        <a-button type="primary" @click="createCategories" :disabled="categories.length === 0">
          批量创建
        </a-button>
      </a-space>
    </template>
  </a-drawer>
</template>