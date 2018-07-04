SELECT
	d.id AS demand_id,
	d.user_id as user_id,
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
	(
		SELECT
			area_definitions.country_id
		FROM area_definitions
		INNER JOIN areas ON areas.id = area_definitions.country_id
		INNER JOIN demands ON areas.id = demands.area_id
		WHERE demands.id = d.id
		LIMIT 1
	) AS country_id,
	problems.name AS problem,
	d.solution AS solution,
	(
	  SELECT areas.short_name
	  FROM areas
		WHERE areas.id = d.area_id
	) as short_name,
	d.topic AS topic,
	(
		SELECT count(id)
		FROM user_demands
		WHERE user_demands.demand_id = d.id
	) AS demand_count,
	d.created_at as created_at
FROM demands d
INNER JOIN problems ON problems.id = d.problem_id
LEFT JOIN areas ON areas.id = d.area_id
