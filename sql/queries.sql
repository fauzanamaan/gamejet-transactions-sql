-- Queries copied as written from the completed document. Each was run on its own in the Global Career Accelerator SQL app, so they are not meant to run as one script.

-- Task 1A
SELECT
  COUNT(*) as num_users
FROM game_jet.users

-- Task 1B
SELECT
  COUNT(DISTINCT(udid)) as num_users
FROM game_jet.sessions

-- Task 1C
SELECT
  udid,
  COUNT(*) as num_sessions
FROM game_jet.sessions
GROUP BY udid
ORDER BY num_sessions DESC

-- Task 1D
SELECT
  udid,
  COUNT(*) as num_sessions
FROM game_jet.sessions
GROUP BY udid
HAVING COUNT(*) >= 32.1
ORDER BY num_sessions DESC

-- Task 2A
SELECT
  COUNT(DISTINCT(udid)) AS num_spending_users
FROM
  game_jet.iaps

-- Task 2B
SELECT
  u.udid,
  SUM(rev)
FROM
  game_jet.users AS u
LEFT JOIN game_jet.iaps AS i
  ON u.udid = i.udid
GROUP BY u.udid

-- Task 2C
SELECT
    u.udid,
    SUM(rev) AS money_spent,
    CASE
    WHEN SUM(rev) IS NULL THEN 'free player'
    WHEN SUM(rev) < 2000 THEN 'minnow'
    WHEN SUM(rev) < 10000 AND SUM(rev) >= 2000  THEN
'dolphin'
    WHEN SUM(rev) >= 10000 THEN 'whale'
    ELSE 'ERROR'
    END AS persona
FROM
    game_jet.users AS u
LEFT JOIN game_jet.iaps AS i
    ON u.udid = i.udid
GROUP BY u.udid

-- Task 3A
WITH full_table AS(
SELECT
    u.udid,
    SUM(rev) AS money_spent,
    CASE
    WHEN SUM(rev) IS NULL THEN 'free player'
    WHEN SUM(rev) < 2000 THEN 'minnow'
    WHEN SUM(rev) < 10000 AND SUM(rev) >= 2000  THEN
'dolphin'
    WHEN SUM(rev) >= 10000 THEN 'whale'
    ELSE 'ERROR'
    END AS persona
FROM
    game_jet.users AS u
LEFT JOIN game_jet.iaps AS i
    ON u.udid = i.udid
GROUP BY u.udid
)

SELECT
  persona,
  COUNT(*) AS num_users
FROM
  full_table
GROUP BY
  persona

-- Task 3B
WITH full_table AS(
SELECT
    u.udid,
    SUM(rev) AS money_spent,
    CASE
    WHEN SUM(rev) IS NULL THEN 'free player'
    WHEN SUM(rev) < 2000 THEN 'minnow'
    WHEN SUM(rev) < 10000 AND SUM(rev) >= 2000  THEN
'dolphin'
    WHEN SUM(rev) >= 10000 THEN 'whale'
    ELSE 'ERROR'
    END AS persona
FROM
    game_jet.users AS u
LEFT JOIN game_jet.iaps AS i
    ON u.udid = i.udid
GROUP BY u.udid
)

SELECT
  persona,
  COUNT(*) AS num_users,
  SUM(money_spent) AS total_revenue
FROM
  full_table
WHERE NOT (persona = 'free player')
GROUP BY
  persona

-- Task 4A
SELECT
  u.udid,
  MIN(i.date - u.install_date) AS days_from_first_purchase
FROM game_jet.users AS u
INNER JOIN game_jet.iaps AS i
  ON u.udid = i.udid
GROUP BY
  u.udid
-- HAVING MIN(i.date - u.install_date) = 0
