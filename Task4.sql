/* Задание: Г) топ-3 товаров по выручке и их доля 
 в общей выручке за любой год*/
WITH purchases_of_item_year AS (
  SELECT itemId,
    SUM(price) as total_item_purchases,
    EXTRACT(
      'Year'
      FROM date
    ) AS year
  FROM Items
    JOIN purchases USING(itemId)
  GROUP BY itemId,
    year
),
all_purchases_year AS (
  SELECT SUM(price) AS all_profit,
    EXTRACT(
      'Year'
      FROM date
    ) AS year
  FROM items
    JOIN purchases USING(itemId)
  GROUP BY year
),
item_profit_year AS (
  SELECT itemId,
    ROUND(total_item_purchases / all_profit, 2) AS item_profit,
    year
  FROM purchases_of_item_year
    JOIN all_purchases_year USING(year)
),
item_rank_year AS (
  SELECT itemId,
    year,
    item_profit,
    rank() OVER (
      PARTITION BY year
      ORDER BY item_profit DESC
    ) AS rank_in_year
  FROM item_profit_year
)
SELECT *
FROM item_rank_year
WHERE rank_in_year < 4
ORDER By YEAR, rank_in_year