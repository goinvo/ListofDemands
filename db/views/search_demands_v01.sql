SELECT
	d.id AS demand_id,
	d.user_id as demanded_by_user_id,
	(
		SELECT
			areas.id
		FROM areas
		INNER JOIN demands ON areas.id = demands.area_id
		WHERE areas.type = 'Municipality' AND demands.id = d.id
	) AS municipality_id,
	(
		SELECT
			areas.id
		FROM areas
		INNER JOIN demands ON areas.id = demands.area_id
		WHERE areas.type = 'County' AND demands.id = d.id
	) AS county_id,
	(
		SELECT
			areas.id
		FROM areas
		INNER JOIN demands ON areas.id = demands.area_id
		WHERE areas.type = 'State' AND demands.id = d.id
	) AS state_id,
	problems.name AS problem,
	d.solution AS solution,
	d.topic AS topic,
	(
		SELECT count(id)
		FROM user_demands
		WHERE user_demands.demand_id = d.id
	) AS demand_count
FROM demands d
INNER JOIN problems ON problems.id = d.problem_id
LEFT JOIN areas ON areas.id = d.area_id
