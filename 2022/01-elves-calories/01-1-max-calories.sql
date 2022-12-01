create temp table data (
    n numeric
);

copy data from 'path/to/input.csv' csv header delimiter ',';

/**
  max nb of calories carried by a single elf
 */
with a as (
    -- add line numbers
    select
        row_number() over (),
        n
    from data
    order by 1
),
b as (
    -- split consecutive groups
    select
    row_number,
    n,
    count(*) filter (where n is null) over (order by row_number) + 1 as "group"
    from a
),
c as (
    -- three highest-carrying elves and how much they carry
    select
        "group" as elf,
        sum(n) as calories
    from b
    group by 1
    order by 2 desc
    limit 3
)
select
    elf,
    sum(calories) as calories
from c
group by grouping sets ((1), ())
order by elf is null, calories desc
;
