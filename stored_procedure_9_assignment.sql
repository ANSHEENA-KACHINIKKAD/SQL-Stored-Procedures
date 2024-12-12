use entri_d42;
CREATE TABLE Worker (
    Worker_Id INT PRIMARY KEY,
    FirstName CHAR(25),
    LastName CHAR(25),
    Salary INT(15),
    JoiningDate DATETIME,
    Department CHAR(25)
);
select* from Worker;
INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department)
VALUES
    (1, 'Alice', 'Johnson', 50000, '2023-11-22', 'IT'),
    (2, 'Bob', 'Smith', 60000, '2023-12-01', 'HR'),
    (3, 'Charlie', 'Brown', 45000, '2023-10-15', 'Finance'),
    (4, 'David', 'Lee', 55000, '2023-09-20', 'Marketing'),
    (5, 'Emily', 'Davis', 62000, '2023-11-05', 'Sales'),
    (6, 'Frank', 'Wilson', 48000, '2023-12-10', 'IT'),
    (7, 'Grace', 'Miller', 58000, '2023-10-25', 'HR'),
    (8, 'Henry', 'Taylor', 52000, '2023-11-18', 'Finance'),
    (9, 'Isabella', 'Anderson', 65000, '2023-12-05', 'Marketing'),
    (10, 'Jack', 'Harris', 49000, '2023-11-10', 'Sales');
    
-- stored procedure with IN parameter
DELIMITER $$
create procedure insert_worker(IN 
    Worker_Id INT ,
    FirstName varchar(25),
    LastName varchar(25),
    Salary INT,
    JoiningDate DATETIME,
    Department varchar(25) )
begin
INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department)
    VALUES (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department);
 SELECT * FROM Worker WHERE Worker_Id = Worker_Id;
end $$
Delimiter ;
-- procedure call
CALL  insert_worker(11, 'Kevin', 'Garcia', 55000, '2024-01-01', 'IT'); --  ------------------------------ (1)
-- ----------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$
CREATE PROCEDURE GetWorkerSalary(
    IN p_Worker_Id INT,
    OUT p_Salary INT
)
BEGIN
    SELECT Salary INTO p_Salary
    FROM Worker
    WHERE Worker_Id = p_Worker_Id;
    
END $$
DELIMITER ;
CALL GetWorkerSalary(1, @Salary);
SELECT @Salary AS Worker_Salary;
-- ------------------------------------------------------------------------- (2)
DELIMITER $$
CREATE PROCEDURE UpdateWorkerDepartment(
    IN p_Worker_Id INT,
    IN p_NewDepartment VARCHAR(25)
)
BEGIN
    UPDATE Worker
    SET Department = p_NewDepartment
    WHERE Worker_Id = p_Worker_Id;
END $$
DELIMITER ;

-- Call the procedure
CALL UpdateWorkerDepartment(1, 'Sales'); 
select Worker_Id,Department from Worker ;
-- -------------------------------------------------------------------------- (3)
DELIMITER $$
CREATE PROCEDURE GetWorkerCountByDepartment(
    IN p_Department VARCHAR(25),
    OUT p_WorkerCount INT
)
BEGIN
    SELECT COUNT(*) INTO p_WorkerCount
    FROM Worker
    WHERE Department = p_Department;
    
END $$
DELIMITER ;

-- Call the procedure
CALL GetWorkerCountByDepartment('IT', @workerCount);
SELECT @workerCount AS WorkerCount;

-- ----------------------------------------------------------- (4)
DELIMITER $$
CREATE PROCEDURE GetAverageSalaryByDepartment(
    IN p_Department VARCHAR(25),
    OUT p_AvgSalary DECIMAL(10,2)
)
BEGIN
    SELECT AVG(Salary) INTO p_AvgSalary
    FROM Worker
    WHERE Department = p_Department;
    
END $$
DELIMITER ;

-- Call the procedure
CALL GetAverageSalaryByDepartment('IT', @avgSalary);
SELECT @avgSalary AS AverageSalary;
-- --------------------------------------------------------------------------- (5)
 
