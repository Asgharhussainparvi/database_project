-- Drop tables if they exist
DROP TABLE Payments CASCADE CONSTRAINTS;
DROP TABLE Tickets CASCADE CONSTRAINTS;
DROP TABLE Events CASCADE CONSTRAINTS;
DROP TABLE Venues CASCADE CONSTRAINTS;
DROP TABLE Users CASCADE CONSTRAINTS;

-- Create Users table
CREATE TABLE Users (
    UserID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Email VARCHAR2(100) UNIQUE NOT NULL,
    Password VARCHAR2(255) NOT NULL,
    Role VARCHAR2(10) DEFAULT 'User'
);

-- Create Venues table
CREATE TABLE Venues (
    VenueID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Location VARCHAR2(200),
    Capacity NUMBER NOT NULL
);

-- Create Events table
CREATE TABLE Events (
    EventID NUMBER PRIMARY KEY,
    Title VARCHAR2(150) NOT NULL,
    Description VARCHAR2(1000),
    EventDate DATE NOT NULL,
    EventTime VARCHAR2(10) NOT NULL,
    VenueID NUMBER,
    FOREIGN KEY (VenueID) REFERENCES Venues(VenueID)
);

-- Create Tickets table
CREATE TABLE Tickets (
    TicketID NUMBER PRIMARY KEY,
    EventID NUMBER,
    UserID NUMBER,
    SeatNo VARCHAR2(10),
    TicketType VARCHAR2(20),
    Price NUMBER(8, 2) NOT NULL,
    Status VARCHAR2(20) DEFAULT 'Booked',
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Create Payments table
CREATE TABLE Payments (
    PaymentID NUMBER PRIMARY KEY,
    UserID NUMBER,
    Amount NUMBER(10, 2) NOT NULL,
    PaymentMethod VARCHAR2(20),
    PaymentTime DATE DEFAULT SYSDATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
