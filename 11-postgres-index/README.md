# Postgres indexes

[Russian version](README_ru.md)

[Interactive database model](https://drawsql.app/community-services/diagrams/community-of-building-owners/)

## 1. Index creation
```postgresql
drop index if exists homeowners.ownership_user_id_idx;
create index ownership_user_id_idx on homeowners.ownership(user_id);
```
This index makes select ownerships by user id faster.

## 2. Selecting with using created index
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


## 3. Full text index creation
```postgresql
drop index if exists homeowners.full_name_text_idx;
create index full_name_text_idx on homeowners.apartment_user using gin (to_tsvector('russian', full_name));
```
This index provides search users by parts of full name.

Tried to create with `using gin (full_name)` but this is not working for me. So goggled and fixed request with this.

## 4. Part table index creation
```postgresql
drop index if exists homeowners.ownership_apt_id_idx;
create index ownership_apt_id_idx on homeowners.ownership(apartment_id) where ownership_type_id != 4;
```
This index makes faster ownership select by apartment_id but only for real owners.

## 5. Multiple fields index creation
```postgresql
drop index if exists voting.vote_voting_id_voter_id_idx;
create index vote_voting_id_voter_id_idx on voting.voting_vote(voting_id, voter_id);
```
This index makes faster votes select by vote_id and voter_id.

