-- Problem 1
DROP SCHEMA IF EXISTS employee;
CREATE SCHEMA employee;
USE employee;
-- Imported data_science_team, proj_table, and emp_record_table

-- Problem 2
SELECT * FROM data_science_team
	ORDER BY dept, continent;
SELECT * FROM emp_record_table
	ORDER BY dept, continent, country;
SELECT * FROM proj_table;
-- (ER Diagram created)

-- Problem 3
SELECT emp_id, first_name, last_name, gender, dept FROM emp_record_table;

-- Problem 4
SELECT emp_id, first_name, last_name, gender, dept, emp_rating FROM emp_record_table
	HAVING emp_rating < 2;
    
SELECT emp_id, first_name, last_name, gender, dept, emp_rating FROM emp_record_table
	HAVING emp_rating > 4;
    
SELECT emp_id, first_name, last_name, gender, dept, emp_rating FROM emp_record_table
	HAVING emp_rating BETWEEN 2 AND 4;
    
-- Problem 5
SELECT CONCAT(first_name, " ", last_name) "Name" FROM emp_record_table
	WHERE dept = "Finance";
    
-- Problem 6
SELECT * FROM emp_record_table;
SELECT b.emp_id, b.first_name, b.last_name, b.role, COUNT(b.emp_ID) "Reporting Employees" FROM emp_record_table a
	JOIN emp_record_table b ON a.manager_id = b.emp_id
    GROUP BY b.emp_id, b.first_name, b.last_name, b.role;
    
-- Problem 7
SELECT emp_id, first_name, last_name, dept FROM emp_record_table
	WHERE dept = "healthcare"
UNION
SELECT emp_id, first_name, last_name, dept FROM emp_record_table
	WHERE dept = "finance";
    
-- Problem 8
SELECT emp_id, first_name, last_name, role, dept, emp_rating, MAX(emp_rating) OVER(PARTITION BY dept) "Highest Employee Rating for Department" 
	FROM emp_record_table;

-- Problem 9
SELECT `role`, MAX(salary) "Highest Salary", MIN(salary) "Lowest Salary" FROM emp_record_table
	GROUP BY `role`;
    
-- Problem 10
SELECT emp_id, first_name, last_name, emp_rating, RANK() OVER(ORDER BY emp_rating DESC) Ranking FROM emp_record_table;

SELECT emp_id, first_name, last_name, emp_rating, DENSE_RANK() OVER(ORDER BY emp_rating DESC) Ranking FROM emp_record_table;

-- Problem 11
DROP VIEW IF EXISTS HighSalary;
CREATE VIEW HighSalary AS
	SELECT emp_ID, CONCAT(first_name, " ", last_name) "Name", Country, Salary FROM emp_record_table
		HAVING salary > 6000 
        ORDER BY SALARY DESC;
SELECT * FROM HighSalary;

-- Problem 12
SELECT CONCAT(first_name, " ", last_name) "Name", exp "Years Experience" FROM emp_record_table
	HAVING exp > 10
    ORDER BY exp DESC;
    
-- Problem 13
CREATE FUNCTION exp_check(role VARCHAR(30), a INT) RETURNS VARCHAR(3)
DETERMINISTIC
	RETURN CASE WHEN role = "junior data scientist" AND a <= 2 THEN "Yes"
    WHEN role = "associate data scientist" AND a BETWEEN 2 AND 5 THEN "Yes"
    WHEN role = "senior data scientist" AND a BETWEEN 5 AND 10 THEN "Yes"
    WHEN role = "lead data scientist" AND a BETWEEN 10 AND 12 THEN "Yes"
    WHEN role = "manager" AND a BETWEEN 12 AND 16 THEN "Yes"
    ELSE "No"
END;
SELECT first_name, last_name, role, exp, exp_check(role, exp) "Meets Standards" FROM emp_record_table;
-- President was not included in exp_check function, so he is coming back as "No"

-- Problem 14
CREATE INDEX eric ON emp_record_table(first_name);
SHOW INDEXES FROM emp_record_table;
SELECT * FROM emp_record_table
	WHERE first_name = 'eric';

-- Problem 15
SELECT first_name, last_name, (.05 * salary * emp_rating) "Bonus" FROM emp_record_table;

-- Problem 16
SELECT Continent, AVG(salary) "Average Salary" FROM emp_record_table
	GROUP BY continent
UNION
SELECT Country, AVG(Salary) "Average Salary" FROM emp_record_table
	GROUP BY country;
