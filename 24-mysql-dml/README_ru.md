# MySQL DML: Вставка, обновление, удаление, выборка

[Английская версия](.)

![Модель базы данных](database-model-24.png)

[Интерактивная модель](https://drawsql.app/community-services/diagrams/community-of-building-owners/)

## 1. Selecting with `left join`, `inner join`
```mysql
select au.id, au.full_name, ot.name, o.share, at.name, a.number, a.floor, a.square
from homeowners.apartment_user au
inner join homeowners.ownership o on au.id = o.user_id
left join homeowners.ownership_type ot on o.ownership_type_id = ot.id
left join homeowners.apartment a on o.apartment_id = a.id
left join homeowners.apartment_type at on a.apartment_type_id = at.id;
```
Запрос выводит всех пользователей с помещениями, которыми они владеют, и некоторой дополнительной информацией (тип собственности, доля, тип помещения, номер, этаж, площадь).

## 2. Selecting with `where`
```mysql
select vt.id, vt.title, vt.content
from homeowners.voting_topic vt
where vt.voting_id=1;
```
Запрос выводит список всех тем/вопросов выбранного голосования.

```mysql
select au.id, au.full_name, ot.name, a.floor, a.number
from homeowners.apartment_user au
     join homeowners.ownership o on au.id = o.user_id
     join ownership_type ot on ot.id = o.ownership_type_id
     join homeowners.apartment a on o.apartment_id = a.id
where au.id = 1;
```
Запрос выводит даныне обо всех помещениях (номер и этаж), типом собственности, которые принадлежат пользователю.

```mysql
select vt.id, vt.content, vv.value
from homeowners.voting_topic vt
     join voting_vote vv on vt.voting_id = vv.voting_id
where vt.id=3;
```
Запрос выводит все голоса по вопросу.

```mysql
select count(*)
from homeowners.voting_topic vt
     join voting_vote vv on vt.voting_id = vv.voting_id
where vt.id=3
    and vv.value = 'for';
```
Запрос выводит соличество голосов по третьему вопросу.

```mysql
select count(a.id)
from apartment a
where a.apartment_type_id = 1;
```
Запрос выводит коичество помещений конкретного типа.

