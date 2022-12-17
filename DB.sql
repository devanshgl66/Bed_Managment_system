--DDL---- from BMS schema in Postgres
CREATE database bms;

create schema BMS;

CREATE TABLE BMS.MEDICAL_CENTRES
(
mc_id	INT,
mc_name	VARCHAR,
mc_type	VARCHAR,
address_line_1	VARCHAR,
address_line_2	VARCHAR,
city	VARCHAR,
state	VARCHAR,
country	VARCHAR,
zip_code	VARCHAR,
maps_url	VARCHAR
);




CREATE TABLE BMS.WARDS
(
ward_id	INT,
ward_no	INT,
mc_id	INT,
ward_type	VARCHAR,
bed_count	INT,
is_deleted	BOOLEAN
);


CREATE TABLE BMS.ROOMS
(
room_id	INT,
room_no	INT,
mc_id	INT,
room_type	VARCHAR,
max_bed_accomodate	INT,
size	VARCHAR,
size_unit	VARCHAR,
is_washroom_available	BOOLEAN,
floor	INT,
cost	INT,
currency_unit	VARCHAR,
description	VARCHAR,
is_deleted	BOOLEAN
);


CREATE TABLE BMS.DEPARTMENTS
(
department_id	INT,
name	VARCHAR,
mc_id	INT
);


CREATE TABLE BMS.BEDS
(
bed_id	INT,
bed_no	INT,
ward_id	INT,
room_id	INT,
bed_type	VARCHAR,
bed_status	VARCHAR,
bed_rails	BOOLEAN,
bed_size	VARCHAR,
bed_size_unit	VARCHAR,
bed_elevation	BOOLEAN,
bed_castors	BOOLEAN,
is_deleted	BOOLEAN
);


CREATE TABLE BMS.PATIENTS
(
patient_id	INT,
first_name	VARCHAR,
middle_name	VARCHAR,
last_name	VARCHAR,
dob	DATE,
gender	VARCHAR,
email_id	VARCHAR,
contact_number	VARCHAR,
emergency_contact_number	VARCHAR,
address	VARCHAR,
admission_channel	VARCHAR
);

CREATE TABLE bms.staff (
	staff_id serial4 NOT NULL,
	first_name varchar(25) NOT NULL,
	middle_name varchar(50) NULL,
	surname varchar(25) NOT NULL,
	"staff_type" varchar(25) NULL,
	email varchar(100) NULL,
	contact_no int8 NOT NULL,
	dob date NOT NULL,
	"gender" varchar(1) NOT NULL,
	emergancy_contact_no int8 NOT NULL,
	address varchar(200) NULL,
	department_id int4 NOT NULL,
	CONSTRAINT staff_pk PRIMARY KEY (staff_id)
);



CREATE TABLE BMS.BED_REQUESTS
(
request_id	INT,
patient_id	INT,
bed_id	INT,
request_created_timestamp	TIMESTAMP,
requested_admission_datetime	TIMESTAMP,
actual_admission_datetime	TIMESTAMP,
discharge_datetime	TIMESTAMP,
requested_by	VARCHAR,
room_or_ward	VARCHAR,
allocation_type	VARCHAR,
priority	VARCHAR,
request_status	VARCHAR,
staff_id INT,
CONSTRAINT staff_fk FOREIGN KEY(staff_id) REFERENCES bms.staff(staff_id)
);

ALTER TABLE BMS.medical_centres  ADD primary key (mc_id);
ALTER TABLE BMS.rooms ADD primary key (room_id);
ALTER TABLE BMS.wards  ADD primary key (ward_id);
ALTER TABLE BMS.beds  ADD primary key (bed_id);
ALTER TABLE BMS.patients  ADD primary key (patient_id);
ALTER TABLE BMS.bed_requests  ADD primary key (request_id);
ALTER TABLE BMS.departments  ADD primary key (department_id);


ALTER TABLE BMS.WARDS
ADD CONSTRAINT fk_wards_mc FOREIGN KEY (mc_id) REFERENCES BMS.MEDICAL_CENTRES (mc_id);

ALTER TABLE BMS.ROOMS
ADD CONSTRAINT fk_rooms_mc FOREIGN KEY (mc_id) REFERENCES BMS.MEDICAL_CENTRES (mc_id);

