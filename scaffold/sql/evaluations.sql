/*
 Navicat Premium Dump SQL

 Source Server         : local-db-mysql
 Source Server Type    : MySQL
 Source Server Version : 50741 (5.7.41)
 Source Host           : localhost:3306
 Source Schema         : food_share

 Target Server Type    : MySQL
 Target Server Version : 50741 (5.7.41)
 File Encoding         : 65001

 Date: 08/12/2024 21:16:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for evaluations
-- ----------------------------
DROP TABLE IF EXISTS `evaluations`;
CREATE TABLE `evaluations`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '父级评论ID',
  `commenter_id` int(11) NULL DEFAULT NULL COMMENT '评论者ID',
  `replier_id` int(11) NULL DEFAULT NULL COMMENT '回复者ID',
  `content_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '内容类型',
  `content_id` int(11) NULL DEFAULT NULL COMMENT '内容ID',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '评论内容',
  `upvote_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '点赞列表，以\",\"分割',
  `create_time` datetime NULL DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 147 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of evaluations
-- ----------------------------
INSERT INTO `evaluations` VALUES (4, NULL, 8, NULL, 'FOOD', 10, '我也遇到过这种问题', '1,7,8', '2024-05-23 11:33:01');
INSERT INTO `evaluations` VALUES (7, 4, 3, NULL, 'FOOD', 10, '大侠风范', '1,7,8,3', '2024-06-08 17:06:19');
INSERT INTO `evaluations` VALUES (8, 1, 3, 3, 'FOOD', 10, '一派胡言', '1,7,8', '2024-06-08 17:06:19');
INSERT INTO `evaluations` VALUES (13, 1, 3, 7, 'FOOD', 10, '这么神奇？', '1,8', '2024-06-08 17:06:19');
INSERT INTO `evaluations` VALUES (14, NULL, 8, 3, 'FOOD', 10, '大哥，我服了！', '1,8', '2024-06-08 17:06:19');
INSERT INTO `evaluations` VALUES (23, NULL, 3, NULL, 'FOOD', 10, '我的评论', '3', '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (27, 23, 3, 3, 'FOOD', 10, '什么事情', '3', '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (29, 14, 3, NULL, 'FOOD', 10, '先生。', '3', '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (40, NULL, 3, NULL, 'FOOD', 19, '测试评论啊', '3', '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (44, 40, 3, NULL, 'FOOD', 19, '回复', NULL, '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (45, 40, 3, 3, 'FOOD', 19, '回复', '3', '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (47, 40, 3, 3, 'FOOD', 19, '测试UU', '3', '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (49, NULL, 3, NULL, 'FOOD', 10, 'UUUIII', NULL, '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (50, 49, 3, NULL, 'FOOD', 10, '就是', NULL, '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (51, 4, 3, NULL, 'FOOD', 10, '就是', NULL, '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (52, 4, 3, 8, 'FOOD', 10, '哈哈哈', '3', '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (53, 49, 3, 3, 'FOOD', 10, '哈哈哈', '8', '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (54, NULL, 3, NULL, 'FOOD', 18, '测试', NULL, '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (55, 54, 3, NULL, 'FOOD', 18, 'niaho ', NULL, '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (58, 57, 3, NULL, 'FOOD', 19, '4324234', NULL, '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (59, 57, 3, 3, 'FOOD', 19, '54354354', NULL, '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (61, NULL, 3, NULL, 'FOOD', 19, '432432423', NULL, '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (83, NULL, 3, NULL, 'FOOD', 13, '健康', NULL, '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (84, NULL, 3, NULL, 'FOOD', 13, '丝滑', NULL, '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (85, NULL, 3, NULL, 'FOOD', 14, '哈哈哈哈哈', NULL, '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (87, NULL, 3, NULL, 'FOOD', 16, '？？？', NULL, '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (88, NULL, 3, NULL, 'FOOD', 16, '好好说话', NULL, '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (89, NULL, 3, NULL, 'FOOD', 19, '12121', '3', '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (90, 89, 3, NULL, 'FOOD', 19, '同意同意', NULL, '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (116, NULL, 9, NULL, 'FOOD', 3, '这是指标的评论！', NULL, '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (117, NULL, 9, NULL, 'FOOD', 5, '3232', NULL, '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (118, 117, 9, NULL, 'FOOD', 5, '4324324', NULL, '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (119, NULL, 9, NULL, 'FOOD', 12, '3342143', '9', '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (120, 119, 9, NULL, 'FOOD', 12, '43243243', '9', '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (121, 119, 9, 9, 'FOOD', 12, '432423432', '9', '2024-10-24 15:04:19');
INSERT INTO `evaluations` VALUES (122, NULL, 8, NULL, 'FOOD', 7, '好玩吗？？？', '10', '2024-11-13 23:02:43');
INSERT INTO `evaluations` VALUES (123, 122, 10, NULL, 'FOOD', 7, '真的好玩', '8', '2024-11-13 23:03:29');
INSERT INTO `evaluations` VALUES (124, 122, 8, 10, 'FOOD', 7, '什么时候去的？', '8', '2024-11-13 23:03:51');
INSERT INTO `evaluations` VALUES (127, 125, 3, 8, 'FOOD', 4, '真好啊', '8', '2024-11-14 15:46:07');
INSERT INTO `evaluations` VALUES (131, NULL, 8, NULL, 'FOOD', 6, '这里的风景怎么样？', NULL, '2024-11-16 19:02:12');
INSERT INTO `evaluations` VALUES (132, 131, 3, NULL, 'FOOD', 6, '真不错', NULL, '2024-11-16 19:02:46');
INSERT INTO `evaluations` VALUES (134, 133, 8, NULL, 'FOOD', 6, '我去过了', NULL, '2024-11-16 19:03:53');
INSERT INTO `evaluations` VALUES (135, NULL, 8, NULL, 'GOURMET', 6, '好不好做？', '8', '2024-11-27 21:53:37');
INSERT INTO `evaluations` VALUES (136, 135, 8, NULL, 'GOURMET', 6, '真的不错', NULL, '2024-11-27 21:53:48');
INSERT INTO `evaluations` VALUES (137, NULL, 8, NULL, 'GOURMET', 7, '4324324', NULL, '2024-11-28 14:30:04');
INSERT INTO `evaluations` VALUES (138, NULL, 8, NULL, 'GOURMET', 5, '4324324', '9', '2024-11-28 16:09:28');
INSERT INTO `evaluations` VALUES (139, NULL, 8, NULL, 'COOKBOOK', 4, '在一个小碗中，将适量生抽、老抽（少量，以免颜色过深）、冰糖、八角、桂皮、香叶和足够覆盖肉块的清水混合均匀，制成调味汁。\n将调味汁倒入砂锅中，确保液体能够没过肉块的一半至三分之二处。', NULL, '2024-11-30 20:49:59');
INSERT INTO `evaluations` VALUES (140, NULL, 8, NULL, 'COOKBOOK', 4, '真好吃', '8', '2024-11-30 20:50:04');
INSERT INTO `evaluations` VALUES (141, 140, 8, NULL, 'COOKBOOK', 4, '攒了赞了', '8', '2024-11-30 20:50:11');
INSERT INTO `evaluations` VALUES (142, NULL, 8, NULL, 'GOURMET', 4, '测试评论', NULL, '2024-12-04 18:10:37');
INSERT INTO `evaluations` VALUES (143, 138, 9, NULL, 'GOURMET', 5, '复刻了吗？', NULL, '2024-12-04 18:15:50');
INSERT INTO `evaluations` VALUES (145, NULL, 8, NULL, 'GOURMET', 11, '到底是谁发明的这个喝法！谢谢啊～ 真的又简单又好喝！以后谁还去奶茶店啊！ 红茶➕白糖炒一炒，炒到焦黄冒泡泡，加一点水煮开，最后倒牛奶就完成啦！（全程小火，糖炒的焦黄冒泡就赶紧加水！', '8', '2024-12-04 18:47:27');
INSERT INTO `evaluations` VALUES (146, 145, 8, NULL, 'GOURMET', 11, '！到底是谁发明的这个喝法！谢', '8', '2024-12-04 18:47:37');

SET FOREIGN_KEY_CHECKS = 1;
