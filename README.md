# 外卖系统

## 项目概述

基于 Spring Boot 3.2.0 +Vue3.0开发的外卖系统，包含用户、商家、骑手和管理员四端，集成百度地图 API、百度 AI 大模型，为外卖行业提供完整的解决方案。

## 主要功能，以下为ai生成的介绍

### 用户管理
- 注册、登录、地址管理
- 个人信息管理
- 订单历史查询
- 余额管理

### 商家管理
- 商品管理（添加、修改、删除）
- 订单处理（接单、拒绝、完成）
- 数据统计（销售额、订单量）
- 店铺信息管理

### 骑手管理
- 订单抢单
- 配送管理
- 个人信息管理

### 订单系统
- 下单、支付、配送、评价
- 订单状态实时更新
- 订单历史查询
- 订单详情查看

### 智能功能（自备密钥）
- AI 生成商品分类
- 距离计算

## 技术栈

### 后端
- Spring Boot 3.2.0
- MyBatis-Plus 3.5.3.1
- MySQL 8.0
- Redis 7.0+
- Knife4j 4.3.0 (OpenAPI 3)
- Hutool 5.3.10
- FastJSON 2.0.32

### 前端
- Vue 3
- Element Plus
- Axios
- HTML5

## 快速开始

### 环境要求
- JDK 17+
- MySQL 8.0+
- Redis 7.0+
- Node.js 16+
- npm 7+

### 安装步骤

1. **克隆仓库**
   ```bash
   git clone https://github.com/index10001/take-out.git
   cd take-out

顾客小程序前端：
<img width="390" height="731" alt="image" src="https://github.com/user-attachments/assets/cea2cf47-fe51-43da-b845-c00e7092a549" />

骑手小程序前端：
<img width="436" height="705" alt="image" src="https://github.com/user-attachments/assets/2dd08091-e1cc-40de-9b31-1fee4f1d8c9a" />
<img width="380" height="740" alt="image" src="https://github.com/user-attachments/assets/62655f90-a14d-4a83-9ed4-6ca0d2638234" />

管理员后端web端：
<img width="1892" height="958" alt="image" src="https://github.com/user-attachments/assets/a2a81534-3954-4968-8cde-0974b73300f0" />

商家后端web端：
<img width="1869" height="814" alt="image" src="https://github.com/user-attachments/assets/a6f99b58-7e82-4e8b-9112-d5068d7dd559" />

### 业务缺陷
1.资金流没有覆盖到商家和骑手，目前只做了用户端的资金扣减
2.百度ai只能生成商品分类不知道修好没有（其实可以效仿市面上的淘宝外卖，也就是饿了么，做一个ai搜索，如果有做ai功能的需求的话）
3.地址管理应该改为用户模块的功能
