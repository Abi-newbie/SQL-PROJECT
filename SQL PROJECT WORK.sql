CREATE TABLE EMPLOYEES(
	emp_no	VARCHAR(255),
	birth_date DATE,
	first_name	VARCHAR(255),
	last_name	VARCHAR(255),
	gender	VARCHAR(255),
	hire_date DATE
);

SELECT *
FROM EMPLOYEES

CREATE TABLE DEPT_MANAGER(
	dept_no VARCHAR(255),
	emp_no	VARCHAR(255),
	from_date DATE,
	to_date DATE
)

SELECT *
FROM DEPT_MANAGER

CREATE TABLE DEPARTMENT(
	dep_no	VARCHAR(255),
	dep_name VARCHAR(255)
)

SELECT *
FROM DEPARTMENT

ALTER TABLE DEPARTMENT
RENAME COLUMN DEP_NO TO DEPT_NO
CREATE TABLE DEPT_EMP(
	emp_no	VARCHAR(255),
	dept_no	VARCHAR(255),
	from_date	DATE,
	to_date DATE
)

SELECT *
FROM DEPT_EMP

CREATE TABLE SALARIES(
	emp_no	VARCHAR (255),
	salary	INT,
	from_date	DATE,
	to_date DATE
)

SELECT *
FROM SALARIES

CREATE TABLE EMPLOYEE_TITLES(
	emp_no	VARCHAR(255),
	title	VARCHAR(255),
	from_date	DATE,
	to_date DATE
)

SELECT *
FROM EMPLOYEE_TITLES

--Retrieve the first name and last name of all employees
SELECT EMP_NO,FIRST_NAME,LAST_NAME
FROM EMPLOYEES

--Find the department numbers and names.
SELECT *
FROM DEPARTMENT

--Get the total number of employees.
SELECT  COUNT(EMP_NO)
FROM EMPLOYEES

--Find the average salary of all employees.
SELECT EMPLOYEES.LAST_NAME,EMPLOYEES.FIRST_NAME,AVG(SALARIES.SALARY)
FROM EMPLOYEES
JOIN SALARIES
ON EMPLOYEES.EMP_NO = SALARIES.EMP_NO
GROUP BY EMPLOYEES.LAST_NAME,EMPLOYEES.FIRST_NAME

--Retrieve the birth date and hire date of employee with emp_no 10003
SELECT BIRTH_DATE,HIRE_DATE
FROM EMPLOYEES
WHERE EMP_NO = '10003'

--Find the titles of all employees.
SELECT TITLE,EMP_NO
FROM EMPLOYEE_TITLES

-- Get the total number of departments
SELECT COUNT(DEP_NO)
FROM DEPARTMENT

---Retrieve the department number and name where employee with emp_no 10004 works.
SELECT DEPARTMENT.DEPT_NO,DEPARTMENT.DEP_NAME,DEPT_MANAGER.EMP_NO
FROM DEPARTMENT
JOIN DEPT_MANAGER
ON DEPARTMENT.DEPT_NO = DEPT_MANAGER.DEPT_NO
WHERE EMP_NO = '10004'

-- Find the gender of employee with emp_no 10007.
SELECT EMP_NO,GENDER
FROM EMPLOYEES
WHERE EMP_NO = '10007'

-- Get the highest salary among all employees
SELECT EMPLOYEES.LAST_NAME,EMPLOYEES.FIRST_NAME,MAX(SALARIES.SALARY)
FROM EMPLOYEES
JOIN SALARIES
ON EMPLOYEES.EMP_NO = SALARIES.EMP_NO
GROUP BY EMPLOYEES.LAST_NAME,EMPLOYEES.FIRST_NAME 
HAVING MAX(SALARIES.SALARY) =70000

--alter table nashville_housing
drop column taxdistrict

--alter table nashville_housing
drop column taxdistrict

--Retrieve the names of all managers along with their department names
SELECT EMPLOYEES.FIRST_NAME,EMPLOYEES.LAST_NAME,DEPARTMENT.DEP_NAME,DEPT_EMP.DEPT_NO
FROM EMPLOYEES
JOIN DEPT_EMP
ON EMPLOYEES.EMP_NO = DEPT_EMP.EMP_NO
JOIN DEPARTMENT
ON DEPT_EMP.DEPT_NO = DEPARTMENT.DEPT_NO
GROUP BY EMPLOYEES.FIRST_NAME,EMPLOYEES.LAST_NAME,DEPARTMENT.DEP_NAME,DEPT_EMP.DEPT_NO
ORDER BY 2

--DEPARTMENT WITH HIGHTEST NUMBER EMPLOYEES
SELECT DEPT_NO, DEP_NAME
FROM DEPARTMENT
ORDER BY DEPT_NO DESC

-- Retrieve the employee number, first name, last name, and salary of employees earning more 
--than $60,000.
SELECT EMPLOYEES.LAST_NAME,EMPLOYEES.FIRST_NAME,SALARIES.SALARY
FROM EMPLOYEES
JOIN SALARIES
ON EMPLOYEES.EMP_NO = SALARIES.EMP_NO
GROUP BY EMPLOYEES.LAST_NAME,EMPLOYEES.FIRST_NAME,SALARIES.SALARY
HAVING SALARIES.SALARY > 60000
 
-- Get the average salary for each department
SELECT DEPT_EMP.EMP_NO,SALARIES.EMP_NO,DEPARTMENT.DEP_NAME,AVG (SALARIES.SALARY)
FROM SALARIES
JOIN DEPT_EMP
ON  DEPT_EMP.EMP_NO = SALARIES.EMP_NO
JOIN DEPARTMENT
ON DEPARTMENT.DEPT_NO = DEPT_EMP.DEPT_NO
GROUP BY DEPT_EMP.EMP_NO,SALARIES.EMP_NO,DEPARTMENT.DEP_NAME

