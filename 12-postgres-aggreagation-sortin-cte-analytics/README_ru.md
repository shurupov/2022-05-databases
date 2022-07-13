# Postgres DML: Агрегация, сортировка, CTE, аналитические функциц

[Английская версия](.)


## 1. Создание таблицы
```postgresql
create table statistic (
    player_name varchar(100) not null,
    player_id int not null,
    year_game smallint not null check (year_game > 0),
    points decimal(12,2) check (points >= 0),
    primary key (player_name,year_game)
);
```

## 2. Добавление данных
```postgresql
INSERT INTO statistic(player_name, player_id, year_game, points) 
    VALUES ('Mike',1,2018,18), 
           ('Jack',2,2018,14), 
           ('Jackie',3,2018,30), 
           ('Jet',4,2018,30), 
           ('Luke',1,2019,16), 
           ('Mike',2,2019,14), 
           ('Jack',3,2019,15), 
           ('Jackie',4,2019,28), 
           ('Jet',5,2019,25), 
           ('Luke',1,2020,19), 
           ('Mike',2,2020,17), 
           ('Jack',3,2020,18), 
           ('Jackie',4,2020,29), 
           ('Jet',5,2020,27);
```

## 3. Запрос суммы очков сгруппированных и отсортированных по году
```postgresql
select sum(points), year_game from statistic
group by year_game
order by year_game;
```

## 4. Запрос суммы очков сгруппированных и отсортированных по году, используя CTE
```postgresql
with points_sum as (
    select sum(points), year_game from statistic
    group by year_game
)
select * from points_sum
order by year_game;
```

## 5. Вывод кол-ва очков по всем игрокам за текущий код и за предыдущий, используя функцию LAG
```postgresql
with comparison_two_year_points as (
    select
        player_name,
        points as curr_year_points,
        lag(points) over (partition by player_name order by year_game) as prev_year_points,
        year_game
    from statistic
)
select * from comparison_two_year_points
where year_game = 2020;
```