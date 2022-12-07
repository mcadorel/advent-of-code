drop table input;
create table input (
    id int generated by default as identity,
    cmd text
);

\copy input(cmd) from 'path/to/input.csv' csv header delimiter ',';

------------------------------------------------------------------------------
-- helper: path_agregate builds a path from a sequence of `cd` instructions --
------------------------------------------------------------------------------

drop aggregate path_aggregate(TEXT[]);
drop function descend_dir(current TEXT[], target TEXT[]);

/*
 Appends target to current path, or backtrack one level if target is '..'.
 */
create or replace function descend_dir(current text[], target text[])
    returns text[]
    immutable
    language sql
as $$
select case
        when target = '{..}' then current[:cardinality(current) - 1]
        else current || target
    end
$$;

create or replace aggregate path_aggregate (text[]) (
    sfunc = descend_dir,
    stype = text[]
);

------------------------------------------------------------------------------

create temp table input_decorated as
with a as (
    select *,
        count(*)
            filter (where cmd ~ '\$ cd')
            over (order by id)
            as working_dir_number
    from input
),
b as (
    select
        working_dir_number,
        max((regexp_match(cmd, '^\$ cd (.*)'))[1]) as current_working_directory,
        array_agg(
            coalesce(nullif(
                (regexp_match(cmd, '\d*'))[1],
                ''
            )::int, 0))
            filter (where cmd !~ '\$ .*') as filesizes
    from a
    group by 1
    order by 1
)
select
    working_dir_number,
    path_aggregate(array[current_working_directory])
        over (order by working_dir_number)
        as path,
    filesizes
from b
;

-- build tree 🎄 from paths
-- @todo

-- sum filesizes <=100000 of all paths of tree
-- @todo
