SELECT
	d.id AS demand_id,
	d.user_id as created_by_user_id,
	(
		SELECT
			area_definitions.municipality_id
		FROM area_definitions
		INNER JOIN areas ON areas.id = area_definitions.municipality_id
		INNER JOIN demands ON areas.id = demands.area_id
		WHERE demands.id = d.id
		LIMIT 1
	) AS municipality_id,
	(
		SELECT
			area_definitions.state_id
		FROM area_definitions
		INNER JOIN areas ON areas.id = area_definitions.state_id
		INNER JOIN demands ON areas.id = demands.area_id
		WHERE demands.id = d.id
		LIMIT 1
	) AS state_id,
	problems.name AS problem,
	d.solution AS solution,
	d.topic AS topic,
	(
		SELECT parts[1]
		FROM (
			SELECT regexp_split_to_array(areas.name, ',')
			FROM areas
			WHERE areas.id = d.area_id
		) as dt(parts)
	) as short_name,
	(
		SELECT count(id)
		FROM user_demands
		WHERE user_demands.demand_id = d.id
	) AS demand_count,
	d.created_at as created_at
FROM demands d
INNER JOIN problems ON problems.id = d.problem_id
LEFT JOIN areas ON areas.id = d.area_id
