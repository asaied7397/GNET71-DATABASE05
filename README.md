# Hospital Database — SQL Server Assignment

A SQL Server project created as part of an **ASP.NET Backend Development Course**.

The project uses a pre-built Hospital database to practice relational database querying, SQL joins, self joins, cross joins, window functions, ranking functions, and more advanced queries involving multiple related tables.

---

## Project Overview

The Hospital database represents a simple hospital management system containing information about:

- Patients
- Wards
- Nurses
- Consultants
- Patient examinations
- Patient-consultant assignments
- Drugs
- Drug brands
- Drug administrations

The assignment contains **39 SQL questions**, progressing from basic table joins to more advanced SQL Server window functions.

---

## Technologies Used

- Microsoft SQL Server 2022
- T-SQL
- Docker
- Visual Studio Code
- SQL Server (MSSQL) Extension for VS Code
- Git
- GitHub

The database is running locally using a SQL Server Docker container.

---

## Database Setup

The original database was provided as a SQL Server backup file:

```text
Hospital.bak
```

The backup was restored into a SQL Server 2022 instance running inside Docker.

### Docker Container

The SQL Server container is accessible locally using:

```text
Server: localhost,1433
Database: Hospital
```

---

## Database Schema

The Hospital database contains the following main tables:

```text
Hospital
│
├── Consultants
├── DrugAdministrations
├── DrugBrands
├── Drugs
├── Nurses
├── PatientConsultantAssignments
├── PatientExaminations
├── Patients
└── Wards
```

`sysdiagrams` may also exist in the database but is not part of the assignment domain model.

---

## Main Tables

### Patients

Stores patient information and the ward to which a patient is assigned.

| Column | Type     | Nullable |
| ------ | -------- | -------- |
| Id     | INT      | No       |
| Name   | NVARCHAR | No       |
| DOB    | DATE     | No       |
| WardId | INT      | Yes      |

---

### Wards

Stores hospital ward information.

| Column | Type     | Nullable |
| ------ | -------- | -------- |
| Id     | INT      | No       |
| Name   | NVARCHAR | No       |

---

### Consultants

Stores consultant information including salary.

| Column | Type     | Nullable |
| ------ | -------- | -------- |
| Id     | INT      | No       |
| Name   | NVARCHAR | No       |
| Salary | DECIMAL  | Yes      |

---

### Nurses

Stores nurse information, ward relationships, manager relationships, and salary.

| Column           | Type     | Nullable |
| ---------------- | -------- | -------- |
| Number           | INT      | No       |
| Name             | NVARCHAR | No       |
| Address          | NVARCHAR | Yes      |
| SupervisedWardId | INT      | Yes      |
| ServesInWardId   | INT      | Yes      |
| ManagerId        | INT      | Yes      |
| Salary           | DECIMAL  | Yes      |

`ManagerId` creates a self-referencing relationship between nurses.

---

### PatientExaminations

Represents examinations performed by consultants on patients.

| Column       | Type | Nullable |
| ------------ | ---- | -------- |
| PatientId    | INT  | No       |
| ConsultantId | INT  | No       |

This table is used when querying consultants who **examined** patients.

---

### PatientConsultantAssignments

Represents patient assignments to consultants.

| Column       | Type | Nullable |
| ------------ | ---- | -------- |
| PatientId    | INT  | No       |
| ConsultantId | INT  | No       |

This table represents consultant-patient **assignments**, which are conceptually separate from examinations.

---

### DrugAdministrations

Stores medication administration records.

| Column    | Type     | Nullable |
| --------- | -------- | -------- |
| NurseId   | INT      | No       |
| DrugCode  | INT      | No       |
| PatientId | INT      | No       |
| Dosage    | NVARCHAR | Yes      |
| DATE      | DATE     | No       |
| Time      | TIME     | No       |

This table connects:

```text
Patient
   │
   │ receives medication
   ▼
DrugAdministration
   │
   ├── Nurse
   └── Drug
```

