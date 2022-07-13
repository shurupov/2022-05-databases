# Индексы в postgres

[Английская версия](.)

[Интерактивная модель](https://drawsql.app/community-services/diagrams/community-of-building-owners/)

## 1. Создание индекса
```postgresql
drop index if exists homeowners.ownership_user_id_idx;
create index ownership_user_id_idx on homeowners.ownership(user_id);
```

## 2. Select с использованием созданного индекса
```postgresql
explain select o.share, a.number from homeowners.ownership o
inner join homeowners.apartment a on o.apartment_id = a.id
where user_id = 1;
```
| QUERY PLAN                                                                                                                                           |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------|
| Hash Join  \(cost=14.47..43.25 rows=8 width=8\)                                                                                                      |
| &nbsp;&nbsp;Hash Cond: \(a.id = o.apartment\_id\)                                                                                                    |
| &nbsp;&nbsp;-&gt;  Seq Scan on apartment a  \(cost=0.00..23.60 rows=1360 width=8\)                                                                   |
| &nbsp;&nbsp;-&gt;  Hash  \(cost=14.37..14.37 rows=8 width=8\)                                                                                        |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&gt;  Bitmap Heap Scan on ownership o  \(cost=4.21..14.37 rows=8 width=8\)                                      |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Recheck Cond: \(user\_id = 1\)                                                           |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&gt;  Bitmap Index Scan on ownership\_user\_id\_idx  \(cost=0.00..4.21 rows=8 width=0\) |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Index Cond: \(user\_id = 1\)                         |


## 3. Создание полнотекстового индекса
```postgresql
drop index if exists homeowners.full_name_text_idx;
create index full_name_text_idx on homeowners.apartment_user using gin (to_tsvector('russian', full_name));
```

## 4. Создание индекса на часть таблицы
```postgresql
drop index if exists homeowners.ownership_apt_id_idx;
create index ownership_apt_id_idx on homeowners.ownership(apartment_id) where ownership_type_id != 4;
```

## 5. Создание индекса на несколько полей
```postgresql
drop index if exists voting.vote_voting_id_voter_id_idx;
create index vote_voting_id_voter_id_idx on voting.voting_vote(voting_id, voter_id);
```

## 5. Добавление комментариев к индексам
```postgresql

```