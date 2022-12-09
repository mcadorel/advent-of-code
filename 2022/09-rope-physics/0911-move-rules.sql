create type rope_position as (
    hy int, -- absolute y of head
    hx int, -- absolute x of head
    ty int, -- y of tail relative to head
    tx int  -- x of tail relative to head
);

-- go right
create or replace function r(r rope_position)
returns rope_position
immutable
language sql
as $$
select (
    r.hy,
    r.hx + 1,
    case
        when r.ty != 0 and r.tx = -1  then 0
        else r.ty
    end,
    greatest(-1, r.tx - 1)
)::rope_position
$$;

-- go left
create or replace function l(r rope_position)
    returns rope_position
    immutable
    language sql
as $$
select (
    r.hy,
    r.hx - 1,
    case
        when r.ty != 0 and r.tx = 1  then 0
        else r.ty
    end,
    least(1, r.tx + 1)
)::rope_position
$$;

-- go down
create or replace function d(r rope_position)
    returns rope_position
    immutable
    language sql
as $$
select (
    r.hy + 1,
    r.hx,
    greatest(-1, r.ty - 1),
    case
        when r.tx != 0 and r.ty = -1  then 0
        else r.tx
    end
)::rope_position
$$;

-- go up
create or replace function u(r rope_position)
    returns rope_position
    immutable
    language sql
as $$
select (
    r.hy - 1,
    r.hx,
    least(1, r.ty + 1),
    case
        when r.tx != 0 and r.ty = 1  then 0
        else r.tx
    end
)::rope_position
$$;

