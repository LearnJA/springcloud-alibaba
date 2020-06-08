/*
 Navicat Premium Data Transfer

 Source Server         : MyDB
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : localhost:3306
 Source Schema         : nacos_config_seata_manager

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 08/06/2020 13:59:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for branch_table
-- ----------------------------
DROP TABLE IF EXISTS `branch_table`;
CREATE TABLE `branch_table`  (
  `branch_id` bigint(20) NOT NULL,
  `xid` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `transaction_id` bigint(20) NULL DEFAULT NULL,
  `resource_group_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `resource_id` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `branch_type` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint(4) NULL DEFAULT NULL,
  `client_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `application_data` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gmt_create` datetime(6) NULL DEFAULT NULL,
  `gmt_modified` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`branch_id`) USING BTREE,
  INDEX `idx_xid`(`xid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_use` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `effect` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_schema` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfo_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 112 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info
-- ----------------------------
INSERT INTO `config_info` VALUES (4, 'nacos-config-client-dev.yaml', 'DEFAULT_GROUP', 'config:\r\n    info: nacos-config-client-dev.yaml dev version=3', '698d41a6e5f64b493bd1d02f4d31ee43', '2020-05-28 12:11:54', '2020-06-03 03:06:38', NULL, '192.168.136.1', '', '', 'null', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (5, 'nacos-config-client-dev.yaml', 'TEST_GROUP', 'config:\r\n    info: nacos-config-client-dev.yaml,TEST_GROUP version=1', '66433b6fa549b63f9b33380822c68301', '2020-05-28 12:15:32', '2020-05-28 12:15:32', NULL, '192.168.136.1', '', '', 'TEST_GROUP', NULL, NULL, 'yaml', NULL);
INSERT INTO `config_info` VALUES (15, 'nacos-config-client-dev.yaml', 'dev', 'config:\r\n    info: nacos-config-client-dev.yaml dev version=0', '0ada4159df70d6dde341d91427c3ebd6', '2020-06-03 03:32:24', '2020-06-03 12:31:32', NULL, '192.168.136.1', '', '', 'null', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (16, 'nacos-config-client-dev.yaml', 'test', 'config:\r\n    info: nacos-config-client-dev.yaml dev version=3', '698d41a6e5f64b493bd1d02f4d31ee43', '2020-06-03 03:32:37', '2020-06-03 03:32:37', NULL, '192.168.136.1', '', '', NULL, NULL, NULL, 'yaml', NULL);
INSERT INTO `config_info` VALUES (17, 'nacos-config-client-dev.yaml', 'pro', 'config:\r\n    info: nacos-config-client-dev.yaml dev version=3', '698d41a6e5f64b493bd1d02f4d31ee43', '2020-06-03 03:32:45', '2020-06-03 03:32:45', NULL, '192.168.136.1', '', '', NULL, NULL, NULL, 'yaml', NULL);
INSERT INTO `config_info` VALUES (36, 'mysql.yaml', 'dev', 'mysql:\r\n    info: mysql.yaml version=10', 'd10086fcb7e764c5a97a36ae4c6b97b4', '2020-06-03 12:34:05', '2020-06-04 01:04:48', NULL, '192.168.136.1', '', '', 'null', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (37, 'database.yaml', 'dev', 'spring:\r\n  # 多个接口上的@FeignClient(“相同服务名”)会报错，overriding is disabled。\r\n  # 设置 为true ,即 允许 同名\r\n  main:\r\n    allow-bean-definition-overriding: true\r\n  datasource:\r\n    # 使用druid数据源\r\n    type: com.alibaba.druid.pool.DruidDataSource\r\n    druid:\r\n      filters: stat,wall\r\n      min-idle: 10\r\n      initial-size: 10\r\n      max-active: 300\r\n      max-wait: 10000\r\n      validation-query: SELECT 1 FROM DUAL\r\n      test-while-idle: true\r\n      time-between-eviction-runs-millis: 60000\r\n      min-evictable-idle-time-millis: 300000\r\n      use-global-data-source-stat: true\r\n      connection-properties: druid.stat.mergeSql=true;druid.stat.slowSqlMillis=2000\r\n      web-stat-filter:\r\n        url-pattern: /*\r\n        exclusions: \'*.js,*.gif,*.jpg,*.bmp,*.png,*.css,*.ico,/druid/*\'\r\n      stat-view-servlet:\r\n        url-pattern: /druid/*\r\n        reset-enable: false\r\n        login-username: admin\r\n        login-password: 123456\r\ndatabase:\r\n    info: database.yaml version=5', '2f53de4c50e657a8cf325d6fe97dffa4', '2020-06-03 12:35:08', '2020-06-04 01:28:31', NULL, '192.168.136.1', '', '', 'null', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (46, 'transport.type', 'SEATA_GROUP', 'TCP', 'b136ef5f6a01d816991fe3cf7a6ac763', '2020-06-05 10:13:51', '2020-06-05 10:13:51', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (47, 'transport.server', 'SEATA_GROUP', 'NIO', 'b6d9dfc0fb54277321cebc0fff55df2f', '2020-06-05 10:13:51', '2020-06-05 10:13:51', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (48, 'transport.heartbeat', 'SEATA_GROUP', 'true', 'b326b5062b2f0e69046810717534cb09', '2020-06-05 10:13:51', '2020-06-05 10:13:51', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (49, 'transport.enableClientBatchSendRequest', 'SEATA_GROUP', 'false', '68934a3e9455fa72420237eb05902327', '2020-06-05 10:13:51', '2020-06-05 10:13:51', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (50, 'transport.threadFactory.bossThreadPrefix', 'SEATA_GROUP', 'NettyBoss', '0f8db59a3b7f2823f38a70c308361836', '2020-06-05 10:13:52', '2020-06-05 10:13:52', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (51, 'transport.threadFactory.workerThreadPrefix', 'SEATA_GROUP', 'NettyServerNIOWorker', 'a78ec7ef5d1631754c4e72ae8a3e9205', '2020-06-05 10:13:52', '2020-06-05 10:13:52', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (52, 'transport.threadFactory.serverExecutorThreadPrefix', 'SEATA_GROUP', 'NettyServerBizHandler', '11a36309f3d9df84fa8b59cf071fa2da', '2020-06-05 10:13:52', '2020-06-05 10:13:52', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (53, 'transport.threadFactory.shareBossWorker', 'SEATA_GROUP', 'false', '68934a3e9455fa72420237eb05902327', '2020-06-05 10:13:52', '2020-06-05 10:13:52', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (54, 'transport.threadFactory.clientSelectorThreadPrefix', 'SEATA_GROUP', 'NettyClientSelector', 'cd7ec5a06541e75f5a7913752322c3af', '2020-06-05 10:13:52', '2020-06-05 10:13:52', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (55, 'transport.threadFactory.clientSelectorThreadSize', 'SEATA_GROUP', '1', 'c4ca4238a0b923820dcc509a6f75849b', '2020-06-05 10:13:53', '2020-06-05 10:13:53', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (56, 'transport.threadFactory.clientWorkerThreadPrefix', 'SEATA_GROUP', 'NettyClientWorkerThread', '61cf4e69a56354cf72f46dc86414a57e', '2020-06-05 10:13:53', '2020-06-05 10:13:53', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (57, 'transport.threadFactory.bossThreadSize', 'SEATA_GROUP', '1', 'c4ca4238a0b923820dcc509a6f75849b', '2020-06-05 10:13:53', '2020-06-05 10:13:53', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (58, 'transport.threadFactory.workerThreadSize', 'SEATA_GROUP', 'default', 'c21f969b5f03d33d43e04f8f136e7682', '2020-06-05 10:13:53', '2020-06-05 10:13:53', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (59, 'transport.shutdown.wait', 'SEATA_GROUP', '3', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', '2020-06-05 10:13:53', '2020-06-05 10:13:53', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (60, 'service.vgroupMapping.bakery_tx_group', 'SEATA_GROUP', 'default', 'c21f969b5f03d33d43e04f8f136e7682', '2020-06-05 10:13:54', '2020-06-05 10:13:54', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (61, 'service.default.grouplist', 'SEATA_GROUP', '127.0.0.1:8091', 'c32ce0d3e264525dcdada751f98143a3', '2020-06-05 10:13:54', '2020-06-05 10:13:54', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (62, 'service.enableDegrade', 'SEATA_GROUP', 'false', '68934a3e9455fa72420237eb05902327', '2020-06-05 10:13:54', '2020-06-05 10:13:54', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (63, 'service.disableGlobalTransaction', 'SEATA_GROUP', 'false', '68934a3e9455fa72420237eb05902327', '2020-06-05 10:13:54', '2020-06-05 10:13:54', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (64, 'client.rm.asyncCommitBufferLimit', 'SEATA_GROUP', '10000', 'b7a782741f667201b54880c925faec4b', '2020-06-05 10:13:54', '2020-06-05 10:13:54', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (65, 'client.rm.lockRetryInternal', 'SEATA_GROUP', '10', 'd3d9446802a44259755d38e6d163e820', '2020-06-05 10:13:54', '2020-06-05 10:13:54', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (66, 'client.rm.lockRetryTimes', 'SEATA_GROUP', '30', '34173cb38f07f89ddbebc2ac9128303f', '2020-06-05 10:13:55', '2020-06-05 10:13:55', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (67, 'client.rm.reportRetryCount', 'SEATA_GROUP', '5', 'e4da3b7fbbce2345d7772b0674a318d5', '2020-06-05 10:13:55', '2020-06-05 10:13:55', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (68, 'client.rm.lockRetryPolicyBranchRollbackOnConflict', 'SEATA_GROUP', 'true', 'b326b5062b2f0e69046810717534cb09', '2020-06-05 10:13:55', '2020-06-05 10:13:55', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (69, 'client.rm.tableMetaCheckEnable', 'SEATA_GROUP', 'false', '68934a3e9455fa72420237eb05902327', '2020-06-05 10:13:55', '2020-06-05 10:13:55', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (70, 'client.rm.sqlParserType', 'SEATA_GROUP', 'druid', '3d650fb8a5df01600281d48c47c9fa60', '2020-06-05 10:13:55', '2020-06-05 10:13:55', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (71, 'client.rm.reportSuccessEnable', 'SEATA_GROUP', 'false', '68934a3e9455fa72420237eb05902327', '2020-06-05 10:13:55', '2020-06-05 10:13:55', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (72, 'client.tm.commitRetryCount', 'SEATA_GROUP', '5', 'e4da3b7fbbce2345d7772b0674a318d5', '2020-06-05 10:13:56', '2020-06-05 10:13:56', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (73, 'client.tm.rollbackRetryCount', 'SEATA_GROUP', '5', 'e4da3b7fbbce2345d7772b0674a318d5', '2020-06-05 10:13:56', '2020-06-05 10:13:56', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (74, 'store.mode', 'SEATA_GROUP', 'file', '8c7dd922ad47494fc02c388e12c00eac', '2020-06-05 10:13:56', '2020-06-05 10:13:56', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (75, 'store.file.dir', 'SEATA_GROUP', 'file_store/data', '6a8dec07c44c33a8a9247cba5710bbb2', '2020-06-05 10:13:56', '2020-06-05 10:13:56', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (76, 'store.file.maxBranchSessionSize', 'SEATA_GROUP', '16384', 'c76fe1d8e08462434d800487585be217', '2020-06-05 10:13:56', '2020-06-05 10:13:56', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (77, 'store.file.maxGlobalSessionSize', 'SEATA_GROUP', '512', '10a7cdd970fe135cf4f7bb55c0e3b59f', '2020-06-05 10:13:57', '2020-06-05 10:13:57', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (78, 'store.file.fileWriteBufferCacheSize', 'SEATA_GROUP', '16384', 'c76fe1d8e08462434d800487585be217', '2020-06-05 10:13:57', '2020-06-05 10:13:57', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (79, 'store.file.flushDiskMode', 'SEATA_GROUP', 'async', '0df93e34273b367bb63bad28c94c78d5', '2020-06-05 10:13:57', '2020-06-05 10:13:57', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (80, 'store.file.sessionReloadReadSize', 'SEATA_GROUP', '100', 'f899139df5e1059396431415e770c6dd', '2020-06-05 10:13:57', '2020-06-05 10:13:57', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (81, 'store.db.datasource', 'SEATA_GROUP', 'druid', '3d650fb8a5df01600281d48c47c9fa60', '2020-06-05 10:13:57', '2020-06-05 10:13:57', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (82, 'store.db.dbType', 'SEATA_GROUP', 'mysql', '81c3b080dad537de7e10e0987a4bf52e', '2020-06-05 10:13:57', '2020-06-05 10:13:57', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (83, 'store.db.driverClassName', 'SEATA_GROUP', 'com.mysql.cj.jdbc.Driver', '33763409bb7f4838bde4fae9540433e4', '2020-06-05 10:13:58', '2020-06-05 10:13:58', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (84, 'store.db.url', 'SEATA_GROUP', 'jdbc:jdbc:mysql://127.0.0.1:3306/nacos_config_seata_manager', 'eef26cb459f4f1eb41e529843c76425d', '2020-06-05 10:13:58', '2020-06-05 10:13:58', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (85, 'store.db.user', 'SEATA_GROUP', 'root', '63a9f0ea7bb98050796b649e85481845', '2020-06-05 10:13:58', '2020-06-05 10:13:58', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (86, 'store.db.password', 'SEATA_GROUP', '123456', 'e10adc3949ba59abbe56e057f20f883e', '2020-06-05 10:13:58', '2020-06-05 10:13:58', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (87, 'store.db.minConn', 'SEATA_GROUP', '1', 'c4ca4238a0b923820dcc509a6f75849b', '2020-06-05 10:13:58', '2020-06-05 10:13:58', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (88, 'store.db.maxConn', 'SEATA_GROUP', '3', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', '2020-06-05 10:13:58', '2020-06-05 10:13:58', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (89, 'store.db.globalTable', 'SEATA_GROUP', 'global_table', '8b28fb6bb4c4f984df2709381f8eba2b', '2020-06-05 10:13:59', '2020-06-05 10:13:59', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (90, 'store.db.branchTable', 'SEATA_GROUP', 'branch_table', '54bcdac38cf62e103fe115bcf46a660c', '2020-06-05 10:13:59', '2020-06-05 10:13:59', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (91, 'store.db.queryLimit', 'SEATA_GROUP', '100', 'f899139df5e1059396431415e770c6dd', '2020-06-05 10:13:59', '2020-06-05 10:13:59', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (92, 'store.db.lockTable', 'SEATA_GROUP', 'lock_table', '55e0cae3b6dc6696b768db90098b8f2f', '2020-06-05 10:13:59', '2020-06-05 10:13:59', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (93, 'server.recovery.committingRetryPeriod', 'SEATA_GROUP', '1000', 'a9b7ba70783b617e9998dc4dd82eb3c5', '2020-06-05 10:14:00', '2020-06-05 10:14:00', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (94, 'server.recovery.asynCommittingRetryPeriod', 'SEATA_GROUP', '1000', 'a9b7ba70783b617e9998dc4dd82eb3c5', '2020-06-05 10:14:00', '2020-06-05 10:14:00', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (95, 'server.recovery.rollbackingRetryPeriod', 'SEATA_GROUP', '1000', 'a9b7ba70783b617e9998dc4dd82eb3c5', '2020-06-05 10:14:00', '2020-06-05 10:14:00', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (96, 'server.recovery.timeoutRetryPeriod', 'SEATA_GROUP', '1000', 'a9b7ba70783b617e9998dc4dd82eb3c5', '2020-06-05 10:14:00', '2020-06-05 10:14:00', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (97, 'server.maxCommitRetryTimeout', 'SEATA_GROUP', '-1', '6bb61e3b7bce0931da574d19d1d82c88', '2020-06-05 10:14:00', '2020-06-05 10:14:00', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (98, 'server.maxRollbackRetryTimeout', 'SEATA_GROUP', '-1', '6bb61e3b7bce0931da574d19d1d82c88', '2020-06-05 10:14:01', '2020-06-05 10:14:01', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (99, 'server.rollbackRetryTimeoutUnlockEnable', 'SEATA_GROUP', 'false', '68934a3e9455fa72420237eb05902327', '2020-06-05 10:14:01', '2020-06-05 10:14:01', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (100, 'client.undo.dataValidation', 'SEATA_GROUP', 'true', 'b326b5062b2f0e69046810717534cb09', '2020-06-05 10:14:01', '2020-06-05 10:14:01', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (101, 'client.undo.logSerialization', 'SEATA_GROUP', 'jackson', 'b41779690b83f182acc67d6388c7bac9', '2020-06-05 10:14:01', '2020-06-05 10:14:01', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (102, 'server.undo.logSaveDays', 'SEATA_GROUP', '7', '8f14e45fceea167a5a36dedd4bea2543', '2020-06-05 10:14:01', '2020-06-05 10:14:01', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (103, 'server.undo.logDeletePeriod', 'SEATA_GROUP', '86400000', 'f4c122804fe9076cb2710f55c3c6e346', '2020-06-05 10:14:01', '2020-06-05 10:14:01', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (104, 'client.undo.logTable', 'SEATA_GROUP', 'undo_log', '2842d229c24afe9e61437135e8306614', '2020-06-05 10:14:01', '2020-06-05 10:14:01', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (105, 'client.log.exceptionRate', 'SEATA_GROUP', '100', 'f899139df5e1059396431415e770c6dd', '2020-06-05 10:14:02', '2020-06-05 10:14:02', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (106, 'transport.serialization', 'SEATA_GROUP', 'seata', 'b943081c423b9a5416a706524ee05d40', '2020-06-05 10:14:02', '2020-06-05 10:14:02', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (107, 'transport.compressor', 'SEATA_GROUP', 'none', '334c4a4c42fdb79d7ebc3e73b517e6f8', '2020-06-05 10:14:02', '2020-06-05 10:14:02', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (108, 'metrics.enabled', 'SEATA_GROUP', 'false', '68934a3e9455fa72420237eb05902327', '2020-06-05 10:14:02', '2020-06-05 10:14:02', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (109, 'metrics.registryType', 'SEATA_GROUP', 'compact', '7cf74ca49c304df8150205fc915cd465', '2020-06-05 10:14:02', '2020-06-05 10:14:02', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (110, 'metrics.exporterList', 'SEATA_GROUP', 'prometheus', 'e4f00638b8a10e6994e67af2f832d51c', '2020-06-05 10:14:02', '2020-06-05 10:14:02', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (111, 'metrics.exporterPrometheusPort', 'SEATA_GROUP', '9898', '7b9dc501afe4ee11c56a4831e20cee71', '2020-06-05 10:14:03', '2020-06-05 10:14:03', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for config_info_aggr
-- ----------------------------
DROP TABLE IF EXISTS `config_info_aggr`;
CREATE TABLE `config_info_aggr`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'datum_id',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime(0) NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfoaggr_datagrouptenantdatum`(`data_id`, `group_id`, `tenant_id`, `datum_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '增加租户字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config_info_beta
-- ----------------------------
DROP TABLE IF EXISTS `config_info_beta`;
CREATE TABLE `config_info_beta`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfobeta_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_beta' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `config_info_tag`;
CREATE TABLE `config_info_tag`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfotag_datagrouptenanttag`(`data_id`, `group_id`, `tenant_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_tag' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `config_tags_relation`;
CREATE TABLE `config_tags_relation`  (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `tag_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`) USING BTREE,
  UNIQUE INDEX `uk_configtagrelation_configidtag`(`id`, `tag_name`, `tag_type`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_tag_relation' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for global_table
-- ----------------------------
DROP TABLE IF EXISTS `global_table`;
CREATE TABLE `global_table`  (
  `xid` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `transaction_id` bigint(20) NULL DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `application_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `transaction_service_group` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `transaction_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `timeout` int(11) NULL DEFAULT NULL,
  `begin_time` bigint(20) NULL DEFAULT NULL,
  `application_data` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gmt_create` datetime(0) NULL DEFAULT NULL,
  `gmt_modified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`xid`) USING BTREE,
  INDEX `idx_gmt_modified_status`(`gmt_modified`, `status`) USING BTREE,
  INDEX `idx_transaction_id`(`transaction_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS `group_capacity`;
CREATE TABLE `group_capacity`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '集群、各Group容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info`  (
  `id` bigint(64) UNSIGNED NOT NULL,
  `nid` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `op_type` char(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`nid`) USING BTREE,
  INDEX `idx_gmt_create`(`gmt_create`) USING BTREE,
  INDEX `idx_gmt_modified`(`gmt_modified`) USING BTREE,
  INDEX `idx_did`(`data_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 115 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '多租户改造' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of his_config_info
-- ----------------------------
INSERT INTO `his_config_info` VALUES (0, 4, 'nacos-config-client-dev.yaml', 'DEFAULT_GROUP', '', 'config:\r\n    info: nacos-config-client-dev.yaml dev version=1', '850c917f5f967301c58d5626f4313026', '2020-05-28 20:11:53', '2020-05-28 12:11:54', NULL, '192.168.136.1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 5, 'nacos-config-client-dev.yaml', 'TEST_GROUP', '', 'config:\r\n    info: nacos-config-client-dev.yaml,TEST_GROUP version=1', '66433b6fa549b63f9b33380822c68301', '2020-05-28 20:15:31', '2020-05-28 12:15:32', NULL, '192.168.136.1', 'I', '');
INSERT INTO `his_config_info` VALUES (4, 6, 'nacos-config-client-dev.yaml', 'DEFAULT_GROUP', '', 'config:\r\n    info: nacos-config-client-dev.yaml dev version=1', '850c917f5f967301c58d5626f4313026', '2020-06-03 09:41:01', '2020-06-03 01:41:01', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (4, 7, 'nacos-config-client-dev.yaml', 'DEFAULT_GROUP', '', 'config:\r\n    info: nacos-config-client-dev.yaml dev version=2', '64ba29380671c824a36b08845a2cf645', '2020-06-03 09:43:28', '2020-06-03 01:43:28', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (4, 8, 'nacos-config-client-dev.yaml', 'DEFAULT_GROUP', '', 'config:\r\n    info: nacos-config-client-dev.yaml dev version=3', '698d41a6e5f64b493bd1d02f4d31ee43', '2020-06-03 09:47:17', '2020-06-03 01:47:17', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (4, 9, 'nacos-config-client-dev.yaml', 'DEFAULT_GROUP', '', 'config:\r\n    info: nacos-config-client-dev.yaml dev version=4', '7c4c444f8b3b269841007dd8a4514693', '2020-06-03 09:51:09', '2020-06-03 01:51:10', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (4, 10, 'nacos-config-client-dev.yaml', 'DEFAULT_GROUP', '', 'config:\r\n    info: nacos-config-client-dev.yaml dev version=5', 'c3dc732e3efa2390e70f72958fc502b0', '2020-06-03 10:09:45', '2020-06-03 02:09:45', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (4, 11, 'nacos-config-client-dev.yaml', 'DEFAULT_GROUP', '', 'config:\r\n    info: nacos-config-client-dev.yaml dev version=6', '8dd35190d81f8ef2f43440353ab2edca', '2020-06-03 10:19:42', '2020-06-03 02:19:43', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (4, 12, 'nacos-config-client-dev.yaml', 'DEFAULT_GROUP', '', 'config:\r\n    info: nacos-config-client-dev.yaml dev version=7', 'd9f24c6cfe588882b3b06c3459a9d54c', '2020-06-03 10:56:14', '2020-06-03 02:56:15', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (4, 13, 'nacos-config-client-dev.yaml', 'DEFAULT_GROUP', '', 'config:\r\n    info: nacos-config-client-dev.yaml dev version=1', '850c917f5f967301c58d5626f4313026', '2020-06-03 10:58:21', '2020-06-03 02:58:21', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (4, 14, 'nacos-config-client-dev.yaml', 'DEFAULT_GROUP', '', 'config:\r\n    info: nacos-config-client-dev.yaml dev version=2', '64ba29380671c824a36b08845a2cf645', '2020-06-03 11:06:38', '2020-06-03 03:06:38', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (0, 15, 'nacos-config-client-dev.yaml', 'dev', '', 'config:\r\n    info: nacos-config-client-dev.yaml dev version=3', '698d41a6e5f64b493bd1d02f4d31ee43', '2020-06-03 11:32:23', '2020-06-03 03:32:24', NULL, '192.168.136.1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 16, 'nacos-config-client-dev.yaml', 'test', '', 'config:\r\n    info: nacos-config-client-dev.yaml dev version=3', '698d41a6e5f64b493bd1d02f4d31ee43', '2020-06-03 11:32:36', '2020-06-03 03:32:37', NULL, '192.168.136.1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 17, 'nacos-config-client-dev.yaml', 'pro', '', 'config:\r\n    info: nacos-config-client-dev.yaml dev version=3', '698d41a6e5f64b493bd1d02f4d31ee43', '2020-06-03 11:32:45', '2020-06-03 03:32:45', NULL, '192.168.136.1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 18, 'userService-dev.yaml', 'dev', '', 'config:\r\n    info: userService-dev.yaml dev version=3', '05be2daec139c04d8eef8590f5815940', '2020-06-03 16:28:12', '2020-06-03 08:28:12', NULL, '192.168.136.1', 'I', '');
INSERT INTO `his_config_info` VALUES (18, 19, 'userService-dev.yaml', 'dev', '', 'config:\r\n    info: userService-dev.yaml dev version=3', '05be2daec139c04d8eef8590f5815940', '2020-06-03 16:31:58', '2020-06-03 08:31:58', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (15, 20, 'nacos-config-client-dev.yaml', 'dev', '', 'config:\r\n    info: nacos-config-client-dev.yaml dev version=3', '698d41a6e5f64b493bd1d02f4d31ee43', '2020-06-03 16:33:38', '2020-06-03 08:33:39', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (18, 21, 'userService-dev.yaml', 'dev', '', 'user:\r\n    info: userService-dev.yaml dev version=3', '2dc5db449c43388e96552072a6a75aba', '2020-06-03 16:34:04', '2020-06-03 08:34:04', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (0, 22, 'orderService-dev.yaml', 'dev', '', 'user:\r\n    info: userService-dev.yaml dev version=5', '15edaf44b2cc282f58e720d25329ed98', '2020-06-03 16:34:56', '2020-06-03 08:34:56', NULL, '192.168.136.1', 'I', '');
INSERT INTO `his_config_info` VALUES (22, 23, 'orderService-dev.yaml', 'dev', '', 'user:\r\n    info: userService-dev.yaml dev version=5', '15edaf44b2cc282f58e720d25329ed98', '2020-06-03 16:50:31', '2020-06-03 08:50:32', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (22, 24, 'orderService-dev.yaml', 'dev', '', 'order:\r\n    info: userService-dev.yaml dev version=5', '88832f2c5506d49d2212ac79d1293e30', '2020-06-03 16:52:31', '2020-06-03 08:52:32', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (22, 25, 'orderService-dev.yaml', 'dev', '', 'order:\r\n    info: userService-dev.yaml dev version=5', '88832f2c5506d49d2212ac79d1293e30', '2020-06-03 16:54:23', '2020-06-03 08:54:24', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (22, 26, 'orderService-dev.yaml', 'dev', '', 'order:\r\n    info: orderService-dev.yaml dev version=5', 'fbe399ea35a6dcc161508a878c5c0de0', '2020-06-03 16:55:27', '2020-06-03 08:55:28', NULL, '192.168.136.1', 'D', '');
INSERT INTO `his_config_info` VALUES (0, 27, 'orderService-dev.yaml', 'dev', '', 'order:\r\n    info: orderService-dev.yaml dev version=5', 'fbe399ea35a6dcc161508a878c5c0de0', '2020-06-03 16:56:14', '2020-06-03 08:56:14', NULL, '192.168.136.1', 'I', '');
INSERT INTO `his_config_info` VALUES (18, 28, 'userService-dev.yaml', 'dev', '', 'user:\r\n    info: userService-dev.yaml dev version=5', '15edaf44b2cc282f58e720d25329ed98', '2020-06-03 17:05:52', '2020-06-03 09:05:52', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (15, 29, 'nacos-config-client-dev.yaml', 'dev', '', 'config:\r\n    info: nacos-config-client-dev.yaml dev version=5', 'c3dc732e3efa2390e70f72958fc502b0', '2020-06-03 17:07:05', '2020-06-03 09:07:05', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (18, 30, 'userService-dev.yaml', 'dev', '', 'user:\r\n    info: userService-dev.yaml dev version=1', '47bc8233994f2223126c21a206e6ce11', '2020-06-03 17:45:10', '2020-06-03 09:45:11', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (18, 31, 'userService-dev.yaml', 'dev', '', 'user:\r\n    info: userService-dev.yaml dev version=3', '2dc5db449c43388e96552072a6a75aba', '2020-06-03 17:46:46', '2020-06-03 09:46:46', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (18, 32, 'userService-dev.yaml', 'dev', '', 'user:\r\n    info: userService-dev.yaml dev version=4', '3b8a6a0875b80fa045cc4b72f8d58a12', '2020-06-03 17:48:10', '2020-06-03 09:48:10', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (18, 33, 'userService-dev.yaml', 'dev', '', 'user:\r\n    info: userService-dev.yaml dev version=5', '15edaf44b2cc282f58e720d25329ed98', '2020-06-03 17:57:35', '2020-06-03 09:57:36', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (18, 34, 'userService-dev.yaml', 'dev', '', 'user:\r\n    info: userService-dev.yaml dev version=6', '979fdec1f090dd44e7e64675ffb9fb4d', '2020-06-03 20:16:31', '2020-06-03 12:16:32', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (18, 35, 'userService-dev.yaml', 'dev', '', 'user:\r\n    info: userService-dev.yaml dev version=1', '47bc8233994f2223126c21a206e6ce11', '2020-06-03 20:30:18', '2020-06-03 12:30:18', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (15, 36, 'nacos-config-client-dev.yaml', 'dev', '', 'config:\r\n    info: nacos-config-client-dev.yaml dev version=1', '850c917f5f967301c58d5626f4313026', '2020-06-03 20:31:31', '2020-06-03 12:31:32', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (26, 37, 'orderService-dev.yaml', 'dev', '', 'order:\r\n    info: orderService-dev.yaml dev version=5', 'fbe399ea35a6dcc161508a878c5c0de0', '2020-06-03 20:32:58', '2020-06-03 12:32:59', NULL, '192.168.136.1', 'D', '');
INSERT INTO `his_config_info` VALUES (18, 38, 'userService-dev.yaml', 'dev', '', 'user:\r\n    info: userService-dev.yaml dev version=2', 'c8085bb4260b36a1df51bb24953deecb', '2020-06-03 20:33:03', '2020-06-03 12:33:03', NULL, '192.168.136.1', 'D', '');
INSERT INTO `his_config_info` VALUES (0, 39, 'mysql.yaml', 'dev', '', 'myaql:\r\n    info: mysql.yaml version=0', 'f6636379b31d2cbab58a8d5e7d377347', '2020-06-03 20:34:05', '2020-06-03 12:34:05', NULL, '192.168.136.1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 40, 'database.yaml', 'dev', '', 'database:\r\n    info: database.yaml version=0', '4a58c60a9d8a015025682c5129debe61', '2020-06-03 20:35:08', '2020-06-03 12:35:08', NULL, '192.168.136.1', 'I', '');
INSERT INTO `his_config_info` VALUES (37, 41, 'database.yaml', 'dev', '', 'database:\r\n    info: database.yaml version=0', '4a58c60a9d8a015025682c5129debe61', '2020-06-03 22:37:37', '2020-06-03 14:37:38', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (36, 42, 'mysql.yaml', 'dev', '', 'myaql:\r\n    info: mysql.yaml version=0', 'f6636379b31d2cbab58a8d5e7d377347', '2020-06-03 22:38:03', '2020-06-03 14:38:04', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (36, 43, 'mysql.yaml', 'dev', '', 'mysql:\r\n    info: mysql.yaml version=0', 'a3978b3a151f1cc4af0af3cdbf18d7bb', '2020-06-03 22:38:36', '2020-06-03 14:38:36', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (36, 44, 'mysql.yaml', 'dev', '', 'mysql:\r\n    info: mysql.yaml version=0', 'a3978b3a151f1cc4af0af3cdbf18d7bb', '2020-06-03 22:39:01', '2020-06-03 14:39:02', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (37, 45, 'database.yaml', 'dev', '', 'database:\r\n    info: database.yaml version=1', '80c8f0a11dc9e56cf50cdea87a9da5d1', '2020-06-03 22:39:34', '2020-06-03 14:39:35', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (37, 46, 'database.yaml', 'dev', '', 'database:\r\n    info: database.yaml version=2', '13135630f15d5bf0537ebfc6d415d909', '2020-06-04 09:04:28', '2020-06-04 01:04:29', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (36, 47, 'mysql.yaml', 'dev', '', 'mysql:\r\n    info: mysql.yaml version=22', '982cebe14c143343a08c8b43ae9f2986', '2020-06-04 09:04:48', '2020-06-04 01:04:48', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (37, 48, 'database.yaml', 'dev', '', 'database:\r\n    info: database.yaml version=5', 'fe3553c3f0d397fc6a3135097152bd2b', '2020-06-04 09:28:31', '2020-06-04 01:28:31', NULL, '192.168.136.1', 'U', '');
INSERT INTO `his_config_info` VALUES (0, 49, 'transport.type', 'SEATA_GROUP', '', 'TCP', 'b136ef5f6a01d816991fe3cf7a6ac763', '2020-06-05 18:13:50', '2020-06-05 10:13:51', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 50, 'transport.server', 'SEATA_GROUP', '', 'NIO', 'b6d9dfc0fb54277321cebc0fff55df2f', '2020-06-05 18:13:51', '2020-06-05 10:13:51', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 51, 'transport.heartbeat', 'SEATA_GROUP', '', 'true', 'b326b5062b2f0e69046810717534cb09', '2020-06-05 18:13:51', '2020-06-05 10:13:51', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 52, 'transport.enableClientBatchSendRequest', 'SEATA_GROUP', '', 'false', '68934a3e9455fa72420237eb05902327', '2020-06-05 18:13:51', '2020-06-05 10:13:51', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 53, 'transport.threadFactory.bossThreadPrefix', 'SEATA_GROUP', '', 'NettyBoss', '0f8db59a3b7f2823f38a70c308361836', '2020-06-05 18:13:51', '2020-06-05 10:13:52', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 54, 'transport.threadFactory.workerThreadPrefix', 'SEATA_GROUP', '', 'NettyServerNIOWorker', 'a78ec7ef5d1631754c4e72ae8a3e9205', '2020-06-05 18:13:51', '2020-06-05 10:13:52', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 55, 'transport.threadFactory.serverExecutorThreadPrefix', 'SEATA_GROUP', '', 'NettyServerBizHandler', '11a36309f3d9df84fa8b59cf071fa2da', '2020-06-05 18:13:52', '2020-06-05 10:13:52', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 56, 'transport.threadFactory.shareBossWorker', 'SEATA_GROUP', '', 'false', '68934a3e9455fa72420237eb05902327', '2020-06-05 18:13:52', '2020-06-05 10:13:52', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 57, 'transport.threadFactory.clientSelectorThreadPrefix', 'SEATA_GROUP', '', 'NettyClientSelector', 'cd7ec5a06541e75f5a7913752322c3af', '2020-06-05 18:13:52', '2020-06-05 10:13:52', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 58, 'transport.threadFactory.clientSelectorThreadSize', 'SEATA_GROUP', '', '1', 'c4ca4238a0b923820dcc509a6f75849b', '2020-06-05 18:13:52', '2020-06-05 10:13:53', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 59, 'transport.threadFactory.clientWorkerThreadPrefix', 'SEATA_GROUP', '', 'NettyClientWorkerThread', '61cf4e69a56354cf72f46dc86414a57e', '2020-06-05 18:13:52', '2020-06-05 10:13:53', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 60, 'transport.threadFactory.bossThreadSize', 'SEATA_GROUP', '', '1', 'c4ca4238a0b923820dcc509a6f75849b', '2020-06-05 18:13:52', '2020-06-05 10:13:53', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 61, 'transport.threadFactory.workerThreadSize', 'SEATA_GROUP', '', 'default', 'c21f969b5f03d33d43e04f8f136e7682', '2020-06-05 18:13:53', '2020-06-05 10:13:53', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 62, 'transport.shutdown.wait', 'SEATA_GROUP', '', '3', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', '2020-06-05 18:13:53', '2020-06-05 10:13:53', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 63, 'service.vgroupMapping.bakery_tx_group', 'SEATA_GROUP', '', 'default', 'c21f969b5f03d33d43e04f8f136e7682', '2020-06-05 18:13:53', '2020-06-05 10:13:54', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 64, 'service.default.grouplist', 'SEATA_GROUP', '', '127.0.0.1:8091', 'c32ce0d3e264525dcdada751f98143a3', '2020-06-05 18:13:53', '2020-06-05 10:13:54', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 65, 'service.enableDegrade', 'SEATA_GROUP', '', 'false', '68934a3e9455fa72420237eb05902327', '2020-06-05 18:13:53', '2020-06-05 10:13:54', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 66, 'service.disableGlobalTransaction', 'SEATA_GROUP', '', 'false', '68934a3e9455fa72420237eb05902327', '2020-06-05 18:13:54', '2020-06-05 10:13:54', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 67, 'client.rm.asyncCommitBufferLimit', 'SEATA_GROUP', '', '10000', 'b7a782741f667201b54880c925faec4b', '2020-06-05 18:13:54', '2020-06-05 10:13:54', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 68, 'client.rm.lockRetryInternal', 'SEATA_GROUP', '', '10', 'd3d9446802a44259755d38e6d163e820', '2020-06-05 18:13:54', '2020-06-05 10:13:54', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 69, 'client.rm.lockRetryTimes', 'SEATA_GROUP', '', '30', '34173cb38f07f89ddbebc2ac9128303f', '2020-06-05 18:13:54', '2020-06-05 10:13:55', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 70, 'client.rm.reportRetryCount', 'SEATA_GROUP', '', '5', 'e4da3b7fbbce2345d7772b0674a318d5', '2020-06-05 18:13:54', '2020-06-05 10:13:55', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 71, 'client.rm.lockRetryPolicyBranchRollbackOnConflict', 'SEATA_GROUP', '', 'true', 'b326b5062b2f0e69046810717534cb09', '2020-06-05 18:13:55', '2020-06-05 10:13:55', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 72, 'client.rm.tableMetaCheckEnable', 'SEATA_GROUP', '', 'false', '68934a3e9455fa72420237eb05902327', '2020-06-05 18:13:55', '2020-06-05 10:13:55', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 73, 'client.rm.sqlParserType', 'SEATA_GROUP', '', 'druid', '3d650fb8a5df01600281d48c47c9fa60', '2020-06-05 18:13:55', '2020-06-05 10:13:55', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 74, 'client.rm.reportSuccessEnable', 'SEATA_GROUP', '', 'false', '68934a3e9455fa72420237eb05902327', '2020-06-05 18:13:55', '2020-06-05 10:13:55', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 75, 'client.tm.commitRetryCount', 'SEATA_GROUP', '', '5', 'e4da3b7fbbce2345d7772b0674a318d5', '2020-06-05 18:13:55', '2020-06-05 10:13:56', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 76, 'client.tm.rollbackRetryCount', 'SEATA_GROUP', '', '5', 'e4da3b7fbbce2345d7772b0674a318d5', '2020-06-05 18:13:55', '2020-06-05 10:13:56', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 77, 'store.mode', 'SEATA_GROUP', '', 'file', '8c7dd922ad47494fc02c388e12c00eac', '2020-06-05 18:13:55', '2020-06-05 10:13:56', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 78, 'store.file.dir', 'SEATA_GROUP', '', 'file_store/data', '6a8dec07c44c33a8a9247cba5710bbb2', '2020-06-05 18:13:56', '2020-06-05 10:13:56', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 79, 'store.file.maxBranchSessionSize', 'SEATA_GROUP', '', '16384', 'c76fe1d8e08462434d800487585be217', '2020-06-05 18:13:56', '2020-06-05 10:13:56', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 80, 'store.file.maxGlobalSessionSize', 'SEATA_GROUP', '', '512', '10a7cdd970fe135cf4f7bb55c0e3b59f', '2020-06-05 18:13:56', '2020-06-05 10:13:57', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 81, 'store.file.fileWriteBufferCacheSize', 'SEATA_GROUP', '', '16384', 'c76fe1d8e08462434d800487585be217', '2020-06-05 18:13:56', '2020-06-05 10:13:57', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 82, 'store.file.flushDiskMode', 'SEATA_GROUP', '', 'async', '0df93e34273b367bb63bad28c94c78d5', '2020-06-05 18:13:56', '2020-06-05 10:13:57', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 83, 'store.file.sessionReloadReadSize', 'SEATA_GROUP', '', '100', 'f899139df5e1059396431415e770c6dd', '2020-06-05 18:13:57', '2020-06-05 10:13:57', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 84, 'store.db.datasource', 'SEATA_GROUP', '', 'druid', '3d650fb8a5df01600281d48c47c9fa60', '2020-06-05 18:13:57', '2020-06-05 10:13:57', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 85, 'store.db.dbType', 'SEATA_GROUP', '', 'mysql', '81c3b080dad537de7e10e0987a4bf52e', '2020-06-05 18:13:57', '2020-06-05 10:13:57', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 86, 'store.db.driverClassName', 'SEATA_GROUP', '', 'com.mysql.cj.jdbc.Driver', '33763409bb7f4838bde4fae9540433e4', '2020-06-05 18:13:57', '2020-06-05 10:13:58', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 87, 'store.db.url', 'SEATA_GROUP', '', 'jdbc:jdbc:mysql://127.0.0.1:3306/nacos_config_seata_manager', 'eef26cb459f4f1eb41e529843c76425d', '2020-06-05 18:13:57', '2020-06-05 10:13:58', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 88, 'store.db.user', 'SEATA_GROUP', '', 'root', '63a9f0ea7bb98050796b649e85481845', '2020-06-05 18:13:57', '2020-06-05 10:13:58', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 89, 'store.db.password', 'SEATA_GROUP', '', '123456', 'e10adc3949ba59abbe56e057f20f883e', '2020-06-05 18:13:58', '2020-06-05 10:13:58', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 90, 'store.db.minConn', 'SEATA_GROUP', '', '1', 'c4ca4238a0b923820dcc509a6f75849b', '2020-06-05 18:13:58', '2020-06-05 10:13:58', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 91, 'store.db.maxConn', 'SEATA_GROUP', '', '3', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', '2020-06-05 18:13:58', '2020-06-05 10:13:58', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 92, 'store.db.globalTable', 'SEATA_GROUP', '', 'global_table', '8b28fb6bb4c4f984df2709381f8eba2b', '2020-06-05 18:13:58', '2020-06-05 10:13:59', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 93, 'store.db.branchTable', 'SEATA_GROUP', '', 'branch_table', '54bcdac38cf62e103fe115bcf46a660c', '2020-06-05 18:13:59', '2020-06-05 10:13:59', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 94, 'store.db.queryLimit', 'SEATA_GROUP', '', '100', 'f899139df5e1059396431415e770c6dd', '2020-06-05 18:13:59', '2020-06-05 10:13:59', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 95, 'store.db.lockTable', 'SEATA_GROUP', '', 'lock_table', '55e0cae3b6dc6696b768db90098b8f2f', '2020-06-05 18:13:59', '2020-06-05 10:13:59', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 96, 'server.recovery.committingRetryPeriod', 'SEATA_GROUP', '', '1000', 'a9b7ba70783b617e9998dc4dd82eb3c5', '2020-06-05 18:13:59', '2020-06-05 10:14:00', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 97, 'server.recovery.asynCommittingRetryPeriod', 'SEATA_GROUP', '', '1000', 'a9b7ba70783b617e9998dc4dd82eb3c5', '2020-06-05 18:13:59', '2020-06-05 10:14:00', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 98, 'server.recovery.rollbackingRetryPeriod', 'SEATA_GROUP', '', '1000', 'a9b7ba70783b617e9998dc4dd82eb3c5', '2020-06-05 18:14:00', '2020-06-05 10:14:00', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 99, 'server.recovery.timeoutRetryPeriod', 'SEATA_GROUP', '', '1000', 'a9b7ba70783b617e9998dc4dd82eb3c5', '2020-06-05 18:14:00', '2020-06-05 10:14:00', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 100, 'server.maxCommitRetryTimeout', 'SEATA_GROUP', '', '-1', '6bb61e3b7bce0931da574d19d1d82c88', '2020-06-05 18:14:00', '2020-06-05 10:14:00', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 101, 'server.maxRollbackRetryTimeout', 'SEATA_GROUP', '', '-1', '6bb61e3b7bce0931da574d19d1d82c88', '2020-06-05 18:14:00', '2020-06-05 10:14:01', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 102, 'server.rollbackRetryTimeoutUnlockEnable', 'SEATA_GROUP', '', 'false', '68934a3e9455fa72420237eb05902327', '2020-06-05 18:14:00', '2020-06-05 10:14:01', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 103, 'client.undo.dataValidation', 'SEATA_GROUP', '', 'true', 'b326b5062b2f0e69046810717534cb09', '2020-06-05 18:14:00', '2020-06-05 10:14:01', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 104, 'client.undo.logSerialization', 'SEATA_GROUP', '', 'jackson', 'b41779690b83f182acc67d6388c7bac9', '2020-06-05 18:14:00', '2020-06-05 10:14:01', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 105, 'server.undo.logSaveDays', 'SEATA_GROUP', '', '7', '8f14e45fceea167a5a36dedd4bea2543', '2020-06-05 18:14:01', '2020-06-05 10:14:01', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 106, 'server.undo.logDeletePeriod', 'SEATA_GROUP', '', '86400000', 'f4c122804fe9076cb2710f55c3c6e346', '2020-06-05 18:14:01', '2020-06-05 10:14:01', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 107, 'client.undo.logTable', 'SEATA_GROUP', '', 'undo_log', '2842d229c24afe9e61437135e8306614', '2020-06-05 18:14:01', '2020-06-05 10:14:01', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 108, 'client.log.exceptionRate', 'SEATA_GROUP', '', '100', 'f899139df5e1059396431415e770c6dd', '2020-06-05 18:14:01', '2020-06-05 10:14:02', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 109, 'transport.serialization', 'SEATA_GROUP', '', 'seata', 'b943081c423b9a5416a706524ee05d40', '2020-06-05 18:14:01', '2020-06-05 10:14:02', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 110, 'transport.compressor', 'SEATA_GROUP', '', 'none', '334c4a4c42fdb79d7ebc3e73b517e6f8', '2020-06-05 18:14:01', '2020-06-05 10:14:02', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 111, 'metrics.enabled', 'SEATA_GROUP', '', 'false', '68934a3e9455fa72420237eb05902327', '2020-06-05 18:14:02', '2020-06-05 10:14:02', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 112, 'metrics.registryType', 'SEATA_GROUP', '', 'compact', '7cf74ca49c304df8150205fc915cd465', '2020-06-05 18:14:02', '2020-06-05 10:14:02', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 113, 'metrics.exporterList', 'SEATA_GROUP', '', 'prometheus', 'e4f00638b8a10e6994e67af2f832d51c', '2020-06-05 18:14:02', '2020-06-05 10:14:02', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 114, 'metrics.exporterPrometheusPort', 'SEATA_GROUP', '', '9898', '7b9dc501afe4ee11c56a4831e20cee71', '2020-06-05 18:14:02', '2020-06-05 10:14:03', NULL, '0:0:0:0:0:0:0:1', 'I', '');

-- ----------------------------
-- Table structure for lock_table
-- ----------------------------
DROP TABLE IF EXISTS `lock_table`;
CREATE TABLE `lock_table`  (
  `row_key` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `xid` varchar(96) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `transaction_id` bigint(20) NULL DEFAULT NULL,
  `branch_id` bigint(20) NOT NULL,
  `resource_id` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `table_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pk` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gmt_create` datetime(0) NULL DEFAULT NULL,
  `gmt_modified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`row_key`) USING BTREE,
  INDEX `idx_branch_id`(`branch_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `role` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `resource` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `action` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  UNIQUE INDEX `uk_role_permission`(`role`, `resource`, `action`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  UNIQUE INDEX `idx_user_role`(`username`, `role`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('nacos', 'ROLE_ADMIN');

-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS `tenant_capacity`;
CREATE TABLE `tenant_capacity`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数',
  `max_aggr_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '租户容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS `tenant_info`;
CREATE TABLE `tenant_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint(20) NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint(20) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_info_kptenantid`(`kp`, `tenant_id`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'tenant_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', 1);

SET FOREIGN_KEY_CHECKS = 1;
