/*
Navicat MySQL Data Transfer

Source Server         : wzh
Source Server Version : 80024
Source Host           : localhost:3306
Source Database       : strange_pet

Target Server Type    : MYSQL
Target Server Version : 80024
File Encoding         : 65001

Date: 2024-12-29 19:55:29
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_banned_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_banned_user`;
CREATE TABLE `t_banned_user` (
  `bu_id` int NOT NULL AUTO_INCREMENT,
  `uid` int NOT NULL,
  `bannedtime` datetime NOT NULL,
  `longtime` datetime NOT NULL,
  `bu_case` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`bu_id`),
  KEY `uid_banneduser` (`uid`),
  CONSTRAINT `uid_banneduser` FOREIGN KEY (`uid`) REFERENCES `t_user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of t_banned_user
-- ----------------------------
INSERT INTO `t_banned_user` VALUES ('5', '2', '2024-11-21 14:10:41', '2024-11-21 15:23:04', '用户账号存在经常发布涉及敏感或争议性话题内容');
INSERT INTO `t_banned_user` VALUES ('7', '6', '2024-11-26 11:25:27', '2024-11-26 11:41:34', '用户账号存在经常发布涉及敏感或争议性话题内容');
INSERT INTO `t_banned_user` VALUES ('12', '8', '2024-12-25 20:00:04', '2024-12-25 20:17:43', '用户账号存在包括生产传播谣言、侵犯他人隐私、侵犯知识产权、从事网络诈骗以及进行网络暴力等行为');
INSERT INTO `t_banned_user` VALUES ('14', '11', '2024-12-27 13:16:05', '2024-12-28 08:55:29', '用户账号存在发布违反国家法律法规、颠覆国家政权、危害国家安全、泄露国家秘密、损害国家尊严等内容或恶搞、歪曲英雄烈士事迹和精神');

-- ----------------------------
-- Table structure for `t_banned_work`
-- ----------------------------
DROP TABLE IF EXISTS `t_banned_work`;
CREATE TABLE `t_banned_work` (
  `bid` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `b_case` varchar(255) NOT NULL,
  `b_time` datetime NOT NULL,
  `b_status` enum('1','0') NOT NULL DEFAULT '0',
  PRIMARY KEY (`bid`),
  KEY `post_id_banned` (`post_id`),
  CONSTRAINT `post_id_banned` FOREIGN KEY (`post_id`) REFERENCES `t_post` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of t_banned_work
-- ----------------------------
INSERT INTO `t_banned_work` VALUES ('28', '19', '作品使用了未经授权的内容，侵犯了他人的版权', '2024-12-25 19:40:46', '1');
INSERT INTO `t_banned_work` VALUES ('32', '26', '作品使用了未经授权的内容，侵犯了他人的版权', '2024-12-27 13:16:05', '1');

-- ----------------------------
-- Table structure for `t_comments`
-- ----------------------------
DROP TABLE IF EXISTS `t_comments`;
CREATE TABLE `t_comments` (
  `cid` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `uid` int NOT NULL,
  `c_content` varchar(2000) NOT NULL,
  `c_time` datetime NOT NULL,
  `c_like` int DEFAULT NULL,
  PRIMARY KEY (`cid`),
  KEY `post_id` (`post_id`),
  KEY `uid2` (`uid`),
  CONSTRAINT `post_id` FOREIGN KEY (`post_id`) REFERENCES `t_post` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uid2` FOREIGN KEY (`uid`) REFERENCES `t_user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of t_comments
-- ----------------------------
INSERT INTO `t_comments` VALUES ('4', '4', '1', '1111', '2024-11-02 16:23:05', null);
INSERT INTO `t_comments` VALUES ('5', '4', '1', '222', '2024-11-02 16:23:15', null);
INSERT INTO `t_comments` VALUES ('7', '7', '1', '鬃狮蜥', '2024-12-17 12:46:30', null);
INSERT INTO `t_comments` VALUES ('8', '7', '8', '111', '2024-12-17 12:56:19', null);
INSERT INTO `t_comments` VALUES ('9', '7', '9', 'wwwwwww', '2024-12-17 13:03:49', null);
INSERT INTO `t_comments` VALUES ('10', '11', '1', '1111', '2024-12-24 02:38:52', null);
INSERT INTO `t_comments` VALUES ('11', '23', '1', '11', '2024-12-26 02:29:02', null);
INSERT INTO `t_comments` VALUES ('12', '27', '10', '呜哇', '2024-12-28 00:13:45', null);

-- ----------------------------
-- Table structure for `t_focus`
-- ----------------------------
DROP TABLE IF EXISTS `t_focus`;
CREATE TABLE `t_focus` (
  `fid` int NOT NULL AUTO_INCREMENT,
  `focus_id` int NOT NULL,
  `uid` int NOT NULL,
  `f_time` datetime NOT NULL,
  PRIMARY KEY (`fid`),
  KEY `focus_id` (`focus_id`),
  KEY `uid4` (`uid`),
  CONSTRAINT `focus_id` FOREIGN KEY (`focus_id`) REFERENCES `t_user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uid4` FOREIGN KEY (`uid`) REFERENCES `t_user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of t_focus
-- ----------------------------
INSERT INTO `t_focus` VALUES ('1', '1', '4', '2024-10-05 14:21:36');
INSERT INTO `t_focus` VALUES ('3', '2', '1', '2024-09-08 16:31:45');
INSERT INTO `t_focus` VALUES ('4', '2', '4', '2024-10-01 19:54:21');
INSERT INTO `t_focus` VALUES ('6', '3', '8', '2024-12-17 20:56:39');
INSERT INTO `t_focus` VALUES ('7', '3', '9', '2024-12-17 21:04:13');

-- ----------------------------
-- Table structure for `t_like`
-- ----------------------------
DROP TABLE IF EXISTS `t_like`;
CREATE TABLE `t_like` (
  `like_id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `uid` int NOT NULL,
  `like_time` datetime NOT NULL,
  PRIMARY KEY (`like_id`),
  KEY `post_id_like` (`post_id`),
  KEY `uid_like` (`uid`),
  CONSTRAINT `post_id_like` FOREIGN KEY (`post_id`) REFERENCES `t_post` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uid_like` FOREIGN KEY (`uid`) REFERENCES `t_user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of t_like
-- ----------------------------
INSERT INTO `t_like` VALUES ('1', '4', '1', '2024-11-02 23:02:41');
INSERT INTO `t_like` VALUES ('2', '2', '1', '2024-11-02 23:02:45');
INSERT INTO `t_like` VALUES ('4', '11', '7', '2024-12-06 09:26:22');
INSERT INTO `t_like` VALUES ('6', '16', '7', '2024-12-06 09:26:26');
INSERT INTO `t_like` VALUES ('9', '14', '7', '2024-12-06 09:26:33');
INSERT INTO `t_like` VALUES ('10', '17', '7', '2024-12-06 09:26:35');
INSERT INTO `t_like` VALUES ('11', '7', '7', '2024-12-06 09:26:47');
INSERT INTO `t_like` VALUES ('13', '7', '8', '2024-12-17 20:58:04');
INSERT INTO `t_like` VALUES ('14', '16', '8', '2024-12-17 20:58:10');
INSERT INTO `t_like` VALUES ('15', '9', '9', '2024-12-17 21:04:25');
INSERT INTO `t_like` VALUES ('17', '16', '9', '2024-12-17 21:04:28');
INSERT INTO `t_like` VALUES ('18', '21', '1', '2024-12-23 08:50:44');
INSERT INTO `t_like` VALUES ('19', '19', '1', '2024-12-23 08:50:46');
INSERT INTO `t_like` VALUES ('20', '11', '1', '2024-12-24 10:38:38');
INSERT INTO `t_like` VALUES ('23', '27', '10', '2024-12-28 08:18:39');
INSERT INTO `t_like` VALUES ('24', '26', '10', '2024-12-28 08:18:41');
INSERT INTO `t_like` VALUES ('25', '21', '10', '2024-12-28 08:18:42');
INSERT INTO `t_like` VALUES ('26', '7', '10', '2024-12-28 08:18:46');
INSERT INTO `t_like` VALUES ('27', '11', '10', '2024-12-28 08:18:49');
INSERT INTO `t_like` VALUES ('28', '16', '10', '2024-12-28 08:18:50');
INSERT INTO `t_like` VALUES ('29', '17', '10', '2024-12-28 08:18:52');
INSERT INTO `t_like` VALUES ('30', '14', '10', '2024-12-28 08:18:54');
INSERT INTO `t_like` VALUES ('31', '11', '11', '2024-12-28 08:50:40');
INSERT INTO `t_like` VALUES ('32', '27', '11', '2024-12-28 08:50:42');
INSERT INTO `t_like` VALUES ('33', '17', '11', '2024-12-28 08:50:44');

-- ----------------------------
-- Table structure for `t_messages`
-- ----------------------------
DROP TABLE IF EXISTS `t_messages`;
CREATE TABLE `t_messages` (
  `mid` int NOT NULL AUTO_INCREMENT,
  `m_content` varchar(255) NOT NULL,
  `send_id` int NOT NULL,
  `send_time` datetime NOT NULL,
  `reception_id` int NOT NULL,
  `reception_time` datetime DEFAULT NULL,
  PRIMARY KEY (`mid`),
  KEY `send_id` (`send_id`),
  KEY `reception_id` (`reception_id`),
  CONSTRAINT `reception_id` FOREIGN KEY (`reception_id`) REFERENCES `t_user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `send_id` FOREIGN KEY (`send_id`) REFERENCES `t_user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of t_messages
-- ----------------------------
INSERT INTO `t_messages` VALUES ('1', '作品使用了未经授权的内容，侵犯了他人的版权', '3', '2024-10-31 00:42:32', '4', null);
INSERT INTO `t_messages` VALUES ('2', '管理员已解除了你的账户', '3', '2024-10-31 08:16:34', '6', null);
INSERT INTO `t_messages` VALUES ('3', '你好', '2', '2024-10-31 10:48:11', '3', '2024-10-31 10:47:33');
INSERT INTO `t_messages` VALUES ('4', '作品使用了未经授权的内容，侵犯了他人的版权', '3', '2024-11-08 11:00:03', '1', '2024-12-17 12:50:57');
INSERT INTO `t_messages` VALUES ('5', '作品使用了未经授权的内容，侵犯了他人的版权', '3', '2024-11-08 11:01:50', '5', null);
INSERT INTO `t_messages` VALUES ('6', '管理员已解除了你的作品', '3', '2024-11-08 11:11:45', '5', null);
INSERT INTO `t_messages` VALUES ('7', '作品使用了未经授权的内容，侵犯了他人的版权', '3', '2024-11-08 11:19:08', '4', null);
INSERT INTO `t_messages` VALUES ('8', '管理员已解除了你的作品', '3', '2024-11-20 10:51:49', '4', null);
INSERT INTO `t_messages` VALUES ('9', '作品使用了未经授权的内容，侵犯了他人的版权', '3', '2024-11-21 14:10:41', '4', null);
INSERT INTO `t_messages` VALUES ('10', '用户账号存在经常发布涉及敏感或争议性话题内容', '3', '2024-11-21 14:10:41', '2', null);
INSERT INTO `t_messages` VALUES ('11', '作品使用了未经授权的内容，侵犯了他人的版权', '3', '2024-11-21 16:32:31', '4', null);
INSERT INTO `t_messages` VALUES ('12', '作品使用了未经授权的内容，侵犯了他人的版权', '3', '2024-11-21 16:44:57', '1', '2024-12-17 12:50:58');
INSERT INTO `t_messages` VALUES ('13', '作品使用了未经授权的内容，侵犯了他人的版权', '3', '2024-11-21 16:44:57', '1', '2024-12-17 12:50:59');
INSERT INTO `t_messages` VALUES ('14', '管理员已解除了你的作品', '3', '2024-11-21 16:53:33', '4', null);
INSERT INTO `t_messages` VALUES ('15', '作品使用了未经授权的内容，侵犯了他人的版权', '3', '2024-11-21 16:56:55', '4', null);
INSERT INTO `t_messages` VALUES ('16', '管理员已解除了你的作品', '3', '2024-11-21 16:56:55', '4', null);
INSERT INTO `t_messages` VALUES ('17', '用户账号存在经常发布涉及敏感或争议性话题内容', '3', '2024-11-26 11:25:27', '6', null);
INSERT INTO `t_messages` VALUES ('18', '管理员已解除了你的账户', '3', '2024-11-26 11:25:27', '6', null);
INSERT INTO `t_messages` VALUES ('19', '用户账号存在经常发布涉及敏感或争议性话题内容', '3', '2024-11-26 11:25:27', '6', null);
INSERT INTO `t_messages` VALUES ('20', '我的作品以修改，请求解封', '4', '2024-11-26 11:44:03', '3', '2024-11-26 11:25:27');
INSERT INTO `t_messages` VALUES ('21', '管理员已解除了你的账户', '3', '2024-11-26 11:25:27', '6', null);
INSERT INTO `t_messages` VALUES ('22', '管理员已解除了你的账户', '3', '2024-11-26 11:25:27', '2', null);
INSERT INTO `t_messages` VALUES ('23', '作品使用了未经授权的内容，侵犯了他人的版权', '3', '2024-11-28 11:13:45', '4', null);
INSERT INTO `t_messages` VALUES ('24', '作品使用了未经授权的内容，侵犯了他人的版权', '3', '2024-12-23 08:21:04', '1', '2024-12-28 00:22:06');
INSERT INTO `t_messages` VALUES ('25', '作品内容可能包含虚假信息、不当行为或错误观念', '3', '2024-12-23 08:21:04', '5', null);
INSERT INTO `t_messages` VALUES ('26', '用户账号存在在用户头像或个人简介中直接加入导流内容，意图引导观众至其他平台', '3', '2024-12-23 08:21:04', '9', null);
INSERT INTO `t_messages` VALUES ('27', '管理员已解除了你的账户', '3', '2024-12-23 08:21:04', '9', null);
INSERT INTO `t_messages` VALUES ('28', '作品使用了未经授权的内容，侵犯了他人的版权', '3', '2024-12-23 08:21:04', '4', null);
INSERT INTO `t_messages` VALUES ('29', '用户账号存在发布违反国家法律法规、颠覆国家政权、危害国家安全、泄露国家秘密、损害国家尊严等内容或恶搞、歪曲英雄烈士事迹和精神', '3', '2024-12-23 08:21:04', '9', null);
INSERT INTO `t_messages` VALUES ('30', '作品使用了未经授权的内容，侵犯了他人的版权', '3', '2024-12-25 19:40:46', '8', null);
INSERT INTO `t_messages` VALUES ('31', '管理员已解除了你的作品', '3', '2024-12-25 19:40:46', '1', '2024-12-28 00:22:07');
INSERT INTO `t_messages` VALUES ('32', '用户账号存在包括生产传播谣言、侵犯他人隐私、侵犯知识产权、从事网络诈骗以及进行网络暴力等行为', '3', '2024-12-25 19:40:46', '1', '2024-12-28 00:22:00');
INSERT INTO `t_messages` VALUES ('33', '管理员已解除了你的账户', '3', '2024-12-25 19:40:46', '1', '2024-12-28 00:22:02');
INSERT INTO `t_messages` VALUES ('34', '作品使用了未经授权的内容，侵犯了他人的版权', '3', '2024-12-25 19:40:46', '1', '2024-12-28 00:22:52');
INSERT INTO `t_messages` VALUES ('35', '管理员已解除了你的账户', '3', '2024-12-25 20:00:04', '9', null);
INSERT INTO `t_messages` VALUES ('36', '我的作品以修改，请求解封', '9', '2024-12-24 20:05:26', '3', '2024-12-25 20:00:04');
INSERT INTO `t_messages` VALUES ('37', '作品使用了未经授权的内容，侵犯了他人的版权', '3', '2024-12-25 20:00:04', '1', '2024-12-28 00:22:53');
INSERT INTO `t_messages` VALUES ('38', '管理员已解除了你的作品', '3', '2024-12-25 20:00:04', '1', '2024-12-28 00:22:53');
INSERT INTO `t_messages` VALUES ('39', '用户账号存在经常发布不良信息，如自杀自残、虐待动物等', '3', '2024-12-25 20:00:04', '9', null);
INSERT INTO `t_messages` VALUES ('40', '管理员已解除了你的账户', '3', '2024-12-25 20:00:04', '9', null);
INSERT INTO `t_messages` VALUES ('41', '用户账号存在包括生产传播谣言、侵犯他人隐私、侵犯知识产权、从事网络诈骗以及进行网络暴力等行为', '3', '2024-12-25 20:00:04', '8', null);
INSERT INTO `t_messages` VALUES ('42', '用户账号存在包括生产传播谣言、侵犯他人隐私、侵犯知识产权、从事网络诈骗以及进行网络暴力等行为', '3', '2024-12-25 20:00:04', '9', null);
INSERT INTO `t_messages` VALUES ('43', '管理员已解除了你的账户', '3', '2024-12-25 20:00:04', '9', null);
INSERT INTO `t_messages` VALUES ('44', '已修改，请求解封', '1', '2024-12-26 10:32:56', '3', null);
INSERT INTO `t_messages` VALUES ('45', '已修改，请求解封', '1', '2024-12-26 02:49:09', '3', null);
INSERT INTO `t_messages` VALUES ('46', '管理员已解除了你的作品', '3', '2024-12-27 13:16:05', '5', null);
INSERT INTO `t_messages` VALUES ('47', '作品使用了未经授权的内容，侵犯了他人的版权', '3', '2024-12-27 13:16:05', '1', null);
INSERT INTO `t_messages` VALUES ('48', '作品使用了未经授权的内容，侵犯了他人的版权', '3', '2024-12-27 13:16:05', '1', null);
INSERT INTO `t_messages` VALUES ('49', '管理员已解除了你的作品', '3', '2024-12-27 13:16:05', '1', null);
INSERT INTO `t_messages` VALUES ('50', '用户账号存在发布违反国家法律法规、颠覆国家政权、危害国家安全、泄露国家秘密、损害国家尊严等内容或恶搞、歪曲英雄烈士事迹和精神', '3', '2024-12-27 13:16:05', '11', null);
INSERT INTO `t_messages` VALUES ('51', '管理员已解除了你的账户', '3', '2024-12-27 13:16:05', '11', null);

-- ----------------------------
-- Table structure for `t_post`
-- ----------------------------
DROP TABLE IF EXISTS `t_post`;
CREATE TABLE `t_post` (
  `post_id` int NOT NULL AUTO_INCREMENT,
  `post_image` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `post_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `post_describe` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `post_type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `post_notes` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `post_time` datetime DEFAULT NULL,
  `post_status` enum('1','0') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1',
  `uid` int NOT NULL,
  `post_like` int unsigned NOT NULL,
  `post_audit` enum('1','0') NOT NULL DEFAULT '0',
  PRIMARY KEY (`post_id`),
  KEY `uid` (`uid`),
  CONSTRAINT `uid` FOREIGN KEY (`uid`) REFERENCES `t_user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of t_post
-- ----------------------------
INSERT INTO `t_post` VALUES ('2', '蜜袋鼯3.jpg', '蜜袋鼬的饲养经验分享', '蜜袋鼯是一种外形似小飞鼠的宠物，拥有滑行膜使其能在树林中滑行。蜜袋鼯性格黏人、可爱，但胆子较小，需要时间适应新环境。饲养时，最好同时养两只或以上，以避免它们感到寂寞。当主人张开手掌时，蜜袋鼯会飞到主人手上。', '分享类', '仅供参考', '2024-10-02 00:00:00', '1', '5', '1', '1');
INSERT INTO `t_post` VALUES ('4', '豚鼠2.jpeg', '有人喜欢这个小豚鼠吗', '我家豚鼠生的这些小豚鼠都长大了，希望能够有人领养他们', '求助类', null, '2024-10-12 08:20:25', '1', '6', '1', '1');
INSERT INTO `t_post` VALUES ('6', '守宫2.jpg', '守宫的养殖分享', '守宫的寿命10年左右，温度最好保持在28度以下', '科普类', '仅供参考，具体内容要按具体品种来', '2024-11-07 10:48:18', '1', '4', '0', '1');
INSERT INTO `t_post` VALUES ('7', '1730643689480é¬ç®è¥1.jpg', '鬃狮蜥的生活习性及特点', '日行性地栖型‌：鬃狮蜥是日行性动物，偏好在地面上活动，同时也善于攀爬。温度与湿度‌：适宜生活在26-38度的高温干燥环境中，最高湿度不超过55%。杂食性‌：以昆虫为主食，如蟋蟀、面包虫等，同时也吃植物花叶、蔬菜和水果。繁殖习性‌：每年春季交配，母鬃狮蜥会挖洞穴产卵，孵化期约60天。防御机制‌：遭受威胁时会张开嘴，将带刺的咽喉充气膨大，以吓唬对手。 ‌性格温顺‌：通常不会主动攻击人类，是理想的宠物伴侣，尤其适合有小孩的家庭。 ‌寿命‌：平均寿命为7-10年，人工饲养下可能更长。', null, '仅供参考啦啦啦', '2024-12-27 13:16:05', '1', '3', '11102', '0');
INSERT INTO `t_post` VALUES ('9', '1730565131909é¾ç«1.jpeg', '龙猫，谁懂？', '龙猫，好可爱', '分享类', '', '2024-11-02 16:31:09', '1', '1', '1', '1');
INSERT INTO `t_post` VALUES ('11', '1731030833835ä¸­å½æ°´é¾3.jpg', '涨知识啦~~~~中国水龙', '中国水龙的饲养环境以保持湿度为主要原则,以热带雨林的模式布置,水龙都是日行性半水栖的爬虫,底材可以树皮屑混合无菌土铺成,湿度保持80%以上,每天必须喷水2次以上才能保持高湿度,UVB也是必须的.另外不能或缺的当然就是一个大水盆,水龙很喜欢静静的坐在水中泡水.只要饲养箱够大,水龙是可以多只雄性共养的.在食性上一样是以昆虫为主,蟋蟀,面包虫和小鱼都是不错的主食,蔬菜水果也可以喂食,成体还可以喂食乳鼠.维他命和钙粉必须定期添加', null, '仅供参考', '2024-12-27 13:16:05', '1', '3', '4', '0');
INSERT INTO `t_post` VALUES ('14', '1732246726071é¾ç«2.jpg', '龙猫的养殖方法和注意事项', '养殖方法：龙猫需要一个宽敞、通风良好的笼子，底部应铺设柔软的垫料，如纸屑或专用的木屑，避免使用松木屑。笼子应放置在阴凉通风的地方，避免阳光直射和潮湿环境‌。龙猫的主食应以高质量的干草为主，如提摩西草。颗粒饲料应选择成分中含有足够纤维、低糖低脂的产品。可以适量提供新鲜蔬菜和水果，但要注意种类和喂食量，避免过量引起消化不良‌。定期清理龙猫的笼子，每周彻底清洗一次。龙猫不能用水洗澡，应使用专门的熔岩砂进行沙浴，以保持清洁和毛发光泽‌。注意事项：新到家的龙猫需要时间适应新环境，不要急于抱它或频繁打扰。刚到家的龙猫可能会吃得少、嗜睡，这是正常现象‌。龙猫适宜生活在15～23度的环境中，避免过热或过冷。夏季需做好防暑降温措施，如开空调、放冰块等‌。猫是社交性动物，适合与其他龙猫一起生活。如果可能，饲养两只龙猫可以让它们互相陪伴，减少孤独感和焦虑‌。定期带龙猫去兽医处进行健康检查，观察其饮食、活动和排便情况，任何异常行为应及时就医‌。', '科普类', '仅提供参考', '2024-11-22 11:31:44', '1', '3', '2', '1');
INSERT INTO `t_post` VALUES ('16', '1732584848629å±å¹æªå¾ 2024-11-26 093054.png', '蓝舌石龙子的饲养注意事项', '蓝舌石龙子是杂食动物，饮食要多样化。主食推荐使用专用的蓝舌粮，每天泡开后手喂，这样可以确保食物的湿度和营养。此外，可以喂食肉类如牛肉、鸡肉、鸡蛋（煮熟），昆虫如大麦虫、蟋蟀、乳鼠等，蔬菜如甘蓝、玉米、胡萝卜、羽衣甘蓝、油麦菜等，水果如蓝莓、车厘子、葡萄、芒果、火龙果、香蕉等‌。避免喂食牛油果、菠菜和酸性柑橘类水果，因为这些可能会导致腹泻或中毒‌。蓝舌石龙子喜欢有一定吸收性的垫材，木屑和树皮都是不错的选择。玉米芯也是一个好的选择，因为它吸水性好，便于清洁和更换，还能减少细菌滋生‌。蓝舌石龙子需要适宜的温度和光照。日间温度应控制在28摄氏度左右，夜间温度控制在23摄氏度，温灯下的温度应保持在33摄氏度左右。适宜的UVB和UVA灯光设置也很重要，UVA灯夏天需要控制在25-35瓦，冬天控制在75-100瓦；UVB灯则需要根据箱子的大小选择合适的瓦数‌', '科普类', '仅供参考', '2024-11-26 08:47:43', '1', '3', '4', '1');
INSERT INTO `t_post` VALUES ('17', '1732585174954å±å¹æªå¾ 2024-11-26 093611.png', '蓝环章鱼的饲养注意事项', '蓝环章鱼是一种含有剧毒的小章鱼，饲养注意风险。\r\n饲养注意事项：蓝环章鱼对水质要求较高，需要保证水质清洁、透明度高、硬度适中，pH值在7.5-8.5之间。建议使用RO水或蒸馏水，避免使用自来水或含氯水。每周定期更换一部分水，保持水质的稳定‌。蓝环章鱼是肉食性动物，需要高蛋白质的食物，如鱼肉、虾仁和蟹肉等。每天喂食1-2次，量不宜过多，以避免造成水质污染。同时，也要注意章鱼的消化情况，在喂食后观察是否有异常‌。蓝环章鱼容易患上各种疾病，如细菌和真菌感染、寄生虫等。需要定期检查章鱼的健康状况，并采取相应的预防措施，如增加水流、定期更换水等。如果章鱼患病，需要及时就医，并采取相应的治疗措施‌。蓝环章鱼是非常活跃的海洋生物，如果它们出现不正常的行为，如过度亢奋、懒散、不食食物等，可能意味着它们出现了生病的症状，需要及时处理‌。蓝环章鱼的皮肤非常敏感，不可直接接触，否则会对其造成伤害。建议使用专用的工具来进行观察或清洁‌。', '科普类', '仅供参考', '2024-11-26 08:47:43', '1', '3', '3', '1');
INSERT INTO `t_post` VALUES ('18', '1734439768144å¾®ä¿¡å¾ç_20241122082409.png', '刺猬', '刺猬身上很多刺，要小心11112', '科普类', '', null, '1', '1', '0', '1');
INSERT INTO `t_post` VALUES ('19', '1734440260023å¾®ä¿¡å¾ç_20241122082522.png', '珠珠', '123123', '求助类', '', '2024-12-17 12:57:11', '0', '8', '1', '1');
INSERT INTO `t_post` VALUES ('21', '1734913558904å¾®ä¿¡å¾ç_20241122082432.png', '塔姆', '嘻嘻嘻，我的小塔姆超级可爱', '分享类', '', '2024-12-23 00:24:53', '1', '1', '2', '1');
INSERT INTO `t_post` VALUES ('23', '1735179673267å¾®ä¿¡å¾ç_20241122082441.png', '111122233322211', '222233333', '科普类', '', null, '1', '1', '0', '1');
INSERT INTO `t_post` VALUES ('26', '1735175553553å¾®ä¿¡å¾ç_20241122082515.jpg', '2222', '1111', '分享类', '', '2024-12-26 01:12:00', '0', '1', '1', '1');
INSERT INTO `t_post` VALUES ('27', '1735262655447å±å¹æªå¾ 2024-11-26 092216.png', '饲养狐獴的注意事项', '狐獴是群居动物，社会性强，通常几十只组成一个族群生活在一起。作为宠物饲养时，虽然可以养一只，但需要花费更多时间陪伴和互动。狐獴喜欢干燥暖和的环境，适合在温暖的气候中生活，冬天需要做好保暖工作。‌狐獴的主要食物包括大麦虫、猫粮和鸡胸肉。它们也喜欢吃一些小型昆虫，如蜘蛛、蜥蜴和蚱蜢。为了保持狐獴的健康，需要定期给它们洗澡并清洁饲养环境。狐獴可能携带病菌，但通过正规渠道购买并做好体内外驱虫可以降低风险。根据当地规定，可能需要为狐獴注射疫苗。', '科普类', '仅供参考', '2024-12-27 08:52:33', '1', '3', '2', '1');

-- ----------------------------
-- Table structure for `t_reply`
-- ----------------------------
DROP TABLE IF EXISTS `t_reply`;
CREATE TABLE `t_reply` (
  `rid` int NOT NULL AUTO_INCREMENT,
  `cid` int NOT NULL,
  `r_content` varchar(2000) NOT NULL,
  `uid` int NOT NULL,
  `r_time` datetime NOT NULL,
  `r_like` int DEFAULT NULL,
  PRIMARY KEY (`rid`),
  KEY `cid` (`cid`),
  KEY `uid3` (`uid`),
  CONSTRAINT `cid` FOREIGN KEY (`cid`) REFERENCES `t_comments` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uid3` FOREIGN KEY (`uid`) REFERENCES `t_user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of t_reply
-- ----------------------------
INSERT INTO `t_reply` VALUES ('2', '4', '11111', '1', '2024-11-03 00:23:10', null);
INSERT INTO `t_reply` VALUES ('4', '7', '鬃狮蜥', '1', '2024-12-17 20:46:44', null);
INSERT INTO `t_reply` VALUES ('5', '7', '11122', '8', '2024-12-17 20:56:31', null);
INSERT INTO `t_reply` VALUES ('6', '8', '1234', '9', '2024-12-17 21:04:02', null);
INSERT INTO `t_reply` VALUES ('7', '10', '2222', '1', '2024-12-24 10:38:58', null);

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `uphone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `upass` varchar(255) NOT NULL,
  `uname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `imageUrl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `usex` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `uage` int DEFAULT NULL,
  `ustatus` enum('1','0') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1',
  `utime` datetime NOT NULL,
  `urole` enum('1','0') NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', '18944972711', '123456', '唐婷', '1735007984256å¾®ä¿¡å¾ç_20241122082522.png', '女', null, '1', '2024-10-14 11:25:31', '0');
INSERT INTO `t_user` VALUES ('2', '18844972711', '123456', '啦啦', '1733447729068å¼å¿å°èµ·é£.jpg', '女', null, '1', '2024-10-14 20:36:48', '0');
INSERT INTO `t_user` VALUES ('3', '14725836999', '123456', '管理员', '1733447622125å¤´å1.jpg', null, null, '1', '2024-10-16 11:33:25', '1');
INSERT INTO `t_user` VALUES ('4', '15478963214', '123456', '喜喜', '1735128116502åç½å¤æ¥.jpg', '女', '23', '1', '2024-10-18 10:25:21', '0');
INSERT INTO `t_user` VALUES ('5', '13265478998', '123456', '大鼓', null, '男', '32', '1', '2024-10-14 12:25:14', '0');
INSERT INTO `t_user` VALUES ('6', '18907386589', '123456', 'mary', '1733447659058ç«å¤´.jpg', '女', null, '1', '2024-10-20 13:16:25', '0');
INSERT INTO `t_user` VALUES ('7', '12345698777', '147258', '黎吧啦', '1733445289419QQæªå¾20240418135316-removebg-preview.png', '女', '30', '1', '2024-12-06 08:32:07', '0');
INSERT INTO `t_user` VALUES ('8', '12345678911', '123456', '吴美丽', '1734440353161å¾®ä¿¡å¾ç_20241122082512.png', '女', '22', '0', '2024-12-17 20:55:34', '0');
INSERT INTO `t_user` VALUES ('9', '12345678922', '123456', '糖果', '1735128816080ç¦èºåä¸.jpg', '女', '25', '1', '2024-12-17 21:03:00', '0');
INSERT INTO `t_user` VALUES ('10', '19944972711', '123456', '吴美丽', '1735345155255å±å¹æªå¾ 2024-11-26 093049.png', '女', '23', '1', '2024-12-28 08:12:57', '0');
INSERT INTO `t_user` VALUES ('11', '17744972711', '1234567', '唐婷', '1735347315463ç¦èºåä¸.jpg', '女', '12', '1', '2024-12-28 08:49:17', '0');
