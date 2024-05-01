Created a SQL script with the following DDL and DML statements.  Normalized (3NF).
o	All DDL statements to Create tables.  
o	All needed Constraints (Primary Keys, Foreign Keys, Not Null, …)
o	SQL Statements to retrieve data for each User View in tabular format.  Add Where clause for each SQL Statement based on the User Views.
o	SQL Statements to retrieve Data exactly in the same format as Appendix A.
o	Optimized queries by creating Indexes for each query, based on the Where clause.
o	A Select Statement to retrieve all Customers that do not have any Charter trip.
o	A Select Statement to retrieve all Employees that are not Charter Crew members.

View 1: Customer Flights
Business Rules:
1. A charter trip can be booked by one customer only.
View 2- Charter Crew
Business Rules:
1. The job functionality of employee within each flight may be different.
View 3- Employees Earned Ratings
Business Rules:
1. All Pilots are employees but not all employees are flight crew members.
2. All Pilots are required to pass Medical Examination and AviaCo is required to keep track of the last Medical Examination date.
3. The value of Medical Type can be 1 or 2 only. 
View 4- Aircrafts Model
Business Rules:
1. One Aircraft can have one model code only but one model code applies to many Aircrafts.
View 5- Aircrafts Charter
Airline requires storing information about Aircrafts and the number of flights for each one of them.
