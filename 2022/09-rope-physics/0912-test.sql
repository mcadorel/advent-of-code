-- test r
with test_data(initial_position, expected) as (values
    (( 1,  1,   0,   0 )::rope_position, (1, 2, 0, -1)::rope_position),
    (( 1,  1,   1,   0 )::rope_position, (1, 2, 0, 0)::rope_position),
    (( 1,  1,   0,   1 )::rope_position, (1, 2, 0, 0)::rope_position),
    (( 1,  1,  -1,   0 )::rope_position, (1, 2, -1, -1)::rope_position),
    (( 1,  1,   0,  -1)::rope_position , (1, 2, 0, 0)::rope_position),
    (( 1,  1,   1,   1 )::rope_position, (1, 2, 0, 0)::rope_position),
    (( 1,  1,   1,  -1)::rope_position , (1, 2, 0, 0)::rope_position)
)
select initial_position, r(initial_position)
from test_data;

-- test left
with test_data(initial_position, expected) as (values
    (( 1,  1,   0,   0 )::rope_position, (1, 0, 0, 1)::rope_position),
    (( 1,  1,   1,   0 )::rope_position, (1, 0, 1, 1)::rope_position),
    (( 1,  1,   0,   1 )::rope_position, (1, 0, 0, 1)::rope_position),
    (( 1,  1,  -1,   0 )::rope_position, (1, 0, -1, 1)::rope_position),
    (( 1,  1,   0,  -1)::rope_position , (1, 0, 0, 0)::rope_position),
    (( 1,  1,   1,   1 )::rope_position, (1, 0, 0, 1)::rope_position),
    (( 1,  1,   1,  -1)::rope_position , (1, 0, 1, 0)::rope_position)
)
select initial_position, expected, l(initial_position)
from test_data;

-- test down
with test_data(initial_position, expected) as (values
    (( 1,  1,   0,   0 )::rope_position, (2, 1, -1, 0)::rope_position),
    (( 1,  1,   1,   0 )::rope_position, (2, 1, 0, 0)::rope_position),
    (( 1,  1,   0,   1 )::rope_position, (2, 1, -1, 1)::rope_position),
    (( 1,  1,  -1,   0 )::rope_position, (2, 1, -1, 0)::rope_position),
    (( 1,  1,   0,  -1)::rope_position , (2, 1, -1, -1)::rope_position),
    (( 1,  1,   1,   1 )::rope_position, (2, 1, 0, 1)::rope_position),
    (( 1,  1,   1,  -1)::rope_position , (2, 1, 0, -1)::rope_position)
)
select initial_position, expected, d(initial_position)
from test_data;

-- test up
with test_data(initial_position, expected) as (values
    (( 1,  1,   0,   0 )::rope_position, (0, 1, 1, 0)::rope_position),
    (( 1,  1,   1,   0 )::rope_position, (0, 1, 1, 0)::rope_position),
    (( 1,  1,   0,   1 )::rope_position, (0, 1, 1, 1)::rope_position),
    (( 1,  1,  -1,   0 )::rope_position, (0, 1, 0, 0)::rope_position),
    (( 1,  1,   0,  -1)::rope_position , (0, 1, 1, -1)::rope_position),
    (( 1,  1,   1,   1 )::rope_position, (0, 1, 1, 0)::rope_position),
    (( 1,  1,   1,  -1)::rope_position , (0, 1, 1, 0)::rope_position)
)
select initial_position, expected, u(initial_position)
from test_data;
