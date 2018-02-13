-- mysql -u root -p < schme.sql
-- drop database if exists slowlife;
-- create database slowlife;
use slowlife;
-- grant select, insert, update, delete on slowlife.* to 'slowlife'@'localhost';
-- grant ALL PRIVILEGES on slowlife.* to 'slowlife'@'localhost';
drop table if exists play_music_table;
create table play_music_table (
    `id` int auto_increment,
    `song_name` varchar(50) not null,
    `songer_name` varchar(50) not null,
    `song_image_path` varchar(100) not null,
    `storage_path` varchar(100) not null,
	primary key (`id`)
) engine=innodb default charset=utf8;

insert into play_music_table
(song_name,songer_name,song_image_path,storage_path)
values('BeginAgain.mp3','Tayer','/static/images/music/BeginAgain.jpg','/static/music/BeginAgin.mp3'),
('IAlmostDo.mp3','Tayer','/static/images/music/IAlmostDo.jpg','/static/music/IAlmostDo.mp3'),
('Red.mp3','Tayer','/static/images/music/Red.jpg','/static/music/Red.mp3'),
('Starlight.mp3','Tayer','/static/images/music/Starlight.jpg','/static/music/Starlight.mp3'),
('StayStayStay.mp3','Tayer','/static/images/music/StayStayStay.jpg','/static/music/StayStayStay.mp3');


drop table if exists recommend_music_table;
create table recommend_music_table(
    `id` int auto_increment,
    `song_name` varchar(50) not null,
    `song_type` varchar(50) not null,
    `recommend_name` varchar(50) not null,
    `recommend_reason` varchar(500) not null,
    `create_at` real not null,
	primary key (`id`)
)engine=innodb default charset=utf8;

create table book_table (
    `id` int auto_increment,
    `book_name` varchar(50) not null,
    `author_name` varchar(50) not null,
    `author_contry` varchar(50) not null,
    `book_type` varchar(50) not null,
    `book_image_path` varchar(100) not null,
    `book_download_url` varchar(200) not null,
     primary key (`id`)
) engine=innodb default charset=utf8;

create table share_moive_table(
    `id` int auto_increment,
    `moive_name` varchar(50) not null,
    `share_reason` varchar(500) not null,
    `moive_download_url` varchar(200) not null,
    primary key (`id`)
)engine=innodb default charset=utf8;

create table comment_table (
    `id` int auto_increment,
    `comment_name` varchar(50) not null,
    `comment_email` varchar(50) not null,
    `comment_message` varchar(500) not null,
    `create_at` real not null,
    primary key (`id`)
) engine=innodb default charset=utf8;