ALTER TABLE BMS.DEPARTMENTS
ADD CONSTRAINT fk_dept_mc FOREIGN KEY (mc_id) REFERENCES BMS.MEDICAL_CENTRES (mc_id);

ALTER TABLE BMS.BEDS
ADD CONSTRAINT fk_beds_ward FOREIGN KEY (ward_id) REFERENCES BMS.wards (ward_id);

ALTER TABLE BMS.BEDS
ADD CONSTRAINT fk_beds_room FOREIGN KEY (room_id) REFERENCES BMS.ROOMS (room_id);

ALTER TABLE BMS.staff 
ADD CONSTRAINT fk_dept_id FOREIGN KEY (department_id) REFERENCES BMS.DEPARTMENTS (department_id);

ALTER TABLE BMS.BED_REQUESTS
ADD CONSTRAINT fk_bedreq_pat FOREIGN KEY (patient_id) REFERENCES BMS.PATIENTS (patient_id);
 
ALTER TABLE BMS.BED_REQUESTS
ADD CONSTRAINT fk_bedreq_bed FOREIGN KEY (bed_id) REFERENCES BMS.BEDS (bed_id);


ALTER TABLE bms.medical_centres ADD state_cd varchar NULL;
ALTER TABLE bms.wards ADD bed_avail_count int4 NULL;
ALTER TABLE bms.rooms ADD bed_avail_count int4 NULL;


---DML----

INSERT INTO BMS.MEDICAL_CENTRES
(mc_id,mc_name,mc_type,address_line_1,address_line_2,City,State,country,zip_code,maps_url)
VALUES
(10001,'Krishna Hospitals','Base','Wipro Circle, Gachibowli, Hyderabad','','Hyderabad','Telangana','India','500021','https://goo.gl/maps/LHrJTAxHbw8GxyYc8'),
(10002,'Sasi Hospitals','Base','Opp Reliance Mart, Syamala Center, Rajahmundry','','Rajahmundry','Andhra Pradesh','India ','533101','https://goo.gl/maps/grJci6n1uEtCJNDL9'),
(10003,'Sagar Medical Camp','Camp','Kothaguda, Hyderabad','','Hyderabad','Telangana','India ','566181','https://goo.gl/maps/LHrJTAxHbw8GxyYc8'),
(10004,'Ayushi Hospitals','Base','Opp Gandhi Park, Sarojini Nagar, Lucknow','','Lucknow','Uttar Pradesh','India ','599261','https://goo.gl/maps/grJci6n1uEtCJNDL9'),
(10005,'Bala Hospitals','Base','Near Uppal Metro Station, Hyderabad','','Hyderabad','Telangana','India ','632341','https://goo.gl/maps/SqCRZtsYb488FWaq7'),
(10006,'Devansh Medical Camp','Camp','Opp Surat Market, Gandhinagar','','Gandhinagar','Gujarat','India ','665421','https://goo.gl/maps/LHrJTAxHbw8GxyYc8'),
(10007,'Hrithik Hospitals','Base','Vasundhra Colony, Gopalpura Bypass','Tonk Rd, Jaipur','Jaipur','Rajasthan','India ','698501','https://goo.gl/maps/SqCRZtsYb488FWaq7');

INSERT INTO BMS.ROOMS
(room_id,room_no,mc_id,room_type,max_bed_accomodate,size,size_unit,is_washroom_available,floor,cost,currency_unit,description,is_deleted) VALUES
(1001,'101','10001','NON-AC SHARED','2','250','SQ FT','Y','1','2000','INR','','FALSE'),
(1002,'201','10004','AC SINGLE','1','135','SQ FT','N','2','100','DOLLAR','','FALSE'),
(1003,'103','10003','AC SINGLE','1','135','SQ FT','Y','1','3000','INR','','FALSE'),
(1004,'307','10006','AC SHARED','2','300','SQ FT','Y','3','2500','INR','','FALSE'),
(1005,'202','10002','NON-AC SINGLE','1','135','SQ FT','N','5','800','INR','','TRUE'),
(1006,'507','10004','AC SHARED','2','300','SQ FT','Y','2','200','DOLLAR','','FALSE');

