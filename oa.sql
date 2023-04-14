/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 8.0.12 : Database - imooc-oa
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`imooc-oa` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;

USE `imooc-oa`;

/*Table structure for table `adm_department` */

DROP TABLE IF EXISTS `adm_department`;

CREATE TABLE `adm_department` (
  `department_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`department_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `adm_department` */

insert  into `adm_department`(`department_id`,`department_name`) values 
(1,'总裁办'),
(2,'研发部'),
(3,'市场部');

/*Table structure for table `adm_employee` */

DROP TABLE IF EXISTS `adm_employee`;

CREATE TABLE `adm_employee` (
  `employee_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `department_id` bigint(20) NOT NULL,
  `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `level` int(255) NOT NULL,
  PRIMARY KEY (`employee_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `adm_employee` */

insert  into `adm_employee`(`employee_id`,`name`,`department_id`,`title`,`level`) values 
(1,'张晓涛',1,'总经理',8),
(2,'齐紫陌',2,'部门经理',7),
(3,'王美美',2,'高级研发工程师',6),
(4,'宋彩妮',2,'研发工程师',5),
(5,'欧阳峰',2,'初级研发工程师',4),
(6,'张世豪',3,'部门经理',7),
(7,'王子豪',3,'大客户经理',6),
(8,'段峰',3,'客户经理',5),
(9,'章雪峰',3,'客户经理',4),
(10,'李莉',3,'见习客户经理',3);

/*Table structure for table `adm_leave_form` */

DROP TABLE IF EXISTS `adm_leave_form`;

CREATE TABLE `adm_leave_form` (
  `form_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '请假单编号',
  `employee_id` bigint(20) unsigned NOT NULL COMMENT '员工编号',
  `form_type` int(10) unsigned NOT NULL COMMENT '请假类型：1事假，2病假，3工伤假，4婚假，5产假，6丧假',
  `start_time` datetime NOT NULL COMMENT '请假起始时间',
  `end_time` datetime NOT NULL COMMENT '请假结束时间',
  `reason` varchar(128) NOT NULL COMMENT '请假事由',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `state` varchar(32) NOT NULL COMMENT 'processing-正在审批，approved-审批已通过，refused-审批被驳回',
  PRIMARY KEY (`form_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `adm_leave_form` */

insert  into `adm_leave_form`(`form_id`,`employee_id`,`form_type`,`start_time`,`end_time`,`reason`,`create_time`,`state`) values 
(5,3,4,'2023-04-20 00:00:00','2023-04-29 00:00:00','回家','2023-04-14 21:36:44','approved'),
(6,3,4,'2023-04-15 00:00:00','2023-04-30 00:00:00','回家结婚','2023-04-14 22:28:03','approved');

/*Table structure for table `adm_process_flow` */

DROP TABLE IF EXISTS `adm_process_flow`;

CREATE TABLE `adm_process_flow` (
  `process_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '处理任务编号',
  `form_id` bigint(20) unsigned NOT NULL COMMENT '表单编号',
  `operator_id` bigint(20) unsigned NOT NULL COMMENT '经办人编号',
  `action` varchar(32) NOT NULL COMMENT 'apply-申请，audit-审批',
  `result` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'approved-同意，refused-驳回',
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '审批意见',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `audit_time` datetime DEFAULT NULL COMMENT '审批时间',
  `order_no` int(11) NOT NULL COMMENT '任务序号',
  `state` varchar(32) NOT NULL COMMENT 'ready-准备，process-正在处理，complete-处理完成，cancel-取消',
  `is_last` int(11) NOT NULL COMMENT '是否最后节点 0 否，1是',
  KEY `process_id` (`process_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `adm_process_flow` */

insert  into `adm_process_flow`(`process_id`,`form_id`,`operator_id`,`action`,`result`,`reason`,`create_time`,`audit_time`,`order_no`,`state`,`is_last`) values 
(1,4,4,'apply',NULL,NULL,'2023-04-14 21:33:43',NULL,1,'complete',0),
(2,4,2,'audit',NULL,NULL,'2023-04-14 21:33:44',NULL,2,'process',0),
(3,4,1,'audit',NULL,NULL,'2023-04-14 21:33:44',NULL,3,'ready',1),
(4,5,4,'apply',NULL,NULL,'2023-04-14 21:36:44',NULL,1,'complete',0),
(5,5,2,'audit','approved','通过','2023-04-14 21:36:45','2023-04-14 22:11:09',2,'complete',0),
(6,5,1,'audit','refused','不同意','2023-04-14 21:36:45','2023-04-14 22:11:54',3,'complete',1),
(7,6,3,'apply',NULL,NULL,'2023-04-14 22:28:03',NULL,1,'complete',0),
(8,6,2,'audit','approved','同意','2023-04-14 22:28:03','2023-04-14 22:29:27',2,'complete',0),
(9,6,1,'audit','approved','同意','2023-04-14 22:28:03','2023-04-14 22:30:50',3,'complete',1);

/*Table structure for table `sys_node` */

DROP TABLE IF EXISTS `sys_node`;

CREATE TABLE `sys_node` (
  `node_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '节点编号',
  `node_type` int(255) NOT NULL COMMENT '节点类型 1-模块 2-功能',
  `node_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '节点名称',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '功能地址',
  `node_code` int(255) NOT NULL COMMENT '节点编码,用于排序',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '上级节点编号',
  PRIMARY KEY (`node_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `sys_node` */

insert  into `sys_node`(`node_id`,`node_type`,`node_name`,`url`,`node_code`,`parent_id`) values 
(1,1,'行政审批',NULL,1000000,NULL),
(2,2,'通知公告','/forward/notice',1000001,1),
(3,2,'请假申请','/forward/form',1000002,1),
(4,2,'请假审批','/forward/audit',1000003,1);

/*Table structure for table `sys_notice` */

DROP TABLE IF EXISTS `sys_notice`;

CREATE TABLE `sys_notice` (
  `notice_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `receiver_id` bigint(20) NOT NULL,
  `content` varchar(255) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `sys_notice` */

insert  into `sys_notice`(`notice_id`,`receiver_id`,`content`,`create_time`) values 
(1,4,'您的请假申请[2023-04-20-00时-2023-04-29-00时]已提交,请等待上级审批.','2023-04-14 21:36:45'),
(2,2,'研发工程师-宋彩妮提起请假申请[2023-04-20-00时-2023-04-29-00时],请尽快审批.','2023-04-14 21:36:45'),
(3,4,'您的请假申请[研发工程师-宋彩妮]2023-04-20-00时2023-04-29-00时已批准,审批意见:通过,审批流程交由上级继续审批.','2023-04-14 22:11:09'),
(4,1,'研发工程师-宋彩妮提请请假申请[2023-04-20-00时-2023-04-29-00时],请尽快审批.','2023-04-14 22:11:09'),
(5,2,'研发工程师-宋彩妮提起请假申请[2023-04-20-00时-2023-04-29-00时]您已批准,审批意见:通过,审批流程交由上级继续审批.','2023-04-14 22:11:09'),
(6,4,'您的请假申请[2023-04-20-00时-2023-04-29-00时]总经理张晓涛已驳回,审批意见:不同意,审批流程已结束.','2023-04-14 22:11:54'),
(7,1,'研发工程师-宋彩妮提起请假申请[2023-04-20-00时-2023-04-29-00时]您已驳回,审批意见:不同意,审批流程已结束.','2023-04-14 22:11:54'),
(8,3,'您的请假申请[2023-04-15-00时-2023-04-30-00时]已提交,请等待上级审批.','2023-04-14 22:28:03'),
(9,2,'高级研发工程师-王美美提起请假申请[2023-04-15-00时-2023-04-30-00时],请尽快审批.','2023-04-14 22:28:03'),
(10,3,'您的请假申请[高级研发工程师-王美美]2023-04-15-00时2023-04-30-00时已批准,审批意见:同意,审批流程交由上级继续审批.','2023-04-14 22:29:27'),
(11,1,'高级研发工程师-王美美提请请假申请[2023-04-15-00时-2023-04-30-00时],请尽快审批.','2023-04-14 22:29:27'),
(12,2,'高级研发工程师-王美美提起请假申请[2023-04-15-00时-2023-04-30-00时]您已批准,审批意见:同意,审批流程交由上级继续审批.','2023-04-14 22:29:27'),
(13,3,'您的请假申请[2023-04-15-00时-2023-04-30-00时]总经理张晓涛已批准,审批意见:同意,审批流程已结束.','2023-04-14 22:30:50'),
(14,1,'高级研发工程师-王美美提起请假申请[2023-04-15-00时-2023-04-30-00时]您已批准,审批意见:同意,审批流程已结束.','2023-04-14 22:30:50');

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色编号',
  `role_description` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色描述',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `sys_role` */

insert  into `sys_role`(`role_id`,`role_description`) values 
(1,'业务岗角色'),
(2,'管理岗角色');

/*Table structure for table `sys_role_node` */

DROP TABLE IF EXISTS `sys_role_node`;

CREATE TABLE `sys_role_node` (
  `rn_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NOT NULL,
  `node_id` bigint(20) NOT NULL,
  PRIMARY KEY (`rn_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `sys_role_node` */

insert  into `sys_role_node`(`rn_id`,`role_id`,`node_id`) values 
(1,1,1),
(2,1,2),
(3,1,3),
(4,2,1),
(5,2,2),
(6,2,3),
(7,2,4);

/*Table structure for table `sys_role_user` */

DROP TABLE IF EXISTS `sys_role_user`;

CREATE TABLE `sys_role_user` (
  `ru_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`ru_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `sys_role_user` */

insert  into `sys_role_user`(`ru_id`,`role_id`,`user_id`) values 
(1,2,1),
(2,2,2),
(3,1,3),
(4,1,4),
(5,1,5),
(6,2,6),
(7,1,7),
(8,1,8),
(9,1,9),
(10,1,10),
(11,1,1);

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `employee_id` bigint(20) NOT NULL COMMENT '员工编号',
  `salt` int(255) NOT NULL COMMENT '盐值',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `sys_user` */

insert  into `sys_user`(`user_id`,`username`,`password`,`employee_id`,`salt`) values 
(1,'m8','f57e762e3fb7e1e3ec8ec4db6a1248e1',1,188),
(2,'t7','dcfa022748271dccf5532c834e98ad08',2,189),
(3,'t6','76ce11f8b004e8bdc8b0976b177c620d',3,190),
(4,'t5','11f04f04054772bc1a8fdc41e70c7977',4,191),
(5,'t4','8d7713848189a8d5c224f94f65d18b06',5,192),
(6,'s7','044214e86e07d96c97de79a2222188cd',6,193),
(7,'s6','ecbd2f592ee65838328236d06ce35252',7,194),
(8,'s5','846ecc83bba8fe420adc38b39f897201',8,195),
(9,'s4','c1e523cd2daa02f6cf4b98b2f26585fd',9,196),
(10,'s3','89e89f369e07634fbb2286efffb9492b',10,197);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
