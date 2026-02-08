# 🏡 RealEstate Web Application

A Java-based Real Estate Web Application developed to apply real-world concepts of
**Java, Hibernate, MySQL, JSP/Servlets, and MVC architecture**.
This project allows users to list, browse, and manage properties with
role-based access for **Admin, Seller, and Buyer**.

---

## 📌 Project Overview

The **RealEstate Web Application** is a full-stack Java web project designed to
digitize property listing and inquiry management.
It focuses on clean architecture, proper database relationships,
and practical implementation of enterprise Java concepts.

This project was built as a **learning-oriented real-world application**
to strengthen backend development skills and understand how
large-scale Java web applications are structured.

---

## 🎯 Purpose & Vision

- Apply Java and Hibernate concepts in a real-world scenario
- Understand MVC architecture using Servlets and JSP
- Practice database design and relationships using MySQL
- Implement role-based access control (Admin / Seller / Buyer)
- Build a maintainable and scalable Java web application

---

## 🧩 Key Features

### 👤 User Management
- User Registration & Login
- Firebase Authentication (for secure login)
- Role-based access (Admin, Seller, Buyer)
- Profile management with profile image

### 🏠 Property Management
- Add, edit, delete property listings
- Upload multiple property images
- Property verification workflow (Admin approval)
- View approved properties on home page
- Property status: Pending / Approved / Rejected

### 📩 Inquiry System
- Buyers can send inquiries to sellers
- Sellers can view received inquiries

### 🛠 Admin Panel
- View all users
- Change user roles
- Approve / reject properties
- Manage platform data securely

### 📊 Dashboard
- Unified dashboard for Buyer & Seller
- Property statistics
- Inquiry tracking
- Role-based dashboard views

---
## 🏗 Architecture & Design Patterns

### 🧱 MVC Architecture
- **Controller Layer** → Servlets  
- **Service Layer** → Business Logic  
- **DAO Layer** → Database Operations (Hibernate)  
- **View Layer** → JSP  

### 🏭 Design Patterns Used
- **Singleton Pattern** → Hibernate Utility (SessionFactory)
- **Factory Pattern** → Service Object Creation
- **Layered Architecture Pattern**
- **Role-Based Authorization using Filters**

---

## 📁 Project Structure
```
RealEstateWebApp
│
├── Deployment Descriptor
├── JAX-WS Web Services
│
├── Java Resources
│   └── src/main/java
│       └── com.realestate
│
│           ├── config              → Configuration Layer
│           │
│           ├── controller          → Servlet Layer (MVC Controller)
│           │
│           ├── dao                 → Data Access Layer 
│           │
│           ├── service             → Business Logic Layer
│           │
│           ├── factory             → Factory Design Pattern Layer
│           │
│           ├── model               → Entity Classes
│           │
│           ├── enums               → Enum Definitions
│           │
│           ├── filter              → Security / Authentication Layer
│           │
│           └── util                → Utility Classes (Singleton Helper)
│
├── src/main/resources
│   ├── Hibernate Configuration
│   └── Application Properties
│
├── src/main/webapp
│   ├── css                                                  
│   ├── admin                   → Admin Dashboard Pages
│   ├── user                    → User Dashboard Pages
│   ├── Public Pages            → Home / About
│
├── pom.xml                         → Maven Build Configuration
└── target                          → Compiled Output

```
----

## 🛠 Technology Stack

### Backend
- Java
- Servlets
- JSP
- Hibernate ORM
- MySQL
- Maven
- Apache Tomcat

### Frontend
- HTML5
- CSS3
- Bootstrap
- JavaScript
- SweetAlert
- Leaflet.js (Maps)

### Tools
- Eclipse / VS Code
- MySQL Workbench
- Postman
- Git & GitHub

---

## 🔐 Security Features

- Role-based authorization (Admin / User)
- Authentication Filter protection
- Safe deletion with foreign key handling
- Hibernate session management
- Secure login with Firebase

___

## 🚀 Learning Outcomes

- Practical understanding of **Hibernate ORM**
- Handling **foreign key constraints** and **cascading deletes**
- Session management and user authentication
- Implementation of **MVC architecture** using Servlets and JSP
- Admin workflows and **role-based access control**
- End-to-end development of a **complete Java web application**

---

## 👨‍💻 Developer

**Aniket Jumde**  

- GitHub: [https://github.com/aniketjumde](https://github.com/aniketjumde)