-- Retrieve the employee number, first name, last name, and title of all employees who are 
--currently managers
SELECT EMPLOYEE_TITLES.EMP_NO,EMPLOYEE_TITLES.TITLE,EMPLOYEES.FIRST_NAME,EMPLOYEES.LAST_NAME
FROM EMPLOYEE_TITLES
JOIN EMPLOYEES
ON EMPLOYEE_TITLES.EMP_NO = EMPLOYEES.EMP_NO
GROUP BY EMPLOYEE_TITLES.EMP_NO,EMPLOYEE_TITLES.TITLE,EMPLOYEES.FIRST_NAME,EMPLOYEES.LAST_NAME

--Find the total number of employees in each department
SELECT COUNT(DEPT_NO),DEP_NAME
FROM DEPARTMENT
GROUP BY DEP_NAME

--Retrieve the department number and name where the most recently hired employee works.
SELECT DEPT_EMP.EMP_NO,DEPT_EMP.DEPT_NO,MAX(EMPLOYEES.HIRE_DATE),DEPARTMENT.DEP_NAME
FROM EMPLOYEES
JOIN DEPT_EMP 
ON EMPLOYEES.EMP_NO = DEPT_EMP.EMP_NO 
JOIN DEPARTMENT
ON DEPT_EMP.DEPT_NO = DEPARTMENT.DEPT_NO
GROUP BY DEPT_EMP.EMP_NO,DEPT_EMP.DEPT_NO,DEPARTMENT.DEP_NAME

alter table EMPLOYEE_titles
ALTER COLUMN emp_no TYPE int USING emp_no::int;

-- Get the department number, name, and average salary for departments with more than 3 
--employee
SELECT DEPARTMENT.DEPT_NO,DEPARTMENT.DEP_NAME,DEPT_EMP.EMP_NO,AVG(SALARIES.SALARY)
FROM DEPARTMENT
JOIN DEPT_EMP 
ON DEPARTMENT.DEPT_NO = DEPT_EMP.DEPT_NO
JOIN SALARIES
ON SALARIES.EMP_NO = DEPT_EMP.EMP_NO
GROUP BY DEPARTMENT.DEPT_NO,DEPARTMENT.DEP_NAME,DEPT_EMP.EMP_NO
HAVING DEPT_EMP.EMP_NO > 3

--Retrieve the employee number, first name, last name, and title of all employees hired in 2005
SELECT EMPLOYEE_TITLES.EMP_NO,EMPLOYEES.FIRST_NAME,EMPLOYEES.LAST_NAME,EMPLOYEE_TITLES.TITLE,EMPLOYEES.HIRE_DATE
FROM EMPLOYEE_TITLES
JOIN EMPLOYEES
ON EMPLOYEES.EMP_NO = EMPLOYEE_TITLES.EMP_NO
WHERE EXTRACT (YEAR FROM EMPLOYEES.HIRE_DATE) = '2005'

--get the department number,total number of employees for department with female manager
SELECT dept_emp.dept_no,employee_titles.emp_no,employees.gender,employee_titles.title
from employees
join dept_emp
on employees.emp_no = dept_emp.emp_no
join employee_titles
on employees.emp_no = employee_titles.emp_no
where employees.gender like  'F%'and employee_titles.title like 'Manager%'

--retrieve the  employee number,firstname,lastname, and name of employees who are currently working in the finance department
select employees.emp_no,employees.first_name,employees.last_name,department.dep_name
from employees
join dept_emp
on employees.emp_no = dept_emp.emp_no
join department
on dept_emp.dept_no = department.dept_no
where department.dep_name  like 'Finance%'

--find employee with the highest salary in each department
select salaries.emp_no,salaries.salary,department.dep_name
from salaries
join dept_emp
on dept_emp.emp_no = salaries.emp_no
join department
on department.dept_no = dept_emp.dept_no
group by salaries.emp_no,department.dep_name,salaries.salary
order by salaries.salary desc

--retrieve the employee number,firstname,lastname and department name of employees who have held managerial positions
select employees.emp_no,employees.last_name,employees.first_name,department.dep_name,employee_titles.title
from employee_titles
join dept_emp
on employee_titles.emp_no = dept_emp.emp_no
join department
on department.dept_no = dept_emp.dept_no
join employees
on employees.emp_no = employee_titles.emp_no
where employee_titles.title like 'Manager%'

--GET THE THE TOTAL NUMBER OF EMPLOYEES WHO HAVE HELD THE TITLE SENIOR MANAGER
SELECT EMP_NO, TITLE
FROM EMPLOYEE_TITLES
WHERE TITLE = 'Senior Manager'

--RETRIEVE THE DEPARTMENT NO,NAME AND THE NUMBER OF EMPLOYEES WHO HAVE WORKED THERE FOR MORE THAN FIVE YEARs



---find employee with the longes tenure in the company


--retreive the employee number,firstname,lastname an tile of employees whose hire date is between 2005-01-01 and 2006-01-01
select employee_titles.emp_no,employees.first_name,employees.last_name,employee_titles.title,employees.hire_date
from employees
join employee_titles
on employees.emp_no = employee_titles.emp_no
where hire_date between '2005-01-01' and '2006-01-01'

--get the department number,name,and the oldest employees birthdate for each department
select department.dept_no,department.dep_name,max(employees.birth_date)
from department
join dept_emp
on department.dept_no = dept_emp.dept_no
join employees
on employees.emp_no = dept_emp.emp_no
group by department.dept_no,department.dep_name

	SELECT *
FROM DEPARTMENT