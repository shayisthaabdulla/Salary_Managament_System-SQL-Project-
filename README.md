# 💰 Salary Management System (SQL Project)

## 📌 Project Overview
**Project Title**: Salary Management System
**Level**: Beginner – Intermediate
**Database**: salary_management_db

This SQL project simulates a corporate salary management system including employees, departments, roles, payroll, and bonuses. It mirrors how Business Analysts work with compensation data to analyze payroll trends, validate pay structures, and report on financial KPIs.

## 💡 Why This Project Matters
This project reflects common BA use cases in HR, Finance, and Operations teams. It demonstrates:
- How to extract insights from salary and payroll data
- How to validate compensation consistency across departments and roles
- My ability to query, clean, and analyze structured datasets using SQL

## 🎯 Objectives
- Design realistic HR compensation tables that are fully joinable
- Practice BA-level SQL queries: JOIN, GROUP BY, CASE, subqueries, filtering, validation, date functions
- Deliver meaningful reporting insights based on salary and performance indicators

## 🏗️ Project Structure
### 1. Database Setup
**Database Name**: salary_management_db
- PostgreSQL-based relational database simulating a real-world corporate payroll system.

### 2. Table Creation
Six core tables represent salary and payroll operations:

1. Departments Table
  CREATE TABLE departments (
  department_id SERIAL PRIMARY KEY,
  department_name VARCHAR(100),
  location VARCHAR(100));

2. Roles Table
  CREATE TABLE roles (
  role_id SERIAL PRIMARY KEY,
  role_name VARCHAR(100),
  salary_band VARCHAR(20));

3. Employees Table
  CREATE TABLE employees (
  employee_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(100) UNIQUE,
  department_id INT REFERENCES departments(department_id),
  role_id INT REFERENCES roles(role_id),
  hire_date DATE,
  active_flag BOOLEAN);

4. Salaries Table
  CREATE TABLE salaries (
  salary_id SERIAL PRIMARY KEY,
  employee_id INT REFERENCES employees(employee_id),
  base_salary NUMERIC(10,2),
  effective_date DATE);

5. Payroll Cycles Table
  CREATE TABLE payroll_cycles (
  payroll_id SERIAL PRIMARY KEY,
  employee_id INT REFERENCES employees(employee_id),
  payroll_date DATE,
  gross_pay NUMERIC(10,2),
  deductions NUMERIC(10,2),
  net_pay NUMERIC(10,2));

6. Bonuses Table
  CREATE TABLE bonuses (
  bonus_id SERIAL PRIMARY KEY,
  employee_id INT REFERENCES employees(employee_id),
  bonus_type VARCHAR(50),
  bonus_amount NUMERIC(10,2),
  bonus_date DATE);

### 📊 SQL Queries for Business Analysts
Full query list will be saved as salary_queries.sql in your GitHub repo.
- Basic SELECT & Filetering
- JOINS & Relationships
- Aggregations & Metrics
- Data Validatin
- Subqueries & Case
- Time Based Performance

### 📈 Key Findings
- Bonus distribution skewed toward specific roles
- Salary inconsistencies in some departments flagged for review
- Monthly payroll costs aligned with hiring spikes
- Identified inactive employees with recurring payroll entries (HR review)

### 📋 Reporting Extensions
- Role-Based Compensation Dashboard
- Departmental Payroll Analysis
- Monthly Bonus Distribution Tracker
- Employee Compensation Variance Report

### 👩‍💼 About the Author
Microsoft Certified Dynamics 365 professional, Shayistha Abdulla is a Business Analyst with 9+ years of experience across Digital Marketing, CRM, PropTech, and IT Consulting. This project showcases her SQL skills applied to real-world salary systems, with a focus on data integrity, analysis, and compensation reporting.


