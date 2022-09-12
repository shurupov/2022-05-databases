create database homeowners;
    
use homeowners;

create table homeowners.building (
    id serial primary key,
    address varchar(100) not null
);

create table homeowners.apartment_type (
    id serial primary key,
    name varchar(100) not null
);

create table homeowners.apartment (
    id serial primary key,
    building_id int not null references homeowners.building(id),
    apartment_type_id int not null references homeowners.apartment_type(id),
    number int not null,
    floor int not null,
    square numeric(4) not null
);

create table homeowners.apartment_user (
    id serial primary key,
    full_name varchar(100) not null,
    short_name varchar(100),
    phone_number varchar(20),
    telegram varchar(100),
    username varchar(50),
    password varchar(50),
    salt varchar(10)
);

create table homeowners.ownership_type (
    id serial primary key,
    name varchar(100) not null
);

create table homeowners.ownership (
    id serial primary key,
    apartment_id int not null references homeowners.apartment(id),
    user_id int not null references homeowners.apartment_user(id),
    ownership_type_id int not null references homeowners.ownership_type(id),
    share real,
    decision_maker boolean not null default true
);


create table homeowners.issue (
    id serial primary key,
    building_id int not null references homeowners.building(id),
    author_id int not null references homeowners.apartment_user(id),
    name varchar(100) not null,
    content text not null,
    tags json
);

create table homeowners.issue_comment (
    id serial primary key,
    issue_id int not null references homeowners.issue(id),
    author_id int not null references homeowners.apartment_user(id),
    content text not null
);

create table homeowners.issue_activity (
    id serial primary key,
    issue_id int not null references homeowners.issue(id),
    author_id int not null references homeowners.apartment_user(id),
    name varchar(100),
    content text
);


create table homeowners.voting (
    id serial primary key,
    building_id int not null references homeowners.building(id),
    author_id int not null references homeowners.apartment_user(id),
    start_date date,
    end_date date,
    voted_percent numeric(2),
    description text,
    tags json
);

create table homeowners.voting_topic (
    id serial primary key,
    voting_id int not null references homeowners.voting(id),
    title varchar(255) not null,
    content text,
    for_percent numeric(2),
    against_percent numeric(2),
    forgo_percent numeric(2)
);

create table homeowners.voting_vote (
    id serial primary key,
    voting_id int not null references homeowners.voting(id),
    topic_id int not null references homeowners.voting_topic(id),
    voter_id int not null references homeowners.apartment_user(id),
    value enum ('for', 'against', 'forgo') not null
);




insert into homeowners.building (address) values ('г. Самара, ул. Аэродромная, 59, 61');

insert into homeowners.apartment_type (id, name) values
    (1, 'Квартира'),
    (2, 'Паркинг'),
    (3, 'Коммерческая площадь');

insert into homeowners.ownership_type (id, name) values
    (1, 'Единоличная собственность'),
    (2, 'Совместная собственность'),
    (3, 'Долевая собственность'),
    (4, 'Не собственник');

insert into homeowners.apartment_user (full_name, short_name)
    values
    ('Сергей Петрович Кашин', 'Сергей'),
    ('Серёга', 'Сергей'),
    ('Иван Дементьев', 'Вано'),
    ('Павел Иванов', 'Пашка'),
    ('Серёжа Анатольевич', 'Сергей'),
    ('Петров Пётр Петрович', 'Петров Пётр'),
    ('Иванов Иван Иванович', 'Иванов Иван'),
    ('Иванова Марфа Евгеньевна', 'Иванова Марфа'),
    ('Сергеев Сергей Сергеевич', 'Сергеев Сергей'),
    ('Сергеева Анна Николаевна', 'Сергеева Анна'),
    ('Антонов Антон Антонович', 'Антонов Антон'),
    ('Антонова Юлия Валерьевна', 'Антонова Юлия');

insert into homeowners.apartment (building_id, apartment_type_id, number, floor, square) values
    (1, 1, 1, 1, 50),
    (1, 1, 2, 1, 100),
    (1, 1, 3, 1, 70),
    (1, 1, 4, 1, 80),
    (1, 1, 5, 1, 100),
    (1, 1, 6, 1, 50),
    (1, 1, 7, 2, 50),
    (1, 1, 8, 2, 100),
    (1, 1, 9,  2, 70),
    (1, 1, 10, 2, 80),
    (1, 1, 11, 2, 100),
    (1, 1, 12, 2, 50),
    (1, 1, 13, 3, 50),
    (1, 1, 14, 3, 100),
    (1, 1, 15, 3, 70),
    (1, 1, 16, 3, 80),
    (1, 1, 17, 3, 100),
    (1, 1, 18, 3, 50),
    (1, 1, 19, 4, 50),
    (1, 1, 20, 4, 100),
    (1, 1, 21, 4, 70),
    (1, 1, 22, 4, 80),
    (1, 1, 23, 4, 100),
    (1, 1, 24, 4, 50);

insert into homeowners.ownership (apartment_id, user_id, ownership_type_id, share) values
    (1,  1, 1, 1),
    (3,  1, 1, 1),
    (5,  2, 2, 1),
    (5,  4, 3, 0.7),
    (10, 5, 3, 0.3),
    (11, 6, 4, 0),
    (11, 7, 4, 0);

insert into homeowners.voting (building_id, author_id, start_date, end_date, description, tags) values
    (1, 1, now(), now(), 'Голосование о том, о сём.', '["первый тэг", "второй тэг"]');

insert into homeowners.voting_topic (voting_id, title, content) values
    (1, 'Выбрать председателя собрания.', 'Выбрать председателя собрания Сергей Сергеева из 1-й квартиры'),
    (1, 'Выбрать совет дома.', 'Выбрать в совет дома Сергея из 3-й квартиры и Павла из 5-й'),
    (1, 'Выбрать управляющую компанию', 'Выбрать управляющей компанией ООО "Чистый дом"');

insert into homeowners.voting_vote (voting_id, topic_id, voter_id, value) values
    (1, 1,  1, 'for'),
    (1, 1,  2, 'for'),
    (1, 1,  4, 'forgo'),
    (1, 1,  5, 'for'),
    (1, 2,  1, 'forgo'),
    (1, 2,  2, 'against'),
    (1, 2,  4, 'forgo'),
    (1, 2,  5, 'for'),
    (1, 3,  1, 'forgo'),
    (1, 3,  2, 'for'),
    (1, 3,  4, 'forgo'),
    (1, 3,  5, 'against');

