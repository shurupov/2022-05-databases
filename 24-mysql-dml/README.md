# MySQL DML: insert, update, delete, select

[Russian version](README_ru.md)

![Database model](database-model-24.png)

[Interactive model](https://drawsql.app/community-services/diagrams/community-of-building-owners/)

## 1. Selecting with `left join`, `inner join`
```mysql
select au.id, au.full_name, ot.name, o.share, at.name, a.number, a.floor, a.square
from homeowners.apartment_user au
inner join homeowners.ownership o on au.id = o.user_id
left join homeowners.ownership_type ot on o.ownership_type_id = ot.id
left join homeowners.apartment a on o.apartment_id = a.id
left join homeowners.apartment_type at on a.apartment_type_id = at.id;
```
The query lists all users with apartments they have and some additional information (ownership type, share, apartment type, number, floor, square).

## 2. Selecting with `where`
```mysql
select vt.id, vt.title, vt.content
from homeowners.voting_topic vt
where vt.voting_id=1;
```
The query lists all topic in selected voting.

```mysql
select au.id, au.full_name, ot.name, a.floor, a.number
from homeowners.apartment_user au
     join homeowners.ownership o on au.id = o.user_id
     join ownership_type ot on ot.id = o.ownership_type_id
     join homeowners.apartment a on o.apartment_id = a.id
where au.id = 1;
```
The query lists all apartments' data (number and floor), ownership types, that belongs to user.

```mysql
select vt.id, vt.content, vv.value
from homeowners.voting_topic vt
     join voting_vote vv on vt.voting_id = vv.voting_id
where vt.id=3;
```
The query lists all votes about one topic.

```mysql
select count(*)
from homeowners.voting_topic vt
     join voting_vote vv on vt.voting_id = vv.voting_id
where vt.id=3
    and vv.value = 'for';
```
The query requests count of votes for the third topic.

```mysql
select count(a.id)
from apartment a
where a.apartment_type_id = 1;
```
The query gets count of apartments of a particular type.

