# Типы данных MySQL

[Английская версия](.)

![Модель базы данных](database-model-22.png)

[Интерактивная модель](https://drawsql.app/community-services/diagrams/community-of-building-owners/)

[Скрипт инициализации](init.sql)

С прошлого домашнего задания изменилось следующее:
1. Тип Поля `value` таблицы `voting_vote` изменён на `enum`
2. Добавлено поле `tags` типа `json` в таблицы `voting` и `issue`.

## Команды для управления и подключения

Запустить БД

`docker-compose up homeownersdb22`

Подключиться

`docker exec -it homeownersdb22 mysql -u root -p12345 homeowners`

Подключиться снаружи от контейнера

`mysql -u root -p12345 --port=3309 --protocol=tcp homeowners`