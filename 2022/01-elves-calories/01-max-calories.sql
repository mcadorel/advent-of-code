create temp table snacks (
    calories numeric
);

copy snacks from 'path/to/input.csv' csv header delimiter ',';

/**
  - how much does the max-carrying elf carry?
  - how much do the three max-carrying elves carry altogether?
 */
with a as (
    -- add line numbers
    select
        row_number() over () as n,
        calories
    from snacks
    order by 1
),
b as (
    -- split consecutive groups
    select
    n,
    calories,
    count(*)
        filter (where calories is null)
        over (order by n)
        + 1
        as "group"
    from a
),
c as (
    -- three highest-carrying elves and
    -- how much they each carry
    select
        "group" as elf,
        sum(calories) as calories
    from b
    group by 1
    order by 2 desc
    limit 3
)
select
    elf,
    sum(calories) as calories
from c
-- individual values and total row
group by grouping sets ((1), ())
order by elf is null, calories desc
;