---

### Drugs

Stores drug information.

| Column | Type     | Nullable |
| ------ | -------- | -------- |
| Code   | INT      | No       |
| Dosage | NVARCHAR | Yes      |

---

### DrugBrands

Stores brand information associated with drugs.

| Column   | Type     | Nullable |
| -------- | -------- | -------- |
| DrugCode | INT      | No       |
| Brand    | NVARCHAR | No       |

---

## Assignment Topics

The assignment progresses through several SQL concepts.

### INNER JOIN

The first questions introduce relationships between tables using `INNER JOIN`.

Examples include:

- Patients and wards
- Drug administrations and patients
- Patients and consultants

---

### LEFT JOIN

`LEFT JOIN` is used when records from the primary table must still appear even if no matching record exists.

Examples:

- Patients without wards
- Wards without patients
- Consultants who have not examined patients

---

### RIGHT JOIN

`RIGHT JOIN` is used to preserve all records from the right-side table.

The assignment uses this to display all wards, including wards with no assigned patients.

---

### FULL OUTER JOIN

`FULL OUTER JOIN` preserves unmatched records from both tables.

It is used to retrieve:

- Patients without wards
- Wards without patients
- Consultants without assignments
- Assignments without matching consultants

---

## Self Joins

The `Nurses` table contains:

```text
ManagerId
```

which references another nurse.

This allows the project to practice self joins such as:

```text
Nurse
  │
  └── Manager → Nurse
```

The assignment uses self joins to display:

- Every nurse and their manager
- Nurses who have managers
- Managers and the nurses they manage

---

## CROSS JOIN

`CROSS JOIN` generates every possible combination between two sets of rows.

The assignment includes:

```text
Patients × Consultants
```

and:

```text
Wards × Consultants
```

---

## Multi-Table Joins

Several questions require joining three or more tables.

Examples include:

```text
Patient
   │
   ├── Ward
   │
   └── PatientExamination
             │
             └── Consultant
```

and:

```text
Patient
   │
   └── DrugAdministration
             │
             └── Nurse
```

These queries combine information from multiple relationships into a single result.

---

# SQL Window Functions

The second major part of the assignment focuses on SQL Server window functions.

The project covers:

- `ROW_NUMBER()`
- `RANK()`
- `DENSE_RANK()`
- `NTILE()`
- `PARTITION BY`

---

## ROW_NUMBER()

`ROW_NUMBER()` assigns a unique sequential number to every row.

Example:

```sql
SELECT
    Name,
    Salary,
    ROW_NUMBER() OVER (
        ORDER BY Salary DESC
    ) AS RowNumber
FROM Consultants;
```

Even when two consultants have the same salary, they receive different row numbers.

---

## RANK()

`RANK()` assigns the same rank to rows with equal values and leaves gaps after ties.

Example salaries:

```text
Salary      Rank
------      ----
20000       1
18000       2
18000       2
15000       4
```

---

## DENSE_RANK()

`DENSE_RANK()` also gives equal values the same rank, but does not leave gaps.

```text
Salary      DenseRank
------      ---------
20000       1
18000       2
18000       2
15000       3
```

---

## RANK vs DENSE_RANK

The project includes queries specifically designed to demonstrate the difference between:

```sql
RANK()
```

and:

```sql
DENSE_RANK()
```

The main difference is how ranking continues after a tie.

---

## NTILE()

`NTILE()` divides ordered rows into approximately equal groups.

The assignment uses:

```sql
NTILE(2)
NTILE(3)
NTILE(4)
```

to divide consultants into salary groups.

For example:

```sql
NTILE(4) OVER (
    ORDER BY Salary DESC
)
```

divides consultants into four salary groups, with the highest-paid consultants appearing in the first group.

---

## PARTITION BY

`PARTITION BY` restarts a window calculation for each logical group.

For example:

