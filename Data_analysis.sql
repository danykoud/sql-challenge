----DATA ANALYSIS
--1)List the following details of each employee: employee number, last name, first name, sex, and salary.
select emp.emp_no, emp.last_name, emp.first_name, emp.sex, sa.salary 
from Employees as emp 
inner join Salaries as sa  on emp.emp_no=sa.emp_no 
---2)list first name, last name, and hire date for employees who were hired in 1986.
select first_name, last_name, hire_date 
from Employees
where hire_date between '1986-01-01' and '1986-12-31'
order by hire_date asc 
--3)List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.
select dm.dept_no, dp.dept_name, dm.emp_no, emp.last_name, emp.first_name
from Employees as emp 
inner join Dept_manager as dm  on emp.emp_no=dm.emp_no 
inner join Departments as dp on dm.dept_no= dp.dept_no
--4)List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
select dm.emp_no, emp.last_name, emp.first_name, dp.dept_name
from Employees as emp 
inner join dept_emp as dm  on emp.emp_no=dm.emp_no 
inner join Departments as dp on dm.dept_no= dp.dept_no
---5)List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select first_name, last_name, sex 
from Employees 
where first_name like '%Hercules%'and last_name like 'B%'
--6)List all employees in the Sales department, including their employee number, last name, first name, and department name
select dm.emp_no, emp.last_name, emp.first_name, dp.dept_name
from Employees as emp 
inner join dept_emp as dm  on emp.emp_no=dm.emp_no 
inner join Departments as dp on dm.dept_no= dp.dept_no
where dp.dept_no= 'd007'
--7)List all employees in the Sales and Development departments, including their employee number,
--last name, first name, and department name.
select dm.emp_no, emp.last_name, emp.first_name, dp.dept_name
from Employees as emp 
inner join dept_emp as dm  on emp.emp_no=dm.emp_no 
inner join Departments as dp on dm.dept_no= dp.dept_no
where dp.dept_no in ('d007','d005')
--8)In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
select last_name, count(first_name) as "frequency count"
from Employees 
group by last_name
order by "frequency count" desc