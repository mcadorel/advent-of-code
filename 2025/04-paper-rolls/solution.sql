with rows_numbered as (
    select
        row_number() over () as row_id,
        row
    from aoc.grid
),
cells_numbered as (
    select
        row_number() over (partition by row_id) as cell_id,
        *
    from rows_numbered
    cross join lateral regexp_split_to_table(row, '') _(cell)
),
triads as (
    select
        row_id,
        cell_id,
        cell,
        array [
            lag(cell) over (partition by row_id order by cell_id),
            cell,
            lead(cell) over (partition by row_id order by cell_id)
        ] as triad
    from cells_numbered
    order by 2, 1
),
triads_with_above_below as (
    select
        row_id,
        cell_id,
        cell,
        lag(triad) over (partition by cell_id order by row_id) as triad_above,
        triad as current_triad,
        triad[1] as cell_left,
        triad[array_upper(triad, 1)] as cell_right,
        lead(triad) over (partition by cell_id order by row_id) as triad_below
    from triads
    order by row_id, cell_id
),
-- table triads_with_above_below;
cells_with_number_of_neighboring_rolls as (
    select
        row_id,
        cell_id,
        cell,
        + coalesce(cardinality(array_positions(triad_above, '@')), 0)
        + coalesce(cardinality(array_positions(triad_below, '@')), 0)
        + case when cell_left is not distinct from '@' then 1 else 0 end
        + case when cell_right is not distinct from '@' then 1 else 0 end
        as number_of_neighboring_rolls
    from triads_with_above_below
)
select count(*)
from cells_with_number_of_neighboring_rolls
where cell = '@'
and number_of_neighboring_rolls < 4
;
