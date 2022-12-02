drop table if exists move_outcomes;
create table move_outcomes(first_move, second_move, values, outcome) as (VALUES
    ('A', 'X', 1, 3), -- rock       rock :     draw
    ('A', 'Y', 2, 6), -- paper      rock :     win
    ('A', 'Z', 3, 0), -- scissors   rock :     loss
    ('B', 'X', 1, 0), -- rock       paper :    loss
    ('B', 'Y', 2, 3), -- paper      paper :    draw
    ('B', 'Z', 3, 6), -- scissors   paper :    win
    ('C', 'X', 1, 6), -- rock       scissors : win
    ('C', 'Y', 2, 0), -- paper      scissors : loss
    ('C', 'Z', 3, 3)  -- scissors   scissors : draw
);

drop table if exists moves;
create table moves (
    first_move text,
    second_move text
);

copy moves from 'path/to/input.csv' csv header delimiter ' ';

select sum(values + outcome)
from moves
join move_outcomes mo using (first_move, second_move);

create view moves_with_row_number as
select row_number() over (), *
from moves;

-- total score of played moves
select sum(outcome + values)
from moves
join move_outcomes mo using (first_move, second_move)

-- total score of required outcomes
with q as (
    select
        row_number,
        m.second_move as expected_outcome,
        m.first_move,
        mo.second_move,
        case
            when m.second_move = 'X' then 0
            when m.second_move = 'Y' then 3
            when m.second_move = 'Z' then 6
        end as outcome_score,
        case
            when mo.second_move = 'X' then 1
            when mo.second_move = 'Y' then 2
            when mo.second_move = 'Z' then 3
        end as move_value
    from moves_with_row_number m
    join move_outcomes mo ON m.first_move = mo.first_move
        and mo.outcome = case
            when m.second_move = 'X' then 0
            when m.second_move = 'Y' then 3
            when m.second_move = 'Z' then 6
        end
    order by 1
)
select sum(outcome_score + move_value)
from q
;
