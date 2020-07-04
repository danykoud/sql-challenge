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