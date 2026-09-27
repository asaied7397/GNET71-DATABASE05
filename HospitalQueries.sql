USE Hospital;
GO


/* ============================================================
   QUESTION 1
   Display every patient together with the name of the ward
   they belong to.
   ============================================================ */

SELECT
    p.Name AS PatientName,
    w.Name AS WardName
FROM Patients p
INNER JOIN Wards w
    ON p.WardId = w.Id;
GO


/* ============================================================
   QUESTION 2
   Display every drug administration together with the patient's
   name and the administered drug code.
   ============================================================ */

SELECT
    p.Name AS PatientName,
    da.DrugCode
FROM DrugAdministrations da
INNER JOIN Patients p
    ON da.PatientId = p.Id;
GO


/* ============================================================
   QUESTION 3
   Display every patient together with the consultant who
   examined them.
   ============================================================ */

SELECT
    p.Name AS PatientName,
    c.Name AS ConsultantName
FROM Patients p
INNER JOIN PatientExaminations pe
    ON p.Id = pe.PatientId
INNER JOIN Consultants c
    ON pe.ConsultantId = c.Id;
GO


/* ============================================================
   QUESTION 4
   Display every patient together with their ward, including
   patients who are not assigned to a ward.
   ============================================================ */

SELECT
    p.Name AS PatientName,
    w.Name AS WardName
FROM Patients p
LEFT JOIN Wards w
    ON p.WardId = w.Id;
GO


/* ============================================================
   QUESTION 5
   Display every ward together with its patients, including
   wards that currently have no patients.
   ============================================================ */

SELECT
    w.Name AS WardName,
    p.Name AS PatientName
FROM Wards w
LEFT JOIN Patients p
    ON w.Id = p.WardId;
GO


/* ============================================================
   QUESTION 6
   Display every consultant together with the patients they
   examined, including consultants who have not examined
   any patient.
   ============================================================ */

SELECT
    c.Name AS ConsultantName,
    p.Name AS PatientName
FROM Consultants c
LEFT JOIN PatientExaminations pe
    ON c.Id = pe.ConsultantId
LEFT JOIN Patients p
    ON pe.PatientId = p.Id;
GO


/* ============================================================
   QUESTION 7
   Display every ward together with the patients assigned to it,
   including wards that have no patients.
   ============================================================ */

SELECT
    w.Name AS WardName,
    p.Name AS PatientName
FROM Patients p
RIGHT JOIN Wards w
    ON p.WardId = w.Id;
GO


/* ============================================================
   QUESTION 8
   Display every consultant together with their patient
   assignments, including consultants who have no assignments.
   ============================================================ */

SELECT
    c.Name AS ConsultantName,
    pca.PatientId
FROM Consultants c
LEFT JOIN PatientConsultantAssignments pca
    ON c.Id = pca.ConsultantId;
GO


/* ============================================================
   QUESTION 9
   Display all patients and all wards, including patients
   without a ward and wards without patients.
   ============================================================ */

SELECT
    p.Name AS PatientName,
    w.Name AS WardName
FROM Patients p
FULL OUTER JOIN Wards w
    ON p.WardId = w.Id;
GO


/* ============================================================
   QUESTION 10
   Display all consultants and their patient assignments,
   including consultants without assignments and assignments
   without consultants.
   ============================================================ */

SELECT
    c.Name AS ConsultantName,
    pca.PatientId,
    pca.ConsultantId
FROM Consultants c
FULL OUTER JOIN PatientConsultantAssignments pca
    ON c.Id = pca.ConsultantId;
GO


/* ============================================================
   QUESTION 11
   Display every nurse together with the name of their manager.
   ============================================================ */

SELECT
    n.Name AS NurseName,
    m.Name AS ManagerName
FROM Nurses n
LEFT JOIN Nurses m
    ON n.ManagerId = m.Number;
GO


/* ============================================================
   QUESTION 12
   Display only nurses who have a manager.
   ============================================================ */

SELECT
    n.Name AS NurseName,
    m.Name AS ManagerName
FROM Nurses n
INNER JOIN Nurses m
    ON n.ManagerId = m.Number;
GO


/* ============================================================
   QUESTION 13
   Display every manager together with the nurses they manage.
   ============================================================ */

SELECT
    m.Name AS ManagerName,
    n.Name AS NurseName
FROM Nurses m
INNER JOIN Nurses n
    ON n.ManagerId = m.Number;
GO


/* ============================================================
   QUESTION 14
   Generate every possible combination of patients and
   consultants.
   ============================================================ */

SELECT
    p.Name AS PatientName,
    c.Name AS ConsultantName
FROM Patients p
CROSS JOIN Consultants c;
GO


/* ============================================================
   QUESTION 15
   Generate every possible combination of wards and consultants.
   ============================================================ */

SELECT
    w.Name AS WardName,
    c.Name AS ConsultantName
FROM Wards w
CROSS JOIN Consultants c;
GO


