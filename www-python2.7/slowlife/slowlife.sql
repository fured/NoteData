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
alter table play_music_table add song_type varchar(100) not null;
insert into play_music_table
(song_name,songer_name,song_image_path,storage_path)
values('今夜你会不会来','黎明','/static/images/head.png','/static/music/今夜你会不会来.mp3'),
('我不愿让你一个人','五月天','/static/images/music/我不愿让你一个人.jpg','/static/music/我不愿让你一个人.mp3'),
('给我一首歌的时间','周杰伦','/static/images/head.png','/static/music/给我一首歌的时间.mp3'),
('不要说话','陈奕迅','/static/images/music/不要说话.jpg','/static/music/不要说话.mp3'),
('勇敢爱','Mi2','/static/images/music/勇敢爱.jpg','/static/music/勇敢爱.mp3'),
('F.L - 你看到那遥远的星空了吗','F.L','/static/images/head.png','/static/music/FL - 你看到那遥远的星空了吗.mp3');

alter table play_music_table add unique(storage_path);
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


insert into book_table
(book_name,author_name,author_contry,book_type,book_image_path,book_download_url)
values('The Dog Of Babel','Carolyn-Parkhurst','America','novel','/static/images/book/thedogofbabel.jpg','https://pan.baidu.com/s/1o9uJxMU'),
('Man Som Hatar Kvinnor','Stieg Larsson','Sweden','novel','/static/images/book/mansonhatarkvinnor.jpg','https://pan.baidu.com/s/1o9uJxMU'),
('Love Letter','岩井俊二','Japan','novel','/static/images/book/loveletter.jpg','https://pan.baidu.com/s/1o9uJxMU'),
('The Kite Runner','Khaled Hosseini','Afghanistan','novel','/static/images/book/thekiterunner.jpg','https://pan.baidu.com/s/1o9uJxMU'),
('围城','钱钟书','china','novel','/static/images/book/weicheng.jpg','https://pan.baidu.com/s/1o9uJxMU');

create table share_moive_table(
    `id` int auto_increment,
    `moive_name` varchar(50) not null,
    `share_reason` varchar(500) not null,
    `moive_download_url` varchar(200) not null,
    primary key (`id`)
)engine=innodb default charset=utf8;

alter table share_moive_table add moive_image_path varchar(100) not null;

insert into share_moive_table
(moive_name,share_reason,moive_image_path,moive_download_url)
values('The Master','在徐之前，虽然我们看了多年的中国功夫片，前有李小龙的完美打斗，后有成龙李连杰式的全新港台武打。','/static/images/moive/themaster.jpg','https://pan.baidu.com/s/1gfTnwnp'),
('Farewell My Concubine','影片围绕两位京剧伶人半个世纪的悲欢离合，展现了对传统文化、人的生存状态及人性的思考与领悟。','/static/images/moive/farewellmyconcubine.jpg','https://pan.baidu.com/s/1gfTnwnp'),
('The Shawshank Redemption','全片透过监狱这一强制剥夺自由、高度强调纪律的特殊背景来展现作为个体的人对“时间流逝、环境改造”的恐惧。','/static/images/moive/theshawshankRedemption.jpg','https://pan.baidu.com/s/1gfTnwnp'),
('Brotherhood of Blades','该片讲述了明末崇祯年间，锦衣卫三兄弟奉命追杀魏忠贤，最后却卷入到一场宫廷阴谋当中的充满悬疑的故事。','/static/images/moive/brotherhoodofblades.jpg','https://pan.baidu.com/s/1gfTnwnp');

create table comment_table (
    `id` int auto_increment,
    `comment_name` varchar(50) not null,
    `comment_email` varchar(50) not null,
    `comment_message` varchar(500) not null,
    `create_at` real not null,
    primary key (`id`)
) engine=innodb default charset=utf8;