INSERT INTO BMS.WARDS
(ward_id,ward_no,mc_id,ward_type,bed_count,is_deleted) VALUES
(50001,'101','10006','GENERAL','20','FALSE'),
(50002,'101','10003','ICU','5','TRUE'),
(50003,'103','10004','ICU','10','FALSE'),
(50004,'201','10002','CCU','8','FALSE'),
(50005,'202','10005','BURN','5','FALSE'),
(50006,'304','10001','ICCU','10','FALSE');

INSERT INTO BMS.BEDS
(bed_id,bed_no,ward_id,room_id,bed_type,bed_status,bed_rails,bed_size,bed_size_unit,bed_elevation,bed_castors,is_deleted) VALUES
(1000001,'1','50001',null,'MANUAL','AVAILABLE','FALSE','6','FT','TRUE','FALSE','FALSE'),
(1000002,'1','50002',null,'ELECTRIC','AVAILABLE','TRUE','5','FT','TRUE','TRUE','FALSE'),
(1000003,'1',null,'1002','ELECTRIC','','TRUE','6','FT','TRUE','FALSE','FALSE'),
(1000004,'6','50001',null,'MANUAL','AVAILABLE','FALSE','7','FT','FALSE','FALSE','TRUE'),
(1000005,'1','50005',null,'ELECTRIC','','TRUE','5','FT','TRUE','TRUE','FALSE'),
(1000006,'1',null,'1004','MANUAL','','TRUE','6','FT','TRUE','TRUE','FALSE'),
(1000007,'2','50001',null,'ELECTRIC','AVAILABLE','FALSE','7','FT','FALSE','TRUE','FALSE'),
(1000008,'1',null,'1004','MANUAL','','TRUE','6','FT','TRUE','TRUE','FALSE');

INSERT INTO BMS.DEPARTMENTS
(department_id,name,mc_id) VALUES
(60001,'CHILDREN','10003'),
(60002,'PSYCHOLOGY','10004'),
(60003,'CHILDREN','10005'),
(60004,'NEURO','10003');

INSERT INTO bms.staff (first_name, middle_name, surname, "staff_type", email, contact_no, dob, "gender", emergancy_contact_no, address, department_id) VALUES('Ayushi', NULL, 'S', 'DOCTOR', 'abc@gmail.com', 9999900000, '1995-12-13', 'F', 9999900000, 'ABC Apartment', 60001);
INSERT INTO bms.staff (first_name, middle_name, surname, "staff_type", email, contact_no, dob, "gender", emergancy_contact_no, address, department_id) VALUES('Hrithik', NULL, 'S', 'DOCTOR', 'abc@gmail.com', 9999900000, '1995-12-11', 'M', 9999900000, 'Sector 14', 60002);