/* ============================================================
   QUESTION 16
   Display each patient's name, ward, and consultant who
   examined the patient.
   ============================================================ */

SELECT
    p.Name AS PatientName,
    w.Name AS WardName,
    c.Name AS ConsultantName
FROM Patients p
INNER JOIN Wards w
    ON p.WardId = w.Id
INNER JOIN PatientExaminations pe
    ON p.Id = pe.PatientId
INNER JOIN Consultants c
    ON pe.ConsultantId = c.Id;
GO


/* ============================================================
   QUESTION 17
   Display each patient's name, the nurse who administered
   the drug, and the drug code.
   ============================================================ */

SELECT
    p.Name AS PatientName,
    n.Name AS NurseName,
    da.DrugCode
FROM DrugAdministrations da
INNER JOIN Patients p
    ON da.PatientId = p.Id
INNER JOIN Nurses n
    ON da.NurseId = n.Number;
GO


/* ============================================================
   QUESTION 18
   Display each patient, their ward, the nurse who administered
   the drug, and the drug dosage.
   ============================================================ */

SELECT
    p.Name AS PatientName,
    w.Name AS WardName,
    n.Name AS NurseName,
    da.Dosage
FROM DrugAdministrations da
INNER JOIN Patients p
    ON da.PatientId = p.Id
LEFT JOIN Wards w
    ON p.WardId = w.Id
INNER JOIN Nurses n
    ON da.NurseId = n.Number;
GO


/* ============================================================
   QUESTION 19
   Display the patient name, consultant name, and ward name
   for every patient who has been examined by a consultant.
   ============================================================ */

SELECT
    p.Name AS PatientName,
    c.Name AS ConsultantName,
    w.Name AS WardName
FROM PatientExaminations pe
INNER JOIN Patients p
    ON pe.PatientId = p.Id
INNER JOIN Consultants c
    ON pe.ConsultantId = c.Id
LEFT JOIN Wards w
    ON p.WardId = w.Id;
GO


/* ============================================================
   QUESTION 20
   Display patient name, nurse name, drug code, dosage,
   administration date, and administration time.
   ============================================================ */

SELECT
    p.Name AS PatientName,
    n.Name AS NurseName,
    da.DrugCode,
    da.Dosage,
    da.DATE AS AdministrationDate,
    da.Time AS AdministrationTime
FROM DrugAdministrations da
INNER JOIN Patients p
    ON da.PatientId = p.Id
INNER JOIN Nurses n
    ON da.NurseId = n.Number;
GO


/* ============================================================
   QUESTION 21
   Assign a unique row number to every consultant based on
   salary, starting with the highest-paid consultant.
   ============================================================ */

SELECT
    Name,
    Salary,
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNumber
FROM Consultants;
GO


/* ============================================================
   QUESTION 22
   Assign a unique row number to every consultant based on
   salary, starting with the lowest-paid consultant.
   ============================================================ */

SELECT
    Name,
    Salary,
    ROW_NUMBER() OVER (ORDER BY Salary ASC) AS RowNumber
FROM Consultants;
GO


/* ============================================================
   QUESTION 23
   Assign a unique row number based on salary. If salaries
   are equal, order consultants alphabetically by name.
   ============================================================ */

SELECT
    Name,
    Salary,
    ROW_NUMBER() OVER (
        ORDER BY Salary DESC, Name ASC
    ) AS RowNumber
FROM Consultants;
GO


/* ============================================================
   QUESTION 24
   Rank all consultants based on salary, with the highest
   salary receiving rank 1.
   ============================================================ */

SELECT
    Name,
    Salary,
    RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Consultants;
GO


/* ============================================================
   QUESTION 25
   Rank all consultants based on salary from lowest to highest.
   ============================================================ */

SELECT
    Name,
    Salary,
    RANK() OVER (ORDER BY Salary ASC) AS SalaryRank
FROM Consultants;
GO


/* ============================================================
   QUESTION 26
   Display each consultant's salary rank and sort the result
   from highest salary to lowest.
   ============================================================ */

SELECT
    Name,
    Salary,
    RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Consultants
ORDER BY Salary DESC;
GO


/* ============================================================
   QUESTION 27
   Assign a dense rank to every consultant based on salary,
   with the highest salary receiving rank 1.
   ============================================================ */

SELECT
    Name,
    Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Consultants;
GO


/* ============================================================
   QUESTION 28
   Display salary and dense rank of every consultant,
   sorted by salary from highest to lowest.
   ============================================================ */

SELECT
    Name,
    Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseSalaryRank
FROM Consultants
ORDER BY Salary DESC;
GO


/* ============================================================
   QUESTION 29
   Display consultant name, salary, RANK and DENSE_RANK to
   compare how ties are handled.
   ============================================================ */