```sql
RANK() OVER (
    PARTITION BY ServesInWardId
    ORDER BY Salary DESC
)
```

ranks nurses based on salary **within their own ward**.

Each ward therefore starts its ranking again from `1`.

---

## CTEs and Ranking

The final questions combine:

- Common Table Expressions (`WITH`)
- Window functions
- Ranking
- Multiple joins

For example, consultant salary ranks can first be calculated independently:

```sql
WITH ConsultantRanks AS
(
    SELECT
        Id,
        Name,
        Salary,
        RANK() OVER (
            ORDER BY Salary DESC
        ) AS SalaryRank
    FROM Consultants
)
```

The ranked consultants can then be joined to patient examination records.

This prevents duplicate rows introduced by joins from incorrectly affecting the original salary ranking.

---

# Assignment Structure

The 39 questions approximately cover the following concepts:

| Questions | Main Concept                    |
| --------- | ------------------------------- |
| Q1–Q3     | INNER JOIN                      |
| Q4–Q6     | LEFT JOIN                       |
| Q7        | RIGHT JOIN                      |
| Q8        | LEFT JOIN / Assignments         |
| Q9–Q10    | FULL OUTER JOIN                 |
| Q11–Q13   | SELF JOIN                       |
| Q14–Q15   | CROSS JOIN                      |
| Q16–Q20   | Multi-table JOINs               |
| Q21–Q23   | ROW_NUMBER                      |
| Q24–Q26   | RANK                            |
| Q27–Q29   | DENSE_RANK                      |
| Q30–Q32   | NTILE                           |
| Q33–Q37   | PARTITION BY + Window Functions |
| Q38–Q39   | CTE + JOIN + Window Functions   |

---

# Project Files

```text
Hospital-Database-Assignment/
│
├── README.md
└── HospitalQueries.sql
```

### `HospitalQueries.sql`

Contains the solutions to all **39 SQL questions**.

The queries cover joins, ranking functions, partitions, CTEs, and multi-table relationships.

---

# Running the Project

## 1. Start SQL Server

If the Docker container already exists:

```bash
docker start sqlserver
```

Verify that it is running:

```bash
docker ps
```

---

## 2. Connect from VS Code

Using the MSSQL extension, connect to:

```text
Server: localhost,1433
Database: Hospital
Authentication: SQL Login
```

---

## 3. Select the Database

The SQL script starts with:

```sql
USE Hospital;
GO
```

---

## 4. Run Queries

Open:

```text
HospitalQueries.sql
```

Queries can be executed individually to inspect and understand the result of each assignment question.

---

# Learning Objectives

After completing this assignment, the main SQL concepts practiced include:

- Relational database relationships
- Primary and foreign key relationships
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL OUTER JOIN
- SELF JOIN
- CROSS JOIN
- Multi-table joins
- Table aliases
- `ROW_NUMBER()`
- `RANK()`
- `DENSE_RANK()`
- `NTILE()`
- `PARTITION BY`
- Common Table Expressions (CTEs)
- Combining joins with window functions

---

# Key SQL Concepts

A useful summary of the join behavior used throughout the assignment:

```text
INNER JOIN
→ Only matching records

LEFT JOIN
→ All records from the left table
  + matching records from the right

RIGHT JOIN
→ All records from the right table
  + matching records from the left

FULL OUTER JOIN
→ All records from both tables

SELF JOIN
→ A table joined to itself

CROSS JOIN
→ Every possible combination
```

For ranking:

```text
ROW_NUMBER()
→ Every row gets a unique number

RANK()
→ Ties receive the same rank
→ Gaps appear after ties

DENSE_RANK()
→ Ties receive the same rank
→ No gaps after ties

NTILE(n)
→ Divides rows into n approximately equal groups

PARTITION BY
→ Restarts the window calculation for each group
```

---

## Course

**ASP.NET Backend Development Course**

Database module covering SQL Server, relational databases, SQL joins, and window functions.
