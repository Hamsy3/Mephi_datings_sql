CREATE TABLE User_auth (
	user_id UUID PRIMARY KEY,
	login VARCHAR(12) UNIQUE NOT NULL,
	password_hash VARCHAR(64)
);
CREATE TABLE User_data (
	user_id UUID REFERENCES User_auth (user_id),
	PRIMARY KEY(user_id),
	telegram_tag VARCHAR(32),
	last_name VARCHAR(32),
	last_name_is_hidden BOOL NOT NULL DEFAULT false,
	first_name VARCHAR(32),
	middle_name VARCHAR(32),
	middle_name_is_hidden BOOL NOT NULL DEFAULT false,
	is_man BOOL,
	grade NUMERIC NOT NULL,
	grade_is_hidden BOOL NOT NULL DEFAULT false,
	"group" VARCHAR(16) NOT NULL,
	group_is_hidden BOOL NOT NULL DEFAULT false,
	course INT NOT NULL,	
	age INT,
	age_is_hidden BOOL NOT NULL DEFAULT false,
	height INT,
	height_is_hidden BOOL NOT NULL DEFAULT false,
	is_smoking BOOL,
	is_smoking_is_hidden BOOL NOT NULL DEFAULT false,
	is_drinking BOOL,
	is_drinking_is_hidden BOOL NOT NULL DEFAULT false,
	zodiac VARCHAR(32),
	zodiac_is_hidden BOOL NOT NULL DEFAULT false,
	fav_music VARCHAR(128),
	fav_music_is_hidden BOOL NOT NULL DEFAULT false,
	fav_sports VARCHAR(128),
	fav_sports_is_hidden BOOL NOT NULL DEFAULT false,
	bio VARCHAR(512)
);
CREATE TABLE User_photo (
	user_id UUID REFERENCES User_data (user_id),
	photo_id SERIAL,
	PRIMARY KEY (photo_id, user_id),
	photo_directory_path VARCHAR(256),
	photo_name VARCHAR(256)
);
CREATE TABLE "Match" (
	user_liking_id UUID REFERENCES User_data (user_id),
	user_liked_id UUID REFERENCES User_data (user_id),
	PRIMARY KEY (user_liking_id, user_liked_id),
	status INT CHECK (status >= 0 and status <= 2),
	message VARCHAR(250),
	"time" timestamp DEFAULT (NOW())
);

CREATE TABLE Fixed_interest (
	fixed_int_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	int_name VARCHAR(32) NOT NULL
);
CREATE TABLE Interest (
	fixed_int_id INT REFERENCES Fixed_interest(fixed_int_id),
	user_id UUID REFERENCES User_data (user_id),
	PRIMARY KEY (fixed_int_id, user_id)
);
CREATE TABLE Fixed_requirement (
	fixed_req_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	req_name VARCHAR(32) NOT NULL
);
CREATE TABLE Requirement (
	fixed_req_id INT REFERENCES Fixed_requirement(fixed_req_id),
	user_id UUID REFERENCES User_data (user_id),
	PRIMARY KEY (fixed_req_id, user_id)
);