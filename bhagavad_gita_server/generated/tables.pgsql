--
-- Class Users as table users
--

CREATE TABLE "users" (
  "id" serial,
  "phoneNumber" text NOT NULL
);

ALTER TABLE ONLY "users"
  ADD CONSTRAINT users_pkey PRIMARY KEY (id);


