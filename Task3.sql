/* Задание: В) какой товар обеспечивает дает наибольший вклад
 в выручку за последний год*/
WITH item_sum AS (
  SELECT itemId,
    SUM(price)
  FROM Items I
    JOIN (
      SELECT itemId,
        date
      FROM Purchases
      WHERE EXTRACT(
          'Year'
          FROM date
        ) = EXTRACT(
          'Year'
          FROM CURRENT_DATE
        )
    ) USING(itemId)
  GROUP BY itemId
)
SELECT itemid,
  sum
FROM item_sum
WHERE sum IN (
    SELECT MAX(sum)
    FROM item_sum
  )