INSERT INTO bms.patients (patient_id, first_name, middle_name, last_name, dob, "gender", email_id, contact_number, emergency_contact_number, address, admission_channel) VALUES(10000001, 'PRIYANKA', '', 'RACHERLA', '1985-12-25', 'F', 'priyanka.racherla@yahoo.com', '9988776655', '8899776655', '2-55-66, 1st Street, SaiKrishna Nagar, Rajahmundry, AndhraPradesh', 'ArogyaSree');
INSERT INTO bms.patients (patient_id, first_name, middle_name, last_name, dob, "gender", email_id, contact_number, emergency_contact_number, address, admission_channel) VALUES(10000002, 'NAGA', 'BALAKRISHNA', 'CHILUKURI', '1994-11-26', 'M', 'naga.bala@gmail.com', '8877665544', '7788665544', '2nd Street, Ambica Nagar, Visakhapatnam, Andhra Pradesh', 'SELF');
INSERT INTO bms.patients (patient_id, first_name, middle_name, last_name, dob, "gender", email_id, contact_number, emergency_contact_number, address, admission_channel) VALUES(10000003, 'AYUSHI', '', 'SRIVASTAVA', '1992-10-27', 'F', 'ayushi123@yahoo.com', '7766554433', '6677554433', '3rd Street, Swaraj Nagar, Gurgoan', 'INSURANCE');
INSERT INTO bms.patients (patient_id, first_name, middle_name, last_name, dob, "gender", email_id, contact_number, emergency_contact_number, address, admission_channel) VALUES(10000004, 'SAGAR', 'KUMAR', 'NARE', '1993-09-28', 'M', 'sagar345@gmail.com', '7654312345', '6754312345', '4th Street, Gajuwaka, Vijayawada, AndhraPradesh', 'INSURANCE');
INSERT INTO bms.patients (patient_id, first_name, middle_name, last_name, dob, "gender", email_id, contact_number, emergency_contact_number, address, admission_channel) VALUES(10000005, 'HRITHIK', '', 'SHARMA', '1995-08-29', 'M', 'hritik.s@gmail.com', '9876512345', '8976512345', '5th Street, Sarojini Nagar, Lucknow', 'SELF');
INSERT INTO bms.patients (patient_id, first_name, middle_name, last_name, dob, "gender", email_id, contact_number, emergency_contact_number, address, admission_channel) VALUES(10000006, 'SASI', 'KUMAR', 'RAMACHANDRAN', '1991-07-30', 'M', 'sasi_234@yahoo.com', '9875431260', '8975431260', '6th Street, SaiKrishna Nagar, Chandigarh', 'ArogyaSree');
INSERT INTO bms.patients (patient_id, first_name, middle_name, last_name, dob, "gender", email_id, contact_number, emergency_contact_number, address, admission_channel) VALUES(10000007, 'DEVANSH', '', 'GOYAL', '1995-12-31', 'M', 'devansh333@gmail.com', '9753124680', '7953124680', '7th Street, Beach Road, Chennai', 'INSURANCE');

INSERT INTO bms.bed_requests (request_id, patient_id, bed_id, request_created_timestamp, requested_admission_datetime, actual_admission_datetime, discharge_datetime, requested_by, room_or_ward, allocation_type, "priority", request_status, staff_id) VALUES(50000003, 10000003, 1000001, '2022-12-15 11:00:00.000', '2022-12-16 08:00:00.000', NULL, NULL, 'Sasi B', 'WARD', 'GENERAL', 'LOW', 'ALLOCATED', 1);
INSERT INTO bms.bed_requests (request_id, patient_id, bed_id, request_created_timestamp, requested_admission_datetime, actual_admission_datetime, discharge_datetime, requested_by, room_or_ward, allocation_type, "priority", request_status, staff_id) VALUES(50000002, 10000002, 1000003, '2022-12-10 08:00:00.000', '2022-12-11 15:00:00.000', '2022-12-11 17:00:00.000', '2022-12-16 09:00:00.000', 'Ayushi S', 'ROOM', 'AC SINGLE', 'MEDIUM', 'DISCHARGED', 2);
INSERT INTO bms.bed_requests (request_id, patient_id, bed_id, request_created_timestamp, requested_admission_datetime, actual_admission_datetime, discharge_datetime, requested_by, room_or_ward, allocation_type, "priority", request_status, staff_id) VALUES(50000004, 10000004, NULL, '2022-12-12 14:00:00.000', '2022-12-12 17:00:00.000', NULL, NULL, 'Devansh G', 'ROOM', 'NON-AC SINGLE', 'MEDIUM', 'REQUESTED', 2);
INSERT INTO bms.bed_requests (request_id, patient_id, bed_id, request_created_timestamp, requested_admission_datetime, actual_admission_datetime, discharge_datetime, requested_by, room_or_ward, allocation_type, "priority", request_status, staff_id) VALUES(50000005, 10000005, 1000002, '2022-12-14 22:00:00.000', '2022-12-14 22:30:00.000', '2022-12-14 22:40:00.000', '2022-12-15 19:00:00.000', 'Krishna C', 'WARD', 'ICU', 'HIGH', 'DISCHARGED', 2);
INSERT INTO bms.bed_requests (request_id, patient_id, bed_id, request_created_timestamp, requested_admission_datetime, actual_admission_datetime, discharge_datetime, requested_by, room_or_ward, allocation_type, "priority", request_status, staff_id) VALUES(50000007, 10000005, 1000002, '2022-12-09 22:00:00.000', '2022-12-10 22:30:00.000', '2022-12-09 22:00:00.000', '2022-12-10 22:30:00.000', 'Krishna C', 'WARD', 'ICU', 'HIGH', 'DISCHARGED', 2);
INSERT INTO bms.bed_requests (request_id, patient_id, bed_id, request_created_timestamp, requested_admission_datetime, actual_admission_datetime, discharge_datetime, requested_by, room_or_ward, allocation_type, "priority", request_status, staff_id) VALUES(50000008, 10000005, 1000002, '2022-12-09 22:00:00.000', '2022-12-10 22:30:00.000', '2022-12-09 22:00:00.000', '2022-12-11 22:30:00.000', 'Krishna C', 'WARD', 'ICU', 'HIGH', 'DISCHARGED', 2);
INSERT INTO bms.bed_requests (request_id, patient_id, bed_id, request_created_timestamp, requested_admission_datetime, actual_admission_datetime, discharge_datetime, requested_by, room_or_ward, allocation_type, "priority", request_status, staff_id) VALUES(50000006, 10000007, 1000007, '2022-12-13 16:00:00.000', '2022-12-13 18:00:00.000', NULL, NULL, 'Hritik S', 'WARD', 'GENERAL', 'HIGH', 'RESERVED', 1);
INSERT INTO bms.bed_requests (request_id, patient_id, bed_id, request_created_timestamp, requested_admission_datetime, actual_admission_datetime, discharge_datetime, requested_by, room_or_ward, allocation_type, "priority", request_status, staff_id) VALUES(50000009, 10000007, 1000002, '2022-12-13 16:00:00.000', '2022-12-13 18:00:00.000', '2022-12-10 22:00:00.000', '2022-12-12 22:30:00.000', 'Hritik S', 'WARD', 'GENERAL', 'HIGH', 'DISCHARGED', 2);
INSERT INTO bms.bed_requests (request_id, patient_id, bed_id, request_created_timestamp, requested_admission_datetime, actual_admission_datetime, discharge_datetime, requested_by, room_or_ward, allocation_type, "priority", request_status, staff_id) VALUES(50000001, 10000001, NULL, '2022-12-16 11:00:00.000', '2022-12-16 17:00:00.000', NULL, '2022-12-12 22:30:00.000', 'Sagar N', 'ROOM', 'NON-AC SHARED', 'LOW', 'REQUESTED', 1);