SELECT
    Name,
    Salary,
    RANK() OVER (
        ORDER BY Salary DESC
    ) AS SalaryRank,
    DENSE_RANK() OVER (
        ORDER BY Salary DESC
    ) AS DenseSalaryRank
FROM Consultants;
GO


/* ============================================================
   QUESTION 30
   Divide all consultants into two salary groups, with the
   highest-paid consultants in the first group.
   ============================================================ */

SELECT
    Name,
    Salary,
    NTILE(2) OVER (ORDER BY Salary DESC) AS SalaryGroup
FROM Consultants;
GO


/* ============================================================
   QUESTION 31
   Divide all consultants into three approximately equal
   salary groups.
   ============================================================ */

SELECT
    Name,
    Salary,
    NTILE(3) OVER (ORDER BY Salary DESC) AS SalaryGroup
FROM Consultants;
GO


/* ============================================================
   QUESTION 32
   Divide all consultants into four salary groups and display
   the highest-paid group first.
   ============================================================ */

SELECT
    Name,
    Salary,
    NTILE(4) OVER (ORDER BY Salary DESC) AS SalaryGroup
FROM Consultants
ORDER BY SalaryGroup ASC, Salary DESC;
GO


/* ============================================================
   QUESTION 33
   Rank nurses by salary within each ward.
   Ranking starts from 1 for every ward.
   ============================================================ */

SELECT
    n.Name AS NurseName,
    w.Name AS WardName,
    n.Salary,
    RANK() OVER (
        PARTITION BY n.ServesInWardId
        ORDER BY n.Salary DESC
    ) AS SalaryRank
FROM Nurses n
LEFT JOIN Wards w
    ON n.ServesInWardId = w.Id;
GO


/* ============================================================
   QUESTION 34
   Assign a unique row number to nurses based on salary
   within each ward.
   ============================================================ */

SELECT
    n.Name AS NurseName,
    w.Name AS WardName,
    n.Salary,
    ROW_NUMBER() OVER (
        PARTITION BY n.ServesInWardId
        ORDER BY n.Salary DESC
    ) AS RowNumber
FROM Nurses n
LEFT JOIN Wards w
    ON n.ServesInWardId = w.Id;
GO


/* ============================================================
   QUESTION 35
   Assign a dense salary rank to nurses within each ward.
   Nurses with the same salary have the same rank.
   ============================================================ */

SELECT
    n.Name AS NurseName,
    w.Name AS WardName,
    n.Salary,
    DENSE_RANK() OVER (
        PARTITION BY n.ServesInWardId
        ORDER BY n.Salary DESC
    ) AS SalaryRank
FROM Nurses n
LEFT JOIN Wards w
    ON n.ServesInWardId = w.Id;
GO


/* ============================================================
   QUESTION 36
   Divide nurses in each ward into two salary groups.
   ============================================================ */

SELECT
    n.Name AS NurseName,
    w.Name AS WardName,
    n.Salary,
    NTILE(2) OVER (
        PARTITION BY n.ServesInWardId
        ORDER BY n.Salary DESC
    ) AS SalaryGroup
FROM Nurses n
LEFT JOIN Wards w
    ON n.ServesInWardId = w.Id;
GO


/* ============================================================
   QUESTION 37
   Display every nurse together with their ward and salary
   rank within that ward.
   ============================================================ */

SELECT
    n.Name AS NurseName,
    w.Name AS WardName,
    n.Salary,
    RANK() OVER (
        PARTITION BY n.ServesInWardId
        ORDER BY n.Salary DESC
    ) AS SalaryRank
FROM Nurses n
LEFT JOIN Wards w
    ON n.ServesInWardId = w.Id;
GO


/* ============================================================
   QUESTION 38
   Display every patient, their ward, and salary rank of the
   consultant who examined them among all consultants.
   ============================================================ */

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
SELECT
    p.Name AS PatientName,
    w.Name AS WardName,
    cr.Name AS ConsultantName,
    cr.SalaryRank
FROM Patients p
LEFT JOIN Wards w
    ON p.WardId = w.Id
LEFT JOIN PatientExaminations pe
    ON p.Id = pe.PatientId
LEFT JOIN ConsultantRanks cr
    ON pe.ConsultantId = cr.Id;
GO


/* ============================================================
   QUESTION 39
   Display every patient, nurse who administered their
   medication, drug dosage, and nurse salary rank within
   their ward.
   ============================================================ */

WITH NurseRanks AS
(
    SELECT
        Number,
        Name,
        ServesInWardId,
        Salary,
        RANK() OVER (
            PARTITION BY ServesInWardId
            ORDER BY Salary DESC
        ) AS SalaryRank
    FROM Nurses
)
SELECT
    p.Name AS PatientName,
    nr.Name AS NurseName,
    da.Dosage,
    nr.SalaryRank
FROM Patients p
LEFT JOIN DrugAdministrations da
    ON p.Id = da.PatientId
LEFT JOIN NurseRanks nr
    ON da.NurseId = nr.Number;
GO