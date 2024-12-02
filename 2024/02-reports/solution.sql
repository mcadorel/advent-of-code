drop view if exists aoc.reports_analysis;
create or replace view aoc.reports_analysis as
with diffs as (
    -- granularity by element in order to track the diffs
    select
        id,
        report,
        -- diff between value and previous
        n::int - lag(n::int) over (partition by id) as diff
    from aoc.reports
    cross join regexp_split_to_table(report, ' ') _(n)
),
diffs_interpretation as (
    -- second level in order to use lag(diff)
    select
        id,
        report,
        diff,
        abs(diff) <= 3 as is_within_range,

        -- @todo rewrite?
        (diff > 0 and lag(diff) over (partition by id) > 0)
        or (diff < 0 and lag(diff) over (partition by id) < 0)
            as is_consistent

    from diffs
    where diff is not null
)
select
    -- regroup by report
    id,
    report,
    array_agg(diff) as diffs, -- for debug
    count(*) filter (where not is_within_range) as count_not_within_range,
    count(*) filter (where not is_consistent) as count_not_consistent,
    count(*) filter (where not is_consistent or not is_within_range) as count_anomalies,
    bool_and(is_safe) as is_safe
from diffs_interpretation
cross join lateral (select is_within_range and is_consistent) as _(is_safe)
group by 1, 2
;

-- query returns number of anomalies by record :
-- * answer to part one is the number of records where count_anomalies = 0
-- * answer to part two is the number of records where count_anomalies in (0, 1)
select
    count_anomalies,
    count(*)
from aoc.reports_analysis
group by count_anomalies
order by 1
;
