-- DROPPING TABLE IF IT ALREADY EXISTS
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Dept_emp;
DROP TABLE IF EXISTS Dept_manager;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Salaries; 
DROP TABLE IF EXISTS Titles;

--CREATING TABLES WITH CONSTRAINTS FOR DATA INTEGRITY 
create table Departments (
dept_no varchar not null primary key ,
dept_name varchar not null
);
create table Titles (
title_id varchar not null primary key,
title varchar not null 
);

create table Employees (
emp_no int not null,
emp_title_id varchar not null,
birth_date date not null,
first_name varchar not null,
last_name varchar not null,
sex varchar not null,
hire_date date not null

);
create table Dept_emp (
emp_no int  not null,
dept_no varchar not null
);
create table Dept_manager (
dept_no varchar not null,
emp_no int not null

);

create table Salaries (
emp_no int not null,
salary int not null

);

-- adding constraints to the table after the upload  since the data couldn't be uploaded in the table with the constraints in 
ALTER TABLE Employees ADD CONSTRAINT pk_employees_emp PRIMARY KEY (emp_no);
ALTER TABLE Employees ADD CONSTRAINT fk_employees_TitleID FOREIGN KEY("emp_title_id") REFERENCES  Titles ("title_id");
ALTER TABLE Dept_emp ADD CONSTRAINT  fk_Dept_emp_emp FOREIGN KEY(emp_no) REFERENCES Employees (emp_no);
ALTER TABLE Dept_emp ADD CONSTRAINT fk_Dept_emp_dept FOREIGN KEY(dept_no) REFERENCES Departments (dept_no);
ALTER TABLE Dept_manager ADD CONSTRAINT fk_Dept_manager_emp FOREIGN KEY(emp_no)REFERENCES Employees (emp_no);
ALTER TABLE Dept_manager ADD CONSTRAINT fk_Dept_manager_dept FOREIGN KEY(dept_no) REFERENCES  Departments (dept_no);
ALTER TABLE salaries ADD CONSTRAINT fk_salaries_emp FOREIGN KEY(emp_no) REFERENCES Employees (emp_no);

-- Dropping constraints to allow the "drop table if exists" to drop the tables 

--ALTER TABLE employees DROP CONSTRAINT "pk_employees_emp";
--ALTER TABLE employees DROP CONSTRAINT fk_employees_TitleID;
--ALTER TABLE Dept_emp DROP CONSTRAINT  fk_Dept_emp_emp;
--ALTER TABLE Dept_emp DROP CONSTRAINT  fk_Dept_emp_dept;
--ALTER TABLE Dept_manager DROP CONSTRAINT  fk_Dept_manager_emp ;
--ALTER TABLE Dept_manager DROP CONSTRAINT  fk_Dept_manager_dept;
--ALTER TABLE salaries DROP CONSTRAINT  fk_salaries_emp;

-- Table output queries
select* from Departments;
select* from Titles;
select* from Employees;
select* from dept_emp;
select* from Dept_manager;
select* from salaries ;


----DATA ANALYSIS
--List the following details of each employee: employee number, last name, first name, sex, and salary.
select emp.emp_no, emp.last_name, emp.first_name, emp.sex, sa.salary 
from Employees as emp 
inner join Salaries as sa  on emp.emp_no=sa.emp_no 
---list first name, last name, and hire date for employees who were hired in 1986.
select first_name, last_name, hire_date 
from Employees
where hire_date between '1986-01-01' and '1986-12-31'
order by hire_date asc 
--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.
select dm.dept_no, dp.dept_name, dm.emp_no, emp.last_name, emp.first_name
from Employees as emp 
inner join Dept_manager as dm  on emp.emp_no=dm.emp_no 
inner join Departments as dp on dm.dept_no= dp.dept_no
--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
select dm.emp_no, emp.last_name, emp.first_name, dp.dept_name
from Employees as emp 
inner join dept_emp as dm  on emp.emp_no=dm.emp_no 
inner join Departments as dp on dm.dept_no= dp.dept_no
---List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select first_name, last_name, sex 
from Employees 
where first_name like '%Hercules%'and last_name like 'B%'
--List all employees in the Sales department, including their employee number, last name, first name, and department name
select dm.emp_no, emp.last_name, emp.first_name, dp.dept_name
from Employees as emp 
inner join dept_emp as dm  on emp.emp_no=dm.emp_no 
inner join Departments as dp on dm.dept_no= dp.dept_no
where dp.dept_no= 'd007'
--List all employees in the Sales and Development departments, including their employee number,
--last name, first name, and department name.
select dm.emp_no, emp.last_name, emp.first_name, dp.dept_name
from Employees as emp 
inner join dept_emp as dm  on emp.emp_no=dm.emp_no 
inner join Departments as dp on dm.dept_no= dp.dept_no
where dp.dept_no in ('d007','d005')
--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
select last_name, count(first_name) as "frequency count"
from Employees 
group by last_name
order by "frequency count" desc