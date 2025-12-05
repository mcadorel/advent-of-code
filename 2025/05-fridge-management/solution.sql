-- part one : how many ingredients are fresh?
with fresh_ranges as (
    -- express ranges as int8ranges
    select int8range(
            id_range[1]::bigint,
            id_range[2]::bigint + 1
        ) as id_range
    from aoc.fresh_id_ranges
    cross join regexp_split_to_array(range, '-') as _(id_range)
)
select count(distinct ingredient.id)
from aoc.ingredient
join fresh_ranges on ingredient.id::bigint <@ fresh_ranges.id_range
;


-- part two : how many ids do the ranges cover?

-- helper function to compute the amplitude of a range
create or replace function aoc.range_length(range int8range)
returns bigint
language sql
immutable
as $$
    select greatest(upper(range) - lower(range), 0);
$$;

-- combined amplitude of all "fresh" ranges
with fresh_ranges as (
    -- express ranges as int8ranges
    select int8range(
            id_range[1]::bigint,
            id_range[2]::bigint + 1
        ) as id_range
    from aoc.fresh_id_ranges
    cross join regexp_split_to_array(range, '-') as _(id_range)
),
multirange as (
    -- form a multirange to leave the overlap-wrangling to Postgres 😴
    select range_agg(id_range) as multirange
    from fresh_ranges
)
select sum(aoc.range_length(range))
from multirange
cross join unnest(multirange) as _(range)
;
