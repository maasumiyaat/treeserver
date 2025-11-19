-- USERS Table
CREATE TABLE users (
    id UUID PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    score INTEGER NOT NULL,
    email TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL
);

-- Indexes for USERS
CREATE INDEX idx_users_username ON users (username);
CREATE INDEX idx_users_score ON users (score);

-- PRODUCTS Table
CREATE TABLE products (
    id UUID PRIMARY KEY,
    name TEXT NOT NULL,
    price NUMERIC NOT NULL,
    category TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL
);

-- Indexes for PRODUCTS
CREATE INDEX idx_products_price ON products (price);
CREATE INDEX idx_products_category ON products (category);

-- TASKS Table
CREATE TABLE tasks (
    id UUID PRIMARY KEY,
    task_name TEXT NOT NULL,
    priority INTEGER NOT NULL,
    status TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL
);

-- Indexes for TASKS
CREATE INDEX idx_tasks_priority ON tasks (priority);

-- DATACENTERS Table
CREATE TABLE datacenters (
    id UUID PRIMARY KEY,
    name TEXT NOT NULL,
    latitude DOUBLE PRECISION NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,
    region TEXT NOT NULL
);

-- Indexes for DATACENTERS (using GIST for spatial)
CREATE INDEX idx_datacenters_location ON datacenters USING GIST (point(latitude, longitude));

-- MAP_OBJECTS Table
CREATE TABLE map_objects (
    id UUID PRIMARY KEY,
    object_type TEXT NOT NULL,
    x FLOAT NOT NULL,
    y FLOAT NOT NULL,
    metadata JSONB
);

-- Indexes for MAP_OBJECTS (GIST for 2D)
CREATE INDEX idx_map_objects_xy ON map_objects USING GIST (point(x, y));

-- API_USAGE Table
CREATE TABLE api_usage (
    id UUID PRIMARY KEY,
    timestamp TIMESTAMP NOT NULL,
    calls INTEGER NOT NULL
);

-- Indexes for API_USAGE
CREATE INDEX idx_api_usage_timestamp ON api_usage (timestamp);

-- LOGS Table
CREATE TABLE logs (
    id UUID PRIMARY KEY,
    log_message TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL
);

-- No specific index needed beyond PK

-- TEXT_SNIPPETS Table
CREATE TABLE text_snippets (
    id UUID PRIMARY KEY,
    content TEXT NOT NULL
);

-- Indexes for TEXT_SNIPPETS (GIN for full-text search if needed)
CREATE INDEX idx_text_snippets_content ON text_snippets USING GIN (to_tsvector('english', content));

