CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


DROP TABLE IF EXISTS "public"."order_times";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."order_times" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v1(),
    "commuted_at" timestamp,
    "started_at" timestamp,
    "completed_at" timestamp,
    "vendor_confirmed_at" timestamp,
    "vendor_cancelled_at" timestamp,
    "created_at" timestamp NOT NULL DEFAULT now(),
    "updated_at" timestamp NOT NULL DEFAULT now(),
    "buyer_cancelled_at" timestamp,
    "delivered_at" timestamp,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."orders";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

DROP TYPE IF EXISTS "public"."order_status";
CREATE TYPE "public"."order_status" AS ENUM ('accepted', 'commuting', 'completed', 'created', 'delivered', 'expired', 'vendor-cancelled', 'vendor-confirmed', 'buyer-cancelled', 'started');

-- Table Definition
CREATE TABLE "public"."orders" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v1(),
    "vendor_id" uuid NOT NULL,
    "buyer_id" uuid,
    "shop_id" uuid NOT NULL,
    "time_slot_id" varchar(64) NOT NULL,
    "proxy_id" uuid,
    "confirmed_at" timestamp,
    "proposed_at" timestamp,
    "expire_at" timestamp NOT NULL,
    "status" "public"."order_status" NOT NULL,
    "created_at" timestamp NOT NULL DEFAULT now(),
    "updated_at" timestamp NOT NULL DEFAULT now(),
    "order_time_id" uuid,
    "message" varchar,
    "cancelled_reason" varchar,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."shops";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."shops" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v1(),
    "vendor_id" uuid,
    "region_id" varchar(64),
    "name" varchar(256) NOT NULL,
    "latitude" varchar(32) NOT NULL,
    "longitude" varchar(32) NOT NULL,
    "shop_type" varchar(64) NOT NULL,
    "address" varchar NOT NULL,
    "floor_size" numeric NOT NULL,
    "message" varchar,
    "created_at" timestamp NOT NULL DEFAULT now(),
    "updated_at" timestamp NOT NULL DEFAULT now(),
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."provinces";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."provinces" (
    "id" uuid NOT NULL,
    "region_id" varchar(64),
    "name_en" varchar(256) NOT NULL,
    "name_th" varchar(256) NOT NULL,
    "created_at" timestamp NOT NULL DEFAULT now(),
    "updated_at" timestamp NOT NULL DEFAULT now(),
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."proxies";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."proxies" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v1(),
    "name" varchar(256) NOT NULL,
    "phone_number" varchar(64) NOT NULL,
    "created_at" timestamp NOT NULL DEFAULT now(),
    "updated_at" timestamp NOT NULL DEFAULT now(),
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."regions";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."regions" (
    "id" varchar(64) NOT NULL,
    "name_en" varchar(256) NOT NULL,
    "name_th" varchar(256) NOT NULL,
    "minimum_price" numeric NOT NULL,
    "maximum_price" numeric NOT NULL,
    "created_at" timestamp NOT NULL DEFAULT now(),
    "updated_at" timestamp NOT NULL DEFAULT now(),
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."time_slots";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."time_slots" (
    "id" varchar(64) NOT NULL,
    "name_en" varchar(256) NOT NULL,
    "name_th" varchar(256) NOT NULL,
    "time_slot_start_at" time NOT NULL,
    "time_slot_end_at" time NOT NULL,
    "created_at" timestamp NOT NULL DEFAULT now(),
    "updated_at" timestamp NOT NULL DEFAULT now(),
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."users";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."users" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v1(),
    "first_name" varchar(256) NOT NULL,
    "last_name" varchar(256) NOT NULL,
    "email" varchar(128),
    "phone_number" varchar(64) NOT NULL,
    "profile_picture" text,
    "line_id" varchar(128),
    "type" varchar(64) NOT NULL,
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL,
    "invitation_code_id" uuid,
    "profile_picture__change_flag" varchar,
    "profile_picture__delete_flag" varchar,
    PRIMARY KEY ("id")
);

INSERT INTO "public"."order_times" ("id", "commuted_at", "started_at", "completed_at", "vendor_confirmed_at", "vendor_cancelled_at", "created_at", "updated_at", "buyer_cancelled_at", "delivered_at") VALUES
('533ed390-948c-11ec-9657-0242ac190002', NULL, NULL, NULL, NULL, NULL, '2022-02-23 16:38:15.444947', '2022-03-17 15:57:53.090228', '2022-03-17 15:57:53.089129', NULL),
('76d1affa-9552-11ec-afba-0242ac190002', NULL, NULL, NULL, NULL, NULL, '2022-02-24 16:16:35.468572', '2022-02-24 16:16:35.468572', '2022-02-24 16:16:35.45902', NULL),
('aaa02970-93b2-11ec-9e3d-0242ac190002', '2022-02-22 07:40:34.65257', '2022-02-22 07:40:34.65257', '2022-02-22 07:40:34.65257', '2022-02-22 07:40:34.65257', NULL, '2022-02-22 14:40:11.763238', '2022-02-22 14:50:30.255458', '2022-02-22 14:50:30.243451', NULL),
('c1c017b0-a5c2-11ec-ad35-0242ac190003', NULL, NULL, NULL, NULL, NULL, '2022-03-17 14:20:43.417139', '2022-03-17 15:40:41.082143', '2022-03-17 15:40:41.07389', NULL),
('c806feb8-9474-11ec-949c-0242ac190002', NULL, NULL, NULL, NULL, NULL, '2022-02-23 13:49:43.454564', '2022-03-17 15:44:42.271648', '2022-03-17 15:44:42.26565', NULL);

INSERT INTO "public"."orders" ("id", "vendor_id", "buyer_id", "shop_id", "time_slot_id", "proxy_id", "confirmed_at", "proposed_at", "expire_at", "status", "created_at", "updated_at", "order_time_id", "message", "cancelled_reason") VALUES
('03426aa4-a509-11ec-8966-0242ac190003', 'd66e46f8-9e9e-11ec-9b91-0242ac190002', '91fd22c6-8e6a-11ec-a821-0242ac190002', 'bb097100-6e27-11ec-865e-0242ac190003', 'afternoon', NULL, '2022-02-22 15:04:05', NULL, '2022-01-12 18:08:19.960617', 'expired', '2022-02-17 11:37:27.79998', '2022-03-02 11:53:32.124397', '533ed390-948c-11ec-9657-0242ac190002', NULL, NULL),
('3ac0076c-7853-11ec-9ca2-0242ac190002', 'd66e46f8-9e9e-11ec-9b91-0242ac190002', '383c7606-692b-11ec-b5cb-0242ac190002', 'bb097100-6e27-11ec-865e-0242ac180003', 'afternoon', NULL, '2022-02-22 15:04:05', NULL, '2022-01-14 18:06:22.205499', 'accepted', '2022-02-12 18:06:22.205519', '2022-03-17 15:40:41.086023', 'c1c017b0-a5c2-11ec-ad35-0242ac190003', NULL, NULL),
('795d195a-a509-11ec-8966-0242ac190003', 'd66e46f8-9e9e-11ec-9b91-0242ac190002', '91fd22c6-8e6a-11ec-a821-0242ac190002', 'bb097100-6e27-11ec-865e-0242ac190003', 'afternoon', NULL, '2022-02-22 15:04:05', NULL, '2022-01-12 18:08:19.960617', 'buyer-cancelled', '2022-02-17 11:37:27.79998', '2022-03-17 15:57:53.094143', '533ed390-948c-11ec-9657-0242ac190002', NULL, NULL),
('795dba18-a509-11ec-8966-0242ac190003', 'd66e46f8-9e9e-11ec-9b91-0242ac190002', '91fd22c6-8e6a-11ec-a821-0242ac190002', 'bb097100-6e27-11ec-865e-0242ac190003', 'afternoon', NULL, '2022-02-22 15:04:05', NULL, '2022-01-12 18:08:19.960617', 'delivered', '2022-02-17 11:37:27.79998', '2022-03-02 11:53:32.124397', '533ed390-948c-11ec-9657-0242ac190002', NULL, NULL),
('795e3f7e-a509-11ec-8966-0242ac190003', 'd66e46f8-9e9e-11ec-9b91-0242ac190002', '91fd22c6-8e6a-11ec-a821-0242ac190002', 'bb097100-6e27-11ec-865e-0242ac190003', 'afternoon', NULL, '2022-02-22 15:04:05', NULL, '2022-01-12 18:08:19.960617', 'vendor-cancelled', '2022-02-17 11:37:27.79998', '2022-03-02 11:53:32.124397', '533ed390-948c-11ec-9657-0242ac190002', NULL, NULL),
('795ed60a-a509-11ec-8966-0242ac190003', 'd66e46f8-9e9e-11ec-9b91-0242ac190002', '91fd22c6-8e6a-11ec-a821-0242ac190002', 'bb097100-6e27-11ec-865e-0242ac190003', 'afternoon', NULL, '2022-02-22 15:04:05', NULL, '2022-01-12 18:08:19.960617', 'created', '2022-02-17 11:37:27.79998', '2022-03-02 11:53:32.124397', '533ed390-948c-11ec-9657-0242ac190002', NULL, NULL),
('795f4cac-a509-11ec-8966-0242ac190003', 'd66e46f8-9e9e-11ec-9b91-0242ac190002', '91fd22c6-8e6a-11ec-a821-0242ac190002', 'bb097100-6e27-11ec-865e-0242ac190003', 'afternoon', NULL, '2022-02-22 15:04:05', NULL, '2022-01-12 18:08:19.960617', 'vendor-confirmed', '2022-02-17 11:37:27.79998', '2022-03-02 11:53:32.124397', '533ed390-948c-11ec-9657-0242ac190002', NULL, NULL),
('795fa8c8-a509-11ec-8966-0242ac190003', 'd66e46f8-9e9e-11ec-9b91-0242ac190002', '91fd22c6-8e6a-11ec-a821-0242ac190002', 'bb097100-6e27-11ec-865e-0242ac190003', 'afternoon', NULL, '2022-02-22 15:04:05', NULL, '2022-01-12 18:08:19.960617', 'completed', '2022-02-17 11:37:27.79998', '2022-03-02 11:53:32.124397', '533ed390-948c-11ec-9657-0242ac190002', NULL, NULL),
('ad0dba96-7397-11ec-9d18-0242ac190002', 'd66e46f8-9e9e-11ec-9b91-0242ac190002', '383c7606-692b-11ec-b5cb-0242ac190002', 'bb097100-6e27-11ec-865e-0242ac180003', 'morning', NULL, '2022-02-24 15:04:05', NULL, '2022-01-14 18:06:22.205499', 'created', '2022-01-12 18:06:22.205519', '2022-03-15 12:06:47.262619', NULL, NULL, NULL),
('e4eb4956-776b-11ec-9ca2-0242ac190002', 'd66e46f8-9e9e-11ec-9b91-0242ac190002', '383c7606-692b-11ec-b5cb-0242ac190002', 'bb097100-6e27-11ec-865e-0242ac190003', 'all-day', '5b6b247a-92bf-11ec-98e5-0242ac190002', '2022-02-23 15:04:05', NULL, '2022-01-14 18:06:22.205499', 'accepted', '2022-01-12 18:06:22.205519', '2022-02-24 16:16:35.476337', '76d1affa-9552-11ec-afba-0242ac190002', NULL, NULL),
('f33cf8e2-7397-11ec-9d18-0242ac190002', 'd66e46f8-9e9e-11ec-9b91-0242ac190002', '383c7606-692b-11ec-b5cb-0242ac190002', 'bb097100-6e27-11ec-865e-0242ac190003', 'afternoon', NULL, '2022-02-22 15:04:05', NULL, '2022-01-14 18:08:19.960602', 'buyer-cancelled', '2022-01-12 18:08:19.960617', '2022-03-17 15:44:42.274707', 'c806feb8-9474-11ec-949c-0242ac190002', NULL, NULL),
('fbe4dc16-8fe5-11ec-8ddd-0242ac190002', 'd66e46f8-9e9e-11ec-9b91-0242ac190002', '91fd22c6-8e6a-11ec-a821-0242ac190002', 'bb097100-6e27-11ec-865e-0242ac190003', 'afternoon', NULL, '2022-02-22 15:04:05', NULL, '2022-01-12 18:08:19.960617', 'delivered', '2022-02-17 11:37:27.79998', '2022-03-02 11:53:32.124397', '533ed390-948c-11ec-9657-0242ac190002', NULL, NULL);

INSERT INTO "public"."shops" ("id", "vendor_id", "region_id", "name", "latitude", "longitude", "shop_type", "address", "floor_size", "message", "created_at", "updated_at") VALUES
('bb097100-6e27-11ec-865e-0242ac180003', 'd66e46f8-9e9e-11ec-9b91-0242ac190002', 'south', 'My shop name', '9.192781745340946', '99.84915223280143', 'food', '22/2 หมู่ที่ 12, Khanom District, Nakhon Si Thammarat 80210', 3.56, 'An optional message can be added', '2022-01-05 20:02:26.212852', '2022-01-05 20:02:26.212852'),
('bb097100-6e27-11ec-865e-0242ac190003', 'd66e46f8-9e9e-11ec-9b91-0242ac190002', 'west', 'Mega shop', '9.192781745340946', '99.84915223280143', 'electronics', '22/2 หมู่ที่ 12, Khanom District, Nakhon Si Thammarat 80210', 1.23, 'An optional message can be added', '2022-01-05 20:02:26.212852', '2022-01-05 20:02:26.212852'),
('c97d71ee-8fe4-11ec-8ddd-0242ac190002', 'd66e46f8-9e9e-11ec-9b91-0242ac190002', 'south', 'World of phones shop', '9.192781745340946', '99.84915223280143', 'electronics', '22/2 หมู่ที่ 12, Khanom District, Nakhon Si Thammarat 80210', 3.56, 'An optional message can be added to the shop', '2022-02-17 11:28:53.738647', '2022-02-17 11:28:53.738647'),
('caa956b4-8fe4-11ec-8ddd-0242ac190002', 'd66e46f8-9e9e-11ec-9b91-0242ac190002', 'south', 'Terrashoper', '9.192781745340946', '99.84915223280143', 'gardening', '22/2 หมู่ที่ 12, Khanom District, Nakhon Si Thammarat 80210', 3.56, 'An optional message can be added to the shop', '2022-02-17 11:28:55.705157', '2022-02-17 11:28:55.705157'),
('caf79ca2-8fe4-11ec-8ddd-0242ac190002', 'd66e46f8-9e9e-11ec-9b91-0242ac190002', 'south', 'You buy I sell boutique', '9.192781745340946', '99.84915223280143', 'grosseries', '22/2 หมู่ที่ 12, Khanom District, Nakhon Si Thammarat 80210', 3.56, 'An optional message can be added to the shop', '2022-02-17 11:28:56.218095', '2022-02-17 11:28:56.218095'),
('cb109676-8fe4-11ec-8ddd-0242ac190002', 'd66e46f8-9e9e-11ec-9b91-0242ac190002', 'south', 'All you can eat store', '9.192781745340946', '99.84915223280143', 'food', '22/2 หมู่ที่ 12, Khanom District, Nakhon Si Thammarat 80210', 3.56, 'An optional message can be added to the shop', '2022-02-17 11:28:56.381809', '2022-02-17 11:28:56.381809');

INSERT INTO "public"."provinces" ("id", "region_id", "name_en", "name_th", "created_at", "updated_at") VALUES
('014051b6-599c-4051-8936-0a908a0bded3', 'north-east', 'Nong Khai', 'หนองคาย', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('03f8086b-e386-4c16-8355-3978cffe70bd', 'central', 'Nakhon Nayok', 'นครนายก', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('069fffee-fab6-4967-bd3d-3fddb920a234', 'bkk-metro', 'Nonthaburi', 'นนทบุรี', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('0a9b71ef-ade5-4e11-8330-698a760e5230', 'central', 'Lop Buri', 'ลพบุรี', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('0c2a5dc1-332a-4155-bf32-1c861bd43d29', 'north-east', 'Kalasin', 'กาฬสินธุ์', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('0efdf291-3a66-4c24-85c4-0dc978bfe1e3', 'south', 'Phuket', 'ภูเก็ต', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('17aa1979-9932-4306-b385-3a32d70589e7', 'central', 'Saraburi', 'สระบุรี', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('1c5fa1cf-d644-4f8a-8aeb-dab4cc722965', 'north-east', 'Bueng Kan', 'บึงกาฬ', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('1e477e04-65a3-490c-8665-fbae1c3c6b57', 'south', 'Yala', 'ยะลา', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('1ef50ed1-1b0e-4ef0-86ad-0f8e4c63faf9', 'west', 'Ratchaburi', 'ราชบุรี', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('2090b484-d840-4690-b29c-8e83535b6b24', 'west', 'Prachuap Khiri Khan', 'ประจวบคีรีขันธ์', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('22874922-61fa-4077-be6e-598f85da2394', 'west', 'Tak', 'ตาก', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('2671b9dd-78fd-4f59-9bb7-c153063f4b39', 'central', 'Nakhon Sawan', 'นครสวรรค์', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('29c30244-678c-4bb2-88f6-03a22f3992e1', 'north-east', 'Sakon Nakhon', 'สกลนคร', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('29e0ba6b-2801-4f4b-8e2c-47b8b5d6198d', 'south', 'Ranong', 'ระนอง', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('31f5a679-a981-4d02-ab73-7882d9a04bdb', 'south', 'Trang', 'ตรัง', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('360d5687-0485-4806-92e2-e91fa5e33029', 'north', 'Lamphun', 'ลำพูน', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('363707d0-852f-4d7c-97be-39aa22114850', 'north-east', 'Udon Thani', 'อุดรธานี', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('376cbe3b-5f7d-45c2-8ba5-e06269ebb4db', 'south', 'Surat Thani', 'สุราษฏร์ธานี', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('39c7c974-919c-4c52-81d7-8553e00fb5cb', 'east', 'Rayong', 'ระยอง', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('3a176eff-d5c3-41b8-8388-1b0d08c95858', 'south', 'Narathiwat', 'นราธิวาส', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('3a2bf739-4f91-44af-8aa0-dfb6377362a2', 'north-east', 'Chaiyaphum', 'ชัยภูมิ', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('3cdd47d8-9eb5-482a-82fd-c32c5d62d1d9', 'north-east', 'Nong Bua Lam Phu', 'หนองบัวลำภู', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('4216e9e4-6b82-484b-8e58-a8d27ee3b324', 'north', 'Chiang Rai', 'เชียงราย', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('464a696b-366c-4395-bdda-9669958a36c3', 'central', 'Ang Thong', 'อ่างทอง', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('49875ae6-1e3a-4520-8577-2aeebf4afb76', 'central', 'Phichit', 'พิจิตร', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('4a87b0b9-306f-437d-898c-c13b3d21a649', 'south', 'Chumphon', 'ชุมพร', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('4e5160a4-56bd-4cf7-b23c-bdf568bd5ce3', 'north-east', 'Si Sa Ket', 'ศรีสะเกษ', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('4f27653d-d3ec-469f-9477-708169f99347', 'north-east', 'Buri Rum', 'บุรีรัมย์', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('52248826-ebfd-491f-a3f8-b1f2a6223810', 'south', 'Krabi', 'กระบี่', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('54fde756-b727-4de1-8df7-cae3f4f13362', 'south', 'Satun', 'สตูล', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('565d3cb2-44e0-47db-9cf0-268d8bdb153e', 'north', 'Uttaradit', 'อุตรดิตถ์', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('5aa433b3-b350-4f8c-b329-9f903218716a', 'south', 'Songkhla', 'สงขลา', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('5c891f48-f057-49a4-ba0c-1c423a23cb94', 'central', 'Uthai Thani', 'อุทัยธานี', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('66395f26-0123-45f2-83d1-c7af2cffa11b', 'north', 'Nan', 'น่าน', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('66ed3f20-eb70-4610-b873-2c8518f536be', 'north-east', 'Mukdahan', 'มุกดาหาร', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('6a97b517-724d-4d2c-a1fe-69dbe496a807', 'north-east', 'Nakhon Phanom', 'นครพนม', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('6b5e1c71-22f8-4256-a5fa-7d257aa56a41', 'north-east', 'Yasothon', 'ยโสธร', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('6ef6e927-0fc4-4f9f-9e5b-c66b58dbef46', 'south', 'Phang Nga', 'พังงา', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('76ac7610-20a3-4c8b-8628-a4f2fa77e7d7', 'south', 'Phattalung', 'พัทลุง', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('77e7612d-d39a-4e97-9401-da9984d0892a', 'central', 'Sukhothai', 'สุโขทัย', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('7c66cdbd-3db5-4636-b7a2-8d56f6a67b46', 'east', 'Chonburi', 'ชลบุรี', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('7f79bf2f-a92e-417f-a55b-00ef1623ade8', 'central', 'Sing Buri', 'สิงห์บุรี', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('829af717-5373-40d5-85f5-8b1c8bff0eda', 'east', 'Chachoengsao', 'ฉะเชิงเทรา', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('832243ca-d79b-4a08-9f77-553f9d660c95', 'north-east', 'Surin', 'สุรินทร์', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('865b3777-20db-4d17-b669-f41401b29d67', 'north-east', 'Loei', 'เลย', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('98347e1b-a047-4600-81c9-c26900687461', 'north-east', 'Roi Et', 'ร้อยเอ็ด', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('99fd0187-73b6-47c7-9f7c-0d11946db1d3', 'central', 'Phra Nakhon Si Ayutthaya', 'พระนครศรีอยุธยา', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('9a29ab2a-a5f9-4285-a700-1f27be73bf50', 'east', 'Chanthaburi', 'จันทบุรี', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('9bb00eca-bc07-4bda-879a-49dd65298cce', 'bkk-metro', 'Samut Sakhon', 'สมุทรสาคร', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('9ce116b6-3d13-41aa-b256-84e02c3c4e27', 'bkk-metro', 'Nakhon Pathom', 'นครปฐม', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('9faf0e8c-1d1e-4cff-a383-ab3a384d52a5', 'bkk-metro', 'Samut Prakan', 'สมุทรปราการ', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('a57a11c3-a5c2-4fb7-862a-26294407b6aa', 'west', 'Phetchaburi', 'เพชรบุรี', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('ae26bf10-559e-4daf-b2d6-8cf4154ba0bb', 'north-east', 'Khon Kaen', 'ขอนแก่น', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('afff1778-a911-400b-acdc-1926517598dc', 'north-east', 'Ubon Ratchathani', 'อุบลราชธานี', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('b266efd3-d081-48f7-8f99-dfab3271f105', 'north-east', 'Amnat Charoen', 'อำนาจเจริญ', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('b3bc4ed6-092e-4992-b8c9-24f9b99a6674', 'bkk-metro', 'Bangkok', 'กรุงเทพมหานคร', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('b43c0ea8-9e60-4cb1-bd1d-e6d8272fbdac', 'north', 'Mae Hong Son', 'แม่ฮ่องสอน', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('b864af91-5771-4c94-a88a-f9ae3afe1e37', 'bkk-metro', 'Pathum Thani', 'ปทุมธานี', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('bc26b6de-f1be-4ddd-8b1d-e10fb37f5bb4', 'north-east', 'Maha Sarakham', 'มหาสารคาม', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('bd583de5-d596-4921-9800-418457f93e2d', 'north', 'Chiang Mai', 'เชียงใหม่', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('be3eba83-e8ac-4681-9ff4-02384e2c603b', 'central', 'Suphan Buri', 'สุพรรณบุรี', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('c1629dee-236c-4280-8c2d-0c9074820f77', 'south', 'Pattani', 'ปัตตานี', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('cf88e46a-49f6-4ed0-b05a-0ac528714ff8', 'central', 'Chai Nat', 'ชัยนาท', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('d32904aa-74a4-4393-aba6-041233be0e28', 'south', 'Nakhon Si Thammarat', 'นครศรีธรรมราช', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('d4f7bffb-7937-4cc4-9ccd-4486c9a0fe5d', 'central', 'Kampheang Phet', 'กำแพงเพชร', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('daef1d8c-6d9c-4175-86cb-2edeedf9a6f1', 'north', 'Phayao', 'พะเยา', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('db6afb79-e405-4aca-a90e-49d590391c1d', 'west', 'Kanchanaburi', 'กาญจนบุรี', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('e167eb56-9b01-4af0-9520-9cb0424390f9', 'east', 'Sa Kaeo', 'สระแก้ว', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('e21444bd-4027-4a1c-8f24-e4114621097f', 'east', 'Trat', 'ตราด', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('f4f37824-3b3f-4890-b24a-db342d2ff739', 'north-east', 'Nakhon Ratchasima', 'นครราชสีมา', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('f609eb4b-6585-4ae1-a011-064d83f22f63', 'central', 'Phetchabun', 'เพชรบูรณ์', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('f6629529-e956-406e-a463-02f4976b8208', 'central', 'Phitsanulok', 'พิษณุโลก', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('f9624ba9-e59e-4625-92b9-54db1b726495', 'north', 'Lampang', 'ลำปาง', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('fa94ced7-9648-4156-b47c-6c29b843051a', 'central', 'Samut Songkhram', 'สมุทรสงคราม', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('fccb6b30-2dd2-4fa9-a901-2c32ae1e1759', 'east', 'Prachinburi', 'ปราจีนบุรี', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714'),
('fe2eb569-fc25-4a1a-b75a-55438bf9e664', 'north', 'Phrae', 'แพร่', '2021-12-23 02:59:01.995714', '2021-12-23 02:59:01.995714');

INSERT INTO "public"."proxies" ("id", "name", "phone_number", "created_at", "updated_at") VALUES
('5b6b247a-92bf-11ec-98e5-0242ac190002', 'Proxy Full name', '0123456789', '2022-02-21 02:38:31.174659', '2022-02-21 02:38:31.174659');

INSERT INTO "public"."regions" ("id", "name_en", "name_th", "minimum_price", "maximum_price", "created_at", "updated_at") VALUES
('bkk-metro', 'Bangkok Metropolitan', 'กรุงเทพฯและปริมณฑล', 70, 90, '2021-12-23 02:59:01.983971', '2021-12-23 02:59:01.983971'),
('central', 'Central', 'กลาง', 70, 90, '2021-12-23 02:59:01.983971', '2021-12-23 02:59:01.983971'),
('east', 'Eastern', 'ตะวันออก', 70, 90, '2021-12-23 02:59:01.983971', '2021-12-23 02:59:01.983971'),
('north', 'Northern', 'เหนือ', 80, 100, '2021-12-23 02:59:01.983971', '2021-12-23 02:59:01.983971'),
('north-east', 'North Eastern', 'อีสาน', 100, 100, '2021-12-23 02:59:01.983971', '2021-12-23 02:59:01.983971'),
('south', 'Southern', 'ใต้', 80, 80, '2021-12-23 02:59:01.983971', '2021-12-23 02:59:01.983971'),
('west', 'Western', 'ตะวันตก', 70, 90, '2021-12-23 02:59:01.983971', '2021-12-23 02:59:01.983971');

INSERT INTO "public"."time_slots" ("id", "name_en", "name_th", "time_slot_start_at", "time_slot_end_at", "created_at", "updated_at") VALUES
('afternoon', 'Afternoon', 'ช่วงบ่าย', '13:00:00', '18:00:00', '2022-01-07 07:51:18.107072', '2022-01-07 07:51:18.107072'),
('all-day', 'All Day', 'ทั้งวัน', '06:00:00', '18:00:00', '2022-01-07 07:51:18.107072', '2022-01-07 07:51:18.107072'),
('morning', 'Morning', 'ช่วงเช้า', '06:00:00', '12:00:00', '2022-01-07 07:51:18.107072', '2022-01-07 07:51:18.107072');

INSERT INTO "public"."users" ("id", "first_name", "last_name", "email", "phone_number", "profile_picture", "line_id", "type", "created_at", "updated_at", "invitation_code_id", "profile_picture__change_flag", "profile_picture__delete_flag") VALUES
('170bff46-8ede-11ec-8588-0242ac190002', 'Angelica', 'JEAN', 'jean@jean.fr', '0800022256', 'https://avatars.dicebear.com/v2/avataaars/7c221a5f9f5fbd873d6423c534ff2bbd.svg', '123123123', 'vendor', '2022-02-16 11:08:26', '2022-02-16 11:08:26', NULL, NULL, NULL),
('1edf0a10-99d8-11ec-90dc-0242ac190002', 'Lacie', 'ADAM', 'Chuck@domain.co', '1234567890', 'https://avatars.dicebear.com/v2/avataaars/92067e22bec44de8f4468ece397ad489.svg', 'xxxxxxxxxxxxxxz', 'buyer', '2022-03-02 10:23:25', '2022-03-02 10:23:25', NULL, '1', '0'),
('230c1f8e-9095-11ec-9da8-0242ac190002', 'Manu', 'BLANK', 'b@lol.com', '019283710222', 'https://avatars.dicebear.com/v2/avataaars/390f655df2323816686fc3284c2533eb.svg', 'u1234567u8i9876543swertyuioiuytrew', 'buyer', '2022-02-18 15:31:15', '2022-02-18 15:31:15', NULL, NULL, NULL),
('2ee894e6-948b-11ec-b581-0242ac190002', 'Kealan', 'CLEGG', 'email@email.vn', '01929382345', 'https://avatars.dicebear.com/v2/avataaars/acc9dda8a94fe2b6d381c2b8f82880f1.svg', 'linenewnewnew', 'vendor', '2022-02-23 16:30:04.961539', '2022-02-23 16:30:04.961539', NULL, NULL, NULL),
('30ae9ba2-9398-11ec-b112-0242ac190002', 'Ritchie', 'HENSLEY', 'toto@toto.com', '222222229', 'https://avatars.dicebear.com/v2/avataaars/1e368ec7aecfbe000e9cd51f0ac67a1e.svg', 'pqlapqlapqpwo2', 'buyer', '2022-02-22 11:30:40.221453', '2022-02-22 11:30:40.221453', NULL, NULL, NULL),
('3380e0b2-8ed7-11ec-809e-0242ac190002', 'Chuck', 'NORRIS', 'Chuck@domain.co', '0815403729', 'https://avatars.dicebear.com/v2/avataaars/eb4d003ff50c252bc5d9cbab9cd9b9d6.svg', '22222', 'vendor', '2022-02-16 10:19:07', '2022-02-16 10:19:07', NULL, NULL, NULL),
('383c7606-692b-11ec-b5cb-0242ac190002', 'Pierre', 'DURAN', 'buyer@drone.net', '0103456789', 'https://avatars.dicebear.com/v2/avataaars/0ddd6f572d06abea9af9c64d27229f3a.svg', 'LINE_ID_222222222', 'buyer', '2021-12-30 11:44:48.960466', '2021-12-30 11:44:48.960466', NULL, NULL, NULL),
('4211fddc-8ed7-11ec-9690-0242ac190002', 'Chuck', 'MEYER', 'Chuck@domain.co', '0899945362', 'https://avatars.dicebear.com/v2/avataaars/9d9bc4c56997ff42643707c8b3361023.svg', '120938120938120938123044356d', 'vendor', '2022-02-16 10:19:31', '2022-02-16 10:19:31', NULL, NULL, NULL),
('4ad91610-8ede-11ec-820a-0242ac190002', 'Luna', 'LORIS', 'lun@lun.fr', '0891647222', 'https://avatars.dicebear.com/v2/avataaars/33eae51beb053bbd020684bde13f8d59.svg', 'ud0923e09i3e9032ie2309ei3', 'buyer', '2022-02-16 11:09:53', '2022-02-16 11:09:53', NULL, NULL, NULL),
('54ba245e-8e6a-11ec-9bb8-0242ac190002', 'Joly', 'MITCHELL', 'Chuck@domain.co', '0816473825', 'https://avatars.dicebear.com/v2/avataaars/9f4008f02ec89392a72bc1ba6866d24f.svg', 'u0293ei3290ei30ei9302', 'vendor', '2022-02-15 21:19:48', '2022-02-15 21:19:48', NULL, NULL, NULL),
('5b7c3a12-8ef5-11ec-9bb1-0242ac190002', 'Neave', 'BOUVET', 'first@last.com', '0192039302', 'https://avatars.dicebear.com/v2/avataaars/642c1d2991af306d85ac5ca608e61c24.svg', 'u1wi12908edj2j38dj238dj3489d', 'vendor', '2022-02-16 13:54:59', '2022-02-16 13:54:59', NULL, NULL, NULL),
('5cdd79e4-695b-11ec-87e4-0242ac190002', 'Steve', 'COSTA', 'rice@forlife.vn', '0001000000', 'https://avatars.dicebear.com/v2/avataaars/5325de1a85d7ce20348fb32599d99489.svg', 'uf320939de34d90iewf43f09efi', 'vendor', '2021-12-30 17:29:26.227597', '2021-12-30 17:29:26.227597', NULL, NULL, NULL),
('5fe7c3d6-90ae-11ec-abdf-0242ac190002', 'Henry', 'RYDER', 'Chuck@domain.co', '1235567890', 'https://avatars.dicebear.com/v2/avataaars/c160b5d7834e89c99cb6d57a5dcb84e5.svg', '22222jjjjj', 'vendor', '2022-02-18 18:31:54', '2022-02-18 18:31:54', NULL, NULL, NULL),
('68ccdf12-9ba4-11ec-b719-0242ac190002', 'Moli', 'NORRIS', 'Chuck@domain.co', '1233567890', 'https://avatars.dicebear.com/v2/avataaars/910b2ca6a3759387e9f37138558d6d25.svg', 'odjwiscksdkbcdfkjvb fdvpsdaclkm', 'vendor', '2022-03-04 17:18:17', '2022-03-08 12:15:24.552178', NULL, '0', '0'),
('7fd8208c-8ee2-11ec-b66e-0242ac190002', 'Jennifer', 'PRICE', 'EMAIL@GMAIL.COM', '0192837465', 'https://avatars.dicebear.com/v2/avataaars/04fbe34dd2f526341262a7512186a710.svg', 'u0329dio4wiru0349iru4309r', 'buyer', '2022-02-16 11:40:00', '2022-02-16 11:40:00', NULL, NULL, NULL),
('855a119a-9497-11ec-ba1b-0242ac190002', 'Chuck', 'STOTT', 'Chuck@domain.co', '1234567890', 'https://avatars.dicebear.com/v2/avataaars/9c265e048e9cea00d63114426a48f75c.svg', '22222___fhf', 'vendor', '2022-02-23 17:58:23.950623', '2022-02-23 17:58:23.950623', NULL, NULL, NULL),
('91fd22c6-8e6a-11ec-a821-0242ac190002', 'FINAL', 'TAIT', 'HERE@WE.GO', '1234567890', 'https://avatars.dicebear.com/v2/avataaars/d58788547696870090b93967ef410442.svg', 'u0923i0329ei2390ei2309', 'buyer', '2022-02-15 21:21:30', '2022-02-15 21:21:30', NULL, NULL, NULL),
('a1ef2f86-955d-11ec-95c0-0242ac190002', 'Chuck', 'MONTES', 'Chuck@domain.co', '1234567890', 'https://avatars.dicebear.com/v2/avataaars/8dedf126f0f222e81d769685cd452e9a.svg', 'sodicmdscwdmcdkncnnnn', 'vendor', '2022-02-24 17:36:32', '2022-02-24 17:36:32', NULL, NULL, NULL),
('a705085c-8fc6-11ec-91cd-0242ac190002', 'Shamima', 'DORSEY', 'buyer@new.com', '012367835', 'https://avatars.dicebear.com/v2/avataaars/b52cec020e8991091b73afe9afae8727.svg', 'uedekdiedoedeokdeokd', 'buyer', '2022-02-17 14:53:10', '2022-02-17 14:53:10', NULL, NULL, NULL),
('b4ffca30-9ba3-11ec-bced-0242ac190002', 'Chuck', 'WEBER', 'Chuck@domain.co', '2234567890', 'https://avatars.dicebear.com/v2/avataaars/376bd0831b4d28376dd4506323152431.svg', 'sdcxsdsdcfdvgfbbbbb', 'vendor', '2022-03-04 17:13:15', '2022-03-04 17:13:15', NULL, '0', '0'),
('b5529b08-955d-11ec-8c77-0242ac190002', 'Rosa', 'PARKS', 'Chuck@domain.co', '1234566890', 'https://avatars.dicebear.com/v2/avataaars/b64d4572f075c6e38ad97325673a93df.svg', '111111__', 'vendor', '2022-02-24 17:37:04', '2022-02-24 17:37:04', NULL, NULL, NULL),
('d66e46f8-9e9e-11ec-9b91-0242ac190002', 'Remy', 'LITTLE', 'remy@little.com', '012367835', 'https://avatars.dicebear.com/v2/avataaars/910b2ca6a3759387e9f37138558d6d25.svg', 'random_line_id', 'buyer', '2022-03-08 12:15:58.089548', '2022-03-17 13:12:37.334703', NULL, NULL, NULL),
('eba62066-9ba3-11ec-b719-0242ac190002', 'Robert', 'GOLDER', 'Chuck@NORRIS.fr', '1234567890', 'https://avatars.dicebear.com/v2/avataaars/0b9353cf646d04cbd3f1cdafdcf59194.svg', 'sdlkdskcdsfk jcv dfkvdfk ', 'vendor', '2022-03-04 17:14:47', '2022-03-04 17:14:47', NULL, '0', '0'),
('f37d0696-8ede-11ec-84d0-0242ac190002', 'Mark', 'LESTER', 'Chuck@domain.co', '0000099991', 'https://avatars.dicebear.com/v2/avataaars/4333115c6ff953998a553743c6cc4171.svg', 'U10293810293830925823423453', 'vendor', '2022-02-16 11:14:36', '2022-02-16 11:14:36', NULL, NULL, NULL),
('fa01bc14-8ede-11ec-84d0-0242ac190002', 'James', 'ALFORD', 'Chuck@domain.co', '1234567890', 'https://avatars.dicebear.com/v2/avataaars/891355be6edbf31b86cf0b8fa4393935.svg', '', 'vendor', '2022-02-16 11:14:46', '2022-02-16 11:14:46', NULL, NULL, NULL);

ALTER TABLE "public"."orders" ADD FOREIGN KEY ("buyer_id") REFERENCES "public"."users"("id") ON DELETE SET NULL;
ALTER TABLE "public"."orders" ADD FOREIGN KEY ("shop_id") REFERENCES "public"."shops"("id") ON DELETE SET NULL;
ALTER TABLE "public"."orders" ADD FOREIGN KEY ("order_time_id") REFERENCES "public"."order_times"("id") ON DELETE SET NULL;
ALTER TABLE "public"."orders" ADD FOREIGN KEY ("time_slot_id") REFERENCES "public"."time_slots"("id") ON DELETE SET NULL;
ALTER TABLE "public"."orders" ADD FOREIGN KEY ("vendor_id") REFERENCES "public"."users"("id") ON DELETE SET NULL;
ALTER TABLE "public"."orders" ADD FOREIGN KEY ("proxy_id") REFERENCES "public"."proxies"("id") ON DELETE SET NULL;
ALTER TABLE "public"."shops" ADD FOREIGN KEY ("region_id") REFERENCES "public"."regions"("id") ON DELETE SET NULL;
ALTER TABLE "public"."shops" ADD FOREIGN KEY ("vendor_id") REFERENCES "public"."users"("id") ON DELETE SET NULL;
ALTER TABLE "public"."provinces" ADD FOREIGN KEY ("region_id") REFERENCES "public"."regions"("id");
