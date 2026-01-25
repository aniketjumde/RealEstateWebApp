<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.realestate.model.User" %>

<%
    User loggedUser = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RealEstate</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<style>
    .navbar-brand {
        font-weight: bold;
        color: #0d6efd;
    }
</style>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
  <div class="container">

    <!-- Logo -->
    <a class="navbar-brand" href="index.jsp">🏠 RealEstate</a>

    <!-- Mobile Toggle -->
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
      data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <!-- Menu -->
    <div class="collapse navbar-collapse" id="navbarNav">

      <!-- Center Menu -->
      <ul class="navbar-nav mx-auto">
        <li class="nav-item">
          <a class="nav-link" href="index.jsp">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="property">Properties</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="about.jsp">About</a>
        </li>
      </ul>

      <!-- Right Side -->
      <ul class="navbar-nav ms-auto">

        <% if (loggedUser == null) { %>
          <!-- Guest -->
          <li class="nav-item">
            <a class="nav-link" href="login.jsp">Login</a>
          </li>
          <li class="nav-item">
            <a class="btn btn-primary ms-2" href="register.jsp">Register</a>
          </li>

        <% } else { %>
          <!-- Logged User -->
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button"
               data-bs-toggle="dropdown">
               👤 <%= loggedUser.getName() %>
            </a>
            <ul class="dropdown-menu dropdown-menu-end">
              <li><a class="dropdown-item" href="dashboard">Dashboard</a></li>
              <li><a class="dropdown-item" href="profile.jsp">Profile</a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item text-danger" href="logout">Logout</a></li>
            </ul>
          </li>
        <% } %>

      </ul>

    </div>
  </div>
</nav>

</body>
</html>
