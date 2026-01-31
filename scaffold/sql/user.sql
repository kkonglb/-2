/*
 Navicat Premium Dump SQL

 Source Server         : local-db-mysql
 Source Server Type    : MySQL
 Source Server Version : 50741 (5.7.41)
 Source Host           : localhost:3306
 Source Schema         : book-manage-sys

 Target Server Type    : MySQL
 Target Server Version : 50741 (5.7.41)
 File Encoding         : 65001

 Date: 08/12/2024 21:05:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `user_account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户账号',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `user_pwd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户密码',
  `user_avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `user_email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户邮箱',
  `user_role` int(11) NULL DEFAULT NULL COMMENT '用户角色',
  `is_login` tinyint(1) NULL DEFAULT NULL COMMENT '可登录状态(0：可用，1：不可用)',
  `is_word` tinyint(1) NULL DEFAULT NULL COMMENT '禁言状态(0：可用，1：不可用)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '用户注册时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', 'B站【程序员辰星】原创出品', '14e1b600b1fd579f47433b88e8d85291', '/api/book-manage-sys-api/v1.0/file/getFile?fileName=60c99f6Snipaste_2024-08-31_17-40-55.png', '1343243@qq.com', 1, 0, 0, '2024-12-04 12:53:05');
INSERT INTO `user` VALUES (2, 'zhangfan', '张帆', '14e1b600b1fd579f47433b88e8d85291', '/api/book-manage-sys-api/v1.0/file/getFile?fileName=ba728e7pic_6.jpg', '12311323@qq.com', 2, 0, 0, '2024-08-16 16:12:12');
INSERT INTO `user` VALUES (7, 'liran', '李冉', '14e1b600b1fd579f47433b88e8d85291', '/api/book-manage-sys-api/v1.0/file/getFile?fileName=5ee4cb8熊猫.png', '12434@qq.com', 1, 1, 1, '2024-10-19 06:39:12');
INSERT INTO `user` VALUES (8, 'lichen', '李琛', '14e1b600b1fd579f47433b88e8d85291', '/api/book-manage-sys-api/v1.0/file/getFile?fileName=109bac7pic_7.jpg', '12345@qq.com', 2, 0, 0, '2024-12-05 15:44:45');
INSERT INTO `user` VALUES (9, 'wangfangfang', '王芳芳', '14e1b600b1fd579f47433b88e8d85291', '/api/book-manage-sys-api/v1.0/file/getFile?fileName=b76542cpic_8.jpg', '1234@qq.com', 2, 0, 1, '2024-12-05 15:45:12');
INSERT INTO `user` VALUES (10, 'yuelang', '月朗', '14e1b600b1fd579f47433b88e8d85291', '/api/book-manage-sys-api/v1.0/file/getFile?fileName=c7568c2pic_5.jpg', '4532432@qq.com', 2, 0, 0, '2024-12-05 15:46:46');
INSERT INTO `user` VALUES (11, 'chenxin', '陈芯', '14e1b600b1fd579f47433b88e8d85291', '/api/book-manage-sys-api/v1.0/file/getFile?fileName=cdf71ffSnipaste_2024-11-29_18-22-44.png', '123432@qq.com', 2, 0, 0, '2024-12-05 15:47:08');
INSERT INTO `user` VALUES (12, 'hututu', '胡图图', '14e1b600b1fd579f47433b88e8d85291', '/api/book-manage-sys-api/v1.0/file/getFile?fileName=e694502Snipaste_2024-11-22_00-47-41.png', '4343@qq.com', 2, 0, 0, '2024-12-05 15:47:26');
INSERT INTO `user` VALUES (13, 'fanggui', '方贵', '14e1b600b1fd579f47433b88e8d85291', '/api/book-manage-sys-api/v1.0/file/getFile?fileName=3e28f7cSnipaste_2024-11-22_00-47-32.png', '43423@qq.com', 2, 0, 0, '2024-12-05 15:51:13');
INSERT INTO `user` VALUES (14, 'jiangxin', '江心', '14e1b600b1fd579f47433b88e8d85291', '/api/book-manage-sys-api/v1.0/file/getFile?fileName=e9a35efpic_7.jpg', '124343@qq.com', 2, 0, 0, '2024-12-05 15:54:50');
INSERT INTO `user` VALUES (15, 'moxin', '陌心', '14e1b600b1fd579f47433b88e8d85291', '/api/book-manage-sys-api/v1.0/file/getFile?fileName=be0e757Snipaste_2024-11-22_00-46-13.png', '654456@qq.com', 2, 1, 1, '2024-12-05 15:55:12');

SET FOREIGN_KEY_CHECKS = 1;
