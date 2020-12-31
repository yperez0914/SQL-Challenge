DROP TABLE dept_emp CASCADE;
DROP TABLE departments CASCADE;
DROP TABLE salaries CASCADE;
DROP TABLE employees CASCADE;
DROP TABLE dept_manager CASCADE;
DROP TABLE titles CASCADE;

CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
	"emp_no" INT   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" INT NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);



COPY departments
FROM 'C:\Users\yenia\Desktop\JHU_Bootcamp\Homework\SQL-Challenge\EmployeeSQL\Data\departments.csv'
DELIMITER ',' CSV HEADER;
SELECT * FROM departments;

COPY dept_emp
FROM 'C:\Users\yenia\Desktop\JHU_Bootcamp\Homework\SQL-Challenge\EmployeeSQL\Data\dept_emp.csv'
DELIMITER ',' CSV HEADER;
SELECT * FROM dept_emp;

COPY dept_manager
FROM 'C:\Users\yenia\Desktop\JHU_Bootcamp\Homework\SQL-Challenge\EmployeeSQL\Data\dept_manager.csv'
DELIMITER ',' CSV HEADER;
SELECT * FROM dept_manager;

COPY employees
FROM 'C:\Users\yenia\Desktop\JHU_Bootcamp\Homework\SQL-Challenge\EmployeeSQL\Data\employees.csv'
DELIMITER ',' CSV HEADER;
SELECT * FROM employees;

COPY salaries
FROM 'C:\Users\yenia\Desktop\JHU_Bootcamp\Homework\SQL-Challenge\EmployeeSQL\Data\salaries.csv'
DELIMITER ',' CSV HEADER;
SELECT * FROM salaries;

COPY titles
FROM 'C:\Users\yenia\Desktop\JHU_Bootcamp\Homework\SQL-Challenge\EmployeeSQL\Data\titles.csv'
DELIMITER ',' CSV HEADER;
SELECT * FROM titles;

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

-- List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT emp.emp_no, emp.last_name, emp.first_name, emp.sex, sal.salary
FROM employees AS emp 
LEFT JOIN salaries AS sal
	ON (emp.emp_no = sal.emp_no)
ORDER BY emp.emp_no;

-- List first name, last name, and hire date for employees who were hired in 1986.
SELECT employees.last_name, employees.first_name, employees.hire_date
FROM employees
WHERE extract (year from employees.hire_date) = 1986;

-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT emp.last_name, emp.first_name, emp.emp_no, depts.dept_no, depts.dept_name
FROM employees AS emp 
INNER JOIN dept_manager AS dept_m
	ON emp.emp_no = dept_m.emp_no 
INNER JOIN departments AS depts
	ON depts.dept_no = dept_m.dept_no;

--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT emp.last_name, emp.first_name, emp.emp_no, depts.dept_name
FROM employees AS emp
INNER JOIN dept_emp AS dept_e
	ON emp.emp_no = dept_e.emp_no
INNER JOIN departments AS depts
	ON dept_e.dept_no = depts.dept_no;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B.
SELECT employees.last_name, employees.first_name, employees.sex
FROM employees
WHERE employees.first_name IN ('Hercules') AND employees.last_name  LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT emp.last_name, emp. first_name, emp.emp_no, depts.dept_name
FROM employees AS emp
INNER JOIN dept_emp AS dept_e
	ON emp.emp_no = dept_e.emp_no
INNER JOIN departments AS depts
	ON dept_e.dept_no = depts.dept_no
	WHERE depts.dept_name = 'Sales';
	
--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT emp.last_name, emp. first_name, emp.emp_no, depts.dept_name
FROM employees AS emp
INNER JOIN dept_emp AS dept_e
	ON emp.emp_no = dept_e.emp_no
INNER JOIN departments AS depts
	ON dept_e.dept_no = depts.dept_no
	WHERE depts.dept_name = 'Sales'
		OR depts.dept_name = 'Development';
		
--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT employees.last_name, COUNT(employees.last_name) as freq_last_names
FROM employees
GROUP BY employees.last_name
ORDER BY freq_last_names DESC;