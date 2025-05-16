-- Drop tables if they exist for clean re-run
DROP TABLE IF EXISTS BookCategories;
DROP TABLE IF EXISTS BookAuthors;
DROP TABLE IF EXISTS Loans;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Authors;
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS Categories;

-- Authors Table
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Bio TEXT
);

-- Categories Table
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE
);

-- Books Table
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    ISBN VARCHAR(20) NOT NULL UNIQUE,
    Publisher VARCHAR(100),
    YearPublished YEAR
);

-- Members Table
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15),
    MembershipDate DATE NOT NULL
);

-- BookAuthors (M-M between Books and Authors)
CREATE TABLE BookAuthors (
    BookID INT NOT NULL,
    AuthorID INT NOT NULL,
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE
);

-- BookCategories (M-M between Books and Categories)
CREATE TABLE BookCategories (
    BookID INT NOT NULL,
    CategoryID INT NOT NULL,
    PRIMARY KEY (BookID, CategoryID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE CASCADE
);

-- Loans Table
CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    LoanDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
    CONSTRAINT UniqueLoan UNIQUE (MemberID, BookID, LoanDate) -- no duplicate loans for same book on same date by same member
);
