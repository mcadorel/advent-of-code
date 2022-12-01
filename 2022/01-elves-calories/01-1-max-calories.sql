create table data (
    n numeric
);

copy data from 'path/to/input.csv' csv header delimiter ',';

with a as (
    -- numéroter les lignes
    select
        row_number() over (),
        n
    from data
    order by 1
),
b as (
    -- identifier les groupes contigus
    select
    row_number,
    n,
    count(*) filter (where n is null) over (order by row_number) + 1 as "group"
    from a
)
select
    "group" as elf,
    sum(n) as calories
from b
group by 1
order by 2 desc
limit 1
;