INSERT INTO users (id, username, score, email, created_at) VALUES
('1d8f218b-10ae-4275-b1b3-a8a927f6a3cf', 'admin36', 57382, 'admin36@example.com', '2025-07-11 18:07:14.631655'),
('a9871289-6fe8-47e5-a1d7-49540105aed7', 'admin45', 33739, 'admin45@example.com', '2025-01-04 18:07:14.631713'),
('4a1ee947-d581-436f-a29c-0916dae2f288', 'guest40', 4131, 'guest40@example.com', '2025-05-15 18:07:14.631738'),
('aaca9893-37e0-458a-8cd5-c6e7d4650b11', 'guest26', 70672, 'guest26@example.com', '2025-10-28 18:07:14.631759'),
('d568ffbf-1910-4715-811d-c387715ac660', 'admin25', 73064, 'admin25@example.com', '2025-03-18 18:07:14.631789'),
('16c7514c-95a0-4641-8fbd-6170e37556b3', 'user41', 58238, 'user41@example.com', '2025-04-25 18:07:14.631809'),
('e7b4bfdc-b225-4bb8-a99d-662fcf74f243', 'guest21', 94338, 'guest21@example.com', '2025-04-13 18:07:14.631828'),
('bc736548-c480-41dc-8b0a-0fd3306bd703', 'admin39', 8647, 'admin39@example.com', '2025-02-22 18:07:14.631848'),
('e13560ff-50ff-49e7-932d-2236478cad52', 'guest35', 37256, 'guest35@example.com', '2025-11-09 18:07:14.631867'),
('e86ad286-b0f5-4b0c-8576-484424d5cb6d', 'guest37', 95967, 'guest37@example.com', '2025-05-16 18:07:14.631888'),
('7a960785-f6dd-4d74-b71c-9adb7fe883c9', 'user27', 72455, 'user27@example.com', '2025-08-15 18:07:14.631907'),
('4dff973c-f702-4a6e-837c-c02b75496d74', 'guest30', 64326, 'guest30@example.com', '2024-12-25 18:07:14.631926'),
('82c0a9c3-14de-43cb-bdd3-1e3acccec5d1', 'guest25', 76385, 'guest25@example.com', '2024-11-24 18:07:14.631945'),
('ea0a5909-f502-418f-88b9-ced865e2da26', 'user49', 23378, 'user49@example.com', '2025-02-08 18:07:14.631962'),
('b8a79cb2-be99-4126-8095-3847d8560431', 'user23', 45669, 'user23@example.com', '2025-10-06 18:07:14.631979'),
('37c57fda-36ca-4c6f-94ab-a547bf907dc7', 'user47', 24656, 'user47@example.com', '2025-09-16 18:07:14.631998'),
('077cc157-7b15-448e-9e47-f59b60ff4ed5', 'guest12', 26149, 'guest12@example.com', '2025-09-29 18:07:14.632017'),
('eaacf854-a659-4be1-83d5-2941e2ee5ce8', 'user34', 59899, 'user34@example.com', '2025-09-18 18:07:14.632037'),
('79e04248-05fd-4783-9595-5dac77c04a09', 'admin49', 93744, 'admin49@example.com', '2025-11-14 18:07:14.632055'),
('504a8d09-5814-4d9b-a7dd-6aaadef3707b', 'guest11', 29031, 'guest11@example.com', '2025-08-24 18:07:14.632074'),
('229cb92e-c5ba-49d6-b85b-090d62fa0b3a', 'guest48', 72099, 'guest48@example.com', '2025-06-18 18:07:14.632093'),
('4c634a21-221f-47c0-98fd-0bcf2fcd3d2b', 'guest10', 4066, 'guest10@example.com', '2025-01-14 18:07:14.632111'),
('8e7a7daa-519c-497e-81d9-9aac214b33f9', 'user29', 22112, 'user29@example.com', '2025-07-05 18:07:14.632130'),
('b15948b1-d96d-4613-b3d3-553275c2ddbc', 'admin41', 80843, 'admin41@example.com', '2025-04-23 18:07:14.632147'),
('e23f6453-dfbf-41d6-8410-723d33f49b6e', 'admin5', 70599, 'admin5@example.com', '2025-06-16 18:07:14.632165'),
('53c10936-bdb5-4a28-8813-2e8c2f7495a9', 'guest33', 76200, 'guest33@example.com', '2025-09-02 18:07:14.632183'),
('b845e03b-77ca-4f7a-9e3e-aedf4a1c52a1', 'guest19', 99557, 'guest19@example.com', '2025-09-15 18:07:14.632201'),
('7d935d30-195a-4c0c-ab09-ed052c7bd45a', 'admin47', 92592, 'admin47@example.com', '2025-05-23 18:07:14.632218'),
('96bd6c41-1204-4a82-a2e0-145f6eb07b06', 'user5', 26222, 'user5@example.com', '2025-11-14 18:07:14.632234'),
('bc7da7f0-f9c1-405e-b6fc-8c7396e5ef28', 'admin13', 96188, 'admin13@example.com', '2025-08-09 18:07:14.632253'),
('f4fb662d-0a84-4c98-ba7d-86ed93b424e3', 'user11', 49286, 'user11@example.com', '2025-04-15 18:07:14.632272'),
('c65a3c71-52e6-424d-9100-d0128d427e97', 'admin18', 31189, 'admin18@example.com', '2024-12-05 18:07:14.632296'),
('d9552d37-bf4b-440e-bcf5-1ac88b0fb61a', 'guest36', 46190, 'guest36@example.com', '2025-09-01 18:07:14.632319'),
('119ee351-1b3f-473f-9422-6eb872d5834c', 'user37', 62375, 'user37@example.com', '2025-07-11 18:07:14.632340'),
('9edceb3f-67d8-4968-85bd-a30b1ef2cd5f', 'admin9', 96633, 'admin9@example.com', '2025-08-18 18:07:14.632362'),
('4aeb2b07-73d9-4cb6-9bce-fc03ee0f9b29', 'guest43', 28473, 'guest43@example.com', '2025-09-01 18:07:14.632384'),
('3e88a23c-6a8f-4030-8333-5d950ef16518', 'admin27', 61593, 'admin27@example.com', '2025-03-13 18:07:14.632404'),
('d9bb0be6-3b42-4654-a68e-1980addf36cb', 'user45', 85024, 'user45@example.com', '2025-07-24 18:07:14.632427'),
('045561a9-9315-4b9e-a0bf-3eb886ce9797', 'user16', 55783, 'user16@example.com', '2025-11-02 18:07:14.632448'),
('87329d85-7aa8-4538-b75f-4e9c05f468ce', 'guest8', 21639, 'guest8@example.com', '2025-06-29 18:07:14.632479'),
('4c740e39-8866-4a7c-8f6e-2e9deb141d56', 'user8', 55507, 'user8@example.com', '2025-05-30 18:07:14.632501'),
('e3532913-c181-4b19-a440-98276de32939', 'user14', 76714, 'user14@example.com', '2025-01-29 18:07:14.632524'),
('9161145f-db7b-4d44-9174-411ff0079076', 'guest32', 67386, 'guest32@example.com', '2025-04-22 18:07:14.632547'),
('a73407be-c8db-4d1b-a6d2-75600a8b8283', 'admin31', 29341, 'admin31@example.com', '2025-02-21 18:07:14.632567'),
('28f98f83-fe7d-44a6-89a0-a5743d24aac2', 'admin6', 90696, 'admin6@example.com', '2025-07-11 18:07:14.632624'),
('30bd5812-f887-4ffb-bab5-a233427c3435', 'guest24', 83892, 'guest24@example.com', '2025-10-05 18:07:14.632648'),
('59b94a7a-5b50-42ea-81fc-f1a4affd17c8', 'admin12', 14744, 'admin12@example.com', '2025-09-11 18:07:14.632668'),
('3e5ceee9-736f-4f6f-a853-5281645f58a5', 'admin32', 98797, 'admin32@example.com', '2025-07-13 18:07:14.632687'),
('eaba7510-b9b6-4006-b715-b0d3a6277bfa', 'guest1', 74662, 'guest1@example.com', '2025-01-10 18:07:14.632706'),
('003f8a59-bd80-4bca-bf79-6536012b2f59', 'user38', 59739, 'user38@example.com', '2025-10-21 18:07:14.632727'),
('38c02180-5c0c-41a4-bdac-4a79cfd2de14', 'admin10', 92456, 'admin10@example.com', '2025-06-21 18:07:14.632746'),
('257d5e9a-4857-4f82-9f79-050e99e6bfe3', 'guest17', 36521, 'guest17@example.com', '2025-05-20 18:07:14.632764'),
('2d08be4c-4708-4c81-a4e2-74cc4c4c764b', 'admin48', 90748, 'admin48@example.com', '2025-01-09 18:07:14.632785'),
('6858b472-f9a2-4e62-810e-6bca937ebba6', 'guest31', 98696, 'guest31@example.com', '2025-03-28 18:07:14.632804'),
('435fed3d-b993-4bbe-94e8-6ca1cfa33c3f', 'admin50', 82559, 'admin50@example.com', '2025-11-14 18:07:14.632824'),
('927b53e4-861c-45cc-9ffd-74aa20a05254', 'user7', 47611, 'user7@example.com', '2025-08-26 18:07:14.632843'),
('f591f790-cbf3-46f1-8527-0ccfc895ba8d', 'admin33', 35571, 'admin33@example.com', '2024-11-20 18:07:14.632863'),
('4ff5b39f-2a64-412f-829c-0d09bf7193d3', 'admin19', 89518, 'admin19@example.com', '2024-12-14 18:07:14.632883'),
('7cd07eb9-73b8-4719-a9eb-d38c16ad18ca', 'admin29', 8338, 'admin29@example.com', '2025-01-01 18:07:14.632902'),
('a5ce8392-2852-4d00-bf14-6af4aa766860', 'guest39', 19319, 'guest39@example.com', '2025-02-03 18:07:14.632922'),
('6c4add7f-b24e-478c-9d7d-744118419008', 'guest13', 37193, 'guest13@example.com', '2025-01-20 18:07:14.632942'),
('f4426e84-ef41-4af7-89cb-65f92b36cb36', 'guest38', 38555, 'guest38@example.com', '2024-12-17 18:07:14.632961'),
('07fb1447-d276-4265-82bb-ffd8bab5d71f', 'user48', 30767, 'user48@example.com', '2024-12-20 18:07:14.632981'),
('becbecca-7fb4-44b2-8a86-981d4447ce37', 'user24', 85036, 'user24@example.com', '2025-01-14 18:07:14.632999'),
('12c6762f-c169-4b58-8737-df99104537be', 'guest47', 29271, 'guest47@example.com', '2025-08-27 18:07:14.633018'),
('e23c805f-61ba-4983-96d7-0201c8999a39', 'user12', 94165, 'user12@example.com', '2025-05-02 18:07:14.633038'),
('27ec3a19-f8b6-4cfb-bed9-8f582846f129', 'admin22', 12358, 'admin22@example.com', '2024-12-21 18:07:14.633057'),
('daf09da1-668c-4359-8311-f1dfa850cc77', 'guest15', 9758, 'guest15@example.com', '2025-04-02 18:07:14.633076'),
('40ae1a0b-e713-44e9-ba30-24d472c7419d', 'admin21', 66972, 'admin21@example.com', '2025-01-15 18:07:14.633094'),
('1699aeb5-0696-4460-8142-98d8c7c2e877', 'admin46', 54883, 'admin46@example.com', '2025-05-23 18:07:14.633113'),
('42a662fb-b65d-4488-8b9a-fc269b3acd44', 'guest16', 63883, 'guest16@example.com', '2025-02-11 18:07:14.633133'),
('9b3fa970-25aa-44f9-b8fc-3a5a8d3d8f73', 'admin24', 75246, 'admin24@example.com', '2025-01-25 18:07:14.633153'),
('be0eadd5-cf5e-41e1-b10d-fe9cdc505787', 'admin26', 37239, 'admin26@example.com', '2025-01-25 18:07:14.633172'),
('3cdc0e9c-2adb-498b-ba6a-5751051a7682', 'user15', 45641, 'user15@example.com', '2025-11-03 18:07:14.633191'),
('a8309afa-a883-46db-b0e7-696743a68fb1', 'user9', 22149, 'user9@example.com', '2025-09-15 18:07:14.633210'),
('82fb8390-afbd-4cec-a669-3d4a3e2c7be9', 'user46', 58827, 'user46@example.com', '2025-05-20 18:07:14.633229'),
('52c2a07d-cabf-4901-9a95-c390bff246d6', 'user36', 54095, 'user36@example.com', '2025-04-14 18:07:14.633248'),
('9b77dcf4-c6ea-45d5-aff1-1762a9a4cec4', 'admin15', 33337, 'admin15@example.com', '2025-06-17 18:07:14.633267'),
('1dc309c6-1a88-4ffa-bc08-408913b998af', 'user22', 97934, 'user22@example.com', '2025-07-17 18:07:14.633286'),
('d5baedcd-4ae9-4d2c-96d9-806c7bb9e96b', 'admin20', 80512, 'admin20@example.com', '2024-12-29 18:07:14.633305'),
('ab725795-86c5-44c2-817b-bffbe1abd97c', 'user1', 45983, 'user1@example.com', '2025-01-17 18:07:14.633338'),
('67c8de96-b742-4e5e-a8a2-2c96fafcdc1c', 'admin3', 32104, 'admin3@example.com', '2025-01-25 18:07:14.633377'),
('33c874c7-dbe2-44df-ade7-9af7f7dfa73d', 'admin8', 76818, 'admin8@example.com', '2025-09-11 18:07:14.633399'),
('f6068d2e-eda3-495a-8a41-664be19cb03b', 'user19', 15345, 'user19@example.com', '2025-10-29 18:07:14.633415'),
('7b9b8234-a785-4721-bc2e-e25c5f2369df', 'admin1', 48213, 'admin1@example.com', '2025-01-29 18:07:14.633431'),
('b4a7915e-87d1-4f47-9371-156b683b5d77', 'admin2', 54800, 'admin2@example.com', '2024-12-28 18:07:14.633447'),
('bce8c718-ccdd-4b96-acc3-ec5ab3d98746', 'admin40', 21235, 'admin40@example.com', '2025-09-25 18:07:14.633471'),
('6b21467e-5e82-4b51-8ab5-a1be00117641', 'user30', 54299, 'user30@example.com', '2025-09-23 18:07:14.633487'),
('fe74fbdc-47fe-469f-af8e-511b74a885e2', 'user42', 96116, 'user42@example.com', '2024-12-02 18:07:14.633503'),
('ae1de852-b939-48ff-950d-dab6f462f715', 'user44', 78363, 'user44@example.com', '2025-09-27 18:07:14.633520'),
('13b81d84-9e7e-46aa-be73-535497c582fb', 'admin16', 68951, 'admin16@example.com', '2024-12-12 18:07:14.633536'),
('9db3c303-660b-49aa-8c0c-8695b71c515a', 'user40', 87760, 'user40@example.com', '2025-07-02 18:07:14.633552'),
('25cf631a-b170-4b3f-b7ff-1bc69efb812b', 'guest23', 691, 'guest23@example.com', '2025-08-07 18:07:14.633568'),
('044fb488-9f5e-42d6-85bd-214aca984675', 'admin43', 95189, 'admin43@example.com', '2025-08-14 18:07:14.633596'),
('eff1e4dd-d691-4509-80e4-b2764faa7221', 'guest6', 97052, 'guest6@example.com', '2024-12-01 18:07:14.633615'),
('c76fc2eb-8d83-4fac-b26f-00952788d4e8', 'user31', 62099, 'user31@example.com', '2025-05-11 18:07:14.633631'),
('84a52192-1f11-4354-b2a8-17ce429e928a', 'user2', 33817, 'user2@example.com', '2025-06-30 18:07:14.633647'),
('09d85daf-ace1-48b4-941e-42f656a1b3af', 'admin23', 45715, 'admin23@example.com', '2025-10-24 18:07:14.633663'),
('58b4b302-a6a5-4b89-8dd7-d5d4510ac883', 'user18', 42723, 'user18@example.com', '2025-05-01 18:07:14.633680'),
('4f262ff2-d6f7-470f-970f-da9993439426', 'guest50', 59775, 'guest50@example.com', '2025-03-11 18:07:14.633696'),
('527f9893-96a6-4ba3-baed-67cd0425af63', 'guest2', 3112, 'guest2@example.com', '2024-12-07 18:07:14.633713'),
('b5f8f41e-4ba2-4e7b-a7ac-c2790676cb85', 'admin11', 2097, 'admin11@example.com', '2025-07-30 18:07:14.633729'),
('5d63fc0f-1ee2-462c-a06c-861b922c1371', 'user39', 50079, 'user39@example.com', '2025-10-11 18:07:14.633745'),
('b51e9523-0cfb-4ee6-9a8d-9717ebcdc5b0', 'user26', 48315, 'user26@example.com', '2025-09-08 18:07:14.633762'),
('a095914b-8bd5-43bb-b3bb-5ce05d50ec5b', 'guest7', 59538, 'guest7@example.com', '2025-06-01 18:07:14.633792'),
('b0c2c639-008b-4578-98a1-6a1f0d524264', 'guest22', 80921, 'guest22@example.com', '2025-06-25 18:07:14.633808'),
('6d94b856-d656-4b47-87a2-d5de6879058e', 'guest3', 53225, 'guest3@example.com', '2025-08-18 18:07:14.633825'),
('6dea131d-1124-48c4-b402-0c4489e2edc4', 'guest34', 82432, 'guest34@example.com', '2025-04-19 18:07:14.633841'),
('e7639a1c-e624-49f2-b2ce-2c673b99135c', 'admin44', 37694, 'admin44@example.com', '2025-02-03 18:07:14.633857'),
('6de61005-73a5-4d4f-841c-4fa16ed9a9e9', 'guest14', 11651, 'guest14@example.com', '2025-05-29 18:07:14.633874'),
('761bda85-b61f-42a9-9007-60d5a35650f1', 'admin35', 64824, 'admin35@example.com', '2025-07-14 18:07:14.633891'),
('b8a0c6a5-798b-4d73-a388-72c0048d5215', 'admin42', 53805, 'admin42@example.com', '2025-01-16 18:07:14.633908'),
('57666a45-3f14-49fb-afae-94ea4b754d5d', 'admin34', 46819, 'admin34@example.com', '2025-03-29 18:07:14.633924'),
('3708d597-967d-4587-8698-40197468a863', 'guest9', 18534, 'guest9@example.com', '2025-10-07 18:07:14.633940'),
('13aaca05-ce8a-4c44-9a69-831706b23c85', 'guest27', 96860, 'guest27@example.com', '2025-02-25 18:07:14.633962'),
('8fdd5393-4ac8-4b3f-bf06-c3ea33bfce46', 'user13', 28677, 'user13@example.com', '2024-12-02 18:07:14.633978'),
('31c85171-9eb4-4385-9afd-0458f2b9fd38', 'user17', 80047, 'user17@example.com', '2025-05-25 18:07:14.633995'),
('733233be-b8a3-4697-bf4f-2db70579710e', 'user32', 65771, 'user32@example.com', '2025-05-03 18:07:14.634011'),
('b01f0a0e-16aa-447d-b0ed-221d9bf0e8df', 'admin17', 226, 'admin17@example.com', '2025-03-02 18:07:14.634028'),
('f5fd7e1b-4afe-4329-8b3e-7f3506e3eabf', 'guest4', 5943, 'guest4@example.com', '2025-07-12 18:07:14.634045'),
('2098377e-4d37-404f-b4ab-1f24498a1894', 'user28', 54182, 'user28@example.com', '2024-12-26 18:07:14.634061'),
('5e049bbe-e482-4d85-9f3d-dea8f037036e', 'guest5', 37713, 'guest5@example.com', '2024-11-20 18:07:14.634077'),
('38e07ca5-008e-457e-9601-815fc7de1aa3', 'user43', 41570, 'user43@example.com', '2025-01-25 18:07:14.634094'),
('ad94d220-231c-4247-927f-d2786b84b30a', 'guest42', 68462, 'guest42@example.com', '2025-05-09 18:07:14.634110'),
('246d84d5-a217-4884-a12b-616bfdb84b26', 'user4', 54221, 'user4@example.com', '2025-02-22 18:07:14.634126'),
('09bcc30c-76e2-43b8-8ea8-285af0c5fe5b', 'admin14', 95582, 'admin14@example.com', '2025-01-31 18:07:14.634144'),
('5184a249-f623-4e0e-87c9-8133c20266cd', 'user10', 97617, 'user10@example.com', '2025-04-06 18:07:14.634161'),
('e0c8a641-c622-41f5-968d-062c99b5c482', 'admin30', 89483, 'admin30@example.com', '2025-02-04 18:07:14.634177'),
('a2fc83a7-5a72-43cc-98a7-dfc8dfa4f953', 'user33', 59710, 'user33@example.com', '2025-06-07 18:07:14.634199'),
('5965761c-b061-4744-8ce3-29647abdf943', 'user20', 38247, 'user20@example.com', '2024-12-12 18:07:14.634215'),
('52580efa-124e-4d54-b476-481b6d9d0f2e', 'user21', 98699, 'user21@example.com', '2025-06-07 18:07:14.634231'),
('84fa9c7b-8461-4881-8d31-6971b5dba2d9', 'admin37', 20077, 'admin37@example.com', '2025-03-17 18:07:14.634247'),
('8423d71c-0771-4e7e-a49a-7cf6d6e9d412', 'user50', 22383, 'user50@example.com', '2025-10-06 18:07:14.634264'),
('9756e899-d7cb-4268-bd97-3c1306b19b8f', 'guest46', 1523, 'guest46@example.com', '2025-11-17 18:07:14.634280'),
('910444f6-39c9-4a48-b438-a0019342a88e', 'guest18', 47190, 'guest18@example.com', '2025-06-18 18:07:14.634296'),
('af22fa83-a8f3-494e-8544-d2e321226aab', 'guest41', 41040, 'guest41@example.com', '2025-07-17 18:07:14.634312'),
('4f60b662-e9b7-49a3-a949-e6365474d199', 'admin4', 84706, 'admin4@example.com', '2025-08-16 18:07:14.634329'),
('b5da00c6-3ff4-4c47-9eca-090271f8941b', 'admin28', 62459, 'admin28@example.com', '2025-10-15 18:07:14.634345'),
('c9356e70-dfbc-4caa-a519-97373226a291', 'user6', 56932, 'user6@example.com', '2025-09-18 18:07:14.634362'),
('42f69a7f-18e6-4b40-b32d-e547806d17db', 'guest44', 43554, 'guest44@example.com', '2025-10-31 18:07:14.634378'),
('0fd5a297-3d6f-4d11-b529-1e4e2f70ed15', 'guest28', 72540, 'guest28@example.com', '2025-05-07 18:07:14.634394'),
('88d8ea3e-75ea-45cb-8e26-df6e3e21f8b2', 'user25', 99003, 'user25@example.com', '2025-04-15 18:07:14.634410'),
('03c876f8-134a-4b4e-8d8f-4fa5377abd60', 'admin7', 26926, 'admin7@example.com', '2025-06-02 18:07:14.634428'),
('cf0cc2ef-9c54-48dc-98cb-1c56e4ebcf77', 'guest20', 49399, 'guest20@example.com', '2025-03-04 18:07:14.634448'),
('37edf627-bc23-4aa3-afc0-88620db93674', 'user35', 44371, 'user35@example.com', '2025-06-22 18:07:14.634472'),
('aaa41b9d-0e00-4257-85d3-35f344771fe9', 'user3', 46389, 'user3@example.com', '2025-09-07 18:07:14.634491'),
('dd4093aa-210f-4a1d-9f02-ba5f5ee8b414', 'guest45', 40168, 'guest45@example.com', '2025-04-14 18:07:14.634511'),
('521b1123-cf7f-4219-b064-42c7813291b5', 'guest49', 18281, 'guest49@example.com', '2025-04-17 18:07:14.634530'),
('fd4a6b2f-1488-4d10-98b2-ee6fe45faf42', 'admin38', 10592, 'admin38@example.com', '2025-08-06 18:07:14.634549'),
('ddaeff4c-067d-4faa-8d59-018a167f5b26', 'guest29', 98116, 'guest29@example.com', '2025-08-08 18:07:14.634567');

