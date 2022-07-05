# DML: Вставка, обновление, удаление, выборка

[Английская версия](.)

![Модель базы данных](database-model-09.png)

[Интерактивная модель](https://drawsql.app/community-services/diagrams/community-of-building-owners/)

## 1. Выборка с помощью регулярных выражений
```postgresql
select count(*) from homeowners.apartment_user where full_name ~ '([Сс]ер([её][жг]а|гей))';
```
Запрос находит количество пользователей с именем `Сергей`.

## 2. Выборка с помощью `left join`, `inner join`
```postgresql
select au.id, au.full_name, ot.name, o.share, at.name, a.number, a.floor, a.square
from homeowners.apartment_user au
inner join homeowners.ownership o on au.id = o.user_id
left join homeowners.ownership_type ot on o.ownership_type_id = ot.id
left join homeowners.apartment a on o.apartment_id = a.id
left join homeowners.apartment_type at on a.apartment_type_id = at.id;
```
Запрос выводит всех пользователей с помещениями, которыми они владеют, и некоторой дополнительной информацией (тип собственности, доля, тип помещения, номер, этаж, площадь).

## 3. Вставка данных с возвращением добавленных записей
```postgresql
insert into homeowners.apartment_user (full_name, short_name, phone_number, telegram, username, password, salt) values 
('Сидоров Сидор Сидорович', 'Сидор', '+79998887766', '@sometelegram', 'sidor', 'fjdksjflksd', 'fdsf')   
returning full_name, short_name, phone_number, telegram, username, password, salt;
```
Запрос добавляет пользователя и возвращает поля добавленной записи.

## 4. Изменение данных используя `update from`
```postgresql
update voting.voting_topic vtt
set
    for_percent = calculated.for * 100 / calculated.voted,
    against_percent = calculated.against * 100 / calculated.voted,
    forgo_percent = calculated.forgo * 100 / calculated.voted
from (
    select
        vt.title,
        vt.id topic_id,
        sum(o.share * a.square) as voted,
        sum(
            case
                when (vv.value = 'for') then o.share * a.square
                else 0
            end
        ) as for,
        sum(
            case
                when (vv.value = 'against') then o.share * a.square
                else 0
            end
        ) as against,
        sum(
            case
                when (vv.value = 'forgo') then o.share * a.square
                else 0
            end
        ) as forgo
    from voting.voting_topic vt
    inner join voting.voting_vote vv on vv.topic_id = vt.id
    inner join homeowners.apartment_user au on vv.voter_id = au.id
    inner join homeowners.ownership o on au.id = o.user_id
    inner join homeowners.apartment a on o.apartment_id = a.id
    where vt.voting_id = 1 and ownership_type_id in (1,2,3)
    group by vt.id
    order by vt.id
) as calculated
where vtt.id = calculated.topic_id;
```
Запрос вычисляет и сохраняет результаты голосования по каждой теме для голосования с id=1.
