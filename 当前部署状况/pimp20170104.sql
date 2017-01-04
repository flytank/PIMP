/*
Navicat MySQL Data Transfer

Source Server         : 120.76.161.130
Source Server Version : 50711
Source Host           : 120.76.161.130:3306
Source Database       : pimp

Target Server Type    : MYSQL
Target Server Version : 50711
File Encoding         : 65001

Date: 2017-01-04 15:37:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `activity`
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
  `UUID` varchar(40) NOT NULL COMMENT '主键',
  `subject` varchar(100) DEFAULT NULL COMMENT '主题',
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  `startDate` date DEFAULT NULL COMMENT '开始时间',
  `endDate` date DEFAULT NULL COMMENT '截止时间',
  `place` varchar(100) DEFAULT NULL COMMENT '地点',
  `mark` varchar(100) DEFAULT NULL COMMENT '备注',
  `activityPic` varbinary(200) DEFAULT NULL COMMENT '活动图片',
  `isShow` tinyint(1) DEFAULT NULL COMMENT 'false，为不展示',
  `zoneCode` varchar(40) DEFAULT NULL COMMENT '参照区域表的主键',
  `townCode` varchar(40) DEFAULT NULL COMMENT '参照乡镇表的主键',
  `villageCode` varchar(40) DEFAULT NULL COMMENT '参照自然村表的主键',
  `scope` int(11) DEFAULT NULL COMMENT '1为区域、2为乡镇、3为自然村',
  `dutyCode` varchar(40) DEFAULT NULL COMMENT '参照职责表的主键',
  `isAddPoints` tinyint(1) DEFAULT NULL COMMENT 'true为已对参加人员添加积分了',
  `points` double DEFAULT NULL COMMENT '本次活动积分，积分不能超过该职责分数',
  `townID` varchar(40) DEFAULT NULL,
  `villageID` varchar(40) DEFAULT NULL,
  `zoneID` varchar(40) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='1、活动范围：区域、乡镇、自然村,根据活动范围来取所属地区的值\r\n2、职责编码：参照职责字典表中的职责编码，活';

-- ----------------------------
-- Records of activity
-- ----------------------------
INSERT INTO `activity` VALUES ('297ebe0e54f1a711015543cbdf750004', '收缴党费', '收缴党费', '2016-05-11', '2016-05-12', '栾城镇组员办', '', null, '1', null, null, null, '1', '0001', null, '2.5', '0001', '0001', '0001', '2016-06-12 16:48:02');
INSERT INTO `activity` VALUES ('297ebe0e54f1a711015543d0c1270007', '两学一做主题征文', '撰写两学一做主题征文', '2016-05-12', '2016-06-12', '栾城镇会议室', '', null, '1', null, null, null, '1', '0003', null, '2', '0001', '0001', '0001', '2016-06-12 16:53:22');

-- ----------------------------
-- Table structure for `activityperson`
-- ----------------------------
DROP TABLE IF EXISTS `activityperson`;
CREATE TABLE `activityperson` (
  `UUID` varchar(40) NOT NULL COMMENT '主键',
  `acitityCode` varchar(40) DEFAULT NULL COMMENT '参照活动表的主键',
  `userCode` varchar(40) DEFAULT NULL COMMENT '参照人员表的主键',
  `mark` varchar(100) DEFAULT NULL COMMENT '备注',
  `actvityCode` varchar(40) NOT NULL,
  `isAddPoints` bit(1) DEFAULT NULL,
  PRIMARY KEY (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of activityperson
-- ----------------------------
INSERT INTO `activityperson` VALUES ('297ebe0e54f1a711015543ccb8dd0005', null, '297ebe0e54f1a711015543c600d70001', null, '297ebe0e54f1a711015543cbdf750004', '');
INSERT INTO `activityperson` VALUES ('297ebe0e54f1a71101554da47ad70009', null, '297ebe0e54f1a71101554da35bfa0008', null, '297ebe0e54f1a711015543cbdf750004', '');

-- ----------------------------
-- Table structure for `authority`
-- ----------------------------
DROP TABLE IF EXISTS `authority`;
CREATE TABLE `authority` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_url` varchar(100) DEFAULT NULL,
  `menu_class` varchar(50) DEFAULT NULL,
  `menu_code` varchar(50) DEFAULT NULL,
  `menu_name` varchar(50) DEFAULT NULL,
  `parent_menucode` varchar(50) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of authority
-- ----------------------------
INSERT INTO `authority` VALUES ('28', '#', 'menu-icon fa fa-desktop', 'systemmanagement', '系统管理', '0', '1');
INSERT INTO `authority` VALUES ('29', 'page/sysuser', 'menu-icon fa fa-caret-right', 'sysuser', '用户管理', 'systemmanagement', '13');
INSERT INTO `authority` VALUES ('32', 'page/role', 'menu-icon fa fa-caret-right', 'role', '角色权限管理', 'systemmanagement', '12');
INSERT INTO `authority` VALUES ('33', 'page/authority', 'menu-icon fa fa-caret-right', 'authority', '菜单管理', 'systemmanagement', '11');
INSERT INTO `authority` VALUES ('34', '#', 'menu-icon fa fa-user', 'personalmanagement', '人员管理', '0', '2');
INSERT INTO `authority` VALUES ('35', 'page/party', 'menu-icon fa fa-caret-right', 'party', '党员管理', 'personalmanagement', '21');
INSERT INTO `authority` VALUES ('36', 'page/team', 'menu-icon fa fa-caret-right', 'team', '党小组管理', 'personalmanagement', '23');
INSERT INTO `authority` VALUES ('37', '#', 'menu-icon fa fa-calendar', 'activitymanagement', '活动管理', '0', '3');
INSERT INTO `authority` VALUES ('38', 'page/activity', 'menu_icon fa fa-caret-right', 'activity', '活动详情管理', 'activitymanagement', '31');
INSERT INTO `authority` VALUES ('39', '#', 'menu-icon fa fa-eye', 'pointmanagement', '积分管理', '0', '4');
INSERT INTO `authority` VALUES ('40', 'page/userpoints', 'menu_icon fa fa-caret-right', 'userpoints', '积分详情管理', 'pointmanagement', '41');
INSERT INTO `authority` VALUES ('41', 'page/activist', 'menu-icon fa fa-caret-right', 'activist', '入党积极分子管理', 'personalmanagement', '22');
INSERT INTO `authority` VALUES ('42', 'page/duty', 'menu-icon fa fa-caret-right', 'duty', '职责管理', 'personalmanagement', '23');
INSERT INTO `authority` VALUES ('43', 'page/look_activity', 'menu_icon fa fa-caret-right', 'look_activity', '活动详情查看', 'activitymanagement', '32');
INSERT INTO `authority` VALUES ('44', '#', 'menu-icon fa fa-list', 'noticemanagement', '公示管理', '0', '5');
INSERT INTO `authority` VALUES ('45', 'page/notice', 'menu_icon fa fa-caret-right', 'notice', '公示详情管理', 'noticemanagement', '51');
INSERT INTO `authority` VALUES ('46', 'page/look_notice', 'menu_icon fa fa-caret-right', 'look_notice', '公示详情查看', 'noticemanagement', '52');
INSERT INTO `authority` VALUES ('47', 'page/look_userpoints', 'menu_icon fa fa-caret-right', 'look_userpoints', '积分详情查看', 'pointmanagement', '42');

-- ----------------------------
-- Table structure for `duty`
-- ----------------------------
DROP TABLE IF EXISTS `duty`;
CREATE TABLE `duty` (
  `dutyCode` varchar(40) NOT NULL COMMENT '职责编码',
  `dutyName` varchar(100) DEFAULT NULL COMMENT '职责类别名称',
  `mark` varchar(100) DEFAULT NULL COMMENT '备注',
  `points` double DEFAULT NULL COMMENT '总分，该职责不能超过这个分数',
  PRIMARY KEY (`dutyCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='1、按时足额缴纳党费，计10分。\r\n2、党员亮牌，达到标准的计10分。\r\n3、A类党员：参加一次村“';

-- ----------------------------
-- Records of duty
-- ----------------------------
INSERT INTO `duty` VALUES ('0001', '按时足额缴纳党费', null, '10');
INSERT INTO `duty` VALUES ('0002', '党员亮牌', null, '10');
INSERT INTO `duty` VALUES ('0003', '村“两委”组织的活动', null, '60');
INSERT INTO `duty` VALUES ('0004', '年累计捐款1200元', null, '30');
INSERT INTO `duty` VALUES ('0005', '参加务工所在地党组织生活，并按要求开展工作', null, '20');
INSERT INTO `duty` VALUES ('0006', '定期向党支部汇报自己在外的思想及工作情况', null, '10');
INSERT INTO `duty` VALUES ('0007', '贡献积分', null, '100');
INSERT INTO `duty` VALUES ('0008', '年度评议积分 ', null, '20');

-- ----------------------------
-- Table structure for `honor`
-- ----------------------------
DROP TABLE IF EXISTS `honor`;
CREATE TABLE `honor` (
  `UUID` varchar(40) NOT NULL COMMENT '主键',
  `userUUID` varchar(40) DEFAULT NULL COMMENT '姓名',
  `amount` double DEFAULT NULL COMMENT '表彰金额',
  `time` date DEFAULT NULL COMMENT '表彰时间',
  `description` varchar(100) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of honor
-- ----------------------------

-- ----------------------------
-- Table structure for `message`
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `UUID` varchar(40) NOT NULL COMMENT '主键',
  `messageID` varchar(40) DEFAULT NULL COMMENT '若来源是活动，则为此字段为活动编码，否则为公示编码',
  `content` varchar(255) DEFAULT NULL COMMENT '留言内容',
  `user` varchar(40) DEFAULT NULL COMMENT '参照人员表的主键',
  `messageSource` int(11) DEFAULT NULL COMMENT '1为活动，2为公示',
  `time` date DEFAULT NULL,
  PRIMARY KEY (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='1、留言对象来源：活动、公示\r\n2、留言对象ID：若来源是活动，这ID为活动编码，若是公示，这ID为公示编码';

-- ----------------------------
-- Records of message
-- ----------------------------

-- ----------------------------
-- Table structure for `notice`
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `UUID` varchar(40) NOT NULL COMMENT '主键',
  `subject` varchar(100) DEFAULT NULL COMMENT '主题',
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  `time` date DEFAULT NULL COMMENT '时间',
  `user` varchar(40) DEFAULT NULL COMMENT '参照人员表的人员主键',
  `mark` varchar(100) DEFAULT NULL COMMENT '备注',
  `isShow` tinyint(1) DEFAULT NULL COMMENT 'true，为展示',
  `zoneCode` varchar(40) DEFAULT NULL COMMENT '参照区域表的主键',
  `townCode` varchar(40) DEFAULT NULL COMMENT '参照乡镇表的主键',
  `villageCode` varchar(40) DEFAULT NULL COMMENT '参照自然村表的主键',
  `scope` int(11) DEFAULT NULL COMMENT '1为区域、2为乡镇、3为自然村',
  `townID` varchar(40) DEFAULT NULL,
  `villageID` varchar(40) DEFAULT NULL,
  `zoneID` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动范围：区域、乡镇、自然村,根据活动范围来取所属地区的值';

-- ----------------------------
-- Records of notice
-- ----------------------------

-- ----------------------------
-- Table structure for `partyduty`
-- ----------------------------
DROP TABLE IF EXISTS `partyduty`;
CREATE TABLE `partyduty` (
  `UUID` varchar(40) NOT NULL COMMENT '主键',
  `partyCode` varchar(40) NOT NULL COMMENT '参照党员类别表的主键',
  `dutyCode` varchar(40) NOT NULL COMMENT '参照职责字典表的主键',
  PRIMARY KEY (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of partyduty
-- ----------------------------
INSERT INTO `partyduty` VALUES ('1', 'A', '0001');
INSERT INTO `partyduty` VALUES ('10', 'C', '0002');
INSERT INTO `partyduty` VALUES ('11', 'C', '0007');
INSERT INTO `partyduty` VALUES ('12', 'C', '0008');
INSERT INTO `partyduty` VALUES ('13', 'A', '0007');
INSERT INTO `partyduty` VALUES ('14', 'A', '0008');
INSERT INTO `partyduty` VALUES ('15', 'B', '0007');
INSERT INTO `partyduty` VALUES ('16', 'B', '0008');
INSERT INTO `partyduty` VALUES ('2', 'A', '0002');
INSERT INTO `partyduty` VALUES ('3', 'A', '0003');
INSERT INTO `partyduty` VALUES ('4', 'B', '0001');
INSERT INTO `partyduty` VALUES ('5', 'B', '0002');
INSERT INTO `partyduty` VALUES ('6', 'B', '0004');
INSERT INTO `partyduty` VALUES ('7', 'B', '0005');
INSERT INTO `partyduty` VALUES ('8', 'B', '0006');
INSERT INTO `partyduty` VALUES ('9', 'C', '0001');

-- ----------------------------
-- Table structure for `partymember`
-- ----------------------------
DROP TABLE IF EXISTS `partymember`;
CREATE TABLE `partymember` (
  `partyCode` varchar(40) NOT NULL COMMENT 'A类党员、B类党员、C类党员',
  `partyName` varchar(100) DEFAULT NULL COMMENT '在村务工或白天外出务工的党员、长期在外务工党员、70岁以\r\n\r\n上或因伤病不宜参加积分管理的党员',
  `mark` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`partyCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='1、A类党员，为在村务工或白天外出务工的党员。\r\n2、B类党员，为长期在外务工党员。\r\n3、C类党员';

-- ----------------------------
-- Records of partymember
-- ----------------------------
INSERT INTO `partymember` VALUES ('A', 'A类党员', '在村务工或白天外出务工的党员');
INSERT INTO `partymember` VALUES ('B', 'B类党员', '长期在外务工党员');
INSERT INTO `partymember` VALUES ('C', 'C类党员', '70岁以上或因伤病不宜参加积分管理的党员');

-- ----------------------------
-- Table structure for `punishment`
-- ----------------------------
DROP TABLE IF EXISTS `punishment`;
CREATE TABLE `punishment` (
  `UUID` varchar(40) NOT NULL COMMENT '主键',
  `userUUID` varchar(40) DEFAULT NULL COMMENT '姓名',
  `time` date DEFAULT NULL COMMENT '表彰时间',
  `description` varchar(100) DEFAULT NULL COMMENT '描述',
  `reason` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of punishment
-- ----------------------------

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_key` varchar(40) DEFAULT NULL,
  `role_value` varchar(40) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'zone', '区域管理员', '区域管理员');
INSERT INTO `role` VALUES ('2', 'town', '乡镇管理员', '乡镇管理员');
INSERT INTO `role` VALUES ('3', 'village', '村级管理员', '村级管理员');
INSERT INTO `role` VALUES ('7', 'ROLE_ADMIN', '超级管理员', '超级管理员');
INSERT INTO `role` VALUES ('9', 'ROLE_USER', '普通用户', '普通用户');

-- ----------------------------
-- Table structure for `role_authority`
-- ----------------------------
DROP TABLE IF EXISTS `role_authority`;
CREATE TABLE `role_authority` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_code` varchar(50) DEFAULT NULL,
  `role_key` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=339 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_authority
-- ----------------------------
INSERT INTO `role_authority` VALUES ('178', 'authority', 'ROLE_RESTRICTED_ADMIN');
INSERT INTO `role_authority` VALUES ('179', 'role', 'ROLE_RESTRICTED_ADMIN');
INSERT INTO `role_authority` VALUES ('180', 'sysuser', 'ROLE_RESTRICTED_ADMIN');
INSERT INTO `role_authority` VALUES ('181', 'party', 'ROLE_RESTRICTED_ADMIN');
INSERT INTO `role_authority` VALUES ('182', 'activist', 'ROLE_RESTRICTED_ADMIN');
INSERT INTO `role_authority` VALUES ('183', 'team', 'ROLE_RESTRICTED_ADMIN');
INSERT INTO `role_authority` VALUES ('184', 'activity', 'ROLE_RESTRICTED_ADMIN');
INSERT INTO `role_authority` VALUES ('185', 'point', 'ROLE_RESTRICTED_ADMIN');
INSERT INTO `role_authority` VALUES ('295', 'sysuser', 'zone');
INSERT INTO `role_authority` VALUES ('296', 'party', 'zone');
INSERT INTO `role_authority` VALUES ('297', 'activist', 'zone');
INSERT INTO `role_authority` VALUES ('298', 'team', 'zone');
INSERT INTO `role_authority` VALUES ('299', 'activity', 'zone');
INSERT INTO `role_authority` VALUES ('300', 'look_activity', 'zone');
INSERT INTO `role_authority` VALUES ('301', 'userpoints', 'zone');
INSERT INTO `role_authority` VALUES ('302', 'look_userpoints', 'zone');
INSERT INTO `role_authority` VALUES ('303', 'notice', 'zone');
INSERT INTO `role_authority` VALUES ('304', 'look_notice', 'zone');
INSERT INTO `role_authority` VALUES ('305', 'party', 'town');
INSERT INTO `role_authority` VALUES ('306', 'activist', 'town');
INSERT INTO `role_authority` VALUES ('307', 'team', 'town');
INSERT INTO `role_authority` VALUES ('308', 'activity', 'town');
INSERT INTO `role_authority` VALUES ('309', 'look_activity', 'town');
INSERT INTO `role_authority` VALUES ('310', 'userpoints', 'town');
INSERT INTO `role_authority` VALUES ('311', 'look_userpoints', 'town');
INSERT INTO `role_authority` VALUES ('312', 'notice', 'town');
INSERT INTO `role_authority` VALUES ('313', 'look_notice', 'town');
INSERT INTO `role_authority` VALUES ('314', 'party', 'village');
INSERT INTO `role_authority` VALUES ('315', 'activist', 'village');
INSERT INTO `role_authority` VALUES ('316', 'team', 'village');
INSERT INTO `role_authority` VALUES ('317', 'activity', 'village');
INSERT INTO `role_authority` VALUES ('318', 'look_activity', 'village');
INSERT INTO `role_authority` VALUES ('319', 'userpoints', 'village');
INSERT INTO `role_authority` VALUES ('320', 'look_userpoints', 'village');
INSERT INTO `role_authority` VALUES ('321', 'notice', 'village');
INSERT INTO `role_authority` VALUES ('322', 'look_notice', 'village');
INSERT INTO `role_authority` VALUES ('323', 'authority', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('324', 'role', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('325', 'sysuser', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('326', 'party', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('327', 'activist', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('328', 'team', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('329', 'duty', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('330', 'activity', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('331', 'look_activity', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('332', 'userpoints', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('333', 'look_userpoints', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('334', 'notice', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('335', 'look_notice', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('336', 'look_activity', 'ROLE_USER');
INSERT INTO `role_authority` VALUES ('337', 'look_userpoints', 'ROLE_USER');
INSERT INTO `role_authority` VALUES ('338', 'look_notice', 'ROLE_USER');

-- ----------------------------
-- Table structure for `sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `UUID` varchar(40) NOT NULL COMMENT '主键',
  `name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `sex` varchar(40) DEFAULT NULL COMMENT '性别',
  `IDCard` varchar(40) DEFAULT NULL COMMENT '身份证号码(18位）',
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `education` varchar(50) DEFAULT NULL COMMENT '中专;大专;本科;研究生',
  `position` varchar(40) DEFAULT NULL COMMENT '组长、副组长等',
  `sortID` varchar(40) DEFAULT NULL COMMENT '参照党员类别表中党员类别编码',
  `teamID` varchar(40) DEFAULT NULL COMMENT '参照党小组表中的党小组编码',
  `villageID` varchar(40) DEFAULT NULL COMMENT '参照自然村表的自然村编码',
  `townID` varchar(40) DEFAULT NULL COMMENT '参照乡镇表的乡镇编码',
  `zoneID` varchar(40) DEFAULT NULL COMMENT '参照区域表的区域编码（只有一个区域）',
  `identity` int(1) DEFAULT NULL COMMENT '1为党员，2为入党积极分子，3为群众',
  `role` varchar(40) DEFAULT NULL COMMENT '参照角色表的role_key',
  `password` varchar(40) DEFAULT NULL COMMENT '采用MD5加密',
  `status` int(11) DEFAULT NULL COMMENT '1为已激活、2为未激活、3为停用',
  `loginName` varchar(40) DEFAULT NULL COMMENT '登录系统账号',
  `createTime` datetime DEFAULT NULL,
  `points` double DEFAULT NULL,
  PRIMARY KEY (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='党员类别编码：参照党员类别字典表中的党员类别编码\r\n党小组：参照党小组表中的党小组编码\r\n所属自然村';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('297ebe0e544764d50154476c6ae80000', '区域管理员', '男', '000000000000000000', '2016-04-24', '小学', '组织部', '', '', '0001', '0001', '0001', '3', 'zone', 'e10adc3949ba59abbe56e057f20f883e', '1', 'leader', '2016-04-24 16:39:28', '0');
INSERT INTO `sys_user` VALUES ('297ebe0e544db6360154939906d80003', '栾城镇', '男', '111111111111111111', '2016-05-16', '本科', '组员办', '', '', '0001', '0001', '0001', '3', 'town', 'e10adc3949ba59abbe56e057f20f883e', '1', '栾城镇', '2016-05-09 11:39:20', '0');
INSERT INTO `sys_user` VALUES ('297ebe0e544db6360154b83746740004', '楼底镇', '男', '222222222222222222', '2016-05-16', '本科', '组员办', '', '', '0048', '0002', '0001', '3', 'town', 'e10adc3949ba59abbe56e057f20f883e', '1', '楼底镇', '2016-05-16 14:18:31', '0');
INSERT INTO `sys_user` VALUES ('297ebe0e544db6360154b8385cdf0005', '冶河镇', '男', '333333333333333333', '2016-05-16', '本科', '组员办', '', '', '0064', '0003', '0001', '3', 'town', 'e10adc3949ba59abbe56e057f20f883e', '1', '冶河镇', '2016-05-16 14:19:42', '0');
INSERT INTO `sys_user` VALUES ('297ebe0e544db6360154b839296a0006', '窦妪镇', '男', '444444444444444444', '2016-05-16', '本科', '组员办', '', '', '0080', '0004', '0001', '3', 'town', 'e10adc3949ba59abbe56e057f20f883e', '1', '窦妪镇', '2016-05-16 14:20:35', '0');
INSERT INTO `sys_user` VALUES ('297ebe0e544db6360154e0bb3f480007', '柳林屯乡', '男', '555555555555555555', '2016-05-16', '本科', '组员办', '', '', '0151', '0007', '0001', '3', 'town', 'e10adc3949ba59abbe56e057f20f883e', '1', '柳林屯乡', '2016-05-24 11:07:28', '0');
INSERT INTO `sys_user` VALUES ('297ebe0e544db6360154e0bd0a770008', '南高乡', '男', '666666666666666666', '2016-05-16', '本科', '组员办', '', '', '0129', '0006', '0001', '3', 'town', 'e10adc3949ba59abbe56e057f20f883e', '1', '南高乡', '2016-05-24 11:09:26', '0');
INSERT INTO `sys_user` VALUES ('297ebe0e544db6360154e0be57d20009', '西营乡', '男', '777777777777777777', '2016-05-16', '本科', '组员办', '', '', '0096', '0005', '0001', '3', 'town', 'e10adc3949ba59abbe56e057f20f883e', '1', '西营乡', '2016-05-24 11:10:51', '0');
INSERT INTO `sys_user` VALUES ('297ebe0e544db6360154e0c2363d000a', '栾城镇北关村', '男', '111111111111111001', '2016-05-24', '本科', '栾城镇北关村管理员', '', '', '0002', '0001', '0001', '3', 'village', 'e10adc3949ba59abbe56e057f20f883e', '1', '栾城镇北关村', '2016-05-24 11:15:05', '0');
INSERT INTO `sys_user` VALUES ('297ebe0e544db6360154e0e300ad000b', '栾城镇八里庄村', '男', '111111111111111002', '2016-05-24', '本科', '栾城镇八里庄村管理员', '', '', '0001', '0001', '0001', '3', 'village', 'e10adc3949ba59abbe56e057f20f883e', '1', '栾城镇八里庄村', '2016-05-24 11:50:54', '0');
INSERT INTO `sys_user` VALUES ('297ebe0e544db6360154e0e4135a000c', '栾城镇小周村', '男', '111111111111111003', '2016-05-24', '本科', '栾城镇小周村管理员', '', '', '0041', '0001', '0001', '3', 'village', 'e10adc3949ba59abbe56e057f20f883e', '1', '栾城镇小周村', '2016-05-24 11:52:04', '0');
INSERT INTO `sys_user` VALUES ('297ebe0e54f1a711015543c600d70001', '刘芳贺', '女', '13012419930518002X', '1993-05-18', '本科', '科员', 'A', '', '0001', '0001', '0001', '1', 'ROLE_USER', 'e10adc3949ba59abbe56e057f20f883e', '1', '刘芳贺', '2016-06-12 16:41:38', '162.5');
INSERT INTO `sys_user` VALUES ('297ebe0e54f1a71101554da35bfa0008', '张天聪', '女', '130124195609220010', '1991-01-01', '本科', '科员', 'A', '297ebe0e54f1a711015543c7af810002', '0001', '0001', '0001', '1', 'ROLE_USER', 'e10adc3949ba59abbe56e057f20f883e', '1', '张天聪', '2016-06-14 14:39:59', '103.5');
INSERT INTO `sys_user` VALUES ('297ebe0e54f1a71101554dac1907000b', '楼底镇樊家屯村', '男', '222222222222222001', '2016-06-14', '本科', '楼底镇樊家屯村管理员', '', '', '0053', '0002', '0001', '3', 'village', 'e10adc3949ba59abbe56e057f20f883e', '1', '楼底镇樊家屯村', '2016-06-14 14:49:32', '0');
INSERT INTO `sys_user` VALUES ('297ebe0e54f1a71101554dae64ac000c', '楼底镇王家屯村', '男', '222222222222222002', '2016-06-14', '本科', '楼底镇王家屯村管理员', '', '', '0058', '0002', '0001', '3', 'village', 'e10adc3949ba59abbe56e057f20f883e', '1', '楼底镇王家屯村', '2016-06-14 14:52:03', '0');
INSERT INTO `sys_user` VALUES ('297ebe0e54f1a71101554dafdb3e000d', '楼底镇夏户庄村', '男', '222222222222222003', '2016-06-14', '本科', '楼底镇夏户庄村管理员', '', '', '0062', '0002', '0001', '3', 'village', 'e10adc3949ba59abbe56e057f20f883e', '1', '楼底镇夏户庄村', '2016-06-14 14:53:38', '0');
INSERT INTO `sys_user` VALUES ('admin', 'admin', '男', '0000000000000000', '2016-04-24', '小学', null, null, null, '0001', null, null, '1', 'ROLE_ADMIN', '18a879e2eb19dba562d01d5923e6270c', '1', 'admin', '2016-04-24 16:39:28', '20');

-- ----------------------------
-- Table structure for `team`
-- ----------------------------
DROP TABLE IF EXISTS `team`;
CREATE TABLE `team` (
  `teamID` varchar(40) NOT NULL COMMENT '主键',
  `teamName` varchar(100) DEFAULT NULL COMMENT '乡镇名+村名+XXX党小组 ',
  `villageID` varchar(40) DEFAULT NULL COMMENT '参照自然村表的主键',
  `townID` varchar(40) DEFAULT NULL COMMENT '参照乡镇表的主键',
  `zoneID` varchar(40) DEFAULT NULL COMMENT '参照区域表的主键',
  `mark` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`teamID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='命名规则：乡镇名+村名+XXX党小组 如：冶河镇端固庄村001党小组';

-- ----------------------------
-- Records of team
-- ----------------------------
INSERT INTO `team` VALUES ('297ebe0e544db6360154518409d10002', '栾城镇八里庄村党小组001', '0001', '0001', '0001', '');
INSERT INTO `team` VALUES ('297ebe0e54f1a711015543c7af810002', '栾城镇八里庄村党小组002', '0001', '0001', '0001', '');
INSERT INTO `team` VALUES ('297ebe0e54f1a711015543ca95cf0003', '栾城镇八里庄村党小组003', '0001', '0001', '0001', '');

-- ----------------------------
-- Table structure for `town`
-- ----------------------------
DROP TABLE IF EXISTS `town`;
CREATE TABLE `town` (
  `townCode` varchar(40) NOT NULL COMMENT '乡镇编码',
  `townName` varchar(100) DEFAULT NULL COMMENT '乡镇名称',
  `zoneCode` varchar(40) DEFAULT NULL COMMENT '所属区域',
  PRIMARY KEY (`townCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of town
-- ----------------------------
INSERT INTO `town` VALUES ('0001', '栾城镇', '0001');
INSERT INTO `town` VALUES ('0002', '楼底镇', '0001');
INSERT INTO `town` VALUES ('0003', '冶河镇', '0001');
INSERT INTO `town` VALUES ('0004', '窦妪镇', '0001');
INSERT INTO `town` VALUES ('0005', '西营乡', '0001');
INSERT INTO `town` VALUES ('0006', '南高乡', '0001');
INSERT INTO `town` VALUES ('0007', '柳林屯乡', '0001');

-- ----------------------------
-- Table structure for `userpoints`
-- ----------------------------
DROP TABLE IF EXISTS `userpoints`;
CREATE TABLE `userpoints` (
  `UUID` varchar(40) NOT NULL COMMENT '主键',
  `userUUID` varchar(40) DEFAULT NULL COMMENT '参照人员表主键',
  `source` int(11) DEFAULT NULL COMMENT '1为活动，2为职责',
  `sourceCode` varchar(40) DEFAULT NULL COMMENT '若来源为活动，则此为活动编码，若来源为职责，则为职责编码\r\n\r\n',
  `points` double DEFAULT NULL COMMENT '获取的积分',
  `time` date DEFAULT NULL COMMENT '获取的时间',
  `isEffect` tinyint(1) DEFAULT NULL COMMENT 'false为无效，不加入总分计算',
  `mark` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='1、积分从职责编码里面来，若积分还从活动里来，则活动编码有值\r\n2、积分不能大于职责编码中的积分值\r\n                               -&#&';

-- ----------------------------
-- Records of userpoints
-- ----------------------------
INSERT INTO `userpoints` VALUES ('297ebe0e54f1a711015543cf08f70006', '297ebe0e54f1a711015543c600d70001', '1', '297ebe0e54f1a711015543cbdf750004', '2.5', '2016-06-12', '1', null);
INSERT INTO `userpoints` VALUES ('297ebe0e54f1a71101554da49295000a', '297ebe0e54f1a71101554da35bfa0008', '1', '297ebe0e54f1a711015543cbdf750004', '2.5', '2016-06-14', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cabf720000', '297ebe0e54f1a711015543c600d70001', '2', '0007', '100', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cac2410001', '297ebe0e54f1a711015543c600d70001', '2', '0008', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cac51f0002', '297ebe0e54f1a711015543c600d70001', '2', '0002', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cac7fd0003', '297ebe0e54f1a711015543c600d70001', '2', '0003', '60', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cad38d0004', '297ebe0e54f1a711015543c600d70001', '2', '0007', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cad38d0005', '297ebe0e54f1a711015543c600d70001', '2', '0007', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cad7f90006', '297ebe0e54f1a711015543c600d70001', '2', '0008', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cad8050007', '297ebe0e54f1a711015543c600d70001', '2', '0007', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cad8240008', '297ebe0e54f1a711015543c600d70001', '2', '0008', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cad8ef0009', '297ebe0e54f1a711015543c600d70001', '2', '0007', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cada4e000a', '297ebe0e54f1a711015543c600d70001', '2', '0002', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cadc5d000b', '297ebe0e54f1a711015543c600d70001', '2', '0008', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cadc6d000c', '297ebe0e54f1a711015543c600d70001', '2', '0007', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cadc70000d', '297ebe0e54f1a711015543c600d70001', '2', '0002', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cadc7f000e', '297ebe0e54f1a711015543c600d70001', '2', '0008', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cadca5000f', '297ebe0e54f1a711015543c600d70001', '2', '0003', '60', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cade1e0010', '297ebe0e54f1a711015543c600d70001', '2', '0002', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cadea90011', '297ebe0e54f1a711015543c600d70001', '2', '0008', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cadeb70012', '297ebe0e54f1a711015543c600d70001', '2', '0003', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cadf3f0013', '297ebe0e54f1a711015543c600d70001', '2', '0002', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cadfe90014', '297ebe0e54f1a711015543c600d70001', '2', '0003', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cae0e30015', '297ebe0e54f1a711015543c600d70001', '2', '0002', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cae0e50016', '297ebe0e54f1a711015543c600d70001', '2', '0007', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cae2050017', '297ebe0e54f1a711015543c600d70001', '2', '0003', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cae3310018', '297ebe0e54f1a711015543c600d70001', '2', '0003', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cae3730019', '297ebe0e54f1a711015543c600d70001', '2', '0008', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cae5b0001a', '297ebe0e54f1a711015543c600d70001', '2', '0007', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cae5c9001b', '297ebe0e54f1a711015543c600d70001', '2', '0002', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cae6d8001c', '297ebe0e54f1a711015543c600d70001', '2', '0007', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cae764001d', '297ebe0e54f1a711015543c600d70001', '2', '0007', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cae7fe001e', '297ebe0e54f1a711015543c600d70001', '2', '0008', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cae827001f', '297ebe0e54f1a711015543c600d70001', '2', '0003', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cae8a00020', '297ebe0e54f1a711015543c600d70001', '2', '0008', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cae9ce0021', '297ebe0e54f1a711015543c600d70001', '2', '0008', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568caea7a0022', '297ebe0e54f1a711015543c600d70001', '2', '0002', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568caeac20023', '297ebe0e54f1a711015543c600d70001', '2', '0002', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568caec500024', '297ebe0e54f1a711015543c600d70001', '2', '0002', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568caec5f0025', '297ebe0e54f1a711015543c600d70001', '2', '0007', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568caec960026', '297ebe0e54f1a711015543c600d70001', '2', '0003', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568caeccc0027', '297ebe0e54f1a711015543c600d70001', '2', '0003', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568caecef0028', '297ebe0e54f1a711015543c600d70001', '2', '0007', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568caeeaf0029', '297ebe0e54f1a711015543c600d70001', '2', '0003', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568caeebb002a', '297ebe0e54f1a711015543c600d70001', '2', '0008', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568caefb7002b', '297ebe0e54f1a711015543c600d70001', '2', '0008', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568caf105002c', '297ebe0e54f1a711015543c600d70001', '2', '0002', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568caf27a002d', '297ebe0e54f1a711015543c600d70001', '2', '0002', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568caf34d002e', '297ebe0e54f1a711015543c600d70001', '2', '0003', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568caf50a002f', '297ebe0e54f1a711015543c600d70001', '2', '0007', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568caf54b0030', '297ebe0e54f1a711015543c600d70001', '2', '0003', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568caf76f0031', '297ebe0e54f1a711015543c600d70001', '2', '0008', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568caf9c10032', '297ebe0e54f1a711015543c600d70001', '2', '0002', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cafbfd0033', '297ebe0e54f1a711015543c600d70001', '2', '0003', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cb18a50034', '297ebe0e54f1a71101554da35bfa0008', '2', '0007', '100', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cb1b640035', '297ebe0e54f1a71101554da35bfa0008', '2', '0008', '1', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cb1e1f0036', '297ebe0e54f1a71101554da35bfa0008', '2', '0002', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568c91d015568cb20ed0037', '297ebe0e54f1a71101554da35bfa0008', '2', '0003', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568d5ff015568d83b8b0000', 'admin', '2', '0001', '10', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568d5ff015568d83e750001', 'admin', '2', '0002', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568d5ff015568d8411d0002', 'admin', '2', '0003', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568d5ff015568d843d90003', 'admin', '2', '0004', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568d5ff015568d8463b0004', 'admin', '2', '0005', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568d5ff015568d848eb0005', 'admin', '2', '0006', '10', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568d5ff015568d84b640006', 'admin', '2', '0007', '0', '2016-06-19', '1', null);
INSERT INTO `userpoints` VALUES ('4028b8815568d5ff015568d84e320007', 'admin', '2', '0008', '0', '2016-06-19', '1', null);

-- ----------------------------
-- Table structure for `village`
-- ----------------------------
DROP TABLE IF EXISTS `village`;
CREATE TABLE `village` (
  `villageCode` varchar(40) NOT NULL COMMENT '自然村编码',
  `villageName` varchar(100) DEFAULT NULL COMMENT '自然村名称',
  `townCode` varchar(40) DEFAULT NULL COMMENT '所属乡镇',
  PRIMARY KEY (`villageCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of village
-- ----------------------------
INSERT INTO `village` VALUES ('0001', '八里庄村', '0001');
INSERT INTO `village` VALUES ('0002', '北关村', '0001');
INSERT INTO `village` VALUES ('0003', '北浪头村', '0001');
INSERT INTO `village` VALUES ('0004', '北石碑村', '0001');
INSERT INTO `village` VALUES ('0005', '柴赵村', '0001');
INSERT INTO `village` VALUES ('0006', '大裴村', '0001');
INSERT INTO `village` VALUES ('0007', '大周村', '0001');
INSERT INTO `village` VALUES ('0008', '狄家庄村', '0001');
INSERT INTO `village` VALUES ('0009', '东不落营村', '0001');
INSERT INTO `village` VALUES ('0010', '东柴村', '0001');
INSERT INTO `village` VALUES ('0011', '东关村', '0001');
INSERT INTO `village` VALUES ('0012', '东街村', '0001');
INSERT INTO `village` VALUES ('0013', '高家庄村', '0001');
INSERT INTO `village` VALUES ('0014', '韩家庄村', '0001');
INSERT INTO `village` VALUES ('0015', '后彪冢村', '0001');
INSERT INTO `village` VALUES ('0016', '胡家寨村', '0001');
INSERT INTO `village` VALUES ('0017', '焦家庄村', '0001');
INSERT INTO `village` VALUES ('0018', '李家庄村', '0001');
INSERT INTO `village` VALUES ('0019', '刘固庄村', '0001');
INSERT INTO `village` VALUES ('0020', '马家庄村', '0001');
INSERT INTO `village` VALUES ('0021', '孟家园村', '0001');
INSERT INTO `village` VALUES ('0022', '南柴村', '0001');
INSERT INTO `village` VALUES ('0023', '南关村', '0001');
INSERT INTO `village` VALUES ('0024', '南浪头村', '0001');
INSERT INTO `village` VALUES ('0025', '南李村', '0001');
INSERT INTO `village` VALUES ('0026', '南石碑村', '0001');
INSERT INTO `village` VALUES ('0027', '南五里铺村', '0001');
INSERT INTO `village` VALUES ('0028', '内营村', '0001');
INSERT INTO `village` VALUES ('0029', '聂家庄村', '0001');
INSERT INTO `village` VALUES ('0030', '前彪冢村', '0001');
INSERT INTO `village` VALUES ('0031', '寺下村', '0001');
INSERT INTO `village` VALUES ('0032', '宋家庄村', '0001');
INSERT INTO `village` VALUES ('0033', '田家庄村', '0001');
INSERT INTO `village` VALUES ('0034', '王家庄村', '0001');
INSERT INTO `village` VALUES ('0035', '西不落营村', '0001');
INSERT INTO `village` VALUES ('0036', '西董铺村', '0001');
INSERT INTO `village` VALUES ('0037', '西关村', '0001');
INSERT INTO `village` VALUES ('0038', '西街村', '0001');
INSERT INTO `village` VALUES ('0039', '小裴村', '0001');
INSERT INTO `village` VALUES ('0040', '小任家庄村', '0001');
INSERT INTO `village` VALUES ('0041', '小周村', '0001');
INSERT INTO `village` VALUES ('0042', '邢家庄村', '0001');
INSERT INTO `village` VALUES ('0043', '榆林村', '0001');
INSERT INTO `village` VALUES ('0044', '榆林道村\r\n榆林道村', '0001');
INSERT INTO `village` VALUES ('0045', '张家庄村', '0001');
INSERT INTO `village` VALUES ('0046', '赵李庄村', '0001');
INSERT INTO `village` VALUES ('0047', '朱家庄村', '0001');
INSERT INTO `village` VALUES ('0048', '北留营村', '0002');
INSERT INTO `village` VALUES ('0049', '东许营村', '0002');
INSERT INTO `village` VALUES ('0050', '东尹村', '0002');
INSERT INTO `village` VALUES ('0051', '段家营村', '0002');
INSERT INTO `village` VALUES ('0052', '段同村', '0002');
INSERT INTO `village` VALUES ('0053', '樊家屯村', '0002');
INSERT INTO `village` VALUES ('0054', '霍家屯村', '0002');
INSERT INTO `village` VALUES ('0055', '楼底村', '0002');
INSERT INTO `village` VALUES ('0056', '秦家庄村', '0002');
INSERT INTO `village` VALUES ('0057', '邵家庄村', '0002');
INSERT INTO `village` VALUES ('0058', '王家屯村', '0002');
INSERT INTO `village` VALUES ('0059', '吴家屯村', '0002');
INSERT INTO `village` VALUES ('0060', '西许营村', '0002');
INSERT INTO `village` VALUES ('0061', '西羊市村', '0002');
INSERT INTO `village` VALUES ('0062', '夏户庄村', '0002');
INSERT INTO `village` VALUES ('0063', '于底村', '0002');
INSERT INTO `village` VALUES ('0064', '北辛庄村', '0003');
INSERT INTO `village` VALUES ('0065', '程上村', '0003');
INSERT INTO `village` VALUES ('0066', '大营村', '0003');
INSERT INTO `village` VALUES ('0067', '东客村', '0003');
INSERT INTO `village` VALUES ('0068', '东留营村', '0003');
INSERT INTO `village` VALUES ('0069', '端固庄村', '0003');
INSERT INTO `village` VALUES ('0070', '乏马村', '0003');
INSERT INTO `village` VALUES ('0071', '军家营村', '0003');
INSERT INTO `village` VALUES ('0072', '南客村', '0003');
INSERT INTO `village` VALUES ('0073', '南留村', '0003');
INSERT INTO `village` VALUES ('0074', '寺上村', '0003');
INSERT INTO `village` VALUES ('0075', '苏邱村', '0003');
INSERT INTO `village` VALUES ('0076', '西留营村', '0003');
INSERT INTO `village` VALUES ('0077', '浔阳村', '0003');
INSERT INTO `village` VALUES ('0078', '冶河村', '0003');
INSERT INTO `village` VALUES ('0079', '油通村', '0003');
INSERT INTO `village` VALUES ('0080', '北陈村', '0004');
INSERT INTO `village` VALUES ('0081', '北牛家庄村', '0004');
INSERT INTO `village` VALUES ('0082', '北赵村', '0004');
INSERT INTO `village` VALUES ('0083', '北赵台村', '0004');
INSERT INTO `village` VALUES ('0084', '陈朝宇村', '0004');
INSERT INTO `village` VALUES ('0085', '窦妪村', '0004');
INSERT INTO `village` VALUES ('0086', '梅家村', '0004');
INSERT INTO `village` VALUES ('0087', '南陈村', '0004');
INSERT INTO `village` VALUES ('0088', '南牛家庄村', '0004');
INSERT INTO `village` VALUES ('0089', '南赵村', '0004');
INSERT INTO `village` VALUES ('0090', '南赵台村', '0004');
INSERT INTO `village` VALUES ('0091', '彭家庄村', '0004');
INSERT INTO `village` VALUES ('0092', '汪家庄村', '0004');
INSERT INTO `village` VALUES ('0093', '王  村', '0004');
INSERT INTO `village` VALUES ('0094', '永安村', '0004');
INSERT INTO `village` VALUES ('0095', '赵庄村', '0004');
INSERT INTO `village` VALUES ('0096', '北安乐村', '0005');
INSERT INTO `village` VALUES ('0097', '北贾村', '0005');
INSERT INTO `village` VALUES ('0098', '大孙村', '0005');
INSERT INTO `village` VALUES ('0099', '东营村', '0005');
INSERT INTO `village` VALUES ('0100', '段家庄村', '0005');
INSERT INTO `village` VALUES ('0101', '关家庄村', '0005');
INSERT INTO `village` VALUES ('0102', '郭家庄村', '0005');
INSERT INTO `village` VALUES ('0103', '河西村', '0005');
INSERT INTO `village` VALUES ('0104', '后牛村', '0005');
INSERT INTO `village` VALUES ('0105', '后小梅村', '0005');
INSERT INTO `village` VALUES ('0106', '黄家辛庄村', '0005');
INSERT INTO `village` VALUES ('0107', '连代梅村', '0005');
INSERT INTO `village` VALUES ('0108', '龙门村', '0005');
INSERT INTO `village` VALUES ('0109', '吕  村', '0005');
INSERT INTO `village` VALUES ('0110', '南安乐村', '0005');
INSERT INTO `village` VALUES ('0111', '南贾村', '0005');
INSERT INTO `village` VALUES ('0112', '南王庄村', '0005');
INSERT INTO `village` VALUES ('0113', '前牛村', '0005');
INSERT INTO `village` VALUES ('0114', '前小梅村', '0005');
INSERT INTO `village` VALUES ('0115', '石板桥村', '0005');
INSERT INTO `village` VALUES ('0116', '水磨头村', '0005');
INSERT INTO `village` VALUES ('0117', '王代梅村', '0005');
INSERT INTO `village` VALUES ('0118', '吴郭村', '0005');
INSERT INTO `village` VALUES ('0119', '吴家辛庄村', '0005');
INSERT INTO `village` VALUES ('0120', '西郭村', '0005');
INSERT INTO `village` VALUES ('0121', '西营村', '0005');
INSERT INTO `village` VALUES ('0122', '小代梅村', '0005');
INSERT INTO `village` VALUES ('0123', '小孙村', '0005');
INSERT INTO `village` VALUES ('0124', '宿  村', '0005');
INSERT INTO `village` VALUES ('0125', '沿  村', '0005');
INSERT INTO `village` VALUES ('0126', '张家辛庄村', '0005');
INSERT INTO `village` VALUES ('0127', '赵家庄村', '0005');
INSERT INTO `village` VALUES ('0128', '周家庄村', '0005');
INSERT INTO `village` VALUES ('0129', '北安庄村', '0006');
INSERT INTO `village` VALUES ('0130', '北高村', '0006');
INSERT INTO `village` VALUES ('0131', '崔家营村', '0006');
INSERT INTO `village` VALUES ('0132', '龙化村', '0006');
INSERT INTO `village` VALUES ('0133', '鲁家庄村', '0006');
INSERT INTO `village` VALUES ('0134', '南安庄村', '0006');
INSERT INTO `village` VALUES ('0135', '南高村', '0006');
INSERT INTO `village` VALUES ('0136', '南宫村', '0006');
INSERT INTO `village` VALUES ('0137', '南韩家庄村', '0006');
INSERT INTO `village` VALUES ('0138', '南十里铺村', '0006');
INSERT INTO `village` VALUES ('0139', '南屯村', '0006');
INSERT INTO `village` VALUES ('0140', '前庄村', '0006');
INSERT INTO `village` VALUES ('0141', '苏辛庄村', '0006');
INSERT INTO `village` VALUES ('0142', '温家庄村', '0006');
INSERT INTO `village` VALUES ('0143', '西安庄村', '0006');
INSERT INTO `village` VALUES ('0144', '西高村', '0006');
INSERT INTO `village` VALUES ('0145', '西宫二村', '0006');
INSERT INTO `village` VALUES ('0146', '西宫一村', '0006');
INSERT INTO `village` VALUES ('0147', '小寺安庄村', '0006');
INSERT INTO `village` VALUES ('0148', '徐家营村', '0006');
INSERT INTO `village` VALUES ('0149', '岳家庄村', '0006');
INSERT INTO `village` VALUES ('0150', '张家营村', '0006');
INSERT INTO `village` VALUES ('0151', '白佛赵村', '0007');
INSERT INTO `village` VALUES ('0152', '北十里铺村', '0007');
INSERT INTO `village` VALUES ('0153', '北屯村', '0007');
INSERT INTO `village` VALUES ('0154', '北五里铺', '0007');
INSERT INTO `village` VALUES ('0155', '北长村', '0007');
INSERT INTO `village` VALUES ('0156', '城郎村', '0007');
INSERT INTO `village` VALUES ('0157', '大任庄村', '0007');
INSERT INTO `village` VALUES ('0158', '东李庄村', '0007');
INSERT INTO `village` VALUES ('0159', '东牛村', '0007');
INSERT INTO `village` VALUES ('0160', '范台村', '0007');
INSERT INTO `village` VALUES ('0161', '岗头村', '0007');
INSERT INTO `village` VALUES ('0162', '圪塔头村', '0007');
INSERT INTO `village` VALUES ('0163', '故意村', '0007');
INSERT INTO `village` VALUES ('0164', '河庄村', '0007');
INSERT INTO `village` VALUES ('0165', '康家庄村', '0007');
INSERT INTO `village` VALUES ('0166', '柳林屯村', '0007');
INSERT INTO `village` VALUES ('0167', '孟董庄村', '0007');
INSERT INTO `village` VALUES ('0168', '乔家庄村', '0007');
INSERT INTO `village` VALUES ('0169', '寺北柴村', '0007');
INSERT INTO `village` VALUES ('0170', '夏凉村', '0007');
INSERT INTO `village` VALUES ('0171', '辛李庄村', '0007');
INSERT INTO `village` VALUES ('0172', '新建村', '0007');
INSERT INTO `village` VALUES ('0173', '张  村', '0007');

-- ----------------------------
-- Table structure for `zone`
-- ----------------------------
DROP TABLE IF EXISTS `zone`;
CREATE TABLE `zone` (
  `zoneCode` varchar(40) NOT NULL COMMENT '区域编码',
  `zoneName` varchar(100) DEFAULT NULL COMMENT '区域名称',
  `cityCode` varchar(40) DEFAULT NULL COMMENT '所属城市',
  PRIMARY KEY (`zoneCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zone
-- ----------------------------
INSERT INTO `zone` VALUES ('0001', '栾城区', '0');
