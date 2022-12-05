drop table if exists rucksacks;
create table rucksacks(contents text);

copy rucksacks from 'path/to/input.csv' csv header delimiter ',';

-- create table item_priorities AS
drop table if exists priorities;
create temp table priorities as
select
    row_number() over () as priority,
    c
from regexp_split_to_table('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', '') c
;

drop view if exists rucksacks_with_priorities;
create view rucksacks_with_priorities as
select
    rucksack_id,
    c,
    row_number() over (partition by r) as item_position,
    case
        when row_number() over (partition by r)
        <= count(*) over (partition by rucksack_id) / 2
        then 1
        else 2
    end as compartment,
    priority
from (
    select
        row_number() over () as rucksack_id,
        r.contents
    from rucksacks r
) r
cross join regexp_split_to_table(r.contents, '') items(c)
join priorities p using (c)
;

-- part 1 : compartment intersection sum
with common_items as (
    select distinct
        r1.rucksack_id,
        r1.c,
        r1.priority
    from rucksacks_with_priorities r1
    join rucksacks_with_priorities r2 on (
        r1.compartment = 1
        and r2.compartment = 2
        and r1.c = r2.c
        and r1.rucksack_id = r2.rucksack_id
    )
)
select sum(priority)
from common_items
;

-- part 2 : common element of rucksack triples
with trios as (
    select
        *,
        (rucksack_id + 2) / 3 as trio
    from rucksacks_with_priorities
),
badges as (
    select trio, c, priority
    from trios
    group by trio, c, priority
    having count(distinct rucksack_id) = 3
)
select sum(priority)
from badges
;