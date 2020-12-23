-- представление, выбирающее результаты, которые были забракованы

CREATE OR REPLACE VIEW v_bad_results
AS
SELECT r.id, r.protocol_name, v.user_name, v.manual_comment 
FROM results r
JOIN validations v ON r.id = v.results_id
GROUP BY r.id HAVING v.manual_comment = 'В переделке';

SELECT * FROM v_bad_results;

-- отключил опцию полной группировки
SET @@sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));
SELECT @@sql_mode;

-- представление для сопоставления наименование стандарта с типом анализируемых проб

CREATE OR REPLACE VIEW v_standard_for_samples
AS
SELECT s.id, s.name, st.types_name 
FROM standards s
RIGHT JOIN sample_types st ON st.id  = s.sample_types_id
ORDER  BY s.id;

SELECT * FROM v_standard_for_samples;
