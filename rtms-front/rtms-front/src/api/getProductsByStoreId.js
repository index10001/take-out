import axios from "axios";
import {ref} from "vue";

const getProductsByStoreId = (storeId) => {
    const products = ref([])

    const load = async () => {
        try {
            console.log('API调用 - getProductsByStoreId:', storeId)
            if (!storeId) {
                console.error('storeId为空')
                return
            }
            
            const {data} = await axios.get(`/api/select_products_by_store_id/${storeId}`)
            console.log('API返回:', data)
            
            if (data && data.code === 200 && data.data) {
                products.value = data.data
            } else {
                console.error('API返回错误:', data.message || '未知错误')
            }
        } catch (error) {
            console.error('API调用失败:', error)
        }
    }

    return {products, load}
}

export default getProductsByStoreId