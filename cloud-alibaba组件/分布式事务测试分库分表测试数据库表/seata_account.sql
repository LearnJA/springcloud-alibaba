/*
 Navicat Premium Data Transfer

 Source Server         : MyDB
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : localhost:3306
 Source Schema         : seata_account

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 08/06/2020 17:03:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sp_user
-- ----------------------------
DROP TABLE IF EXISTS `sp_user`;
CREATE TABLE `sp_user`  (
  `id` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户ID',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名,不重复,可中文',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'shiro MD5密码32位',
  `state` int(11) NULL DEFAULT NULL COMMENT '1启用0停用',
  `seller_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商户ID',
  `company` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司名称',
  `nick_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '店铺名称',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建用户',
  `create_dept` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建部门',
  `update_by` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新用户',
  `dept_id` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门ID',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注字段',
  `del_flag` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据删除状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_Reference_24`(`dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sp_user
-- ----------------------------
INSERT INTO `sp_user` VALUES ('025a21b400774be28b497de95692ad6e', 'wandu', '3f723090e9b2bfbf61024e65314e57b1', 1, 'wandu', 'wandu', '万度商城', '2019-05-31 17:12:05', '2019-11-22 16:14:25', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO `sp_user` VALUES ('030afc1401374feca1784ba87efe1403', 'keleme', 'e8f9a4abce7d552e74cfc040371d9651', 1, 'keleme', '渴了么中国有限公司', '渴了么店铺', '2019-05-31 17:12:12', '2019-05-31 17:12:00', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO `sp_user` VALUES ('03922f74d5c540b3b734ff7c7189d34e', 'bokecx', 'ea8e35a4532a15b456f1bbdb90c714ed', 1, NULL, '青丝缠雪', NULL, '2019-12-24 16:05:29', NULL, NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO `sp_user` VALUES ('14469f8bb4fb47539f6e0f9c5cb5d1e3', 'nnwqiih', '4076bed4c26543edf18253e92a2acd5d', 1, NULL, NULL, NULL, '2020-05-10 14:31:31', NULL, NULL, NULL, NULL, 'dbd0205069a74e9985167655e9db5eaa', NULL, '0');
INSERT INTO `sp_user` VALUES ('1bdd499c69fc483eb8a300c125f5e8de', 'xiaomi', '57c64260de3109c2a260351c0157303b', 1, 'xiaomi', '小米中国有限公司', '小米商城', '2019-05-31 17:12:12', '2019-05-31 17:12:00', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO `sp_user` VALUES ('219728a960494aac9bb38d850d64ab29', '17683701217a', 'e10adc3949ba59abbe56e057f20f883e', 1, NULL, NULL, NULL, '2020-05-14 11:10:27', NULL, NULL, NULL, NULL, 'dbd0205069a74e9985167655e9db5eaa', NULL, '0');
INSERT INTO `sp_user` VALUES ('2f57a69f63404af9a3c40852187c8c6e', 'damai', 'd5ef3c9dc084c4965138c48b005f2f2f', 1, 'damai', '大麦中国有限公司', '大麦商城', '2019-05-31 17:12:13', '2019-05-31 17:12:00', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO `sp_user` VALUES ('418c483c2f7b4c7690c48b4eca9fed64', 'admin', '928bfd2577490322a6e19b793691467e', 1, NULL, '超级管理员', NULL, '2019-05-31 17:12:13', '2019-12-06 17:18:33', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO `sp_user` VALUES ('65b1d0fff68f4a718fa6d5ae9ec1a65e', 'bakery', '2293b6f6a29ec5b3bf4f8afdb9997ba6', 1, 'shopx5', 'shopx5商城系统', 'shopx5自营店', '2019-10-08 10:34:45', '2019-12-03 15:19:08', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO `sp_user` VALUES ('949cff69f42c4d11a9e174f0878493ef', 'bokenn', 'e95cb9a4a61f2cbe5c4616e9fb69202a', 1, NULL, '鼻涕妞妞', NULL, '2019-12-24 16:06:12', NULL, NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO `sp_user` VALUES ('dc86404e698d4705993514753b032315', 'qianxi', '322d4e719c137edc7ce39520b372f88e', 1, 'qianxi', '千禧中国有限公司', '千禧店铺', '2019-05-31 17:12:18', '2019-05-31 17:12:00', NULL, NULL, NULL, NULL, NULL, '0');

-- ----------------------------
-- Table structure for t_account
-- ----------------------------
DROP TABLE IF EXISTS `t_account`;
CREATE TABLE `t_account`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `total` decimal(18, 2) NULL DEFAULT NULL COMMENT '总额度',
  `used` decimal(18, 2) NULL DEFAULT NULL COMMENT '使用额度',
  `residue` decimal(18, 2) NULL DEFAULT 0.00 COMMENT '剩余额度',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_account
-- ----------------------------
INSERT INTO `t_account` VALUES (1, 1, 10000.00, 100.00, 10000.00);

-- ----------------------------
-- Table structure for undo_log
-- ----------------------------
DROP TABLE IF EXISTS `undo_log`;
CREATE TABLE `undo_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'increment id',
  `branch_id` bigint(20) NOT NULL COMMENT 'branch transaction id',
  `xid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'global transaction id',
  `context` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'undo_log context,such as serialization',
  `rollback_info` longblob NOT NULL COMMENT 'rollback info',
  `log_status` int(11) NOT NULL COMMENT '0:normal status,1:defense status',
  `log_created` datetime(0) NOT NULL COMMENT 'create datetime',
  `log_modified` datetime(0) NOT NULL COMMENT 'modify datetime',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ux_undo_log`(`xid`, `branch_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'AT transaction mode undo table' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
