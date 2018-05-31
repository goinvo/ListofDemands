SELECT
	demands.id AS demand_id,
	demands.user_id as demanded_by_user_id,
	problems.name AS problem,
	demands.solution AS solution,
	demands.topic AS topic,
	(
		SELECT count(id)
		FROM user_demands
		WHERE user_demands.demand_id = demands.id
	) AS demand_count
FROM demands
INNER JOIN problems ON problems.id = demands.problem_id
LEFT JOIN areas ON areas.id = demands.area_id
