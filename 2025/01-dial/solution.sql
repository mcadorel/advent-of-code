with rotations as (
    select
        -- number rotations to preserve order
        row_number() over () as row_number,
        -- express rotations as addable ints
        case when left(s, 1) = 'L' then -1 else 1 end
        * regexp_replace(s, '\D*', '')::int
        as r
    from aoc.input
),
steps as (
    select
        row_number,         -- for debug
        r,                  -- for debug
        (
            50              -- initial state
            + 100           -- count always above zero
            + sum(r) over w -- apply successive rotations
        ) % 100             -- rotate between 0 and 99
            as state
    from rotations
    window w as (order by row_number)
)
select count(*)
from steps
where state = 0
;
