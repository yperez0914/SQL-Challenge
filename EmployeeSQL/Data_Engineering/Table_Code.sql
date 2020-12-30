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
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
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
