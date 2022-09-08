# Databases MySQL architecture

[Russian version](README_ru.md)

![Database model](database-model-21.png)

[Interactive model](https://drawsql.app/community-services/diagrams/community-of-building-owners/)

[Init script](init.sql)

This is a database of apartment owners in a building. It contains data about owners, apartments, building. 
Also, it has additional data about activities about some common issues of building owners.
Another part of database is about voting on common issues. 
This is a legal procedure in Russia to make some decisions and perform some changes for example building management company replacement.

Database can solve the next business goals:
1. Hold owners data.
2. Find owner or resident of apartment.
3. Find owners of the floor.
4. Manage voting process with activists.
5. Solve common problems in discussions and common activities.

## Commands to manipulate and connect

To start database

`docker-compose up homeownersdb`

To connect

`docker exec -it homeownersdb mysql -u root -p12345 homeowners`

To connect outside of container

`mysql -u root -p12345 --port=3309 --protocol=tcp homeowners`