<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.realestate.model.Property" %>
<%@ page import="com.realestate.model.User" %>

<%
    User user = (User) session.getAttribute("user");
    List<Property> properties = (List<Property>) request.getAttribute("properties");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RealEstate | Home</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
/* HERO */
.hero {
    background: linear-gradient(to right, #0f766e, #115e59);
    color: white;
    padding: 70px 0;
}

/* PROPERTY CARD */
.property-card img {
    height: 200px;
    object-fit: cover;
}

.property-card {
    transition: transform 0.2s;
}
.property-card:hover {
    transform: translateY(-5px);
}
</style>
</head>

<body>

<!-- ================= NAVBAR ================= -->
<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
  <div class="container">
    <a class="navbar-brand fw-bold" href="home">🏠 RealEstate</a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto align-items-center">
        <li class="nav-item"><a class="nav-link" href="home">Home</a></li>
        <li class="nav-item"><a class="nav-link" href="property">Properties</a></li>

        <% if (user == null) { %>
            <li class="nav-item">
                <a class="nav-link btn btn-outline-primary px-3 ms-2" href="login.jsp">
                    Login
                </a>
            </li>
        <% } else { %>
            <li class="nav-item">
                <a class="nav-link" href="dashboard">Dashboard</a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-danger" href="logout">Logout</a>
            </li>
        <% } %>
      </ul>
    </div>
  </div>
</nav>

<!-- ================= HERO SECTION ================= -->
<section class="hero text-center">
  <div class="container">
    <h1 class="fw-bold mb-3">Find Your Dream Property</h1>
    <p class="lead">Buy • Sell • Rent verified properties</p>

    <!-- SEARCH BAR -->
    <form class="row g-2 justify-content-center mt-4" action="property-search" method="get">
      <div class="col-md-3">
        <input type="text" name="city" class="form-control" placeholder="City">
      </div>

      <div class="col-md-3">
        <select name="type" class="form-control">
          <option value="">Property Type</option>
          <option>House</option>
          <option>Apartment</option>
          <option>Villa</option>
          <option>Plot</option>
        </select>
      </div>

      <div class="col-md-2">
        <button class="btn btn-warning w-100 fw-bold">Search</button>
      </div>
    </form>
  </div>
</section>

<!-- ================= FEATURED PROPERTIES ================= -->
<div class="container my-5">

  <div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold">Featured Properties</h3>

    <% if (user != null) { %>
        <a href="add-property.jsp" class="btn btn-success">
            + Add Property
        </a>
    <% } %>
  </div>

  <% if (properties == null || properties.isEmpty()) { %>
      <p class="text-muted">No properties available right now.</p>
  <% } else { %>

  <div class="row g-4">

    <% for (Property p : properties) { %>
    <div class="col-md-4">
      <div class="card property-card shadow-sm">

        <!-- PROPERTY IMAGE -->
        <%
            if (p.getImages() != null && !p.getImages().isEmpty()) {
        %>
            <img src="property-image?id=<%= p.getImages().get(0).getImageId() %>"
                 class="card-img-top">
        <%
            } else {
        %>
            <img src="default.jpg" class="card-img-top">
        <%
            }
        %>

        <!-- CARD BODY -->
        <div class="card-body">
          <h5 class="card-title"><%= p.getTitle() %></h5>
          <p class="text-muted mb-1"><%= p.getCity() %>, <%= p.getState() %></p>

          <p class="mb-2">
            ₹ <strong><%= p.getPrice() %></strong>
            &nbsp;•&nbsp; <%= p.getBedrooms() %> Beds
            &nbsp;•&nbsp; <%= p.getBathrooms() %> Bath
          </p>

          <a href="property-details?id=<%= p.getId() %>"
             class="btn btn-outline-primary w-100">
             View Details
          </a>
        </div>
      </div>
    </div>
    <% } %>

  </div>
  <% } %>
</div>

<!-- ================= FOOTER ================= -->
<footer class="bg-dark text-white text-center py-3 mt-5">
  © 2026 RealEstate | All Rights Reserved
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
