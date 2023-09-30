/*Задание: А) какую сумму в среднем в месяц тратит:
- пользователи в возрастном диапазоне от 26 до 35 лет включительно */
/*
 Month_year_avg - average_price for each pair(month, year) 
 if any purchase were made in that pair.
 */
WITH month_year_avg AS (
  SELECT ROUND(AVG(price), 2) AS average_price,
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
      WHERE age BETWEEN 26 AND 35
    ) AS U
    JOIN Purchases P USING(userId)
    JOIN Items I USING(itemId)
  GROUP BY month, year
)
/* SELECT average spending of people (26-35 years) for each year.*/
SELECT ROUND(AVG(average_price), 2),
  year
FROM month_year_avg
group BY YEAR