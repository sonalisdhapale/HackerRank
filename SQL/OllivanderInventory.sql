-- Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.

-- Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. If more than one wand has same power, sort the result in order of descending age.

SELECT aa.id, bb.age, aa.coins_needed, aa.power
FROM WANDS AS aa
JOIN WANDS_PROPERTY AS bb ON aa.CODE = bb.CODE
JOIN (SELECT age AS AG, MIN(coins_needed) AS MCN, power AS PW
FROM WANDS AS A
JOIN WANDS_PROPERTY AS B ON A.CODE = B.CODE
WHERE IS_EVIL = 0
GROUP BY power, age) AS Q ON bb.age = AG AND aa.coins_needed = MCN AND aa.power = PW
ORDER BY aa.power DESC, bb.age DESC;



SELECT 
    id,age
    ,coins_needed
    ,power 
FROM (
SELECT 
    w.id
    ,wp.age
    ,w.coins_needed
    ,w.power
    ,rank() OVER(PARTITION BY wp.code, w.power ORDER BY w.coins_needed) rnk
FROM wands w
INNER JOIN wands_property wp 
ON w.code = wp.code
WHERE wp.is_evil = 0
)z WHERE rnk = 1 ORDER BY power DESC,age DESC
;
