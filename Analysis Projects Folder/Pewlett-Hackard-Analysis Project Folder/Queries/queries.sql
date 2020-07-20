SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;
SELECT * FROM dept_emp;

-- Searching for the # of employees that are retirement age
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

--Refining the search: Only birthdates in 1952 - RETURNED 21,000 ish
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Skill DRILL - creating a query for 1952, 1954, and 1955

-- 1953: 22857 Rows
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';
--1954: 23228 Rows
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';
--1955: 23104 Rows
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';


-- GET THE COUNT BECAUSE THESE LISTS ARE TOO FUCKING LONG
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Make a new table in memory for Bobby's retirement stuff

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- Making sure that shit worked
SELECT * FROM retirement_info;

-- Searching for the # of employees that are retirement age
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

--Refining the search: Only birthdates in 1952 - RETURNED 21,000 ish
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Skill DRILL - creating a query for 1952, 1954, and 1955

-- 1953: 22857 Rows
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';
--1954: 23228 Rows
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';
--1955: 23104 Rows
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';


-- GET THE COUNT BECAUSE THESE LISTS ARE TOO FUCKING LONG
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Make a new table in memory for Bobby's retirement stuff

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- Making sure that shit worked
SELECT * FROM retirement_info;

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;


-- Joining departments and dept_manager tables: Now updated with Aliases
SELECT d.dept_name,
     d.emp_no,
     d.from_date,
     d.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- joinig retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

	-- UPDATING THE JOIN FROM RETIREMENT_INFO SO THAT IT'S SHORTET: ALIASES: MAKE THE TABLE	
SELECT ri.emp_no,
	ri.first_name,
ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Go retrieve the new table
SELECT * FROM current_emp;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no =de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- SKILL DRILL: Making a new table out of this code block
SELECT COUNT(ce.emp_no), de.dept_no
INTO ret_count
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no =de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM salaries; 

-- Create an emp_info with the employees, the right dates, and emp_no
SELECT emp_no,
first_name,
last_name,
gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- Now Start making the join to get salaries
SELECT 
e.emp_no,
e.first_name,
e.last_name,
e.gender,
s.salary
INTO f_join
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT
e.emp_no,
e.first_name,
e.last_name,
e.gender,
s.salary
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

--Check to make sure that worked.
Select * FROM emp_info;

-- List of  ACTIVE? Managers by Department
SELECT dm.dept_no,
d.dept_name,
dm.emp_no,
ce.last_name,
ce.first_name,
dm.from_date,
dm.to_date
--INTO manager_info
FROM dept_manager AS dm
INNER JOIN departments as d
ON (dm.dept_no = d.dept_no)
INNER JOIN current_emp AS ce
ON (dm.emp_no = ce.emp_no);


-- Department names on a current emp table to get retirees of managers
SELECT
ce.emp_no,
ce.last_name,
d.dept_name
INTO dept_info
FROM current_emp AS ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

--SKILL DRILL: Retiring employees in SALES
Select * FROM emp_info;
select * from retirement_info;
SELECT* FROM dept_info;
Select ri.emp_no,
ri.first_name,
ri.last_name,
di.dept_name
INTO ret_sales
FROM retirement_info AS ri
LEFT JOIN dept_info as di
ON (ri.emp_no = di.emp_no)
WHERE (di.dept_name = 'Sales');

-- SKILL DRILL 2: Retiring employees in Sales AND Development
Select ri.emp_no,
ri.first_name,
ri.last_name,
di.dept_name
INTO ret_dev_sales
FROM retirement_info AS ri
LEFT JOIN dept_info as di
ON (ri.emp_no = di.emp_no)
WHERE di.dept_name IN('Development','Sales');


--CHALLENGE: Table with ALL employees retriing with their titles
-- First: get All of the retireees with title
SELECT
e.emp_no,
de.to_date
INTO placehold
FROM employees AS e
LEFT JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (de.to_date = '9999-01-01');

-- CHALLENGE 1 Check to make sure it looks good
SELECT * FROM placehold;



-- CHALLENGE 1.) Get the retiring employees paired with titles.
SELECT
ph.emp_no,
ti.title
FROM placehold AS ph
INNER JOIN titles AS ti
ON (ph.emp_no = ti.emp_no);

-- CHALLENGE 1: CSV #1 Table with # of employees retiring by title
SELECT COUNT(DISTINCT ph.emp_no),ti.title
INTO retire_titles_count
FROM placehold AS ph
INNER JOIN titles AS ti
ON (ph.emp_no = ti.emp_no)
GROUP BY ti.title;
--^ The data above likely contains multiple duplicates, perhaps employees had multiple titles.

-- CHALLENGE: Part 1, CSV 2: Number of employees with each title
-- First lets get ALL current employees that have a title
SELECT
e.emp_no,
ti.title
FROM employees AS e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no);

-- NEXT we'll get the count for each title and make a table -- This includes non retiring employees
SELECT COUNT (DISTINCT e.emp_no), ti.title
INTO emps_title
FROM employees AS e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
GROUP BY ti.title;
-- This may also potentially have duplicates since some employees have had multiple titles

--CHALLENGE Deliverable 1: CSV 3: All Employees about to retire Grouped by Job title

-- First, create a new table with retiring employees that has some of the columns we want
SELECT
e.emp_no,
e.first_name,
e.last_name,
de.to_date
INTO retiring_list
FROM employees AS e
LEFT JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (de.to_date = '9999-01-01');

-- Check on the Data for this table
SELECT * FROM retiring_list;

-- Next we can add the titles and salaries by doing two INNER JOINS
SELECT
rl.emp_no,
rl.first_name,
rl.last_name,
ti.title,
ti.from_date,
sal.salary
INTO retirelist_titlesalary
FROM retiring_list AS rl
INNER JOIN titles AS ti
ON (rl.emp_no = ti.emp_no)
INNER JOIN salaries as sal
ON (rl.emp_no = sal.emp_no);
-- NOTE! This table has some duplicates and triplicates. Multiple titles per employee CONFIRMED.

-- CHeck this table
SELECT * FROM retirelist_titlesalary;

-- CHALLENGE PART 1: CSV 3: WE MUST GET RID OF THE DUPLICATES
--- We will do this by using partitioning

-- Partition the data to show only most recent title per employee
SELECT emp_no,
 first_name,
 last_name,
 title,
 from_date,
 salary
INTO retirelist_lasttitle
FROM (SELECT emp_no,
first_name,
last_name,
title,
from_date,
salary, ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY from_date DESC) rn
 FROM retirelist_titlesalary
 ) tmp WHERE rn = 1
ORDER BY emp_no;

-- CHALLENGE DELIVERABLE 2: Determine mentorship eligibility table
SELECT 
e.emp_no,
e.first_name,
e.last_name,
ti.title,
de.from_date,
de.to_date
INTO mentor_eligible_duplicates
FROM employees AS e
INNER JOIN titles AS ti
ON(e.emp_no = ti.emp_no)
INNER JOIN dept_emp AS de
ON(e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')

-- Lets deal with duplicates!
SELECT emp_no,
 first_name,
 last_name,
 title,
 from_date,
 to_date
INTO mentor_eligible
FROM (SELECT emp_no,
first_name,
last_name,
title,
from_date,
to_date, ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY from_date DESC) rn
 FROM mentor_eligible_duplicates
 ) tmp WHERE rn = 1
ORDER BY emp_no;

-- Check to see if it's good.
SELECT * FROM mentor_eligible;

-- It is GOOD!
