create schema if not exists aoc;

drop table if exists aoc.batteries;
create table aoc.batteries (bank) as (values
    ('987654321111111'),
    ('811111111111119'),
    ('234234234234278'),
    ('818181911112111')
);
