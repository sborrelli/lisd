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
INSERT INTO "auth_user" VALUES(1,'dario.alvarezmiranda','','','dalvarez@eecs.wsu.edu','sha1$4705e$47b75b91842946c05e88d22ec37cf73b09ed36d3',1,1,1,'2012-03-28 11:27:37.713000','2012-03-12 11:52:58.743000');
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
CREATE TABLE "lis_courses_students" (
    "id" integer NOT NULL PRIMARY KEY,
    "course_id" integer NOT NULL,
    "student_id" integer NOT NULL,
    UNIQUE ("course_id", "student_id")
);
INSERT INTO "lis_courses_students" VALUES(9,2,2);
INSERT INTO "lis_courses_students" VALUES(10,2,3);
INSERT INTO "lis_courses_students" VALUES(11,2,4);
INSERT INTO "lis_courses_students" VALUES(12,1,1);
INSERT INTO "lis_courses_students" VALUES(13,1,2);
INSERT INTO "lis_courses_students" VALUES(14,1,3);
INSERT INTO "lis_courses_students" VALUES(15,3,2);
INSERT INTO "lis_courses_students" VALUES(16,3,4);
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
INSERT INTO "lis_courses" VALUES(1,'ENGL','101','1','Bob Hoskins',1,'Fall 2011','2012-03-13');
INSERT INTO "lis_courses" VALUES(2,'ARCH','101','1','Frank Gehry',1,'Fall 2011','2012-03-13');
INSERT INTO "lis_courses" VALUES(3,'GEOL','101','1','',1,'Fall 2011','2011-12-25');
CREATE TABLE 'lis_locations' (
    "location_id" integer NOT NULL PRIMARY KEY,
    "name" varchar(40) NOT NULL,
    "description" varchar(200)
);
INSERT INTO "lis_locations" VALUES(1,'WSU Pullman',NULL);
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
CREATE TABLE "lis_session_types" (
    "session_type_id" integer NOT NULL PRIMARY KEY,
    "name" varchar(40) NOT NULL
);
INSERT INTO "lis_session_types" VALUES(1,'Composition');
INSERT INTO "lis_session_types" VALUES(2,'Course Related Instruction');
INSERT INTO "lis_session_types" VALUES(3,'Partner Program');
INSERT INTO "lis_session_types" VALUES(4,'Tour/Workshop');
CREATE TABLE "lis_sessions" (
    "session_id" integer NOT NULL PRIMARY KEY,
    "date" date,
    "librarian_id" integer NOT NULL REFERENCES "lis_librarians" ("librarian_id"),
    "session_type_id" integer NOT NULL REFERENCES "lis_session_types" ("session_type_id"),
    "location" varchar(40) NOT NULL,
    "gov_docs" bool NOT NULL,
    "session_format_id" integer,
    "course_id" integer NOT NULL REFERENCES "lis_courses" ("course_id")
);
INSERT INTO "lis_sessions" VALUES(1,'2011-09-13',1,2,'',0,2,2);
INSERT INTO "lis_sessions" VALUES(2,'2011-09-13',2,1,'',0,2,1);
INSERT INTO "lis_sessions" VALUES(3,'2011-09-08',1,1,'',0,2,1);
CREATE TABLE "lis_session_formats" (
    "session_format_id" integer NOT NULL PRIMARY KEY,
    "format_name" varchar(40) NOT NULL
);
INSERT INTO "lis_session_formats" VALUES(1,'Online');
INSERT INTO "lis_session_formats" VALUES(2,'In person');
CREATE TABLE "lis_students" (
    "student_id" integer NOT NULL PRIMARY KEY,
    "last_name" varchar(40),
    "first_name" varchar(40),
    "wsu_id" integer NOT NULL UNIQUE,
    "network_id" varchar(40) NOT NULL
);
INSERT INTO "lis_students" VALUES(1,'Rossi','Paolo',12457854,'');
INSERT INTO "lis_students" VALUES(2,'Sciffo','Vincenzo',25412478,'');
INSERT INTO "lis_students" VALUES(3,'','',11214947,'');
INSERT INTO "lis_students" VALUES(4,'','',11252428,'');
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
