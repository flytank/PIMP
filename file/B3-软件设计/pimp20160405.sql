/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50711
Source Host           : localhost:3306
Source Database       : pimp

Target Server Type    : MYSQL
Target Server Version : 50711
File Encoding         : 65001

Date: 2016-04-05 23:02:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `activity`
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
  `UUID` varchar(40) NOT NULL COMMENT '主键',
  `subject` varchar(100) DEFAULT NULL COMMENT '主题',
  `content` varchar(100) DEFAULT NULL COMMENT '内容',
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
  PRIMARY KEY (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='1、活动范围：区域、乡镇、自然村,根据活动范围来取所属地区的值\r\n2、职责编码：参照职责字典表中的职责编码，活';

-- ----------------------------
-- Records of activity
-- ----------------------------

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
  PRIMARY KEY (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of activityperson
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

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
INSERT INTO `authority` VALUES ('40', 'page/point', 'menu_icon fa fa-caret-right', 'point', '积分详情管理', 'pointmanagement', '41');
INSERT INTO `authority` VALUES ('41', 'page/activist', 'menu-icon fa fa-caret-right', 'activist', '入党积极分子管理', 'personalmanagement', '22');
INSERT INTO `authority` VALUES ('42', 'page/duty', 'menu-icon fa fa-caret-right', 'duty', '职责管理', 'personalmanagement', '23');

-- ----------------------------
-- Table structure for `department`
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `department_key` varchar(20) NOT NULL,
  `department_value` varchar(40) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `parent_departmentkey` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_a2k9ginqlra87vjoac9jotied` (`department_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of department
-- ----------------------------

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
INSERT INTO `duty` VALUES ('0007', '主动承担卫生清洁、民事协调等活动', null, null);
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
  `content` varchar(100) DEFAULT NULL COMMENT '留言内容',
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
  `content` varchar(100) DEFAULT NULL COMMENT '内容',
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
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8;

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
INSERT INTO `role_authority` VALUES ('186', 'authority', 'ROLE_USER');
INSERT INTO `role_authority` VALUES ('187', 'role', 'ROLE_USER');
INSERT INTO `role_authority` VALUES ('188', 'sysuser', 'ROLE_USER');
INSERT INTO `role_authority` VALUES ('189', 'party', 'ROLE_USER');
INSERT INTO `role_authority` VALUES ('190', 'activist', 'ROLE_USER');
INSERT INTO `role_authority` VALUES ('191', 'team', 'ROLE_USER');
INSERT INTO `role_authority` VALUES ('192', 'authority', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('193', 'role', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('194', 'sysuser', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('195', 'party', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('196', 'activist', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('197', 'team', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('198', 'duty', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('199', 'activity', 'ROLE_ADMIN');
INSERT INTO `role_authority` VALUES ('200', 'point', 'ROLE_ADMIN');

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
  PRIMARY KEY (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='党员类别编码：参照党员类别字典表中的党员类别编码\r\n党小组：参照党小组表中的党小组编码\r\n所属自然村';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('4028828e53c1c1240153c1c1bd240000', '001', '女', '123123122222222222', '2016-03-29', '初中', '', null, '', '0048', '0002', '0001', '2', 'town', null, '1', '001', null);
INSERT INTO `sys_user` VALUES ('4028828e53c1e56b0153c1e5cc7c0000', '002', '', '000000000000000000', null, '', '', '', '', '0049', '0002', '0001', '2', 'town', 'e10adc3949ba59abbe56e057f20f883e', '2', '002', null);
INSERT INTO `sys_user` VALUES ('4028828e53c1e56b0153c1e9f8b80001', '003', '', '000000000000000001', null, '', '', '', '', '0048', '0002', '0001', '1', 'town', null, '2', '003', null);
INSERT INTO `sys_user` VALUES ('4028958153d4c14c0153d4c95ad70000', '11', '男', '222222222222222222', '2016-04-02', '', '', '', '', '0008', '0001', '0001', '1', 'ROLE_USER', 'e10adc3949ba59abbe56e057f20f883e', '1', '006', '2016-04-02 10:24:39');
INSERT INTO `sys_user` VALUES ('4028958153e54b2e0153e54fa9670000', '3333', '男', '333333333333333333', null, '', '', '', '', '0001', '0001', '0001', '1', 'zone', 'e10adc3949ba59abbe56e057f20f883e', '1', '3333', '2016-04-05 15:25:17');
INSERT INTO `sys_user` VALUES ('admin', 'admin', '男', '213123123', '2016-03-30', '大学', null, null, null, '0049', '0001', '0001', '3', 'ROLE_ADMIN', 'e10adc3949ba59abbe56e057f20f883e', '1', 'admin', null);

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
INSERT INTO `team` VALUES ('001', '001', '0001', '0001', '0001', '111111111111');
INSERT INTO `team` VALUES ('4028828e53ac62f80153ac642cd70000', 'ggg', '0002', '0001', '0001', '');
INSERT INTO `team` VALUES ('4028828e53ac62f80153ac6574ad0001', '002', '0001', '0001', '0001', '');
INSERT INTO `team` VALUES ('4028828e53ac80450153ac808f780000', 'fff', '0048', '0002', '0001', '');
INSERT INTO `team` VALUES ('4028828e53c194500153c194abae0000', 'dd', '0066', '0003', '0001', '');

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
