# Установка и запуск БД postgres

[Russian version](README_ru.md)

1.  Установка и запуск postgres-сервера

   `docker-compose up`

   В первый раз конманда устанавливает и запускает

   ![Install start](docker-compose_up_0.png)
   ![Install completed](docker-compose_up_1.png)


2. Стерт postgres-сервера

   `docker-compose up`

   Следующие разы эта команда только стартует сервер

   ![Started](docker-compose_up_2.png)


3. Запуск клиента psql из командной строки из докера

   `docker exec -it postgresdb psql -U postgresuser postgresdb`

   ![psql](psql_0.png)


4. Подключение к postgres с помощью средств Intellij Idea

   ![psql](idea_0.png)
   ![psql](idea_1.png)
   ![psql](idea_2.png)
