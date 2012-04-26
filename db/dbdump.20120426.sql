BEGIN TRANSACTION;
DELETE FROM sqlite_sequence;
CREATE TABLE "auth_permission" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(50) NOT NULL,
    "content_type_id" integer NOT NULL,
    "codename" varchar(100) NOT NULL,
    UNIQUE ("content_type_id", "codename")
);
INSERT INTO "auth_permission" VALUES(1,'Can add permission',1,'add_permission');
INSERT INTO "auth_permission" VALUES(2,'Can change permission',1,'change_permission');
INSERT INTO "auth_permission" VALUES(3,'Can delete permission',1,'delete_permission');
INSERT INTO "auth_permission" VALUES(4,'Can add group',2,'add_group');
INSERT INTO "auth_permission" VALUES(5,'Can change group',2,'change_group');
INSERT INTO "auth_permission" VALUES(6,'Can delete group',2,'delete_group');
INSERT INTO "auth_permission" VALUES(7,'Can add user',3,'add_user');
INSERT INTO "auth_permission" VALUES(8,'Can change user',3,'change_user');
INSERT INTO "auth_permission" VALUES(9,'Can delete user',3,'delete_user');
INSERT INTO "auth_permission" VALUES(10,'Can add message',4,'add_message');
INSERT INTO "auth_permission" VALUES(11,'Can change message',4,'change_message');
INSERT INTO "auth_permission" VALUES(12,'Can delete message',4,'delete_message');
INSERT INTO "auth_permission" VALUES(13,'Can add content type',5,'add_contenttype');
INSERT INTO "auth_permission" VALUES(14,'Can change content type',5,'change_contenttype');
INSERT INTO "auth_permission" VALUES(15,'Can delete content type',5,'delete_contenttype');
INSERT INTO "auth_permission" VALUES(16,'Can add session',6,'add_session');
INSERT INTO "auth_permission" VALUES(17,'Can change session',6,'change_session');
INSERT INTO "auth_permission" VALUES(18,'Can delete session',6,'delete_session');
INSERT INTO "auth_permission" VALUES(19,'Can add site',7,'add_site');
INSERT INTO "auth_permission" VALUES(20,'Can change site',7,'change_site');
INSERT INTO "auth_permission" VALUES(21,'Can delete site',7,'delete_site');
INSERT INTO "auth_permission" VALUES(22,'Can add course',8,'add_course');
INSERT INTO "auth_permission" VALUES(23,'Can change course',8,'change_course');
INSERT INTO "auth_permission" VALUES(24,'Can delete course',8,'delete_course');
INSERT INTO "auth_permission" VALUES(25,'Can add librarian',9,'add_librarian');
INSERT INTO "auth_permission" VALUES(26,'Can change librarian',9,'change_librarian');
INSERT INTO "auth_permission" VALUES(27,'Can delete librarian',9,'delete_librarian');
INSERT INTO "auth_permission" VALUES(28,'Can add session type',10,'add_sessiontype');
INSERT INTO "auth_permission" VALUES(29,'Can change session type',10,'change_sessiontype');
INSERT INTO "auth_permission" VALUES(30,'Can delete session type',10,'delete_sessiontype');
INSERT INTO "auth_permission" VALUES(31,'Can add session',11,'add_session');
INSERT INTO "auth_permission" VALUES(32,'Can change session',11,'change_session');
INSERT INTO "auth_permission" VALUES(33,'Can delete session',11,'delete_session');
INSERT INTO "auth_permission" VALUES(34,'Can add student',12,'add_student');
INSERT INTO "auth_permission" VALUES(35,'Can change student',12,'change_student');
INSERT INTO "auth_permission" VALUES(36,'Can delete student',12,'delete_student');
INSERT INTO "auth_permission" VALUES(37,'Can add student snapshot',13,'add_studentsnapshot');
INSERT INTO "auth_permission" VALUES(38,'Can change student snapshot',13,'change_studentsnapshot');
INSERT INTO "auth_permission" VALUES(39,'Can delete student snapshot',13,'delete_studentsnapshot');
INSERT INTO "auth_permission" VALUES(40,'Can add log entry',14,'add_logentry');
INSERT INTO "auth_permission" VALUES(41,'Can change log entry',14,'change_logentry');
INSERT INTO "auth_permission" VALUES(42,'Can delete log entry',14,'delete_logentry');
INSERT INTO "auth_permission" VALUES(43,'Can add location',16,'add_location');
INSERT INTO "auth_permission" VALUES(44,'Can change location',16,'change_location');
INSERT INTO "auth_permission" VALUES(45,'Can delete location',16,'delete_location');
INSERT INTO "auth_permission" VALUES(46,'Can add session format',15,'add_sessionformat');
INSERT INTO "auth_permission" VALUES(47,'Can change session format',15,'change_sessionformat');
INSERT INTO "auth_permission" VALUES(48,'Can delete session format',15,'delete_sessionformat');
CREATE TABLE "auth_group_permissions" (
    "id" integer NOT NULL PRIMARY KEY,
    "group_id" integer NOT NULL,
    "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id"),
    UNIQUE ("group_id", "permission_id")
);
CREATE TABLE "auth_group" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(80) NOT NULL UNIQUE
);
CREATE TABLE "auth_user_user_permissions" (
    "id" integer NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL,
    "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id"),
    UNIQUE ("user_id", "permission_id")
);
CREATE TABLE "auth_user_groups" (
    "id" integer NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL,
    "group_id" integer NOT NULL REFERENCES "auth_group" ("id"),
    UNIQUE ("user_id", "group_id")
);
CREATE TABLE "auth_user" (
    "id" integer NOT NULL PRIMARY KEY,
    "username" varchar(30) NOT NULL UNIQUE,
    "first_name" varchar(30) NOT NULL,
    "last_name" varchar(30) NOT NULL,
    "email" varchar(75) NOT NULL,
    "password" varchar(128) NOT NULL,
    "is_staff" bool NOT NULL,
    "is_active" bool NOT NULL,
    "is_superuser" bool NOT NULL,
    "last_login" datetime NOT NULL,
    "date_joined" datetime NOT NULL
);
INSERT INTO "auth_user" VALUES(1,'dario.alvarezmiranda','','','dalvarez@eecs.wsu.edu','sha1$4705e$47b75b91842946c05e88d22ec37cf73b09ed36d3',1,1,1,'2012-04-23 15:45:06.255000','2012-03-12 11:52:58.743000');
INSERT INTO "auth_user" VALUES(2,'sborrelli','Steve','Borrelli','sborrelli@wsu.edu','sha1$489e4$42873ba573e62bd4ddb8b12bcf094bc462605d36',1,1,1,'2012-04-23 11:59:10.520889','2012-04-23 11:44:16');
CREATE TABLE "auth_message" (
    "id" integer NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id"),
    "message" text NOT NULL
);
CREATE TABLE "django_content_type" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(100) NOT NULL,
    "app_label" varchar(100) NOT NULL,
    "model" varchar(100) NOT NULL,
    UNIQUE ("app_label", "model")
);
INSERT INTO "django_content_type" VALUES(1,'permission','auth','permission');
INSERT INTO "django_content_type" VALUES(2,'group','auth','group');
INSERT INTO "django_content_type" VALUES(3,'user','auth','user');
INSERT INTO "django_content_type" VALUES(4,'message','auth','message');
INSERT INTO "django_content_type" VALUES(5,'content type','contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES(6,'session','sessions','session');
INSERT INTO "django_content_type" VALUES(7,'site','sites','site');
INSERT INTO "django_content_type" VALUES(8,'course','lis','course');
INSERT INTO "django_content_type" VALUES(9,'librarian','lis','librarian');
INSERT INTO "django_content_type" VALUES(10,'session type','lis','sessiontype');
INSERT INTO "django_content_type" VALUES(11,'session','lis','session');
INSERT INTO "django_content_type" VALUES(12,'student','lis','student');
INSERT INTO "django_content_type" VALUES(13,'student snapshot','lis','studentsnapshot');
INSERT INTO "django_content_type" VALUES(14,'log entry','admin','logentry');
INSERT INTO "django_content_type" VALUES(15,'session format','lis','sessionformat');
INSERT INTO "django_content_type" VALUES(16,'location','lis','location');
CREATE TABLE "django_session" (
    "session_key" varchar(40) NOT NULL PRIMARY KEY,
    "session_data" text NOT NULL,
    "expire_date" datetime NOT NULL
);
INSERT INTO "django_session" VALUES('876a1e03190ae86166ebd3d206d8184b','MTJkZDVhYzEwZTRlZTJkOTE3YzUyNjBlMmJiMDI2NzNiZjFlZjJkNDqAAn1xAShVEl9hdXRoX3Vz
ZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED
VQ1fYXV0aF91c2VyX2lkcQRLAXUu
','2012-04-11 11:27:37.901000');
INSERT INTO "django_session" VALUES('4c1698a297c7bec4e013c997ec961276','MDBjYTNhMTE2Y2ZkYTE3MzU1NmI2NGQ2ZDliMGY2MGM1ODQxMzcyMDqAAn1xAVUKdGVzdGNvb2tp
ZXECVQZ3b3JrZWRxA3Mu
','2012-05-01 08:55:44.852696');
INSERT INTO "django_session" VALUES('eda2f0e03689058045e398ed8bcd4c54','MTJkZDVhYzEwZTRlZTJkOTE3YzUyNjBlMmJiMDI2NzNiZjFlZjJkNDqAAn1xAShVEl9hdXRoX3Vz
ZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED
VQ1fYXV0aF91c2VyX2lkcQRLAXUu
','2012-05-07 11:51:01.392124');
INSERT INTO "django_session" VALUES('26b7be142dc1aecc9781b5aa368cff09','MmI4MmFmYWIxNWE0MzdiMDJiZWQ1YmY0ZTQ5ZDQ1NjMxMmQ5NWViMTqAAn1xAShVEl9hdXRoX3Vz
ZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED
VQ1fYXV0aF91c2VyX2lkcQRLAnUu
','2012-05-07 11:59:10.537083');
INSERT INTO "django_session" VALUES('48964cfdd708ac985e8eac171217f05b','MTVmYTYzMzMwNDgzMDE0ODIxZjM1OTA1MTNkYTY2OWFlOWJjZGIwNjqAAn1xAS4=
','2012-05-07 15:45:15.708000');
CREATE TABLE "django_site" (
    "id" integer NOT NULL PRIMARY KEY,
    "domain" varchar(100) NOT NULL,
    "name" varchar(50) NOT NULL
);
INSERT INTO "django_site" VALUES(1,'example.com','example.com');
CREATE TABLE "django_admin_log" (
    "id" integer NOT NULL PRIMARY KEY,
    "action_time" datetime NOT NULL,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id"),
    "content_type_id" integer REFERENCES "django_content_type" ("id"),
    "object_id" text,
    "object_repr" varchar(200) NOT NULL,
    "action_flag" smallint unsigned NOT NULL,
    "change_message" text NOT NULL
);
INSERT INTO "django_admin_log" VALUES(1,'2012-03-13 09:51:52.623000',1,8,'1','Course object',1,'');
INSERT INTO "django_admin_log" VALUES(2,'2012-03-13 13:44:45.952000',1,8,'1','Course object',1,'');
INSERT INTO "django_admin_log" VALUES(3,'2012-03-13 13:44:56.111000',1,8,'1','Course object',2,'Changed instructor, course_location, academic_location, academic_term and snapshot_date.');
INSERT INTO "django_admin_log" VALUES(4,'2012-03-13 13:45:58.567000',1,8,'2','Course object',1,'');
INSERT INTO "django_admin_log" VALUES(5,'2012-03-13 13:48:07.617000',1,10,'1','SessionType object',1,'');
INSERT INTO "django_admin_log" VALUES(6,'2012-03-13 13:57:34.850000',1,9,'1','Lara Cummings',1,'');
INSERT INTO "django_admin_log" VALUES(7,'2012-03-13 13:57:42.324000',1,9,'2','Stephen Borrelli',1,'');
INSERT INTO "django_admin_log" VALUES(8,'2012-03-13 13:58:19.602000',1,10,'2','Course Related Instruction',1,'');
INSERT INTO "django_admin_log" VALUES(9,'2012-03-13 13:58:30.251000',1,10,'3','Partner Program',1,'');
INSERT INTO "django_admin_log" VALUES(10,'2012-03-13 13:58:38.116000',1,10,'4','Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(11,'2012-03-13 14:01:56.372000',1,15,'1','Online',1,'');
INSERT INTO "django_admin_log" VALUES(12,'2012-03-13 14:02:07.130000',1,15,'2','In person',1,'');
INSERT INTO "django_admin_log" VALUES(13,'2012-03-13 14:02:16.355000',1,11,'1','Session object',1,'');
INSERT INTO "django_admin_log" VALUES(14,'2012-03-13 14:02:30.615000',1,11,'2','Session object',1,'');
INSERT INTO "django_admin_log" VALUES(15,'2012-03-14 12:56:38.049000',1,12,'1','12457854',1,'');
INSERT INTO "django_admin_log" VALUES(16,'2012-03-14 12:57:01.677000',1,12,'2','25412478',1,'');
INSERT INTO "django_admin_log" VALUES(17,'2012-03-14 13:15:20.565000',1,12,'3',', ',1,'');
INSERT INTO "django_admin_log" VALUES(18,'2012-03-14 13:20:02.961000',1,8,'2','ARCH 101',2,'Changed students.');
INSERT INTO "django_admin_log" VALUES(19,'2012-03-19 12:35:27.996000',1,8,'2','ARCH 101',2,'Changed academic_course_number, section and instructor.');
INSERT INTO "django_admin_log" VALUES(20,'2012-03-19 12:35:37.934000',1,8,'1','ENGL 101',2,'Changed academic_course_number, section and instructor.');
INSERT INTO "django_admin_log" VALUES(21,'2012-03-19 12:45:11.934000',1,16,'2','WSU Spokane',1,'');
INSERT INTO "django_admin_log" VALUES(22,'2012-03-19 12:45:19.168000',1,16,'3','WSU Vancouver',1,'');
INSERT INTO "django_admin_log" VALUES(23,'2012-03-19 12:45:34.340000',1,16,'4','WSU Tri-Cities',1,'');
INSERT INTO "django_admin_log" VALUES(24,'2012-03-19 12:45:38.793000',1,16,'5','WSU Online',1,'');
INSERT INTO "django_admin_log" VALUES(25,'2012-03-19 12:47:02.731000',1,12,'3','11214947',2,'No fields changed.');
INSERT INTO "django_admin_log" VALUES(26,'2012-03-19 12:47:10.934000',1,12,'4','11252428',1,'');
INSERT INTO "django_admin_log" VALUES(27,'2012-03-19 12:48:16.184000',1,8,'2','ARCH 101',2,'No fields changed.');
INSERT INTO "django_admin_log" VALUES(28,'2012-03-20 13:12:45.813000',1,8,'2','ARCH 101',2,'Changed students.');
INSERT INTO "django_admin_log" VALUES(29,'2012-03-21 12:19:32.518000',1,15,'1','Online',1,'');
INSERT INTO "django_admin_log" VALUES(30,'2012-03-21 12:19:36.416000',1,15,'2','In person',1,'');
INSERT INTO "django_admin_log" VALUES(31,'2012-03-21 12:19:47.842000',1,11,'3','2010-09-08 - Composition',1,'');
INSERT INTO "django_admin_log" VALUES(32,'2012-03-21 12:19:55.058000',1,11,'3','2011-09-08 - Composition',2,'Changed date.');
INSERT INTO "django_admin_log" VALUES(33,'2012-03-26 10:24:47.878000',1,8,'3','GEOL 101',1,'');
INSERT INTO "django_admin_log" VALUES(34,'2012-03-26 11:22:22.899000',1,8,'1','ENGL 101',2,'Changed students.');
INSERT INTO "django_admin_log" VALUES(35,'2012-03-26 11:22:42.384000',1,8,'2','ARCH 101',2,'Changed students.');
INSERT INTO "django_admin_log" VALUES(36,'2012-03-26 11:23:00.416000',1,8,'1','ENGL 101',2,'Changed students.');
INSERT INTO "django_admin_log" VALUES(37,'2012-03-26 12:23:44.353000',1,8,'3','GEOL 101',2,'Changed students.');
INSERT INTO "django_admin_log" VALUES(38,'2012-04-03 14:25:36.096000',1,9,'1','Lara Cummings',1,'');
INSERT INTO "django_admin_log" VALUES(39,'2012-04-03 14:25:49.808000',1,9,'2','Stephen Borrelli',1,'');
INSERT INTO "django_admin_log" VALUES(40,'2012-04-03 14:26:01.268000',1,9,'3','Corey Johnson',1,'');
INSERT INTO "django_admin_log" VALUES(41,'2012-04-03 14:26:07.912000',1,9,'4','Jane Scales',1,'');
INSERT INTO "django_admin_log" VALUES(42,'2012-04-03 14:26:31.927000',1,9,'5','Gilles Brady',1,'');
INSERT INTO "django_admin_log" VALUES(43,'2012-04-03 14:27:23.599000',1,9,'6','Betty Galbraith',1,'');
INSERT INTO "django_admin_log" VALUES(44,'2012-04-03 14:27:45.518000',1,9,'7','Zinthia Briceno',1,'');
INSERT INTO "django_admin_log" VALUES(45,'2012-04-03 14:28:03.436000',1,9,'8','Gabriella Reznowski',1,'');
INSERT INTO "django_admin_log" VALUES(46,'2012-04-03 14:28:12.660000',1,9,'9','Erica Nicol',1,'');
INSERT INTO "django_admin_log" VALUES(47,'2012-04-03 14:28:46.587000',1,10,'1','Compos',1,'');
INSERT INTO "django_admin_log" VALUES(48,'2012-04-03 14:28:53.106000',1,10,'2','Course Related Instruction',1,'');
INSERT INTO "django_admin_log" VALUES(49,'2012-04-03 14:28:57.719000',1,10,'3','Partner Program',1,'');
INSERT INTO "django_admin_log" VALUES(50,'2012-04-03 14:29:03.535000',1,10,'4','Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(51,'2012-04-03 14:29:17.965000',1,15,'1','In person',1,'');
INSERT INTO "django_admin_log" VALUES(52,'2012-04-03 14:29:20.576000',1,15,'2','Online',1,'');
INSERT INTO "django_admin_log" VALUES(53,'2012-04-03 14:31:31.984000',1,11,'1','2011-07-07 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(54,'2012-04-03 14:32:14.448000',1,11,'2','2011-07-11 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(55,'2012-04-03 14:32:33.725000',1,11,'3','2011-07-15 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(56,'2012-04-03 14:33:02.946000',1,11,'4','2011-07-20 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(57,'2012-04-03 14:33:40.922000',1,11,'5','2011-07-25 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(58,'2012-04-03 14:34:10.096000',1,11,'6','2011-07-29 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(59,'2012-04-03 14:35:16.449000',1,11,'7','2011-08-02 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(60,'2012-04-03 14:35:57.927000',1,11,'8','2011-09-06 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(61,'2012-04-03 14:36:40.797000',1,11,'9','2011-09-14 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(62,'2012-04-03 14:37:30.218000',1,11,'9','2011-09-14 - Tour/Workshop',2,'Changed number_of_users.');
INSERT INTO "django_admin_log" VALUES(63,'2012-04-03 14:38:01.784000',1,11,'10','2011-09-14 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(64,'2012-04-03 14:38:35.773000',1,11,'11','2011-09-14 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(65,'2012-04-03 14:40:25.402000',1,11,'12','2011-10-12 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(66,'2012-04-03 14:40:36.721000',1,11,'11','2011-09-07 - Tour/Workshop',2,'Changed date.');
INSERT INTO "django_admin_log" VALUES(67,'2012-04-03 14:41:40.401000',1,11,'13','2011-12-13 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(68,'2012-04-03 14:43:33.157000',1,9,'10','Linda Crook',1,'');
INSERT INTO "django_admin_log" VALUES(69,'2012-04-03 14:43:49.323000',1,9,'11','Vicki Croft',1,'');
INSERT INTO "django_admin_log" VALUES(70,'2012-04-03 14:44:23.125000',1,9,'12','Bob Matuozzi',1,'');
INSERT INTO "django_admin_log" VALUES(71,'2012-04-03 14:45:00.444000',1,9,'13','Lorena Oenglish',1,'');
INSERT INTO "django_admin_log" VALUES(72,'2012-04-03 14:45:14.703000',1,9,'14','Lou Vyhnanek',1,'');
INSERT INTO "django_admin_log" VALUES(73,'2012-04-03 14:45:51.678000',1,9,'13','Lorena O''English',2,'Changed last_name.');
INSERT INTO "django_admin_log" VALUES(74,'2012-04-03 14:46:34.720000',1,9,'5','Eileen Brady',2,'Changed first_name.');
INSERT INTO "django_admin_log" VALUES(75,'2012-04-03 14:46:40.724000',1,9,'15','Mary Gilles',1,'');
INSERT INTO "django_admin_log" VALUES(76,'2012-04-03 14:46:58.172000',1,9,'16','Marilyn Von Seggern',1,'');
INSERT INTO "django_admin_log" VALUES(77,'2012-04-03 14:47:33.631000',1,9,'17','MASC  ',1,'');
INSERT INTO "django_admin_log" VALUES(78,'2012-04-03 14:48:43.142000',1,11,'14','2011-08-04 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(79,'2012-04-03 14:49:12.519000',1,9,'18','Multiple  ',1,'');
INSERT INTO "django_admin_log" VALUES(80,'2012-04-03 14:49:49.354000',1,11,'15','2011-07-19 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(81,'2012-04-03 14:50:22.703000',1,11,'16','2011-07-20 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(82,'2012-04-03 14:50:51.517000',1,11,'17','2011-08-03 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(83,'2012-04-03 14:51:10.388000',1,11,'18','2011-08-08 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(84,'2012-04-03 14:51:23.505000',1,11,'19','2011-09-01 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(85,'2012-04-03 14:51:42.845000',1,11,'20','2011-09-07 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(86,'2012-04-03 14:52:20.383000',1,11,'21','2011-09-15 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(87,'2012-04-03 14:52:46.571000',1,11,'22','2011-09-21 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(88,'2012-04-03 14:52:59.923000',1,11,'23','2011-09-28 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(89,'2012-04-03 14:53:22.531000',1,11,'24','2011-10-14 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(90,'2012-04-03 14:56:11.211000',1,11,'25','2011-10-19 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(91,'2012-04-03 14:56:50.047000',1,11,'26','2011-11-03 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(92,'2012-04-03 14:57:24.881000',1,11,'27','2011-11-09 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(93,'2012-04-03 14:57:37.561000',1,11,'28','2011-12-08 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(94,'2012-04-03 14:58:23.135000',1,11,'29','2011-11-02 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(95,'2012-04-03 14:58:52.293000',1,11,'30','2011-07-27 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(96,'2012-04-03 14:59:08.303000',1,11,'31','2011-08-03 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(97,'2012-04-03 14:59:45.717000',1,11,'32','2011-08-10 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(98,'2012-04-03 15:00:08.527000',1,11,'33','2011-08-17 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(99,'2012-04-03 15:00:32.792000',1,11,'34','2011-10-27 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(100,'2012-04-03 15:01:01.794000',1,11,'35','2011-11-09 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(101,'2012-04-03 15:01:29.514000',1,11,'36','2011-11-16 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(102,'2012-04-03 15:06:45.534000',1,16,'1','WSU Pullman',1,'');
INSERT INTO "django_admin_log" VALUES(103,'2012-04-03 15:06:49.067000',1,8,'1','HIST 422',1,'');
INSERT INTO "django_admin_log" VALUES(104,'2012-04-03 15:06:58.808000',1,16,'2','WSU Spokane',1,'');
INSERT INTO "django_admin_log" VALUES(105,'2012-04-03 15:07:03.529000',1,16,'3','WSU Vancouver',1,'');
INSERT INTO "django_admin_log" VALUES(106,'2012-04-03 15:07:07.938000',1,16,'4','WSU Tri-Cities',1,'');
INSERT INTO "django_admin_log" VALUES(107,'2012-04-03 15:07:12.441000',1,16,'5','WSU Online',1,'');
INSERT INTO "django_admin_log" VALUES(108,'2012-04-03 15:07:32.187000',1,8,'2','BE 322',1,'');
INSERT INTO "django_admin_log" VALUES(109,'2012-04-03 15:07:55.592000',1,8,'3','BE 205',1,'');
INSERT INTO "django_admin_log" VALUES(110,'2012-04-03 15:08:12.274000',1,8,'4','BE 410',1,'');
INSERT INTO "django_admin_log" VALUES(111,'2012-04-03 15:08:29.566000',1,8,'5','ChE 596',1,'');
INSERT INTO "django_admin_log" VALUES(112,'2012-04-03 15:08:37.931000',1,8,'6','ChE 450',1,'');
INSERT INTO "django_admin_log" VALUES(113,'2012-04-04 11:59:52.444000',1,8,'6','ChE 450',2,'Changed academic_term.');
INSERT INTO "django_admin_log" VALUES(114,'2012-04-04 12:00:00.792000',1,8,'5','ChE 596',2,'Changed academic_term.');
INSERT INTO "django_admin_log" VALUES(115,'2012-04-04 12:00:08.577000',1,8,'4','BE 410',2,'Changed academic_term.');
INSERT INTO "django_admin_log" VALUES(116,'2012-04-04 12:00:14.330000',1,8,'3','BE 205',2,'Changed academic_term.');
INSERT INTO "django_admin_log" VALUES(117,'2012-04-04 12:00:24.866000',1,8,'2','BE 322',2,'Changed academic_term.');
INSERT INTO "django_admin_log" VALUES(118,'2012-04-04 12:00:30.478000',1,8,'1','HIST 422',2,'Changed academic_term.');
INSERT INTO "django_admin_log" VALUES(119,'2012-04-04 12:07:51.796000',1,11,'37','2011-08-15 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(120,'2012-04-04 12:08:19.497000',1,11,'38','2011-08-15 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(121,'2012-04-04 12:08:54.920000',1,11,'39','2011-08-15 - Tour/Workshop',1,'');
INSERT INTO "django_admin_log" VALUES(122,'2012-04-04 12:11:02.762000',1,9,'19','Trevor Bond',1,'');
INSERT INTO "django_admin_log" VALUES(123,'2012-04-04 12:11:25.898000',1,11,'40','2011-09-11 - Course Related Instruction',1,'');
INSERT INTO "django_admin_log" VALUES(124,'2012-04-04 12:19:46.369000',1,11,'40','2011-11-09 - Course Related Instruction',2,'Changed date.');
INSERT INTO "django_admin_log" VALUES(125,'2012-04-04 12:20:29.905000',1,11,'41','2011-09-12 - Course Related Instruction',1,'');
INSERT INTO "django_admin_log" VALUES(126,'2012-04-04 12:21:03.499000',1,11,'42','2011-09-13 - Course Related Instruction',1,'');
INSERT INTO "django_admin_log" VALUES(127,'2012-04-04 12:21:51.881000',1,11,'43','2011-09-13 - Course Related Instruction',1,'');
INSERT INTO "django_admin_log" VALUES(128,'2012-04-04 12:22:19.879000',1,11,'44','2011-10-18 - Course Related Instruction',1,'');
INSERT INTO "django_admin_log" VALUES(129,'2012-04-04 12:23:12.122000',1,11,'45','2011-10-20 - Course Related Instruction',1,'');
INSERT INTO "django_admin_log" VALUES(130,'2012-04-04 12:23:28.849000',1,11,'46','2011-10-26 - Course Related Instruction',1,'');
INSERT INTO "django_admin_log" VALUES(131,'2012-04-04 12:23:51.344000',1,11,'47','2011-10-27 - Course Related Instruction',1,'');
INSERT INTO "django_admin_log" VALUES(132,'2012-04-04 12:24:18.529000',1,11,'48','2011-10-28 - Course Related Instruction',1,'');
INSERT INTO "django_admin_log" VALUES(133,'2012-04-04 12:24:32.285000',1,11,'46','2011-10-26 - Course Related Instruction',2,'Changed gov_docs.');
INSERT INTO "django_admin_log" VALUES(134,'2012-04-04 12:24:42.712000',1,11,'44','2011-10-18 - Course Related Instruction',2,'Changed gov_docs.');
INSERT INTO "django_admin_log" VALUES(135,'2012-04-04 12:26:43.285000',1,11,'49','2011-10-31 - Course Related Instruction',1,'');
INSERT INTO "django_admin_log" VALUES(136,'2012-04-04 12:27:15.206000',1,11,'50','2011-10-31 - Course Related Instruction',1,'');
INSERT INTO "django_admin_log" VALUES(137,'2012-04-04 12:27:44.361000',1,11,'51','2011-11-01 - Course Related Instruction',1,'');
INSERT INTO "django_admin_log" VALUES(138,'2012-04-04 12:28:07.950000',1,11,'52','2011-11-04 - Course Related Instruction',1,'');
INSERT INTO "django_admin_log" VALUES(139,'2012-04-04 12:28:46.828000',1,11,'53','2011-09-20 - Course Related Instruction',1,'');
INSERT INTO "django_admin_log" VALUES(140,'2012-04-04 12:29:31.427000',1,11,'54','2011-11-28 - Course Related Instruction',1,'');
INSERT INTO "django_admin_log" VALUES(141,'2012-04-04 12:30:21.326000',1,11,'55','2011-11-30 - Course Related Instruction',1,'');
INSERT INTO "django_admin_log" VALUES(142,'2012-04-04 13:04:22.870000',1,8,'7','Fall 2011 - ARCH 101',1,'');
INSERT INTO "django_admin_log" VALUES(143,'2012-04-04 13:04:32.312000',1,8,'8','Fall 2011 - ARCH 101',1,'');
INSERT INTO "django_admin_log" VALUES(144,'2012-04-04 13:04:58.872000',1,8,'9',' - BIOL 393',1,'');
INSERT INTO "django_admin_log" VALUES(145,'2012-04-04 13:05:11.456000',1,8,'10','Fall 2011 - BIOL 418',1,'');
INSERT INTO "django_admin_log" VALUES(146,'2012-04-04 13:05:22.664000',1,8,'11',' - BIOL 251',1,'');
INSERT INTO "django_admin_log" VALUES(147,'2012-04-04 13:05:30.965000',1,8,'11','Fall 2011 - BIOL 251',2,'Changed academic_term.');
INSERT INTO "django_admin_log" VALUES(148,'2012-04-04 13:05:35.561000',1,8,'9','Fall 2011 - BIOL 393',2,'Changed academic_term.');
INSERT INTO "django_admin_log" VALUES(149,'2012-04-04 13:05:58.212000',1,8,'12','Fall 2011 - CE 580',1,'');
INSERT INTO "django_admin_log" VALUES(150,'2012-04-04 13:06:11.422000',1,8,'13','Fall 2011 - ESRP 592',1,'');
INSERT INTO "django_admin_log" VALUES(151,'2012-04-04 13:06:31.275000',1,8,'14','Fall 2011 - GEOL 598',1,'');
INSERT INTO "django_admin_log" VALUES(152,'2012-04-04 13:06:42.124000',1,8,'15','Fall 2011 - GEOL 210',1,'');
INSERT INTO "django_admin_log" VALUES(153,'2012-04-04 13:06:53.957000',1,8,'16','Fall 2011 - GEOL 101',1,'');
INSERT INTO "django_admin_log" VALUES(154,'2012-04-23 11:44:16.636642',1,3,'2','sborrelli',1,'');
INSERT INTO "django_admin_log" VALUES(155,'2012-04-23 11:44:41.644322',1,3,'2','sborrelli',2,'Changed is_superuser.');
INSERT INTO "django_admin_log" VALUES(156,'2012-04-23 11:46:14.172587',1,3,'2','sborrelli',2,'Changed user_permissions.');
INSERT INTO "django_admin_log" VALUES(157,'2012-04-23 11:47:11.861555',1,3,'2','sborrelli',2,'Changed is_staff and user_permissions.');
INSERT INTO "django_admin_log" VALUES(158,'2012-04-23 11:57:17.865197',2,3,'2','sborrelli',2,'Changed first_name, last_name and email.');
INSERT INTO "django_admin_log" VALUES(159,'2012-04-23 11:57:33.386595',2,3,'2','sborrelli',2,'No fields changed.');
CREATE TABLE "lis_courses_students" (
    "id" integer NOT NULL PRIMARY KEY,
    "course_id" integer NOT NULL,
    "student_id" integer NOT NULL,
    UNIQUE ("course_id", "student_id")
);
CREATE TABLE "lis_courses" (
    "course_id" integer NOT NULL PRIMARY KEY,
    "academic_field" varchar(20) NOT NULL,
    "academic_course_number" varchar(10) NOT NULL,
    "section" varchar(20),
    "instructor" varchar(40) NOT NULL,
    "academic_location_id" integer NOT NULL,
    "academic_term" varchar(20) NOT NULL,
    "snapshot_date" date
);
INSERT INTO "lis_courses" VALUES(1,'HIST','422','','McCoy',1,'Fall 2011',NULL);
INSERT INTO "lis_courses" VALUES(2,'BE','322','','',1,'Fall 2011',NULL);
INSERT INTO "lis_courses" VALUES(3,'BE','205','Vasavada','',1,'Fall 2011',NULL);
INSERT INTO "lis_courses" VALUES(4,'BE','410','','Davis',1,'Fall 2011',NULL);
INSERT INTO "lis_courses" VALUES(5,'ChE','596','','Petersen',1,'Fall 2011',NULL);
INSERT INTO "lis_courses" VALUES(6,'ChE','450','','',1,'Fall 2011',NULL);
INSERT INTO "lis_courses" VALUES(7,'ARCH','101','1','',1,'Fall 2011',NULL);
INSERT INTO "lis_courses" VALUES(8,'ARCH','101','2','',1,'Fall 2011',NULL);
INSERT INTO "lis_courses" VALUES(9,'BIOL','393','','',1,'Fall 2011',NULL);
INSERT INTO "lis_courses" VALUES(10,'BIOL','418','','Davitt',1,'Fall 2011',NULL);
INSERT INTO "lis_courses" VALUES(11,'BIOL','251','','',1,'Fall 2011',NULL);
INSERT INTO "lis_courses" VALUES(12,'CE','580','','',1,'Fall 2011',NULL);
INSERT INTO "lis_courses" VALUES(13,'ESRP','592','','',1,'Fall 2011',NULL);
INSERT INTO "lis_courses" VALUES(14,'GEOL','598','','',1,'Fall 2011',NULL);
INSERT INTO "lis_courses" VALUES(15,'GEOL','210','','',1,'Fall 2011',NULL);
INSERT INTO "lis_courses" VALUES(16,'GEOL','101','','',1,'Fall 2011',NULL);
CREATE TABLE "lis_locations" (
    "location_id" integer NOT NULL PRIMARY KEY,
    "name" varchar(40) NOT NULL,
    "description" varchar(200)
);
INSERT INTO "lis_locations" VALUES(1,'WSU Pullman','');
INSERT INTO "lis_locations" VALUES(2,'WSU Spokane','');
INSERT INTO "lis_locations" VALUES(3,'WSU Vancouver','');
INSERT INTO "lis_locations" VALUES(4,'WSU Tri-Cities','');
INSERT INTO "lis_locations" VALUES(5,'WSU Online','');
CREATE TABLE "lis_librarians" (
    "librarian_id" integer NOT NULL PRIMARY KEY,
    "first_name" varchar(40) NOT NULL,
    "last_name" varchar(40) NOT NULL
);
INSERT INTO "lis_librarians" VALUES(1,'Lara','Cummings');
INSERT INTO "lis_librarians" VALUES(2,'Stephen','Borrelli');
INSERT INTO "lis_librarians" VALUES(3,'Corey','Johnson');
INSERT INTO "lis_librarians" VALUES(4,'Jane','Scales');
INSERT INTO "lis_librarians" VALUES(5,'Eileen','Brady');
INSERT INTO "lis_librarians" VALUES(6,'Betty','Galbraith');
INSERT INTO "lis_librarians" VALUES(7,'Zinthia','Briceno');
INSERT INTO "lis_librarians" VALUES(8,'Gabriella','Reznowski');
INSERT INTO "lis_librarians" VALUES(9,'Erica','Nicol');
INSERT INTO "lis_librarians" VALUES(10,'Linda','Crook');
INSERT INTO "lis_librarians" VALUES(11,'Vicki','Croft');
INSERT INTO "lis_librarians" VALUES(12,'Bob','Matuozzi');
INSERT INTO "lis_librarians" VALUES(13,'Lorena','O''English');
INSERT INTO "lis_librarians" VALUES(14,'Lou','Vyhnanek');
INSERT INTO "lis_librarians" VALUES(15,'Mary','Gilles');
INSERT INTO "lis_librarians" VALUES(16,'Marilyn','Von Seggern');
INSERT INTO "lis_librarians" VALUES(17,'MASC',' ');
INSERT INTO "lis_librarians" VALUES(18,'Multiple',' ');
INSERT INTO "lis_librarians" VALUES(19,'Trevor','Bond');
CREATE TABLE "lis_session_types" (
    "session_type_id" integer NOT NULL PRIMARY KEY,
    "name" varchar(40) NOT NULL
);
INSERT INTO "lis_session_types" VALUES(1,'Compos');
INSERT INTO "lis_session_types" VALUES(2,'Course Related Instruction');
INSERT INTO "lis_session_types" VALUES(3,'Partner Program');
INSERT INTO "lis_session_types" VALUES(4,'Tour/Workshop');
CREATE TABLE "lis_sessions" (
    "session_id" integer NOT NULL PRIMARY KEY,
    "date" date,
    "librarian_id" integer NOT NULL REFERENCES "lis_librarians" ("librarian_id"),
    "session_type_id" integer NOT NULL REFERENCES "lis_session_types" ("session_type_id"),
    "description" varchar(200),
    "number_of_users" integer,
    "location" varchar(40),
    "gov_docs" bool NOT NULL,
    "session_format_id" integer,
    "course_id" integer REFERENCES "lis_courses" ("course_id")
);
INSERT INTO "lis_sessions" VALUES(1,'2011-07-07',1,4,'ALIVE Parent Tour #7',NULL,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(2,'2011-07-11',1,4,'ALIVE Parent Tour #8',NULL,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(3,'2011-07-15',1,4,'ALIVE Parent Tour #9',NULL,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(4,'2011-07-20',1,4,'ALIVE Parent Tour #10',NULL,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(5,'2011-07-25',1,4,'ALIVE Parent Tour #11',NULL,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(6,'2011-07-29',1,4,'ALIVE Parent Tour #12',NULL,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(7,'2011-08-02',1,4,'ALIVE Parent Tour #13',NULL,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(8,'2011-09-06',1,4,'Transfer Student Orientation',2,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(9,'2011-09-14',1,4,'McNair Scholars Workshop',13,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(10,'2011-09-14',6,4,'New Grad Seminar',5,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(11,'2011-09-07',3,4,'Washtucna High School',12,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(12,'2011-10-12',3,4,'HRS Create Your Own Web Page',5,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(13,'2011-12-13',3,4,'Colton High School',9,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(14,'2011-08-04',10,4,'Atheletic Training Program',32,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(15,'2011-07-19',18,4,'Cougar Kids',64,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(16,'2011-07-20',13,4,'Keeping Up and Keeping Track',NULL,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(17,'2011-08-03',13,4,'Zotero',NULL,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(18,'2011-08-08',13,4,'Zotero',NULL,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(19,'2011-09-01',13,4,'Zotero',NULL,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(20,'2011-09-07',13,4,'Zotero',7,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(21,'2011-09-15',13,4,'Zotero',NULL,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(22,'2011-09-21',13,4,'Zotero',1,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(23,'2011-09-28',13,4,'Zotero',NULL,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(24,'2011-10-14',13,4,'Zotero',NULL,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(25,'2011-10-19',13,4,'Keeping Up and Keeping Track',NULL,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(26,'2011-11-03',13,4,'Zotero',NULL,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(27,'2011-11-09',13,4,'Zotero (Drop In)',NULL,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(28,'2011-12-08',13,4,'Zotero (Drop In)',NULL,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(29,'2011-11-02',8,4,'Open Workshop for International Students',NULL,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(30,'2011-07-27',4,4,'Beginning EndNote',3,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(31,'2011-08-03',4,4,'EndNote',3,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(32,'2011-08-10',4,4,'EndNote',5,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(33,'2011-08-17',4,4,'EndNote Open Workshop ',5,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(34,'2011-10-27',4,4,'EndNote Beginners',6,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(35,'2011-11-09',4,4,'EndNote Beginners',5,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(36,'2011-11-16',4,4,'EndNote Cite While You Write',NULL,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(37,'2011-08-15',5,4,'Grad Student Tours ',13,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(38,'2011-08-15',6,4,'Grad Student Tours',19,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(39,'2011-08-15',16,4,'Grad Student Tours',16,'',0,1,NULL);
INSERT INTO "lis_sessions" VALUES(40,'2011-11-09',19,2,'',22,'',0,1,1);
INSERT INTO "lis_sessions" VALUES(41,'2011-09-12',5,2,'',9,'',0,1,2);
INSERT INTO "lis_sessions" VALUES(42,'2011-09-13',5,2,'',28,'',0,1,3);
INSERT INTO "lis_sessions" VALUES(43,'2011-09-13',5,2,'',12,'',0,1,2);
INSERT INTO "lis_sessions" VALUES(44,'2011-10-18',5,2,'',4,'',1,1,4);
INSERT INTO "lis_sessions" VALUES(45,'2011-10-20',5,2,'',5,'',0,1,4);
INSERT INTO "lis_sessions" VALUES(46,'2011-10-26',5,2,'',3,'',1,1,4);
INSERT INTO "lis_sessions" VALUES(47,'2011-10-27',5,2,'',4,'',0,1,4);
INSERT INTO "lis_sessions" VALUES(48,'2011-10-28',5,2,'',3,'',0,1,4);
INSERT INTO "lis_sessions" VALUES(49,'2011-10-31',5,2,'',3,'',0,1,4);
INSERT INTO "lis_sessions" VALUES(50,'2011-10-31',5,2,'',4,'',0,1,4);
INSERT INTO "lis_sessions" VALUES(51,'2011-11-01',5,2,'',3,'',1,1,4);
INSERT INTO "lis_sessions" VALUES(52,'2011-11-04',5,2,'',5,'',0,1,4);
INSERT INTO "lis_sessions" VALUES(53,'2011-09-20',5,2,'',15,'',0,1,5);
INSERT INTO "lis_sessions" VALUES(54,'2011-11-28',5,2,'',14,'',1,1,6);
INSERT INTO "lis_sessions" VALUES(55,'2011-11-30',5,2,'',11,'',0,1,6);
CREATE TABLE "lis_session_formats" (
    "session_format_id" integer NOT NULL PRIMARY KEY,
    "format_name" varchar(40) NOT NULL
);
INSERT INTO "lis_session_formats" VALUES(1,'In person');
INSERT INTO "lis_session_formats" VALUES(2,'Online');
CREATE TABLE "lis_students" (
    "student_id" integer NOT NULL PRIMARY KEY,
    "last_name" varchar(40),
    "first_name" varchar(40),
    "wsu_id" integer NOT NULL UNIQUE,
    "network_id" varchar(40) NOT NULL
);
CREATE TABLE "lis_student_snapshots" (
    "student_snapshot_id" integer NOT NULL PRIMARY KEY,
    "student_id" integer NOT NULL REFERENCES "lis_students" ("student_id"),
    "academic_degree_major" varchar(40) NOT NULL,
    "cumulative_gpa" decimal NOT NULL,
    "email" varchar(80) NOT NULL,
    "phone_1" varchar(20) NOT NULL,
    "phone_2" varchar(20) NOT NULL,
    "snapshot_date" date,
    "address_street_1" varchar(80) NOT NULL,
    "address_street_2" varchar(80) NOT NULL,
    "address_city" varchar(40) NOT NULL,
    "address_state" varchar(20) NOT NULL,
    "address_zip" varchar(10) NOT NULL,
    "address_business_act_code" varchar(10) NOT NULL
);
CREATE TABLE "lis_sessions_librarians" (
    "id" integer NOT NULL PRIMARY KEY,
    "session_id" integer NOT NULL,
    "librarian_id" integer NOT NULL REFERENCES "lis_librarians" ("librarian_id")
,
    UNIQUE ("session_id", "librarian_id")
);
CREATE INDEX "auth_permission_1bb8f392" ON "auth_permission" ("content_type_id");
CREATE INDEX "auth_group_permissions_425ae3c4" ON "auth_group_permissions" ("group_id");
CREATE INDEX "auth_group_permissions_1e014c8f" ON "auth_group_permissions" ("permission_id");
CREATE INDEX "auth_user_user_permissions_403f60f" ON "auth_user_user_permissions" ("user_id");
CREATE INDEX "auth_user_user_permissions_1e014c8f" ON "auth_user_user_permissions" ("permission_id");
CREATE INDEX "auth_user_groups_403f60f" ON "auth_user_groups" ("user_id");
CREATE INDEX "auth_user_groups_425ae3c4" ON "auth_user_groups" ("group_id");
CREATE INDEX "auth_message_403f60f" ON "auth_message" ("user_id");
CREATE INDEX "django_session_3da3d3d8" ON "django_session" ("expire_date");
CREATE INDEX "django_admin_log_403f60f" ON "django_admin_log" ("user_id");
CREATE INDEX "django_admin_log_1bb8f392" ON "django_admin_log" ("content_type_id");
CREATE INDEX "lis_courses_3549b700" ON "lis_courses" ("academic_location_id");
CREATE INDEX "lis_sessions_73602d6f" ON "lis_sessions" ("librarian_id");
CREATE INDEX "lis_sessions_413500b9" ON "lis_sessions" ("session_type_id");
CREATE INDEX "lis_sessions_783d0d64" ON "lis_sessions" ("session_format_id");
CREATE INDEX "lis_sessions_b7271b" ON "lis_sessions" ("course_id");
CREATE INDEX "lis_student_snapshots_42ff452e" ON "lis_student_snapshots" ("student_id");
COMMIT;
