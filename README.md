## Problem Statement

Many hospitals face scheduling inefficiencies, leading to long patient wait times and underutilized resources. A digital scheduling system can optimize doctor availability, reduce overcrowding, and streamline the appointment process

## Overview

The **Healthcare App** is a web-based application designed to manage patient information, diseases, and treatment details efficiently. It provides a user-friendly interface for doctors to view and manage patient records, appointments, and disease-related data.

## Features
- **User Authentication**: Secure login and session management.
- **Disease Management**: View, add, and update diseases along with symptoms, medicines, and treatments.
- **Appointment Scheduling**: Manage patient appointments efficiently.
- **Bootstrap UI**: Responsive design with a clean and modern layout.
- **MySQL Database**: Stores patient and disease-related information securely.

## Technologies Used
- **Frontend**: HTML, CSS, Bootstrap
- **Backend**: Java, JSP, Servlets
- **Database**: MySQL
- **Server**: Apache Tomcat

## Setup Instructions
### Prerequisites
1. Install [Java JDK](https://www.oracle.com/java/technologies/javase-downloads.html)
2. Install [Apache Tomcat](https://tomcat.apache.org/)
3. Install [MySQL Server](https://dev.mysql.com/downloads/installer/)
4. Install Git (if not already installed)

### Clone the Repository
```sh
git clone https://github.com/Vineetrajput09/Problem_Statement2_VineetRajput.git
cd Problem_Statement2_VineetRajput
```

### Database Configuration
1. Open MySQL and create a database:
```sql
CREATE DATABASE Hackathon;
USE Hackathon;
```
2. Import the database schema:
```sql
CREATE TABLE diseases (
    id INT AUTO_INCREMENT PRIMARY KEY,
    disease VARCHAR(50) NOT NULL UNIQUE,
    symptoms_1 VARCHAR(50) NOT NULL,
    symptoms_2 VARCHAR(50) NOT NULL,
    symptoms_3 VARCHAR(50) NOT NULL,
    medicine VARCHAR(50) NOT NULL,
    treatment VARCHAR(200) DEFAULT NULL,
    notes VARCHAR(200) DEFAULT NULL
);
```

### Configure and Run the Project
1. Open the project in an IDE (vscode ,Eclipse, IntelliJ IDEA, or NetBeans).
2. Configure Apache Tomcat as the server.
3. Update database details with your MySQL credentials.
4. Deploy the project on Tomcat and start the server.
5. Access the application at: `http://localhost:8080/Hackathon/`

## Usage
- **Doctors** can log in and manage disease data and look the appointment.
- **Admin** can add new diseases and manage the database.
- **Patients** can book appointments and view disease information.

## Contribution
Feel free to contribute by:
- Reporting bugs
- Suggesting new features
- Improving UI/UX.

## Contact
For any queries, reach out to vineetrajput7902@gmail.com

