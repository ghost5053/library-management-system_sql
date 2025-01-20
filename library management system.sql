CREATE DATABASE library;
USE library;
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
(1, 101, '123 Main St, City A', '1234567890'),
(2, 102, '456 Elm St, City B', '0987654321'),
(3, 103, '789 Pine St, City C', '1122334455'),
(4, 104, '101 Maple Ave, City D', '5566778899'),
(5, 105, '202 Birch Ln, City E', '6677889900');
select * from branch;
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(100),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES
(101, 'Alice', 'Manager', 75000, 1),
(102, 'Bob', 'Manager', 72000, 2),
(103, 'Charlie', 'Manager', 71000, 3),
(104, 'David', 'Librarian', 40000, 1),
(105, 'Eve', 'Assistant Librarian', 35000, 2),
(106, 'Frank', 'Clerk', 30000, 3),
(107, 'Grace', 'Clerk', 28000, 1),
(108, 'Hank', 'Librarian', 42000, 2),
(109, 'Ivy', 'Assistant Librarian', 36000, 4),
(110, 'Jake', 'Clerk', 29000, 5),
(111, 'Karen', 'Manager', 73000, 4),
(112, 'Leo', 'Assistant Librarian', 34500, 5);
select * from employee;
CREATE TABLE Books (
    ISBN INT PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3),
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES

(1006, 'Introduction to Biology', 'Science', 20, 'yes', 'Laura Brown', 'Oxford'),
(1007, 'The Renaissance', 'History', 45, 'yes', 'Thomas Green', 'Penguin'),
(1008, 'Painting 101', 'Art', 30, 'no', 'Samantha Blue', 'Harper Collins'),
(1009, 'Quantum Mechanics', 'Science', 60, 'yes', 'Michael Red', 'Springer'),
(1010, 'Medieval Europe', 'History', 28, 'yes', 'Richard Black', 'Penguin'),
(1011, 'Digital Marketing', 'Business', 55, 'yes', 'Amy White', 'McGraw Hill'),
(1012, 'Startup Culture', 'Business', 48, 'no', 'Chris Yellow', 'Harvard Press'),
(1013, 'Graphic Design Basics', 'Art', 35, 'yes', 'Evan Gray', 'Oxford'),
(1014, 'Robotics in Practice', 'Technology', 75, 'yes', 'Nina Violet', 'Springer'),
(1015, 'Artificial Intelligence', 'Technology', 85, 'no', 'Mark Cyan', 'Springer');

select * from books;
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
(1, 'John Carter', '12 Oak St, City A', '2021-12-15'),
(2, 'Sarah Connor', '34 Maple St, City B', '2022-03-10'),
(3, 'Michael Scott', '56 Birch Ln, City A', '2023-01-20'),
(4, 'Dwight Schrute', '78 Willow Dr, City B', '2021-11-22'),
(5, 'Pam Beesly', '90 Aspen St, City C', '2022-12-01'),
(6, 'Jim Halpert', '101 Cedar Ln, City D', '2023-05-14'),
(7, 'Angela Martin', '123 Poplar St, City E', '2022-08-19'),
(8, 'Oscar Martinez', '145 Elm St, City A', '2022-06-15'),
(9, 'Kevin Malone', '167 Maple Ave, City B', '2023-03-08'),
(10, 'Ryan Howard', '189 Pine St, City C', '2021-10-30');
select * from customer;
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust_id INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust_id) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
INSERT INTO IssueStatus (Issue_Id, Issued_cust_id, Issued_book_name, Issue_date, Isbn_book)
VALUES
(1, 3, 'Modern Art', '2023-06-05', 1003),
(2, 5, 'History of the World', '2023-06-15', 1001),
(3, 6, 'World War II', '2023-06-20', 1005),
(4, 7, 'Painting 101', '2023-06-25', 1008),
(5, 9, 'Medieval Europe', '2023-06-10', 1010),
(6, 4, 'The Renaissance', '2023-07-01', 1007),
(7, 8, 'Digital Marketing', '2023-07-05', 1011);
select * from issuestatus;
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
(1, 3, 'Modern Art', '2023-06-10', 1003),
(2, 5, 'History of the World', '2023-06-20', 1001),
(3, 6, 'World War II', '2023-06-25', 1005),
(4, 7, 'Painting 101', '2023-06-30', 1008),
(5, 9, 'Medieval Europe', '2023-07-01', 1010),
(6, 4, 'The Renaissance', '2023-07-05', 1007);
select * from ReturnStatus;

# 1. Retrieve the book title, category, and rental price of all available books.
SELECT Book_title, Category, Rental_Price 
FROM Books 
WHERE Status = 'yes';
# 2. List the employee names and their respective salaries in descending order of salary.
SELECT Emp_name, Salary 
FROM Employee 
ORDER BY Salary DESC;
#3. Retrieve the book titles and the corresponding customers who have issued those books.
SELECT B.Book_title, C.Customer_name 
FROM Books B
JOIN IssueStatus I ON B.ISBN = I.Isbn_book
JOIN Customer C ON I.Issued_cust_id = C.Customer_Id;
#4. Display the total count of books in each category.
SELECT Category, COUNT(*) AS Total_Books 
FROM Books 
GROUP BY Category;
#5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT Emp_name, Position 
FROM Employee 
WHERE Salary > 50000;
#6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_name 
FROM Customer C
WHERE Reg_date < '2022-01-01' 
  AND NOT EXISTS (
      SELECT 1 
      FROM IssueStatus I 
      WHERE I.Issued_cust_id = C.Customer_Id
  );
#7. Display the branch numbers and the total count of employees in each branch.
SELECT Branch_no, COUNT(*) AS Total_Employees 
FROM Employee 
GROUP BY Branch_no;
#8. Display the names of customers who have issued books in the month of June 2023.
SELECT DISTINCT C.Customer_name 
FROM Customer C
JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust_id
WHERE Issue_date BETWEEN '2023-06-01' AND '2023-06-30';
#9. Retrieve book_title from Books table containing the keyword "history".
SELECT Book_title 
FROM Books 
WHERE Book_title LIKE '%history%';
#10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
SELECT Branch_no, COUNT(*) AS Total_Employees 
FROM Employee 
GROUP BY Branch_no 
HAVING COUNT(*) > 5;
#11. Retrieve the names of employees who manage branches and their respective branch addresses.
SELECT E.Emp_name, B.Branch_address 
FROM Employee E
JOIN Branch B ON E.Emp_Id = B.Manager_Id;
#12. Display the names of customers who have issued books with a rental price higher than Rs. 25.
SELECT DISTINCT C.Customer_name 
FROM Customer C
JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust_id
JOIN Books B ON I.Isbn_book = B.ISBN
WHERE B.Rental_Price > 25;

