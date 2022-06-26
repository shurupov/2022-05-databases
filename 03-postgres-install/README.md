# Installing and starting postgres database

[Russian version](README_ru.md)

1. Install and start postgres server
    
    `docker-compose up`

    First time is installs and starts

    ![Install start](docker-compose_up_0.png)
    ![Install completed](docker-compose_up_1.png)


2. Start postgres server

   `docker-compose up`

   Next time it just starts

   ![Started](docker-compose_up_2.png)


3. Start terminal client psql in docker

    `docker exec -it postgresdb psql -U postgresuser postgresdb`

   ![psql](psql_0.png)


4. Connecting to postgres via Intellij Idea db tool

   ![psql](idea_0.png)
   ![psql](idea_1.png)
   ![psql](idea_2.png)
