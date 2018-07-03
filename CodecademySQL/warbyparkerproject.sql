--Quiz Funnel--
SELECT question, COUNT (DISTINCT user_id) as 'Responses / Question'
FROM survey
GROUP BY question;

--Results of the Style Quiz--
SELECT question, response, COUNT (*) as 'Count'
FROM survey
GROUP BY response
ORDER BY question ASC;

--Purchases by Model---
SELECT model_name, price, COUNT (*) as 'count'
FROM purchase
GROUP BY model_name
ORDER BY 3 DESC;

--Popular Color--
SELECT color, COUNT (*) as 'count'
FROM purchase
GROUP BY color
ORDER BY 2 DESC;

--Overall conversion Funnel--
WITH browse as (SELECT DISTINCT q.user_id, h.user_id IS NOT NULL as 'is_home_try_on', h.number_of_pairs as 'number_of_pairs', p.user_id IS NOT NULL as 'is_purchase'
FROM quiz AS 'q'
	LEFT JOIN home_try_on AS 'h'
	ON h.user_id = q.user_id
	LEFT JOIN purchase AS 'p'
	ON p.user_id = h.user_id)
  SELECT COUNT (*) as 'num quiz', SUM(is_home_try_on) as 'num_try_on', SUM(is_purchase) as 'is_purchase'
  FROM browse;

--Purchase Funnel by # of at home pairs--
WITH browse as (SELECT DISTINCT q.user_id, h.user_id IS NOT NULL as 'is_home_try_on', h.number_of_pairs as 'number_of_pairs', p.user_id IS NOT NULL as 'is_purchase'
FROM quiz AS 'q'
	LEFT JOIN home_try_on AS 'h'
	ON h.user_id = q.user_id
	LEFT JOIN purchase AS 'p'
	ON p.user_id = h.user_id)
  SELECT SUM(is_home_try_on) as 'num_try_on', SUM(is_purchase) as 'is_purchase', number_of_pairs
  FROM browse
  GROUP BY number_of_pairs;