# Creating database structure

[Russian version](README_ru.md)

![Database model](../02-indexes-constraints/database-model-02.png)

[Interactive model](https://drawsql.app/community-services/diagrams/community-of-building-owners/)

## Create role and database
```shell
docker exec -it postgresdb psql -U postgresuser postgresdb
```
```postgresql
create role homeowners LOGIN password 'homeowners';

create database homeowners owner homeowners;
```

## Create schema and tables
```shell
docker exec -it postgresdb psql -U homeowners
```
```postgresql

create schema homeowners;

create table homeowners.building (
    id serial primary key,
    address varchar(100)
);

create table homeowners.apartment_type (
    id serial primary key,
    name varchar(100)
);

create table homeowners.apartment (
    id serial primary key,
    building_id int references building(id),
    apartment_type_id int references apartment_type(id),
    number int,
    floor int,
    square numeric(4)
);

create table homeowners.apartment_user (
    id serial primary key,
    full_name varchar(100),
    short_name varchar(100),
    phone_number varchar(20),
    telegram varchar(100),
    username varchar(50),
    password varchar(50),
    salt varchar(10)
);

create table homeowners.ownership_type (
    id serial primary key,
    name varchar(100)
);

create table homeowners.ownership (
    id serial primary key,
    apartment_id int references apartment(id),
    user_id int references apartment_user(id),
    ownership_type_id int references ownership_type(id),
    share real,
    decision_maker boolean
);
```