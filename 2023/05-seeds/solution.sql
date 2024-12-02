select
    aoc.seeds.seed,
    aoc.seeds.seed
        + coalesce(aoc.seed_to_soil."offset", 0)
        as soil,
    aoc.seeds.seed
        + coalesce(aoc.seed_to_soil."offset", 0)
        + coalesce(aoc.soil_to_fertilizer."offset", 0)
        as fertilizer,
    aoc.seeds.seed
        + coalesce(aoc.seed_to_soil."offset", 0)
        + coalesce(aoc.soil_to_fertilizer."offset", 0)
        + coalesce(aoc.fertilizer_to_water."offset", 0)
        as water,
    aoc.seeds.seed
        + coalesce(aoc.seed_to_soil."offset", 0)
        + coalesce(aoc.soil_to_fertilizer."offset", 0)
        + coalesce(aoc.fertilizer_to_water."offset", 0)
        + coalesce(aoc.water_to_light."offset", 0)
        as light,
    aoc.seeds.seed
        + coalesce(aoc.seed_to_soil."offset", 0)
        + coalesce(aoc.soil_to_fertilizer."offset", 0)
        + coalesce(aoc.fertilizer_to_water."offset", 0)
        + coalesce(aoc.water_to_light."offset", 0)
        + coalesce(aoc.light_to_temperature."offset", 0)
        as temperature,
    aoc.seeds.seed
        + coalesce(aoc.seed_to_soil."offset", 0)
        + coalesce(aoc.soil_to_fertilizer."offset", 0)
        + coalesce(aoc.fertilizer_to_water."offset", 0)
        + coalesce(aoc.water_to_light."offset", 0)
        + coalesce(aoc.light_to_temperature."offset", 0)
        + coalesce(aoc.temperature_to_humidity."offset", 0)
        as humidity,
    aoc.seeds.seed
        + coalesce(aoc.seed_to_soil."offset", 0)
        + coalesce(aoc.soil_to_fertilizer."offset", 0)
        + coalesce(aoc.fertilizer_to_water."offset", 0)
        + coalesce(aoc.water_to_light."offset", 0)
        + coalesce(aoc.light_to_temperature."offset", 0)
        + coalesce(aoc.temperature_to_humidity."offset", 0)
        + coalesce(aoc.humidity_to_location."offset", 0)
        as location
from aoc.seeds
left join aoc.seed_to_soil on seeds.seed <@ aoc.seed_to_soil.source_range
left join aoc.soil_to_fertilizer on aoc.soil_to_fertilizer.source_range
        @> seeds.seed
        + coalesce(seed_to_soil."offset", 0)
left join aoc.fertilizer_to_water on aoc.fertilizer_to_water.source_range
        @> seeds.seed
        + coalesce(seed_to_soil."offset", 0)
        + coalesce(soil_to_fertilizer."offset", 0)
left join aoc.water_to_light on aoc.water_to_light.source_range
        @> seeds.seed
        + coalesce(seed_to_soil."offset", 0)
        + coalesce(soil_to_fertilizer."offset", 0)
        + coalesce(fertilizer_to_water."offset", 0)
left join aoc.light_to_temperature on aoc.light_to_temperature.source_range
        @> seeds.seed
        + coalesce(seed_to_soil."offset", 0)
        + coalesce(soil_to_fertilizer."offset", 0)
        + coalesce(fertilizer_to_water."offset", 0)
        + coalesce(water_to_light."offset", 0)
left join aoc.temperature_to_humidity on aoc.temperature_to_humidity.source_range
        @> seeds.seed
        + coalesce(seed_to_soil."offset", 0)
        + coalesce(soil_to_fertilizer."offset", 0)
        + coalesce(fertilizer_to_water."offset", 0)
        + coalesce(water_to_light."offset", 0)
        + coalesce(light_to_temperature."offset", 0)
left join aoc.humidity_to_location on aoc.humidity_to_location.source_range
        @> seeds.seed
        + coalesce(seed_to_soil."offset", 0)
        + coalesce(soil_to_fertilizer."offset", 0)
        + coalesce(fertilizer_to_water."offset", 0)
        + coalesce(water_to_light."offset", 0)
        + coalesce(light_to_temperature."offset", 0)
        + coalesce(humidity_to_location."offset", 0)
;

-- 1018124761

select
    '[0, 9223372036854775807)'::int8range * seed_to_soil.source_range,
    "offset"
from aoc.seed_to_soil
order by 1

;



with soil as (
    select
        seed,
        seed + coalesce("offset", 0) as soil
    from aoc.seeds
    left join aoc.seed_to_soil on seeds.seed <@ aoc.seed_to_soil.source_range
)
select *
from soil
;


with world as (
    select int8range(0, 9223372036854775807) as source_range
)
select *
from world
left join aoc.seed_to_soil on world.

;



with offsets as (
    select
        source_range,
        "offset",
        type
    from (
                   select source_range, "offset", 'soil' as type from aoc.soil_to_fertilizer
        union all (select source_range, "offset", 'fert' from aoc.soil_to_fertilizer)
        union all (select source_range, "offset", 'watr' from aoc.fertilizer_to_water)
        union all (select source_range, "offset", 'ligt' from aoc.water_to_light)
        union all (select source_range, "offset", 'temp' from aoc.light_to_temperature)
        union all (select source_range, "offset", 'humt' from aoc.temperature_to_humidity)
        union all (select source_range, "offset", 'locn' from aoc.humidity_to_location)
    ) _
)
select
    *
--     seed,
--     sum(offsets."offset"),
--     seed + sum(offsets."offset")
from aoc.seeds
left join offsets on seeds.seed <@ source_range
-- group by 1
order by 1, 2
;

