SELECT *
FROM [Work reward].dbo.Absenteeism_at_work

SELECT *
FROM [Work reward].dbo.compensation

SELECT *
FROM [Work reward].dbo.Reasons



SELECT *
FROM [Work reward].dbo.Absenteeism_at_work AS a
LEFT JOIN [Work reward].dbo.compensation AS b
ON a.ID = b.ID
LEFT JOIN [Work reward].dbo.Reasons AS c
ON CONVERT(NVARCHAR, a.[Reason for absence]) = c.[Number]


---These are the healthiest employees for the bonus
SELECT *
FROM [Work reward].dbo.Absenteeism_at_work
WHERE [Social drinker] = 0 
  AND [Social smoker] = 0
  AND [Body mass index] < 25
  AND [Absenteeism time in hours] < (
    SELECT AVG([Absenteeism time in hours]) 
    FROM [Work reward].dbo.Absenteeism_at_work
  );



--Compensation rate increase for non-smokers/budget $983,221/0.68 increase per hour/1 414.4 per year
SELECT COUNT(*) AS "Non smokers"
FROM [Work reward].dbo.Absenteeism_at_work
WHERE [Social smoker] = 0



----Query for PowerBI Analysis
SELECT a.ID, c.Reason,
[Body mass index],
CASE WHEN [Body mass index] < 18 THEN 'Underweight'
	WHEN [Body mass index] BETWEEN 18 AND 25 THEN 'Healthy weight'
	WHEN [Body mass index] BETWEEN 25 AND 30 THEN 'Overwieght'
	WHEN [Body mass index] > 30 THEN 'Obese'
	ELSE 'Unkown' END AS "Body mass index Category",
[Month of absence], 
CASE WHEN [Month of absence] IN (1,2,12) THEN 'Winter'
	WHEN [Month of absence] IN (3,4,5) THEN 'Spring'
	WHEN [Month of absence] IN (6,7,8) THEN 'Summer'
	WHEN [Month of absence] IN (9,10,11) THEN 'Fall'
	ELSE 'Unkown' END AS "Season_Names",
Seasons, [Day of the week], [Transportation expense], Education, Son, 
[Social drinker], [Social smoker], Pet, [Disciplinary failure], 
Age,
CASE WHEN Age < 18 THEN 'Under age'
	WHEN Age >= 18 AND Age < 60 THEN 'Adult'
	WHEN Age >= 60 THEN 'Senior'
	ELSE 'Unkown' END AS "Age group",
[Work load Average/day ],
[Absenteeism time in hours]
FROM [Work reward].dbo.Absenteeism_at_work AS a
LEFT JOIN [Work reward].dbo.compensation AS b
ON a.ID = b.ID
LEFT JOIN [Work reward].dbo.Reasons AS c
ON CONVERT(NVARCHAR, a.[Reason for absence]) = c.[Number]





