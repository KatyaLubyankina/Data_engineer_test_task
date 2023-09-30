/*Задание Б) в каком месяце года выручка от пользователей в возрастном диапазоне
 35+ самая большая*/

WITH month_year_avg AS (
  SELECT sum(price) AS total_sum,
    EXTRACT(
      'MONTH'
      FROM date
    ) AS month,
    EXTRACT(
      'Year'
      FROM date
    ) AS Year
  FROM (
      SELECT *
      FROM Users
      WHERE age >= 35
    ) AS U
    JOIN Purchases P USING(userId)
    JOIN Items I USING(itemId)
  GROUP By month, year
)
SELECT total_sum,
  month,
  year
FROM month_year_avg
WHERE total_sum IN (
    SELECT max(total_sum)
    FROM month_year_avg
    GROUP BY year
  )