UPDATE bms.medical_centres SET mc_name='Krishna Hospitals', mc_type='Base', address_line_1='Wipro Circle, Gachibowli, Hyderabad', address_line_2='', city='Hyderabad', state='Telangana', state_cd='IN-TG', country='India', zip_code='500021', maps_url='https://goo.gl/maps/LHrJTAxHbw8GxyYc8' WHERE mc_id=10001;
UPDATE bms.medical_centres SET mc_name='Sasi Hospitals', mc_type='Base', address_line_1='Opp Reliance Mart, Syamala Center, Rajahmundry', address_line_2='', city='Rajahmundry', state='Andhra Pradesh', state_cd='IN-AP', country='India ', zip_code='533101', maps_url='https://goo.gl/maps/grJci6n1uEtCJNDL9' WHERE mc_id=10002;
UPDATE bms.medical_centres SET mc_name='Sagar Medical Camp', mc_type='Camp', address_line_1='Kothaguda, Hyderabad', address_line_2='', city='Hyderabad', state='Telangana', state_cd='IN-TG', country='India ', zip_code='566181', maps_url='https://goo.gl/maps/LHrJTAxHbw8GxyYc8' WHERE mc_id=10003;
UPDATE bms.medical_centres SET mc_name='Ayushi Hospitals', mc_type='Base', address_line_1='Opp Gandhi Park, Sarojini Nagar, Lucknow', address_line_2='', city='Lucknow', state='Uttar Pradesh', state_cd='IN-UP', country='India ', zip_code='599261', maps_url='https://goo.gl/maps/grJci6n1uEtCJNDL9' WHERE mc_id=10004;
UPDATE bms.medical_centres SET mc_name='Bala Hospitals', mc_type='Base', address_line_1='Near Uppal Metro Station, Hyderabad', address_line_2='', city='Hyderabad', state='Telangana', state_cd='IN-TG', country='India ', zip_code='632341', maps_url='https://goo.gl/maps/SqCRZtsYb488FWaq7' WHERE mc_id=10005;
UPDATE bms.medical_centres SET mc_name='Devansh Medical Camp', mc_type='Camp', address_line_1='Opp Surat Market, Gandhinagar', address_line_2='', city='Gandhinagar', state='Gujarat', state_cd='IN-GJ', country='India ', zip_code='665421', maps_url='https://goo.gl/maps/LHrJTAxHbw8GxyYc8' WHERE mc_id=10006;
UPDATE bms.medical_centres SET mc_name='Hrithik Hospitals', mc_type='Base', address_line_1='Vasundhra Colony, Gopalpura Bypass', address_line_2='Tonk Rd, Jaipur', city='Jaipur', state='Rajasthan', state_cd='IN-RJ', country='India ', zip_code='698501', maps_url='https://goo.gl/maps/SqCRZtsYb488FWaq7' WHERE mc_id=10007;

