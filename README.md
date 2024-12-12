# SQL-Stored-Procedures
This repository contains SQL scripts for creating a Worker table and various stored procedures to perform operations on the table.

## Table Structure:

    CREATE TABLE Worker (
    Worker_Id INT PRIMARY KEY,
    FirstName CHAR(25),
    LastName CHAR(25),
    Salary INT(15),
    JoiningDate DATETIME,
    Department CHAR(25)
    );

## Stored Procedures:
  ## Work1:
  Create a stored procedure that takes in IN parameters for all the columns in the Worker table and adds a new record to the table and then invokes the procedure call.

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
    CALL  insert_worker(11, 'Kevin', 'Garcia', 55000, '2024-01-01', 'IT');
    
  ## Work2:
  Write stored procedure takes in an IN parameter for WORKER_ID and an OUT parameter for SALARY. It should retrieve the salary of the worker with the given ID and returns it in the p_salary parameter. 
  Then make the procedure call
  
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

 ## Work3:
 Create a stored procedure that takes in IN parameters for WORKER_ID and DEPARTMENT. It should update the department of the worker with the given ID. Then make a procedure call.

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

  ## Work4:
  Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter for p_workerCount. It should retrieve the number of workers in the given department and returns it in the 
  p_workerCount parameter. Make procedure call.

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

  ## Work5:
  Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter for p_avgSalary. It should retrieve the average salary of all workers in the given department and returns it 
  in the p_avgSalary parameter and call the procedure.

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
    


  
  
