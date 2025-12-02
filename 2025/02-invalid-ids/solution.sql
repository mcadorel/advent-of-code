with ranges as (
    -- process input
    select
        -- create valid postgres range from bounds
        int8range(
            bounds[1]::int8,
            bounds[2]::int8
        ) r
    from aoc.id_ranges
    -- split to ranges
    cross join regexp_split_to_table(s, ',') 🐹(range)
    -- extract bounds from range
    cross join lateral regexp_split_to_array(range, '-') 🐈(bounds)
)
select sum(n) as n
from ranges
cross join generate_series(lower(r), upper(r)) _(n)
-- match invalid ids
where regexp_match(n::text, '^(\d+)\1$') is not null
;

-- part 2 : change the regex to '^(\d+)\1+$'
