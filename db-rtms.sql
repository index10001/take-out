/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50639
Source Host           : localhost:3306
Source Database       : db-rtms

Target Server Type    : MYSQL
Target Server Version : 50639
File Encoding         : 65001

Date: 2026-01-14 17:01:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tb_account
-- ----------------------------
DROP TABLE IF EXISTS `tb_account`;
CREATE TABLE `tb_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '账号id',
  `username` varchar(255) DEFAULT NULL COMMENT '账号',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `role` varchar(255) DEFAULT NULL COMMENT '角色',
  `phone` varchar(255) DEFAULT NULL COMMENT '电话号码',
  `nickname` varchar(255) DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(2048) DEFAULT NULL COMMENT '头像',
  `money` bigint(20) DEFAULT '0' COMMENT '账号余额',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` varchar(255) DEFAULT '正常' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `username` (`username`) USING BTREE,
  KEY `money` (`money`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_account
-- ----------------------------
INSERT INTO `tb_account` VALUES ('14', 'admin', 'f4abbdc38236a77fe6fadd1cebd6e8ce', '管理员', '13533243456', '管理员', 'JJ4WKu9EFaiSf9c557d8c2d6963636f75f2600160e33.png', '0', '2025-11-16 01:28:31', '2026-01-12 10:41:47', '正常');
INSERT INTO `tb_account` VALUES ('15', 'xbk', '37b2aa62455fe1082d2f4bd21f1bfa4f', '商家', '14544345654', '星巴克', 'customer.png', '19100', '2025-11-16 01:31:16', '2026-01-12 10:41:44', '正常');
INSERT INTO `tb_account` VALUES ('16', 'rx', 'c7ad872dfcdadf048de8838a4221cc7b', '商家', '14543456545', '瑞兴咖啡', 'customer.png', '9970', '2025-11-16 01:47:14', '2026-01-12 10:41:41', '正常');
INSERT INTO `tb_account` VALUES ('17', 'lz', 'f7db064f9b550e2013aa336ab281259c', '商家', '12345435345', '兰州拉面', 'customer.png', '14700', '2025-11-16 01:59:04', '2026-01-12 10:41:38', '正常');
INSERT INTO `tb_account` VALUES ('18', 'ji123', '37d9a4669259384b5b9b85a8eaaa0bee', '顾客', '13433234565', '马龙', 'UeDHsZpzZM2W0c19ea80796c84161c7ec333f40cfb8a.png', '24090', '2025-11-16 02:07:54', '2026-01-12 10:41:50', '正常');
INSERT INTO `tb_account` VALUES ('19', 'qs1', '46d6cb0708d30c972cebd80ad424baeb', '顾客', '13433234565', '小王', 'qtaaObw0ugJjfca0f1be34ab9a7e0cefcc21edcc6fc1.png', '0', '2025-11-16 02:15:56', '2026-01-12 10:41:52', '正常');
INSERT INTO `tb_account` VALUES ('20', 'kfc', '0386d6c151b68a22e7fc5e4805dc06ec', '商家', '13455434567', '肯德基', 'customer.png', '23960', '2025-11-16 03:59:36', '2026-01-12 10:41:54', '正常');
INSERT INTO `tb_account` VALUES ('21', 'kfcd', 'c21cb79e201c82160c22d808346932ac', '骑手', '13444543456', '骑手1', 'customer.png', '0', '2025-11-16 04:07:05', '2026-01-12 10:41:57', '已封禁');
INSERT INTO `tb_account` VALUES ('22', 'qq12', '0011b43e4d1918c2818cc50cd228f280', '顾客', '14555434565', '王五', 'customer.png', '22610', '2025-11-20 22:10:30', '2026-01-12 10:41:59', '正常');
INSERT INTO `tb_account` VALUES ('23', 'kfc1', 'f4047e1b7b85dcdf73226af537e5ac5e', '顾客', '13544345654', '肯卖几', 'customer.png', '0', '2025-11-20 22:15:07', '2026-01-12 10:42:02', '已封禁');
INSERT INTO `tb_account` VALUES ('24', 'qs3', 'ecb47f3e307b8bd45b5eaa406ff09eaf', '骑手', '13444444444', 'qs3', 'customer.png', '0', '2025-11-20 22:19:00', '2026-01-12 10:42:04', '已封禁');
INSERT INTO `tb_account` VALUES ('25', 'hls', '5e1bebeabbaea12f1b91ebb911f6905d', '商家', '13533454323', '华莱士', 'customer.png', '0', '2025-11-21 12:43:17', '2026-01-12 10:42:06', '正常');
INSERT INTO `tb_account` VALUES ('26', 'yy123', 'a1aa864de7c67aee10f1f32fd7b45b7d', '顾客', '13433234543', '王武', 'customer.png', '0', '2025-11-01 01:18:53', '2026-01-12 10:42:15', '已封禁');
INSERT INTO `tb_account` VALUES ('27', '123456', 'b8f3feacb60518e9a5d053f4142f11f0', '骑手', '18250969058', '123456', 'zFGKk977hLmmfc42788001efb51195068b59a8eb5de2.png', '33230', '2025-12-18 21:49:51', '2026-01-12 09:31:00', '正常');
INSERT INTO `tb_account` VALUES ('28', '222', 'bc3a2c82ff058e7684b097bf1d93de38', '商家', '18250969058', '222', 'customer.png', '1200', '2026-01-08 20:54:45', '2026-01-11 20:55:11', '正常');
INSERT INTO `tb_account` VALUES ('29', 'tang', '7b3ce36009a4e800f5ea92966a252661', '骑手', '13906067214', '汤', '7BYMTDWcfbl6fc42788001efb51195068b59a8eb5de2.png', '3600', '2026-01-11 20:31:05', '2026-01-11 20:41:32', '正常');
INSERT INTO `tb_account` VALUES ('30', 'wei', 'f288e824c7b7aee330ff0229d4b0a695', '顾客', '13918922778', '炜', 'customer.png', '0', '2026-01-11 20:58:50', '2026-01-12 09:30:12', '正常');

-- ----------------------------
-- Table structure for tb_address
-- ----------------------------
DROP TABLE IF EXISTS `tb_address`;
CREATE TABLE `tb_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '地址id',
  `address` varchar(510) DEFAULT NULL COMMENT '地址信息',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` varchar(255) DEFAULT '正常' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_address
-- ----------------------------
INSERT INTO `tb_address` VALUES ('13', '闽南师范大学西门', '2026-01-09 16:31:51', '2026-01-10 21:17:26', '正常');
INSERT INTO `tb_address` VALUES ('14', '周大福金融大厦取餐点', '2026-01-09 16:32:02', '2026-01-11 20:44:06', '正常');
INSERT INTO `tb_address` VALUES ('16', '钻石广场取餐点', '2026-01-11 20:44:14', '2026-01-11 20:44:16', '已删除');

-- ----------------------------
-- Table structure for tb_category
-- ----------------------------
DROP TABLE IF EXISTS `tb_category`;
CREATE TABLE `tb_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `store_id` bigint(20) DEFAULT NULL COMMENT '店铺id',
  `name` varchar(255) DEFAULT NULL COMMENT '分类名称',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` varchar(255) DEFAULT '正常' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_category_store` (`store_id`) USING BTREE,
  CONSTRAINT `fk_category_store` FOREIGN KEY (`store_id`) REFERENCES `tb_store` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_category
-- ----------------------------
INSERT INTO `tb_category` VALUES ('23', '12', '本周推荐', '2025-03-16 01:38:22', '2025-03-16 01:38:22', '正常');
INSERT INTO `tb_category` VALUES ('24', '12', '经典咖啡', '2025-03-16 01:38:32', '2025-03-16 01:38:32', '正常');
INSERT INTO `tb_category` VALUES ('25', '12', '浓/系列', '2025-03-16 01:38:51', '2026-01-12 09:27:27', '已删除');
INSERT INTO `tb_category` VALUES ('26', '12', '冰淇淋', '2025-03-16 01:39:15', '2025-03-16 01:39:15', '正常');
INSERT INTO `tb_category` VALUES ('27', '12', '星巴克甄选', '2025-03-16 01:39:25', '2025-03-16 01:39:25', '正常');
INSERT INTO `tb_category` VALUES ('28', '12', '其他饮品', '2025-03-16 01:39:39', '2025-03-16 01:39:39', '正常');
INSERT INTO `tb_category` VALUES ('29', '13', '生椰家族', '2025-03-16 01:53:48', '2025-03-16 01:53:48', '正常');
INSERT INTO `tb_category` VALUES ('30', '13', '美式家族', '2025-03-16 01:54:03', '2025-03-16 01:54:03', '正常');
INSERT INTO `tb_category` VALUES ('31', '13', '丝绒拿铁', '2025-03-16 01:54:12', '2025-03-16 01:54:12', '正常');
INSERT INTO `tb_category` VALUES ('32', '13', '柠檬茶', '2025-03-16 01:54:22', '2025-03-16 01:54:22', '正常');
INSERT INTO `tb_category` VALUES ('33', '14', '经典牛肉面', '2025-03-16 02:02:42', '2025-03-16 02:02:42', '正常');
INSERT INTO `tb_category` VALUES ('34', '14', '炒拉面', '2025-03-16 02:02:50', '2025-03-16 02:02:50', '正常');
INSERT INTO `tb_category` VALUES ('35', '14', '牛/羊肉饭', '2025-03-16 02:03:14', '2025-03-16 02:03:14', '正常');
INSERT INTO `tb_category` VALUES ('36', '14', '加肉/菜', '2025-03-16 02:03:27', '2025-03-16 02:03:27', '正常');
INSERT INTO `tb_category` VALUES ('37', '15', '人气热卖', '2025-03-16 04:01:22', '2025-03-16 04:01:22', '正常');
INSERT INTO `tb_category` VALUES ('38', '15', '人气套餐', '2025-03-16 04:01:33', '2025-03-16 04:01:33', '正常');
INSERT INTO `tb_category` VALUES ('39', '15', '疯狂星期四', '2025-03-20 22:16:03', '2025-03-20 22:16:03', '正常');
INSERT INTO `tb_category` VALUES ('40', '15', '周末套餐', '2025-03-21 12:45:14', '2025-03-21 12:45:14', '正常');
INSERT INTO `tb_category` VALUES ('41', '17', '饮料', '2026-01-09 16:04:24', '2026-01-09 16:05:36', '正常');
INSERT INTO `tb_category` VALUES ('42', '17', '零食', '2026-01-09 16:04:32', '2026-01-09 16:04:32', '正常');
INSERT INTO `tb_category` VALUES ('43', '17', '饿了', '2026-01-11 20:47:51', '2026-01-12 08:39:55', '已删除');
INSERT INTO `tb_category` VALUES ('44', '18', '特惠', '2026-01-11 21:01:03', '2026-01-12 02:15:54', '已删除');
INSERT INTO `tb_category` VALUES ('45', '17', '冰淇淋', '2026-01-11 21:39:55', '2026-01-11 21:39:55', '正常');
INSERT INTO `tb_category` VALUES ('56', '12', '套餐', '2026-01-12 09:27:23', '2026-01-12 09:27:23', '正常');

-- ----------------------------
-- Table structure for tb_order
-- ----------------------------
DROP TABLE IF EXISTS `tb_order`;
CREATE TABLE `tb_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `account_id` bigint(20) DEFAULT NULL COMMENT '账号id',
  `store_id` bigint(20) DEFAULT NULL COMMENT '店铺id',
  `rider_id` bigint(20) DEFAULT '0' COMMENT '骑手id',
  `code` char(27) DEFAULT NULL COMMENT '订单号码',
  `note` varchar(510) DEFAULT NULL COMMENT '订单备注',
  `expected_time` varchar(255) DEFAULT NULL COMMENT '期望时间',
  `address` varchar(510) DEFAULT NULL COMMENT '配送地址',
  `phone` varchar(255) DEFAULT NULL COMMENT '顾客电话',
  `package_price` bigint(20) DEFAULT NULL COMMENT '打包费用',
  `delivery_price` bigint(20) DEFAULT NULL COMMENT '配送费用',
  `total_price` bigint(20) DEFAULT NULL COMMENT '合计费用',
  `payment` varchar(255) DEFAULT NULL COMMENT '支付方式',
  `progress` varchar(255) DEFAULT NULL COMMENT '订单进度',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` varchar(255) DEFAULT '正常' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_order_account` (`account_id`) USING BTREE,
  CONSTRAINT `fk_order_account` FOREIGN KEY (`account_id`) REFERENCES `tb_account` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_order
-- ----------------------------
INSERT INTO `tb_order` VALUES ('48', '18', '14', '5', '2025-0316-0221-5037-2437-94', '1', '02:21', '远洋大厦取餐点', '13433234565', '400', '400', '8300', '余额支付', '已完成', '2025-03-16 02:21:50', '2025-03-16 02:23:17', '正常');
INSERT INTO `tb_order` VALUES ('49', '18', '14', '5', '2025-0316-0339-0608-5674-70', '无备注', '05:39', '远洋大厦取餐点', '13433234565', '400', '400', '2300', '余额支付', '已完成', '2025-03-16 03:39:06', '2025-03-16 03:57:43', '正常');
INSERT INTO `tb_order` VALUES ('50', '18', '14', '5', '2025-0316-0351-1292-4088-58', '1111111111', '03:51', '周大福金融大厦取餐点', '13433234565', '400', '400', '5300', '余额支付', '已完成', '2025-03-16 03:51:12', '2025-03-16 03:52:50', '正常');
INSERT INTO `tb_order` VALUES ('51', '18', '14', '5', '2025-0316-0356-3814-8005-70', '无备注', '03:56', '周大福金融大厦取餐点', '13433234565', '400', '400', '2300', '余额支付', '已送达', '2025-03-16 03:56:38', '2025-03-16 03:57:29', '正常');
INSERT INTO `tb_order` VALUES ('52', '18', '15', '5', '2025-0316-0404-1101-4661-28', '无备注', '04:04', '周大福金融大厦取餐点', '13433234565', '500', '400', '10880', '余额支付', '配送中', '2025-03-16 04:04:11', '2025-03-16 20:24:10', '正常');
INSERT INTO `tb_order` VALUES ('53', '18', '15', '5', '2025-0316-2215-5249-3249-66', '无备注', '22:15', '远洋大厦取餐点', '13433234565', '500', '400', '13880', '余额支付', '配送中', '2025-03-16 22:15:52', '2025-03-16 22:20:11', '正常');
INSERT INTO `tb_order` VALUES ('54', '18', '15', '5', '2025-0316-2223-4813-0575-59', '无备注', '22:23', '远洋大厦取餐点', '13433234565', '500', '400', '2400', '余额支付', '已送达', '2025-03-16 22:23:48', '2025-03-16 22:24:29', '正常');
INSERT INTO `tb_order` VALUES ('55', '22', '15', '5', '2025-0320-2211-3462-0019-76', '无备注', '22:11', '周大福金融大厦取餐点', '14555434565', '500', '400', '7390', '余额支付', '已完成', '2025-03-20 22:11:34', '2025-03-20 22:13:38', '正常');
INSERT INTO `tb_order` VALUES ('56', '18', '15', '8', '2025-0321-1236-4815-1772-69', '无备注', '12:36', '远洋大厦取餐点', '13433234565', '500', '400', '5890', '余额支付', '已送达', '2025-03-21 12:36:48', '2026-01-10 18:13:38', '正常');
INSERT INTO `tb_order` VALUES ('57', '18', '15', '5', '2025-0321-1239-4986-4905-07', '无备注', '12:39', '周大福金融大厦取餐点', '13433234565', '500', '400', '17370', '余额支付', '已完成', '2025-03-21 12:39:49', '2025-03-21 12:41:20', '正常');
INSERT INTO `tb_order` VALUES ('58', '18', '15', '8', '2025-0323-2328-3481-3762-69', '无备注', '23:28', '周大福金融大厦取餐点', '13433234565', '500', '400', '7290', '余额支付', '已送达', '2025-03-23 23:28:34', '2026-01-10 18:13:43', '正常');
INSERT INTO `tb_order` VALUES ('59', '27', '17', '0', '2026-0110-0007-3422-0735-69', '慢点', '13:05', '钻石广场取餐点', '18250969058', '200', '200', '1800', '余额支付', '已取消', '2026-01-10 00:07:34', '2026-01-10 00:11:26', '顾客已删除');
INSERT INTO `tb_order` VALUES ('60', '27', '13', '8', '2026-0110-0013-4289-2406-44', '慢点', '08:24', '钻石广场取餐点', '18250969058', '500', '200', '3690', '余额支付', '已完成', '2026-01-10 00:13:42', '2026-01-11 02:13:32', '顾客已删除');
INSERT INTO `tb_order` VALUES ('61', '27', '13', '8', '2026-0110-0019-3240-1146-52', '无备注', '11:29', '钻石广场取餐点', '18250969058', '500', '200', '6680', '余额支付', '已完成', '2026-01-10 00:19:32', '2026-01-10 00:21:04', '正常');
INSERT INTO `tb_order` VALUES ('62', '27', '14', '8', '2026-0110-1820-3975-2644-25', '无备注', '19:20', '钻石广场取餐点', '18250969058', '400', '200', '2100', '余额支付', '已送达', '2026-01-10 18:20:40', '2026-01-11 20:37:54', '正常');
INSERT INTO `tb_order` VALUES ('63', '27', '12', '0', '2026-0110-1916-3036-3255-19', '无备注', '20:16', '钻石广场取餐点', '18250969058', '500', '200', '10500', '余额支付', '待支付', '2026-01-10 19:16:30', '2026-01-10 19:16:30', '正常');
INSERT INTO `tb_order` VALUES ('64', '27', '12', '0', '2026-0110-2026-4108-4538-04', '无备注', '21:26', '钻石广场取餐点', '18250969058', '500', '200', '5600', '余额支付', '待支付', '2026-01-10 20:26:43', '2026-01-10 20:26:43', '正常');
INSERT INTO `tb_order` VALUES ('65', '27', '13', '0', '2026-0110-2041-2687-5545-57', '无备注', '21:41', '钻石广场取餐点', '18250969058', '500', '200', '3690', '余额支付', '已取消', '2026-01-10 20:41:28', '2026-01-11 02:12:40', '正常');
INSERT INTO `tb_order` VALUES ('66', '27', '17', '0', '2026-0111-0212-2808-7313-74', '无备注', '03:12', '闽南师范大学西门', '18250969058', '200', '200', '1600', '余额支付', '已取消', '2026-01-11 02:12:30', '2026-01-11 02:13:58', '正常');
INSERT INTO `tb_order` VALUES ('67', '27', '17', '0', '2026-0111-0217-5983-0950-01', '无备注', '03:17', '闽南师范大学西门', '18250969058', '200', '200', '33400', '余额支付', '已取消', '2026-01-11 02:17:59', '2026-01-11 02:19:09', '正常');
INSERT INTO `tb_order` VALUES ('68', '27', '17', '0', '2026-0111-0218-5035-6619-46', '无备注', '03:18', '闽南师范大学西门', '18250969058', '200', '200', '12900', '余额支付', '已取消', '2026-01-11 02:18:51', '2026-01-11 02:43:20', '正常');
INSERT INTO `tb_order` VALUES ('69', '27', '17', '0', '2026-0111-0222-2414-2838-56', '无备注', '03:21', '闽南师范大学西门', '18250969058', '200', '200', '900', '余额支付', '已取消', '2026-01-11 02:22:24', '2026-01-11 02:35:05', '正常');
INSERT INTO `tb_order` VALUES ('70', '27', '17', '0', '2026-0111-1305-2187-4120-77', '无备注', '14:04', '闽南师范大学西门', '18250969058', '200', '200', '600', '余额支付', '待支付', '2026-01-11 13:05:21', '2026-01-11 13:05:21', '正常');
INSERT INTO `tb_order` VALUES ('71', '27', '17', '0', '2026-0111-1328-0760-1537-11', '无备注', '14:21', '闽南师范大学西门', '18250969058', '200', '200', '800', '余额支付', '待支付', '2026-01-11 13:28:19', '2026-01-11 13:28:19', '正常');
INSERT INTO `tb_order` VALUES ('72', '29', '17', '8', '2026-0111-2033-4865-2280-87', '无备注', '21:33', '闽南师范大学西门', '13906067214', '200', '200', '1400', '余额支付', '已完成', '2026-01-11 20:34:00', '2026-01-11 20:38:31', '正常');
INSERT INTO `tb_order` VALUES ('73', '29', '17', '0', '2026-0111-2034-5018-2922-29', '无备注', '21:34', '闽南师范大学西门', '13906067214', '200', '200', '600', '余额支付', '已取消', '2026-01-11 20:34:50', '2026-01-11 20:36:18', '顾客已删除');
INSERT INTO `tb_order` VALUES ('74', '27', '17', '0', '2026-0112-0843-0522-9630-52', '无备注', '09:42', '闽南师范大学西门', '18250969058', '200', '200', '600', '余额支付', '待支付', '2026-01-12 08:43:06', '2026-01-12 08:43:06', '正常');
INSERT INTO `tb_order` VALUES ('75', '27', '12', '10', '2026-0112-0924-0875-3938-58', '无备注', '10:22', '闽南师范大学西门', '18250969058', '500', '200', '19300', '余额支付', '已完成', '2026-01-12 09:24:09', '2026-01-12 09:26:40', '正常');

-- ----------------------------
-- Table structure for tb_order_product
-- ----------------------------
DROP TABLE IF EXISTS `tb_order_product`;
CREATE TABLE `tb_order_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单产品id',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单id',
  `product_id` bigint(20) DEFAULT NULL COMMENT '产品id',
  `name` varchar(255) DEFAULT NULL COMMENT '产品名称',
  `price` bigint(20) DEFAULT NULL COMMENT '产品单价',
  `number` bigint(20) DEFAULT NULL COMMENT '产品数量',
  `specification` varchar(510) DEFAULT NULL COMMENT '产品规格',
  `total_price` bigint(20) DEFAULT NULL COMMENT '合计费用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` varchar(255) DEFAULT '正常' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_orderproduct_order` (`order_id`) USING BTREE,
  KEY `fk_orderproduct_product` (`product_id`) USING BTREE,
  CONSTRAINT `fk_orderproduct_order` FOREIGN KEY (`order_id`) REFERENCES `tb_order` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_orderproduct_product` FOREIGN KEY (`product_id`) REFERENCES `tb_product` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_order_product
-- ----------------------------
INSERT INTO `tb_order_product` VALUES ('32', '48', '33', '牛肉拉面', '1500', '1', '辣度: 中辣', '1500', '2025-03-16 02:21:50', '2025-03-16 02:21:50', '正常');
INSERT INTO `tb_order_product` VALUES ('33', '48', '34', '红烧牛肉面', '1500', '1', '', '1500', '2025-03-16 02:21:50', '2025-03-16 02:21:50', '正常');
INSERT INTO `tb_order_product` VALUES ('34', '48', '35', '牛肉汤', '1500', '3', '', '4500', '2025-03-16 02:21:50', '2025-03-16 02:21:50', '正常');
INSERT INTO `tb_order_product` VALUES ('35', '49', '34', '红烧牛肉面', '1500', '1', '', '1500', '2025-03-16 03:39:06', '2025-03-16 03:39:06', '正常');
INSERT INTO `tb_order_product` VALUES ('36', '50', '33', '牛肉拉面', '1500', '3', '辣度: 中辣', '4500', '2025-03-16 03:51:12', '2025-03-16 03:51:12', '正常');
INSERT INTO `tb_order_product` VALUES ('37', '51', '35', '牛肉汤', '1500', '1', '', '1500', '2025-03-16 03:56:38', '2025-03-16 03:56:38', '正常');
INSERT INTO `tb_order_product` VALUES ('38', '52', '37', '49.9人气套餐', '4990', '2', '', '9980', '2025-03-16 04:04:11', '2025-03-16 04:04:11', '正常');
INSERT INTO `tb_order_product` VALUES ('39', '53', '37', '49.9人气套餐', '4990', '2', '', '9980', '2025-03-16 22:15:52', '2025-03-16 22:15:52', '正常');
INSERT INTO `tb_order_product` VALUES ('40', '53', '36', '薯条', '1500', '2', '大小: 小份, 辣度: 微辣', '3000', '2025-03-16 22:15:52', '2025-03-16 22:15:52', '正常');
INSERT INTO `tb_order_product` VALUES ('41', '54', '36', '薯条', '1500', '1', '大小: 大份, 辣度: 微辣', '1500', '2025-03-16 22:23:48', '2025-03-16 22:23:48', '正常');
INSERT INTO `tb_order_product` VALUES ('42', '55', '36', '薯条', '1500', '1', '大小: 大份, 辣度: 不辣', '1500', '2025-03-20 22:11:34', '2025-03-20 22:11:34', '正常');
INSERT INTO `tb_order_product` VALUES ('43', '55', '37', '49.9人气套餐', '4990', '1', '', '4990', '2025-03-20 22:11:34', '2025-03-20 22:11:34', '正常');
INSERT INTO `tb_order_product` VALUES ('44', '56', '37', '49.9人气套餐', '4990', '1', '', '4990', '2025-03-21 12:36:48', '2025-03-21 12:36:48', '正常');
INSERT INTO `tb_order_product` VALUES ('45', '57', '36', '薯条', '1500', '1', '大小: 小份, 辣度: 微辣', '1500', '2025-03-21 12:39:49', '2025-03-21 12:39:49', '正常');
INSERT INTO `tb_order_product` VALUES ('46', '57', '37', '49.9人气套餐', '4990', '3', '', '14970', '2025-03-21 12:39:49', '2025-03-21 12:39:49', '正常');
INSERT INTO `tb_order_product` VALUES ('47', '58', '39', '全家桶', '5990', '1', '辣度: 微辣, 大小: 特大桶', '5990', '2025-03-23 23:28:34', '2025-03-23 23:28:34', '正常');
INSERT INTO `tb_order_product` VALUES ('48', '59', '42', '乐事薯片', '500', '2', '口味: 番茄味', '1000', '2026-01-10 00:07:34', '2026-01-10 00:07:34', '正常');
INSERT INTO `tb_order_product` VALUES ('49', '59', '40', '罐装可乐', '200', '1', '温度: 冰', '200', '2026-01-10 00:07:34', '2026-01-10 00:07:34', '正常');
INSERT INTO `tb_order_product` VALUES ('50', '59', '40', '罐装可乐', '200', '1', '温度: 常温', '200', '2026-01-10 00:07:34', '2026-01-10 00:07:34', '正常');
INSERT INTO `tb_order_product` VALUES ('51', '60', '29', '生椰拿铁', '2990', '1', '口味: 意式', '2990', '2026-01-10 00:13:42', '2026-01-10 00:13:42', '正常');
INSERT INTO `tb_order_product` VALUES ('52', '61', '30', '生椰丝绒拿铁', '2990', '1', '', '2990', '2026-01-10 00:19:32', '2026-01-10 00:19:32', '正常');
INSERT INTO `tb_order_product` VALUES ('53', '61', '29', '生椰拿铁', '2990', '1', '口味: 美式', '2990', '2026-01-10 00:19:32', '2026-01-10 00:19:32', '正常');
INSERT INTO `tb_order_product` VALUES ('54', '62', '33', '牛肉拉面', '1500', '1', '辣度: 中辣', '1500', '2026-01-10 18:20:40', '2026-01-10 18:20:40', '正常');
INSERT INTO `tb_order_product` VALUES ('55', '63', '28', '冰美式', '4900', '1', '', '4900', '2026-01-10 19:16:30', '2026-01-10 19:16:30', '正常');
INSERT INTO `tb_order_product` VALUES ('56', '63', '27', '牛乳拿铁', '4900', '1', '', '4900', '2026-01-10 19:16:30', '2026-01-10 19:16:30', '正常');
INSERT INTO `tb_order_product` VALUES ('57', '64', '27', '牛乳拿铁', '4900', '1', '', '4900', '2026-01-10 20:26:43', '2026-01-10 20:26:43', '正常');
INSERT INTO `tb_order_product` VALUES ('58', '65', '30', '生椰丝绒拿铁', '2990', '1', '', '2990', '2026-01-10 20:41:28', '2026-01-10 20:41:28', '正常');
INSERT INTO `tb_order_product` VALUES ('59', '66', '40', '罐装可乐', '200', '1', '温度: 常温', '200', '2026-01-11 02:12:30', '2026-01-11 02:12:30', '正常');
INSERT INTO `tb_order_product` VALUES ('60', '66', '42', '乐事薯片', '500', '2', '口味: 原味', '1000', '2026-01-11 02:12:30', '2026-01-11 02:12:30', '正常');
INSERT INTO `tb_order_product` VALUES ('61', '67', '42', '乐事薯片', '500', '66', '口味: 原味', '33000', '2026-01-11 02:17:59', '2026-01-11 02:17:59', '正常');
INSERT INTO `tb_order_product` VALUES ('62', '68', '42', '乐事薯片', '500', '25', '口味: 原味', '12500', '2026-01-11 02:18:51', '2026-01-11 02:18:51', '正常');
INSERT INTO `tb_order_product` VALUES ('63', '69', '42', '乐事薯片', '500', '1', '口味: 原味', '500', '2026-01-11 02:22:24', '2026-01-11 02:22:24', '正常');
INSERT INTO `tb_order_product` VALUES ('64', '70', '40', '罐装可乐', '200', '1', '温度: 常温', '200', '2026-01-11 13:05:21', '2026-01-11 13:05:21', '正常');
INSERT INTO `tb_order_product` VALUES ('65', '71', '40', '罐装可乐', '200', '1', '温度: 常温', '200', '2026-01-11 13:28:19', '2026-01-11 13:28:19', '正常');
INSERT INTO `tb_order_product` VALUES ('66', '71', '40', '罐装可乐', '200', '1', '温度: 常温', '200', '2026-01-11 13:28:19', '2026-01-11 13:28:19', '正常');
INSERT INTO `tb_order_product` VALUES ('67', '72', '42', '乐事薯片', '500', '2', '口味: 原味', '1000', '2026-01-11 20:34:00', '2026-01-11 20:34:00', '正常');
INSERT INTO `tb_order_product` VALUES ('68', '73', '40', '罐装可乐', '200', '1', '温度: 常温', '200', '2026-01-11 20:34:50', '2026-01-11 20:34:50', '正常');
INSERT INTO `tb_order_product` VALUES ('69', '74', '40', '罐装可乐', '200', '1', '温度: 常温', '200', '2026-01-12 08:43:06', '2026-01-12 08:43:06', '正常');
INSERT INTO `tb_order_product` VALUES ('70', '75', '26', '茉莉100拿铁', '3900', '1', '大小: 大杯', '3900', '2026-01-12 09:24:09', '2026-01-12 09:24:09', '正常');
INSERT INTO `tb_order_product` VALUES ('71', '75', '27', '牛乳拿铁', '4900', '3', '', '14700', '2026-01-12 09:24:09', '2026-01-12 09:24:09', '正常');

-- ----------------------------
-- Table structure for tb_product
-- ----------------------------
DROP TABLE IF EXISTS `tb_product`;
CREATE TABLE `tb_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '产品id',
  `store_id` bigint(20) DEFAULT NULL COMMENT '店铺id',
  `category_id` bigint(20) DEFAULT NULL COMMENT '分类id',
  `name` varchar(255) DEFAULT NULL COMMENT '产品名称',
  `price` bigint(20) DEFAULT NULL COMMENT '产品单价',
  `unit` varchar(255) DEFAULT NULL COMMENT '产品单位',
  `description` varchar(510) DEFAULT NULL COMMENT '产品简介',
  `picture` varchar(2048) DEFAULT NULL COMMENT '产品图片',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` varchar(255) DEFAULT '正常' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_product_store` (`store_id`) USING BTREE,
  KEY `fk_product_category` (`category_id`) USING BTREE,
  CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `tb_category` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_product_store` FOREIGN KEY (`store_id`) REFERENCES `tb_store` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_product
-- ----------------------------
INSERT INTO `tb_product` VALUES ('26', '12', '23', '茉莉100拿铁', '3900', '杯', '一杯满载100朵茉莉精粹', 'efaae4c5-4369-4714-b097-37b0fe5eca77.jfif', '2025-03-16 01:40:42', '2025-03-16 01:44:05', '正常');
INSERT INTO `tb_product` VALUES ('27', '12', '23', '牛乳拿铁', '4900', '杯', '经典回归靠巴旦木牛乳拿铁。', 'a7b8023f9ad8b90fbf36088388a2c18d.jpg', '2025-03-16 01:45:49', '2025-03-16 01:45:49', '正常');
INSERT INTO `tb_product` VALUES ('28', '12', '23', '冰美式', '4900', '杯', '经典回归冰美式。', '8a794e227f0a947ad53fab1d61e5fe4c.jpeg', '2025-03-16 01:46:38', '2025-03-16 01:46:38', '正常');
INSERT INTO `tb_product` VALUES ('29', '13', '29', '生椰拿铁', '2990', '杯', '生椰拿铁，4年突破12亿杯', '31ff8246-13c7-412f-8d26-2d73c9f9106e.jfif', '2025-03-16 01:55:46', '2025-03-16 01:55:46', '正常');
INSERT INTO `tb_product` VALUES ('30', '13', '29', '生椰丝绒拿铁', '2990', '杯', '生椰拿铁，4年突破12亿杯', '4bfc4eb9099d9dc3e2ff4a08c360ade4.jpeg', '2025-03-16 01:56:51', '2025-03-16 01:56:51', '正常');
INSERT INTO `tb_product` VALUES ('31', '13', '30', '美式橙C', '2990', '杯', '美式橙C，4年突破12亿杯', '3a0e9ae71b9ad8f1c9952dd5e61ebe8d.jpeg', '2025-03-16 01:57:31', '2025-03-16 01:57:31', '正常');
INSERT INTO `tb_product` VALUES ('32', '13', '32', '葡萄柠檬茶', '2990', '杯', '美式橙C，4年突破12亿杯', '4dffea5ee09a9ab6dc7235cc7fd56657.jpg', '2025-03-16 01:58:26', '2025-03-16 01:58:26', '正常');
INSERT INTO `tb_product` VALUES ('33', '14', '33', '牛肉拉面', '1500', '碗', '牛肉拉面', 'bbf597fb3e04080e51dfb12638ee2d70.jpeg', '2025-03-16 02:04:04', '2025-03-16 02:04:04', '正常');
INSERT INTO `tb_product` VALUES ('34', '14', '33', '红烧牛肉面', '1500', '碗', '红烧牛肉面', 'fb65940989325f8385ec96dd28d532ad.jpg', '2025-03-16 02:04:22', '2025-03-16 02:04:22', '正常');
INSERT INTO `tb_product` VALUES ('35', '14', '33', '牛肉汤', '1500', '碗', '红烧牛肉面', 'a9dbf9fd98123006925613f316bef30b.jpeg', '2025-03-16 02:04:40', '2025-03-16 02:04:40', '正常');
INSERT INTO `tb_product` VALUES ('36', '15', '37', '薯条', '1500', '份', '薯条', '42b83ac056e2d8227d8cc2d1f9e63008.jpeg', '2025-03-16 04:02:19', '2025-03-16 04:02:19', '正常');
INSERT INTO `tb_product` VALUES ('37', '15', '38', '49.9人气套餐', '4990', '份', '49.9人气套餐', '9fdbbf40f712cae5a15673838d0c9313.jpg', '2025-03-16 04:03:24', '2025-03-16 04:03:24', '正常');
INSERT INTO `tb_product` VALUES ('38', '15', '39', '鸡肉保', '1500', '个', '111', '12fad40c9b993d3abd8cd7dee400c038.jpg', '2025-03-20 22:16:35', '2025-03-20 22:16:35', '正常');
INSERT INTO `tb_product` VALUES ('39', '15', '37', '全家桶', '5990', '份', '1', '9fdbbf40f712cae5a15673838d0c9313.jpg', '2025-03-21 12:45:56', '2025-03-21 12:45:56', '正常');
INSERT INTO `tb_product` VALUES ('40', '17', '41', '罐装可乐', '200', '罐', '矮矮的蓝蓝的', 'DkTYdbw9a0D4ttES_hPdww.jpg', '2026-01-09 16:08:52', '2026-01-11 21:53:08', '正常');
INSERT INTO `tb_product` VALUES ('42', '17', '42', '乐事薯片', '500', '袋', '好贵的土豆片', '屏幕截图 2026-01-09 160922.png', '2026-01-09 16:11:22', '2026-01-11 21:53:04', '正常');
INSERT INTO `tb_product` VALUES ('43', '17', '43', '饿了么', '2000', '了', '不饿', '屏幕截图 2026-01-08 205927.png', '2026-01-11 20:48:57', '2026-01-11 22:10:31', '已删除');
INSERT INTO `tb_product` VALUES ('44', '18', '44', '馄饨', '500', '碗', '', '', '2026-01-11 21:01:28', '2026-01-11 21:01:28', '正常');
INSERT INTO `tb_product` VALUES ('62', '17', '45', '22', '0', '了', '2', '', '2026-01-11 21:53:25', '2026-01-11 21:53:41', '已删除');
INSERT INTO `tb_product` VALUES ('63', '17', '45', '223', '0', '了', '2', '', '2026-01-11 21:53:47', '2026-01-11 21:54:06', '已删除');
INSERT INTO `tb_product` VALUES ('64', '17', '41', '雪碧', '200', '罐', '', '', '2026-01-11 22:11:40', '2026-01-11 22:12:16', '已删除');
INSERT INTO `tb_product` VALUES ('65', '17', '41', '2', '200', '罐', '', '', '2026-01-11 22:12:14', '2026-01-11 22:12:22', '已删除');
INSERT INTO `tb_product` VALUES ('66', '12', '27', '茉莉和拿铁', '1000', '瓶', '', '20221115121911_a9ab2.png', '2026-01-12 09:28:35', '2026-01-12 09:28:35', '正常');

-- ----------------------------
-- Table structure for tb_rider
-- ----------------------------
DROP TABLE IF EXISTS `tb_rider`;
CREATE TABLE `tb_rider` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '骑手id',
  `account_id` bigint(20) DEFAULT NULL COMMENT '账号id',
  `name` varchar(255) DEFAULT NULL COMMENT '骑手姓名',
  `id_number` varchar(255) DEFAULT NULL COMMENT '身份证号',
  `gender` varchar(255) DEFAULT NULL COMMENT '骑手性别',
  `phone` varchar(255) DEFAULT NULL COMMENT '电话号码',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` varchar(255) DEFAULT '正常' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_rider_account` (`account_id`) USING BTREE,
  CONSTRAINT `fk_rider_account` FOREIGN KEY (`account_id`) REFERENCES `tb_account` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_rider
-- ----------------------------
INSERT INTO `tb_rider` VALUES ('5', '19', '小李', '345433345434565435', '男', '18250969058', '2025-03-16 02:18:24', '2026-01-09 17:03:11', '已删除');
INSERT INTO `tb_rider` VALUES ('6', '21', '顶针', '123456199801011234', '男', '12345678910', '2025-03-16 04:07:31', '2026-01-11 20:42:17', '正常');
INSERT INTO `tb_rider` VALUES ('7', '24', '宫百万', '123456199801011234', '女', '18250969058', '2025-03-21 12:48:41', '2026-01-11 20:42:24', '正常');
INSERT INTO `tb_rider` VALUES ('8', '27', '饿了么', '123456199801011234', '男', '13918922778', '2026-01-09 16:41:29', '2026-01-11 20:42:48', '已删除');
INSERT INTO `tb_rider` VALUES ('9', '18', '马龙', '123456199801011234', '男', '18250969058', '2026-01-09 17:37:49', '2026-01-09 17:46:50', '已删除');
INSERT INTO `tb_rider` VALUES ('10', '29', '嘉', '123456199801011234', '男', '13906067214', '2026-01-11 20:41:32', '2026-01-11 20:41:43', '正常');
INSERT INTO `tb_rider` VALUES ('11', '27', '汤', '123456199801011234', '男', '18250969058', '2026-01-12 09:31:00', '2026-01-12 09:31:00', '正常');

-- ----------------------------
-- Table structure for tb_specification
-- ----------------------------
DROP TABLE IF EXISTS `tb_specification`;
CREATE TABLE `tb_specification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '规格id',
  `product_id` bigint(20) DEFAULT NULL COMMENT '产品id',
  `type` varchar(255) DEFAULT NULL COMMENT '规格类型',
  `name` varchar(255) DEFAULT NULL COMMENT '规格名称',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` varchar(255) DEFAULT '正常' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_specification_product` (`product_id`) USING BTREE,
  CONSTRAINT `fk_specification_product` FOREIGN KEY (`product_id`) REFERENCES `tb_product` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_specification
-- ----------------------------
INSERT INTO `tb_specification` VALUES ('11', '26', '大小', '中杯', '2025-03-16 01:44:31', '2025-03-16 01:44:31', '正常');
INSERT INTO `tb_specification` VALUES ('12', '26', '大小', '大杯', '2025-03-16 01:44:38', '2025-03-16 01:44:38', '正常');
INSERT INTO `tb_specification` VALUES ('13', '29', '口味', '美食', '2025-03-16 01:55:56', '2025-03-16 01:56:30', '已删除');
INSERT INTO `tb_specification` VALUES ('14', '29', '口味', '意式', '2025-03-16 01:56:12', '2025-03-16 01:56:12', '正常');
INSERT INTO `tb_specification` VALUES ('15', '29', '口味', '美式', '2025-03-16 01:56:28', '2025-03-16 01:56:28', '正常');
INSERT INTO `tb_specification` VALUES ('16', '31', '温度', '冷', '2025-03-16 01:57:57', '2025-03-16 01:57:57', '正常');
INSERT INTO `tb_specification` VALUES ('17', '31', '温度', '热', '2025-03-16 01:58:04', '2025-03-16 01:58:04', '正常');
INSERT INTO `tb_specification` VALUES ('18', '31', '温度', '常温', '2025-03-16 01:58:10', '2025-03-16 01:58:10', '正常');
INSERT INTO `tb_specification` VALUES ('19', '33', '辣度', '不辣', '2025-03-16 02:04:52', '2025-03-16 02:04:52', '正常');
INSERT INTO `tb_specification` VALUES ('20', '33', '辣度', '中辣', '2025-03-16 02:05:00', '2025-03-16 02:05:00', '正常');
INSERT INTO `tb_specification` VALUES ('21', '33', '辣度', '中辣', '2025-03-16 02:05:01', '2025-03-16 02:05:04', '已删除');
INSERT INTO `tb_specification` VALUES ('22', '33', '辣度', '特辣', '2025-03-16 02:05:08', '2025-03-16 02:05:08', '正常');
INSERT INTO `tb_specification` VALUES ('23', '36', '大小', '小份', '2025-03-16 04:02:38', '2025-03-16 04:02:38', '正常');
INSERT INTO `tb_specification` VALUES ('24', '36', '大小', '大份', '2025-03-16 04:02:45', '2025-03-16 04:02:45', '正常');
INSERT INTO `tb_specification` VALUES ('25', '36', '辣度', '不辣', '2025-03-16 20:16:43', '2025-03-16 20:16:43', '正常');
INSERT INTO `tb_specification` VALUES ('26', '36', '辣度', '微辣', '2025-03-16 20:16:48', '2025-03-16 20:16:48', '正常');
INSERT INTO `tb_specification` VALUES ('27', '38', '辣度', '微辣', '2025-03-20 22:16:49', '2025-03-20 22:16:49', '正常');
INSERT INTO `tb_specification` VALUES ('28', '38', '辣度', '重辣', '2025-03-20 22:16:56', '2025-03-20 22:16:56', '正常');
INSERT INTO `tb_specification` VALUES ('29', '39', '辣度', '微辣', '2025-03-21 12:46:15', '2025-03-21 12:46:15', '正常');
INSERT INTO `tb_specification` VALUES ('30', '39', '辣度', '特辣', '2025-03-21 12:46:20', '2025-03-21 12:46:20', '正常');
INSERT INTO `tb_specification` VALUES ('31', '39', '大小', '大桶', '2025-03-21 12:46:41', '2025-03-21 12:46:41', '正常');
INSERT INTO `tb_specification` VALUES ('32', '39', '大小', '特大桶', '2025-03-21 12:46:55', '2025-03-21 12:46:55', '正常');
INSERT INTO `tb_specification` VALUES ('33', '40', '温度', '冰', '2026-01-09 16:12:22', '2026-01-09 16:12:22', '正常');
INSERT INTO `tb_specification` VALUES ('34', '40', '温度', '常温', '2026-01-09 16:12:28', '2026-01-09 16:12:28', '正常');
INSERT INTO `tb_specification` VALUES ('35', '42', '口味', '番茄味', '2026-01-09 16:12:43', '2026-01-09 16:12:43', '正常');
INSERT INTO `tb_specification` VALUES ('36', '42', '口味', '原味', '2026-01-09 16:12:47', '2026-01-09 16:12:57', '已删除');
INSERT INTO `tb_specification` VALUES ('37', '42', '口味', '原味', '2026-01-09 16:12:58', '2026-01-09 16:12:58', '正常');
INSERT INTO `tb_specification` VALUES ('38', '42', '大小', '小', '2026-01-11 20:51:42', '2026-01-11 20:51:42', '正常');
INSERT INTO `tb_specification` VALUES ('39', '42', '大小', '大', '2026-01-11 20:51:46', '2026-01-11 20:51:46', '正常');

-- ----------------------------
-- Table structure for tb_store
-- ----------------------------
DROP TABLE IF EXISTS `tb_store`;
CREATE TABLE `tb_store` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '店铺id',
  `account_id` bigint(20) DEFAULT NULL COMMENT '账号id',
  `name` varchar(255) DEFAULT NULL COMMENT '店铺名称',
  `logo` varchar(2048) DEFAULT NULL COMMENT '店铺logo',
  `description` varchar(510) DEFAULT NULL COMMENT '店铺简介',
  `phone` varchar(255) DEFAULT NULL COMMENT '电话号码',
  `address` varchar(510) DEFAULT NULL COMMENT '店铺地址',
  `business_hour` varchar(255) DEFAULT NULL COMMENT '营业时段',
  `business_license` varchar(2048) DEFAULT NULL COMMENT '营业执照',
  `package_price` bigint(20) DEFAULT NULL COMMENT '打包费用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` varchar(255) DEFAULT NULL COMMENT '状态',
  `type` varchar(255) DEFAULT NULL COMMENT '店铺类型',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_store_account` (`account_id`) USING BTREE,
  CONSTRAINT `fk_store_account` FOREIGN KEY (`account_id`) REFERENCES `tb_account` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_store
-- ----------------------------
INSERT INTO `tb_store` VALUES ('12', '15', '星巴克', 'Starbucks星巴克.png', '全球知名咖啡连锁，于 1971 年创立，店内氛围闲适，供应多样咖啡轻食。', '40445455488', '闽南师范大学东门', '24H', 'Starbucks星巴克.png', '500', '2025-03-16 01:33:58', '2026-01-11 13:39:29', '正常', '奶茶饮品');
INSERT INTO `tb_store` VALUES ('13', '16', '瑞兴咖啡', 'icon_瑞幸咖啡.png', '诞生于 2017 年，瑞幸秉持 “专业咖啡新鲜式” 理念，用创意咖啡与便捷体验圈粉无数。', '54545434545', '闽南师范大学东门', '24H', 'icon_瑞幸咖啡.png', '500', '2025-03-16 01:48:37', '2026-01-11 13:39:24', '正常', '奶茶饮品');
INSERT INTO `tb_store` VALUES ('14', '17', '兰州拉面', '182e068ef80db4f6a4ca551b4092cef5.jpg', '兰州拉面', '3423453535', '闽南师范大学东门', '24H', '182e068ef80db4f6a4ca551b4092cef5.jpg', '400', '2025-03-16 02:02:05', '2026-01-11 13:39:22', '正常', '中餐美食');
INSERT INTO `tb_store` VALUES ('15', '20', '肯德基', 'KFC肯德基.png', '肯德基', '4234234234', '闽南师范大学东门', '24H', 'KFC肯德基.png', '500', '2025-03-16 04:00:28', '2026-01-11 13:39:21', '正常', '汉堡炸鸡');
INSERT INTO `tb_store` VALUES ('16', '25', '华莱士', '63df5d94e1e955778ca0fb046be02f0d.jpeg', '1', '123123213', '闽南师范大学东门', '24H', '63df5d94e1e955778ca0fb046be02f0d.jpeg', '300', '2025-03-21 12:43:52', '2026-01-11 13:39:19', '正常', '汉堡炸鸡');
INSERT INTO `tb_store` VALUES ('17', '28', '生活超市', '屏幕截图 2026-01-08 210100.png', '是一家为了便利生活的超市', '18250969058', '闽南师范大学东门', '全天24小时', '', '200', '2026-01-09 15:58:19', '2026-01-11 20:55:11', '正常', '超市便利');
INSERT INTO `tb_store` VALUES ('18', '30', '沙县小吃', '屏幕截图 2026-01-08 205927.png', '名吃快餐', '18250969058', '闽南师范大学东门', '全天24小时', '屏幕截图 2026-01-08 205927.png', '200', '2026-01-11 21:00:11', '2026-01-12 09:30:12', '审核中', '名吃快餐');

-- ----------------------------
-- Table structure for tb_system
-- ----------------------------
DROP TABLE IF EXISTS `tb_system`;
CREATE TABLE `tb_system` (
  `table_key` varchar(255) DEFAULT '0' COMMENT '键',
  `table_value` varchar(255) DEFAULT NULL COMMENT '值',
  `note` varchar(255) DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_system
-- ----------------------------
INSERT INTO `tb_system` VALUES ('delivery_price', '200', '平台配送费用');
INSERT INTO `tb_system` VALUES ('announcement', '舌尖急先锋，健康美味', '平台公告');
INSERT INTO `tb_system` VALUES ('banner_1', '屏幕截图 2026-01-09 162937.png', '轮播图1');
INSERT INTO `tb_system` VALUES ('banner_2', '4dffea5ee09a9ab6dc7235cc7fd56657.jpg', '轮播图2');
INSERT INTO `tb_system` VALUES ('banner_3', '9fdbbf40f712cae5a15673838d0c9313.jpg', '轮播图3');
INSERT INTO `tb_system` VALUES ('name', '舌尖急先锋', '平台名称');

-- ----------------------------
-- View structure for v_product
-- ----------------------------
DROP VIEW IF EXISTS `v_product`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_product` AS select `p`.`id` AS `id`,`p`.`store_id` AS `store_id`,`p`.`category_id` AS `category_id`,`c`.`name` AS `category_name`,`p`.`name` AS `name`,`p`.`price` AS `price`,`p`.`unit` AS `unit`,`p`.`description` AS `description`,`p`.`picture` AS `picture`,`p`.`create_time` AS `create_time`,`p`.`update_time` AS `update_time`,`p`.`status` AS `status` from (`tb_product` `p` join `tb_category` `c` on((`p`.`category_id` = `c`.`id`))) ;

-- ----------------------------
-- View structure for v_store_home
-- ----------------------------
DROP VIEW IF EXISTS `v_store_home`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_store_home` AS select `s`.`id` AS `store_id`,sum((case when (cast(`o`.`create_time` as date) = curdate()) then 1 else 0 end)) AS `day_orders`,(sum((case when (cast(`o`.`create_time` as date) = curdate()) then 1 else 0 end)) - (select sum((case when (cast(`o`.`create_time` as date) = (curdate() - interval 1 day)) then 1 else 0 end)) from `tb_order` `o` where (`o`.`store_id` = `s`.`id`))) AS `last_day_orders_rate`,sum((case when (cast(`o`.`create_time` as date) = curdate()) then (`o`.`total_price` - `o`.`delivery_price`) else 0 end)) AS `day_sales`,(sum((case when (cast(`o`.`create_time` as date) = curdate()) then (`o`.`total_price` - `o`.`delivery_price`) else 0 end)) - (select sum((case when (cast(`o`.`create_time` as date) = (curdate() - interval 1 day)) then (`o`.`total_price` - `o`.`delivery_price`) else 0 end)) from `tb_order` `o` where (`o`.`store_id` = `s`.`id`))) AS `last_day_sales_rate`,sum((case when ((year(`o`.`create_time`) = year(curdate())) and (month(`o`.`create_time`) = month(curdate()))) then (`o`.`total_price` - `o`.`delivery_price`) else 0 end)) AS `month_sales`,(sum((case when ((year(`o`.`create_time`) = year(curdate())) and (month(`o`.`create_time`) = month(curdate()))) then (`o`.`total_price` - `o`.`delivery_price`) else 0 end)) - (select sum((case when ((year(`o`.`create_time`) = year((curdate() - interval 1 month))) and (month(`o`.`create_time`) = month((curdate() - interval 1 month)))) then (`o`.`total_price` - `o`.`delivery_price`) else 0 end)) from `tb_order` `o` where (`o`.`store_id` = `s`.`id`))) AS `last_month_sales_rate`,(select count(0) from `tb_category` `c` where ((`c`.`store_id` = `s`.`id`) and (`c`.`status` <> '已删除'))) AS `category_number`,(select count(0) from `tb_product` `p` where ((`p`.`store_id` = `s`.`id`) and (`p`.`status` <> '已删除'))) AS `product_number`,(select count(0) from `tb_order` `o` where ((`o`.`store_id` = `s`.`id`) and (`o`.`status` <> '已删除'))) AS `order_number` from (`tb_store` `s` join `tb_order` `o` on((`o`.`store_id` = `s`.`id`))) group by `s`.`id` ;
