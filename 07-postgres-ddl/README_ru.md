# Создание структуры базы данных

[English version](.)

![Модель базы данных](../02-indexes-constraints/database-model-02.png)

[Интерактивная модель](https://drawsql.app/community-services/diagrams/community-of-building-owners/)

## Создание роли и базы данных
```shell
docker exec -it postgresdb psql -U postgresuser postgresdb
```
```postgresql
create role homeowners LOGIN password 'homeowners';

create database homeowners owner homeowners;
```

## Создание схем и таблиц
```shell
docker exec -it postgresdb psql -U homeowners
```
```postgresql
-- Создание главной схемы и таблицы

create schema homeowners;

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
    building_id int references homeowners.building(id) not null,
    apartment_type_id int references homeowners.apartment_type(id) not null,
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
    apartment_id int references homeowners.apartment(id) not null,
    user_id int references homeowners.apartment_user(id) not null,
    ownership_type_id int references homeowners.ownership_type(id) not null,
    share real,
    decision_maker boolean not null default true
);


-- Создание схемы issue (вопрос) и таблиц

create schema issue;

create table issue.issue (
    id serial primary key,
    building_id int references homeowners.building(id) not null ,
    author_id int references homeowners.apartment_user(id) not null,
    name varchar(100) not null,
    content text not null
);

create table issue.issue_comment (
    id serial primary key,
    issue_id int references issue.issue(id) not null,
    author_id int references homeowners.apartment_user(id) not null,
    content text not null
);

create table issue.issue_activity (
    id serial primary key,
    issue_id int references issue.issue(id) not null,
    author_id int references homeowners.apartment_user(id) not null,
    name varchar(100),
    content text
);


-- Создание схемы voting (голосование) и таблиц

create schema voting;

create table voting.voting (
    id serial primary key,
    building_id int references homeowners.building(id) not null ,
    author_id int references homeowners.apartment_user(id) not null,
    start_date date,
    end_date date,
    voted_percent numeric(2),
    description text
);

create table voting.voting_topic (
    id serial primary key,
    voting_id int references voting.voting(id) not null,
    title varchar(255) not null,
    content text,
    for_percent numeric(2),
    against_percent numeric(2),
    forgo_percent numeric(2)
);

CREATE TYPE voting.vote_type AS ENUM ('for', 'against', 'forgo');

create table voting.voting_vote (
    id serial primary key,
    voting_id int references voting.voting(id) not null,
    topic_id int references voting.voting_topic(id) not null,
    voter_id int references homeowners.apartment_user(id) not null,
    title varchar(255) not null,
    content text,
    for_percent numeric(2),
    against_percent numeric(2),
    forgo_percent numeric(2),
    value voting.vote_type
);
```
