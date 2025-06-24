
-- 1. Write a SQL query to list all employees who are currently active.
SELECT employee_id, first_name, last_name
FROM employees
WHERE active_flag = TRUE;

-- 2. Write a SQL query to fetch employee details who joined after Jan 1, 2022.
SELECT employee_id, first_name, last_name, hire_date
FROM employees
WHERE hire_date > '2022-01-01';

-- 3. Write a SQL query to find all employees in the “Finance” department.
SELECT e.first_name, e.last_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';

-- 4. Write a SQL query to fetch employee names with their department and role.
SELECT e.first_name, e.last_name, d.department_name, r.role_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN roles r ON e.role_id = r.role_id;

-- 5. Write a SQL query to list salaries with employee names.
SELECT e.first_name, e.last_name, s.base_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id;

-- 6. Write a SQL query to find all bonus records with corresponding employee details.
SELECT e.first_name, e.last_name, b.bonus_type, b.bonus_amount
FROM bonuses b
JOIN employees e ON b.employee_id = e.employee_id;

-- 7. Write a SQL query to fetch payroll records with employee and department info.
SELECT e.first_name, e.last_name, d.department_name, p.payroll_date, p.net_pay
FROM payroll_cycles p
JOIN employees e ON p.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id;

-- 8. Write a SQL query to calculate average salary by role.
SELECT r.role_name, AVG(s.base_salary) AS avg_salary
FROM salaries s
JOIN employees e ON s.employee_id = e.employee_id
JOIN roles r ON e.role_id = r.role_id
GROUP BY r.role_name;

-- 9. Write a SQL query to find the total bonuses paid per department.
SELECT d.department_name, SUM(b.bonus_amount) AS total_bonus
FROM bonuses b
JOIN employees e ON b.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

-- 10. Write a SQL query to show total payroll paid in each month.
SELECT DATE_TRUNC('month', payroll_date) AS month, 
       SUM(net_pay) AS total_net_pay
FROM payroll_cycles
GROUP BY month
ORDER BY month DESC;

-- 11. Write a SQL query to count number of employees in each role.
SELECT r.role_name, COUNT(*) AS employee_count
FROM employees e
JOIN roles r ON e.role_id = r.role_id
GROUP BY r.role_name;

-- 12. Write a SQL query to find employees earning below average for their role.
SELECT e.first_name, e.last_name, s.base_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.base_salary < (
    SELECT AVG(s2.base_salary)
    FROM salaries s2
    JOIN employees e2 ON s2.employee_id = e2.employee_id
    WHERE e2.role_id = e.role_id
);

-- 13. Write a SQL query to show departments with no active employees.
SELECT department_name
FROM departments
WHERE department_id NOT IN (
    SELECT department_id FROM employees WHERE active_flag = TRUE
);

-- 14. Write a SQL query to get top 5 earners (salary + bonus).
SELECT e.employee_id, e.first_name, e.last_name, 
       s.base_salary + COALESCE(SUM(b.bonus_amount), 0) AS total_comp
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
LEFT JOIN bonuses b ON e.employee_id = b.employee_id
GROUP BY e.employee_id, s.base_salary
ORDER BY total_comp DESC
LIMIT 5;

-- 15. Write a SQL query to tag employees as ‘Low’, ‘Medium’, or ‘High’ salary.
SELECT e.first_name, e.last_name, s.base_salary,
  CASE
    WHEN s.base_salary < 50000 THEN 'Low'
    WHEN s.base_salary BETWEEN 50000 AND 80000 THEN 'Medium'
    ELSE 'High'
  END AS salary_band
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id;

-- 16. Write a SQL query to mark payrolls as ‘On Time’ or ‘Delayed’.
SELECT employee_id, payroll_date,
  CASE
    WHEN payroll_date > CURRENT_DATE - INTERVAL '5 days' THEN 'On Time'
    ELSE 'Delayed'
  END AS payroll_status
FROM payroll_cycles;

-- 17. Write a SQL query to find bonuses issued in the last 90 days.
SELECT * FROM bonuses
WHERE bonus_date >= CURRENT_DATE - INTERVAL '90 days';

-- 18. Write a SQL query to find payroll records for the last 3 months.
SELECT * FROM payroll_cycles
WHERE payroll_date >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '3 months');

-- 19. Write a SQL query to find employees hired in the same year as today.
SELECT * FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = EXTRACT(YEAR FROM CURRENT_DATE);

-- 20. Write a SQL query to identify employees without a salary record.
SELECT e.employee_id, e.first_name
FROM employees e
LEFT JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.salary_id IS NULL;

-- 21. Write a SQL query to detect invalid net_pay (net_pay ≠ gross - deductions).
SELECT * FROM payroll_cycles
WHERE net_pay <> gross_pay - deductions;

-- 22. Write a SQL query to find duplicate employee emails (shouldn’t exist).
SELECT email, COUNT(*) 
FROM employees
GROUP BY email
HAVING COUNT(*) > 1;

-- 23. Write a SQL query to find department-wise average net pay.
SELECT d.department_name, AVG(p.net_pay) AS avg_net_pay
FROM payroll_cycles p
JOIN employees e ON p.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

-- 24. Write a SQL query to find the most common bonus type.
SELECT bonus_type, COUNT(*) AS count
FROM bonuses
GROUP BY bonus_type
ORDER BY count DESC
LIMIT 1;

-- 25. Write a SQL query to find employees receiving more than 2 bonuses.
SELECT employee_id, COUNT(*) AS bonus_count
FROM bonuses
GROUP BY employee_id
HAVING COUNT(*) > 2;

-- 26. Write a SQL query to list roles and the number of active employees per role.
SELECT r.role_name, COUNT(*) AS active_count
FROM employees e
JOIN roles r ON e.role_id = r.role_id
WHERE e.active_flag = TRUE
GROUP BY r.role_name;

-- 27. Write a SQL query to find payroll records of inactive employees (audit use case).
SELECT e.first_name, e.last_name, p.*
FROM payroll_cycles p
JOIN employees e ON p.employee_id = e.employee_id
WHERE e.active_flag = FALSE;

-- 28. Write a SQL query to fetch monthly gross pay trend by department.
SELECT d.department_name, DATE_TRUNC('month', p.payroll_date) AS month, 
       SUM(p.gross_pay) AS total_gross
FROM payroll_cycles p
JOIN employees e ON p.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name, month
ORDER BY month;

-- 29. Write a SQL query to identify employees who never received any bonus.
SELECT e.employee_id, e.first_name, e.last_name
FROM employees e
LEFT JOIN bonuses b ON e.employee_id = b.employee_id
WHERE b.bonus_id IS NULL;

-- 30. Write a SQL query to find the total compensation (salary + bonus) per employee.
SELECT e.employee_id, e.first_name, e.last_name,
       s.base_salary + COALESCE(SUM(b.bonus_amount), 0) AS total_comp
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
LEFT JOIN bonuses b ON e.employee_id = b.employee_id
GROUP BY e.employee_id, s.base_salary;
