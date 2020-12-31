# SQL-Challenge
For this project, I used PostgreSQL and pgAdmin to manage a company's employee data.
<br>

# Data Engineering
Using the information provided from multiple CSV files, I created an EDR for the data. The following relationships were defined in the EDR:
Table | Primary Key
-------------------------
employees | emp_no
departments |dept_no
titles | title_id
salariesv| emp_no
<br>

Table | Composite Key
---------------------------
dept_emp | emp_no, dept_no
dept_manager | emp_no, dept_no
<br>
These relationships and foreign keys can be seen in the code for the EDR & table schemas.
<br>

[Table_Schemata full code](https://github.com/yperez0914/SQL-Challenge/blob/main/EmployeeSQL/Data_Engineering/Table_Schemata.sql)
    Example:
    ```CREATE TABLE "dept_manager" (
            "emp_no" INT   NOT NULL,
            "dept_no" VARCHAR   NOT NULL,
            CONSTRAINT "pk_dept_manager" PRIMARY KEY (
            "emp_no","dept_no"
            )
        );
       ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
       REFERENCES "employees" ("emp_no");```
<br>
Then, I imported the tables from the CSV files to create a SQL table schema for each of the CSV files.
    Example:
    ```COPY dept_manager
       FROM
       'C:\Users\yenia\Desktop\JHU_Bootcamp\Homework\SQL-Challenge\EmployeeSQL\Data\dept_manager.csv'
       DELIMITER ',' CSV HEADER;
       SELECT * FROM dept_manager;```
<br>

# Data Analysis
Finally, I performed data analysis in the following ways:
<br>

1. List the following details of each employee: employee number, last name, first name, sex, and salary.

2. List first name, last name, and hire date for employees who were hired in 1986.

3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

4. List the department of each employee with the following information: employee number, last name, first name, and department name.

5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
<br>

[Queries full code](https://github.com/yperez0914/SQL-Challenge/blob/main/EmployeeSQL/Data_Analysis/Queries.sql)
    #3 Example:
    ```SELECT emp.last_name, emp.first_name, emp.emp_no, depts.dept_no, depts.dept_name
       FROM employees AS emp 
       INNER JOIN dept_manager AS dept_m
	        ON emp.emp_no = dept_m.emp_no 
       INNER JOIN departments AS depts
	        ON depts.dept_no = dept_m.dept_no;```