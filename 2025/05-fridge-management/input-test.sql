create schema if not exists aoc;

drop table if exists aoc.fresh_id_ranges;
create table aoc.fresh_id_ranges (range) as (values
    ('3-5'),
    ('10-14'),
    ('16-20'),
    ('12-18')
)
;

create table aoc.ingredient(id) as (values
    ('1'),
    ('5'),
    ('8'),
    ('11'),
    ('17'),
    ('32')
);