UPDATE bms.rooms SET room_no=101, mc_id=10001, room_type='NON-AC SHARED', max_bed_accomodate=2, bed_avail_count=1, "size"='250', size_unit='SQ FT', is_washroom_available=true, floor=1, "cost"=2000, currency_unit='INR', description='', is_deleted=false WHERE room_id=1001;
UPDATE bms.rooms SET room_no=201, mc_id=10004, room_type='AC SINGLE', max_bed_accomodate=1, bed_avail_count=1, "size"='135', size_unit='SQ FT', is_washroom_available=false, floor=2, "cost"=100, currency_unit='DOLLAR', description='', is_deleted=false WHERE room_id=1002;
UPDATE bms.rooms SET room_no=103, mc_id=10003, room_type='AC SINGLE', max_bed_accomodate=1, bed_avail_count=0, "size"='135', size_unit='SQ FT', is_washroom_available=true, floor=1, "cost"=3000, currency_unit='INR', description='', is_deleted=false WHERE room_id=1003;
UPDATE bms.rooms SET room_no=307, mc_id=10006, room_type='AC SHARED', max_bed_accomodate=2, bed_avail_count=1, "size"='300', size_unit='SQ FT', is_washroom_available=true, floor=3, "cost"=2500, currency_unit='INR', description='', is_deleted=false WHERE room_id=1004;
UPDATE bms.rooms SET room_no=202, mc_id=10002, room_type='NON-AC SINGLE', max_bed_accomodate=1, bed_avail_count=0, "size"='135', size_unit='SQ FT', is_washroom_available=false, floor=5, "cost"=800, currency_unit='INR', description='', is_deleted=true WHERE room_id=1005;
UPDATE bms.rooms SET room_no=507, mc_id=10004, room_type='AC SHARED', max_bed_accomodate=2, bed_avail_count=2, "size"='300', size_unit='SQ FT', is_washroom_available=true, floor=2, "cost"=200, currency_unit='DOLLAR', description='', is_deleted=false WHERE room_id=1006;

UPDATE bms.wards SET ward_no=101, mc_id=10006, "ward_type"='GENERAL', bed_count=20, is_deleted=false, bed_avail_count=15 WHERE ward_id=50001;
UPDATE bms.wards SET ward_no=101, mc_id=10003, "ward_type"='ICU', bed_count=5, is_deleted=true, bed_avail_count=4 WHERE ward_id=50002;
UPDATE bms.wards SET ward_no=103, mc_id=10004, "ward_type"='ICU', bed_count=10, is_deleted=false, bed_avail_count=7 WHERE ward_id=50003;
UPDATE bms.wards SET ward_no=201, mc_id=10002, "ward_type"='CCU', bed_count=8, is_deleted=false, bed_avail_count=8 WHERE ward_id=50004;
UPDATE bms.wards SET ward_no=202, mc_id=10005, "ward_type"='BURN', bed_count=5, is_deleted=false, bed_avail_count=4 WHERE ward_id=50005;
UPDATE bms.wards SET ward_no=304, mc_id=10001, "ward_type"='ICCU', bed_count=10, is_deleted=false, bed_avail_count=5 WHERE ward_id=50006;



