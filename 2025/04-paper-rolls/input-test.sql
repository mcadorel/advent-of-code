create schema if not exists aoc;

drop table if exists aoc.grid;
create table aoc.grid(row) as (values
    ('..@@.@@@@.'),
    ('@@@.@.@.@@'),
    ('@@@@@.@.@@'),
    ('@.@@@@..@.'),
    ('@@.@@@@.@@'),
    ('.@@@@@@@.@'),
    ('.@.@.@.@@@'),
    ('@.@@@.@@@@'),
    ('.@@@@@@@@.'),
    ('@.@.@@@.@.')
);