INSERT INTO products (id, name, price, category, created_at) VALUES
('a428d7e5-0453-42aa-b5d9-989b93e1fdd4', 'Product1', 486.54, 'Clothing', '2025-06-09 18:07:14.634722'),
('bab643ab-4cab-46ce-b98c-03c3
-- init.sql
-- PostgreSQL schema + sample data for tree data-structure demonstrations
-- All tables use gen_random_uuid() from pgcrypto
-- Run with: psql -f init.sql your_database

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- 1. USERS (Trie autocomplete + BST/AVL leaderboard)
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username TEXT NOT NULL UNIQUE,
    score INTEGER NOT NULL,
    email TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_score ON users(score DESC);  -- for BST leaderboard

-- 120 users with many shared prefixes to make Trie testing meaningful
INSERT INTO users (username, score, email) VALUES
('alex', 98450, 'alex@example.com'),
('alexander', 87210, 'alexander@example.com'),
('alexa', 76540, 'alexa@example.com'),
('alexis', 89120, 'alexis@example.com'),
('alicia', 62330, 'alicia@example.com'),
('apple', 99999, 'apple@example.com'),
('application', 84560, 'application@example.com'),
('appetite', 71230, 'appetite@example.com'),
('appreciate', 67890, 'appreciate@example.com'),
('apricot', 543', 54321, 'apricot543@example.com'),
('banana', 45670, 'banana@example.com'),
('bandana', 39870, 'bandana@example.com'),
('banana_split', 88760, 'banana_split@example.com'),
('banjo', 23450, 'banjo@example.com'),
('charlie', 91230, 'charlie@example.com'),
('christopher', 84560, 'christopher@example.com'),
('chris', 73210, 'chris@example.com'),
('catherine', 66780, 'catherine@example.com'),
('catapult', 88900, 'catapult@example.com'),
('dragon', 97650, 'dragon@example.com'),
('dragonfly', 82340, 'dragonfly@example.com'),
('drake', 71200, 'drake@example.com'),
('emma', 94560, 'emma@example.com'),
('emily', 87890, 'emily@example.com'),
('frank', 56780, 'frank@example.com'),
('grace', 99800, 'grace@example.com'),
('grok', 100000, 'grok@example.com'),
('grokker', 92340, 'grokker@example.com'),
('groovy', 75670, 'groovy@example.com'),
('henry', 83450, 'henry@example.com'),
('isabella', 78900, 'isabella@example.com'),
('jack', 91230, 'jack@example.com'),
('jackson', 84560, 'jackson@example.com'),
('james', 67890, 'james@example.com'),
('kate', 95430, 'kate@example.com'),
('liam', 88760, 'liam@example.com'),
('mia', 82340, 'mia@example.com'),
('noah', 97650, 'noah@example.com'),
('olivia', 73450, 'olivia@example.com'),
('peter', 88900, 'peter@example.com'),
('quinn', 66780, 'quinn@example.com'),
('ryan', 94560, 'ryan@example.com'),
('sophia', 81230, 'sophia@example.com'),
('thomas', 75670, 'thomas@example.com'),
('uma', 92340, 'uma@example.com'),
('victor', 83450, 'victor@example.com'),
('william', 67890, 'william@example.com'),
('xander', 98900, 'xander@example.com'),
('zoe', 87650, 'zoe@example.com');

-- Additional 80 users with numbered suffixes for volume + more prefix overlap
INSERT INTO users (username, score, email)
SELECT 
    'user' || i || chosen_prefix,
    floor(random() * 100000)::integer,
    'user' || i || chosen_prefix || '@example.com'
FROM generate_series(1, 80) i,
     (VALUES ('app'), ('ban'), ('cat'), ('drag'), ('gro')) AS p(chosen_prefix);

-- 2. PRODUCTS (B-Tree pagination + range scans)
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    price NUMERIC(12,2) NOT NULL,
    category TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_products_category_price ON products(category, price);  -- ideal for category-filtered range scans

INSERT INTO products (name, price, category) VALUES
('Wireless Mouse Pro', 79.99, 'Electronics'),
('Mechanical Keyboard RGB', 149.99, 'Electronics'),
('4K Monitor 32"', 499.99, 'Electronics'),
('Laptop Stand Aluminum', 39.99, 'Electronics'),
('USB-C Hub 7-in-1', 59.99, 'Electronics'),
('Cotton T-Shirt Basic', 19.99, 'Clothing'),
('Hoodie Oversize', 59.99, 'Clothing'),
('Jeans Slim Fit', 89.99, 'Clothing'),
('Running Shoes', 129.99, 'Sports'),
('Yoga Mat Premium', 44.99, 'Sports'),
('Dumbbell Set 20kg', 199.99, 'Sports'),
('The Great Gatsby', 12.99, 'Books'),
('1984', 14.99, 'Books'),
('Sapiens', 24.99, 'Books'),
('Coffee Maker 12-Cup', 89.99, 'Home'),
('Air Fryer 5.8QT', 119.99, 'Home'),
('Smart Plug WiFi', 24.99, 'Home');

-- 200+ more with generate_series for variety
INSERT INTO products (name, price, category)
SELECT 
    'Product ' || i || ' - ' || cat || ' #' || floor(random()*1000),
    round((random() * 4999.99 + 0.99)::numeric, 2),
    cat
FROM generate_series(1, 250) i,
     (VALUES ('Electronics'), ('Clothing'), ('Books'), ('Home'), ('Sports'), ('Toys'), ('Beauty')) AS c(cat);

-- 3. TASKS (Min-Heap priority queue)
CREATE TABLE tasks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    task_name TEXT NOT NULL,
    priority INTEGER NOT NULL CHECK (priority BETWEEN 1 AND 100),
    status TEXT NOT NULL DEFAULT 'pending',
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO tasks (task_name, priority, status)
SELECT 
    'Task ' || i || ' - ' || desc,
    floor(random()*100 + 1)::integer,
    CASE WHEN random() > 0.7 THEN 'completed' ELSE 'pending' END
FROM generate_series(1, 80) i,
     (VALUES ('Critical bugfix'), ('Feature request'), ('Refactor'), ('Documentation'), ('Testing')) AS d(desc);

-- 4. DATACENTERS (K-D Tree nearest neighbor)
CREATE TABLE datacenters (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    latitude DOUBLE PRECISION NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,
    region TEXT NOT NULL
);

-- Realistic global coordinates (approximate city centers of major cloud regions)
INSERT INTO datacenters (name, latitude, longitude, region) VALUES
('AWS US East (N. Virginia)', 39.0438, -77.4874, 'North America'),
('AWS US East (Ohio)', 40.0000, -83.0000, 'North America'),
('AWS US West (Oregon)', 45.8399, -119.7009, 'North America'),
('AWS West (N. California)', 37.7749, -122.4194, 'North America'),
('AWS Canada Central', 43.6510, -79.3470, 'North America'),
('AWS São Paulo', -23.5505, -46.6333, 'South America'),
('AWS London', 51.5074, -0.1278, 'Europe'),
('AWS Paris', 48.8566, 2.3522, 'Europe'),
('AWS Frankfurt', 50.1109, 8.6821, 'Europe'),
('AWS Stockholm', 59.3293, 18.0686, 'Europe'),
('AWS Ireland', 53.3498, -6.2603, 'Europe'),
('AWS Tokyo', 35.6762, 139.6503, 'Asia Pacific'),
('AWS Seoul', 37.5665, 126.9780, 'Asia Pacific'),
('AWS Singapore', 1.3521, 103.8198, 'Asia Pacific'),
('AWS Sydney', -33.8688, 151.2093, 'Asia Pacific'),
('AWS Mumbai', 19.0760, 72.8777, 'Asia Pacific'),
('AWS Osaka', 34.6937, 135.5023, 'Asia Pacific'),
('Google Council Bluffs', 41.2619, -95.8608, 'North America'),
('Google The Dalles', 45.5946, -121.1787, 'North America'),
('Google Berlin', 52.5200, 13.4050, 'Europe'),
('Google Zurich', 47.3769, 8.5417, 'Europe'),
('Google São Paulo', -23.5505, -46.6333, 'South America'),
('Google Sydney', -33.8688, 151.2093, 'Asia Pacific'),
('Google Tokyo', 35.6762, 139.6503, 'Asia Pacific'),
('Google Singapore', 1.3521, 103.8198, 'Asia Pacific'),
('Azure East US (Virginia)', 37.4316, -78.6569, 'North America'),
('Azure West US 2 (Washington)', 47.6062, -122.3321, 'North America'),
('Azure North Europe (Ireland)', 53.3498, -6.2603, 'Europe'),
('Azure West Europe (Netherlands)', 52.3702, 4.8952, 'Europe'),
('Azure Japan East', 35.6762, 139.6503, 'Asia Pacific'),
('Azure Australia East', -33.8688, 151.2093, 'Asia Pacific'),
('Oracle Frankfurt', 50.1109, 8.6821, 'Europe'),
('Oracle London', 51.5074, -0.1278, 'Europe'),
('IBM Dallas', 32.7767, -96.7970, 'North America'),
('DigitalOcean Bangalore', 12.9716, 77.5946, 'Asia Pacific'),
('OVH Gravelines', 50.9871, 2.1281, 'Europe'),
('Hetzner Helsinki', 60.1699, 24.9384, 'Europe'),
('Equinix Tokyo', 35.6762, 139.6503, 'Asia Pacific'),
('Alibaba Hangzhou', 30.2741, 120.1551, 'Asia Pacific');

-- Optional GiST index if PostGIS is installed (uncomment if you want true nearest-neighbor in SQL)
-- CREATE EXTENSION IF NOT EXISTS postgis;
-- ALTER TABLE datacenters ADD COLUMN geom geography(POINT,4326);
-- UPDATE datacenters SET geom = ST_PointFromText('POINT(' || longitude || ' ' || latitude || ')', 4326);
-- CREATE INDEX idx_datacenters_geom ON datacenters USING GIST (geom);

-- 5. MAP_OBJECTS (Quadtree spatial partitioning)
CREATE TABLE map_objects (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    object_type TEXT NOT NULL,
    x DOUBLE PRECISION NOT NULL,
    y DOUBLE PRECISION NOT NULL,
    metadata JSONB
);

-- 350 objects in a 0-1000 x 0-1000 grid
INSERT INTO map_objects (object_type, x, y, metadata)
SELECT 
    types[t].t,
    random() * 1000,
    random() * 1000,
    jsonb_build_object('size', floor(random()*10 + 1), 'color', colors[c])
FROM generate_series(1, 350) i,
     (VALUES ('tree'), ('rock'), ('house'), ('player'), ('enemy'), ('item')) AS types(t),
     (VALUES ('red'), ('green'), ('blue'), ('yellow'), ('purple')) AS colors(c),
     (SELECT floor(random()*6 + 1)::int AS t, floor(random()*5 + 1)::int AS c);

CREATE INDEX idx_map_objects_x ON map_objects(x);
CREATE INDEX idx_map_objects_y ON map_objects(y);
-- If PostGIS available:
-- ALTER TABLE map_objects ADD COLUMN geom geometry(POINT);
-- UPDATE map_objects SET geom = ST_MakePoint(x, y);
-- CREATE INDEX idx_map_objects_geom ON map_objects USING GIST (geom);

-- 6. API_USAGE (Segment Tree range sum queries)
CREATE TABLE api_usage (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    ts TIMESTAMPTZ NOT NULL,
    calls INTEGER NOT NULL
);

CREATE INDEX idx_api_usage_ts ON api_usage(ts);

-- One record per day for 5 years (~1825 rows) with realistic variation
INSERT INTO api_usage (ts, calls)
SELECT 
    '2020-01-01'::date + (i || ' days')::interval,
    floor(500 + random() * 9500)::integer
FROM generate_series(0, 1824) i;

-- 7. LOGS (Merkle Tree integrity proofs)
CREATE TABLE logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    log_message TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO logs (log_message) VALUES
('User 42 logged in'),
('Failed login attempt from 192.168.1.100'),
('Payment processed for order #12345'),
('Database backup completed successfully'),
('Error: Connection timeout to external API'),
('Cache invalidated for key user:789'),
('New user registration: grokfan@example.com'),
('Rate limit exceeded for IP 203.0.113.50'),
('Security scan passed'),
('Deployment of version 2.4.1 started');

-- 140 more with pattern + random
INSERT INTO logs (log_message)
SELECT 
    CASE (i % 7)
        WHEN 0 THEN 'INFO: User ' || floor(random()*1000) || ' performed action'
        WHEN 1 THEN 'WARN: High memory usage detected'
        WHEN 2 THEN 'ERROR: Failed to connect to DB'
        WHEN 3 THEN 'INFO: Cache hit ratio 98%'
        WHEN 4 THEN 'DEBUG: Processing request ' || i
        WHEN 5 THEN 'INFO: Scheduled job completed'
        ELSE 'SECURITY: Unauthorized access attempt'
    END
FROM generate_series(1, 140) i;

-- 8. TEXT_SNIPPETS (Huffman coding examples)
CREATE TABLE text_snippets (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    content TEXT NOT NULL
);

-- 25 reasonably long samples (lorem + famous public-domain excerpts)
INSERT INTO text_snippets (content) VALUES
('Alice was beginning to get very tired of sitting by her sister on the bank, and of having nothing to do: once or twice she had peeped into the book her sister was reading, but it had no pictures or conversations in it, "and what is the use of a book," thought Alice "without pictures or conversations?"'),
('Call me Ishmael. Some years ago—never mind how long precisely—having little or no money in my purse, and nothing particular to interest me on shore, I thought I would sail about a little and see the watery part of the world.'),
('It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness...'),
('All happy families are alike; each unhappy family is unhappy in its own way.'),
('In a hole in the ground there lived a hobbit. Not a nasty, dirty, wet hole, filled with the ends of worms and an oozy smell, nor yet a dry, bare, sandy hole with nothing in it to sit down on or to eat: it was a hobbit-hole, and that means comfort.'),
('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat... (repeated for length)'),
('To be, or not to be, that is the question: Whether ''tis nobler in the mind to suffer the slings and arrows of outrageous fortune...'),
('It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife.'),
('The sky above the port was the color of television, tuned to a dead channel.'),
('Far out in the uncharted backwaters of the unfashionable end of the western spiral arm of the Galaxy lies a small unregarded yellow sun.'),
('Happy families are all alike; every unhappy family is unhappy in its own way.'),
('Mother died today. Nothing to be done about that.'),
('All animals are equal, but some animals are more equal than others.'),
('Many years later, as he faced the firing squad, Colonel Aureliano Buendía was to remember that distant afternoon when his father took him to discover ice.'),
('The cold passed reluctantly from the earth, and the retiring fogs revealed an army stretched out on the hills, resting.'),
('I am an invisible man. No, I am not a spook like those who haunted Edgar Allan Poe...'),
('You don’t know about me without you have read a book by the name of The Adventures of Tom Sawyer; but that ain’t no matter.'),
('It was a bright cold day in April, and the clocks were striking thirteen.'),
('The story so far: In the beginning the Universe was created. This has made a lot of people very angry and been widely regarded as a bad move.'),
('As Gregor Samsa awoke one morning from uneasy dreams he found himself transformed in his bed into a gigantic insect.'),
('All this happened, more or less. The war parts, anyway, are pretty much true.'),
('He was born with a gift of laughter and a sense that the world was mad.'),
('Stately, plump Buck Mulligan came from the stairhead, bearing a bowl of lather on which a mirror and a razor lay crossed.'),
('If you really want to hear about it, the first thing you’ll probably want to know is where I was born...'),
('It was a pleasure to burn.');

-- End of init.sql