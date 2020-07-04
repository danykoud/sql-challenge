# SQL Homework - Employee Database: A Mystery in Two Parts

![](images/Capture.png)

## Background

It is a beautiful spring day, and it is two weeks since you have been hired as a new data engineer at Pewlett Hackard. Your first major task is a research project on employees of the corporation from the 1980s and 1990s. All that remain of the database of employees from that period are six CSV files.

In this assignment, you will design the tables to hold data in the CSVs, import the CSVs into a SQL database, and answer questions about the data. In other words, you will perform:



#### Data Modeling

Inspect the CSVs and sketch out an ERD of the tables. 

#### Data Engineering

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

-- Table output queries
select* from Departments;
select* from Titles;
select* from Employees;
select* from dept_emp;
select* from Dept_manager;
select* from salaries ;

#### Data Analysis

Once you have a complete database, do the following:

##1. List the following details of each employee: employee number, last name, first name, sex, and salary.


select emp.emp_no, emp.last_name, emp.first_name, emp.sex, sa.salary 
from Employees as emp 
inner join Salaries as sa  on emp.emp_no=sa.emp_no 

##2. List first name, last name, and hire date for employees who were hired in 1986.

select first_name, last_name, hire_date 
from Employees
where hire_date between '1986-01-01' and '1986-12-31'
order by hire_date asc 

##3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.


select dm.dept_no, dp.dept_name, dm.emp_no, emp.last_name, emp.first_name
from Employees as emp 
inner join Dept_manager as dm  on emp.emp_no=dm.emp_no 
inner join Departments as dp on dm.dept_no= dp.dept_no

##4. List the department of each employee with the following information: employee number, last name, first name, and department name.


select dm.emp_no, emp.last_name, emp.first_name, dp.dept_name
from Employees as emp 
inner join dept_emp as dm  on emp.emp_no=dm.emp_no 
inner join Departments as dp on dm.dept_no= dp.dept_no
5.List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select first_name, last_name, sex 
from Employees 
where first_name like '%Hercules%'and last_name like 'B%'

##6. List all employees in the Sales department, including their employee number, last name, first name, and department name.


select dm.emp_no, emp.last_name, emp.first_name, dp.dept_name
from Employees as emp 
inner join dept_emp as dm  on emp.emp_no=dm.emp_no 
inner join Departments as dp on dm.dept_no= dp.dept_no
where dp.dept_no= 'd007'

##7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.


select dm.emp_no, emp.last_name, emp.first_name, dp.dept_name
from Employees as emp 
inner join dept_emp as dm  on emp.emp_no=dm.emp_no 
inner join Departments as dp on dm.dept_no= dp.dept_no
where dp.dept_no in ('d007','d005')

##8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.


select last_name, count(first_name) as "frequency count"
from Employees 
group by last_name
order by "frequency count" desc


## Bonus (Optional)

As you examine the data, you are overcome with a creeping suspicion that the dataset is fake. You surmise that your boss handed you spurious data in order to test the data engineering skills of a new employee. To confirm your hunch, you decide to take the following steps to generate a visualization of the data, with which you will confront your boss:

1. Import the SQL database into Pandas. (Yes, you could read the CSVs directly in Pandas, but you are, after all, trying to prove your technical mettle.) This step may require some research. Feel free to use the code below to get started. Be sure to make any necessary modifications for your username, password, host, port, and database name:

   ```sql
   from sqlalchemy import create_engine
   engine = create_engine('postgresql://localhost:5432/<your_db_name>')
   connection = engine.connect()
   ```

* Consult [SQLAlchemy documentation](https://docs.sqlalchemy.org/en/latest/core/engines.html#postgresql) for more information.

* If using a password, do not upload your password to your GitHub repository. See [https://www.youtube.com/watch?v=2uaTPmNvH0I](https://www.youtube.com/watch?v=2uaTPmNvH0I) and [https://help.github.com/en/github/using-git/ignoring-files](https://help.github.com/en/github/using-git/ignoring-files) for more information.

2. Create a histogram to visualize the most common salary ranges for employees.

3. Create a bar chart of average salary by title.

## Epilogue

Evidence in hand, you march into your boss's office and present the visualization. With a sly grin, your boss thanks you for your work. On your way out of the office, you hear the words, "Search your ID number." You look down at your badge to see that your employee ID number is 499942.

## Submission

* Create an image file of your ERD.

* Create a `.sql` file of your table schemata.

* Create a `.sql` file of your queries.

* (Optional) Create a Jupyter Notebook of the bonus analysis.

* Create and upload a repository with the above files to GitHub and post a link on BootCamp Spot.

![](images/bar_chart_img.png)


![](images/bar_chart.png)
