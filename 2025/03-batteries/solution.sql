-- prepare input : enumerate joltages per bank
drop table if exists joltages;
create temp table joltages as
with batteries_numbered as (
    select
        row_number() over () as bank_id,
        bank
    from aoc.batteries
)
select
    bank_id,
    row_number() over (partition by bank_id) as battery_id,
    -- bank,
    joltage
from batteries_numbered
cross join regexp_split_to_table(bank, '') _(joltage)
;

with computed_value as (
    select
        bank_id,

        -- highest joltage to the left of current joltage, including current joltage
        max(joltage::int) over (
            by_bank
            rows between unbounded preceding and current row
        )

        -- prioritize the left-hand joltage against the right-hand joltage
        * 10

        -- highest joltage to the right of current joltage, excluding current joltage
        + max(joltage::int) over (
            by_bank
            rows between current row and unbounded following exclude current row
        ) as value

    from joltages
    window by_bank as (
        partition by bank_id
        order by battery_id
    )
    order by bank_id, value desc nulls last
)
select
    bank_id,
    max(value)
from computed_value
group by 1
order by 1
;
