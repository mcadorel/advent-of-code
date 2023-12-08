/**
 * First star: how many steps does it take to
 * reach ZZZ following the instructions?
 */
with recursive path as (

    -- first node : AAA
    select
        node,
        "left",
        "right",
        instructions.dir as next_dir,
        instructions.row_number as instruction_number
    from aoc.network
    join aoc.instructions on instructions.row_number = 1
    where node = 'AAA'

    union all

    select
        network.node,
        network."left",
        network."right",
        instructions.dir as "next_dir",
        instructions.row_number as instruction_number
    from path

    -- lookup instruction plan, fallback to 1 after the last instruction
    left join aoc.instructions on instructions.row_number = path.instruction_number % 263 + 1

    -- join next node according to next instruction
    join aoc.network on network.node = (
        case
            when path.next_dir = 'L' then path.left
            else path.right
        end
    )

    -- exit condition
    where network.node != 'ZZZ'
)
select
    *,
    -- last step will be the solution : number of nodes traversed
    -- (AAA is 1 instead of 0 but ZZZ is not counted so it evens out)
    row_number() over () as step
from path
;
