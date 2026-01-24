<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.realestate.model.Property" %>
<%@ page import="com.realestate.model.User" %>
<%@ page import="com.realestate.enums.PropertyVerificationStatus" %>

<!DOCTYPE html>
<html>
<head>
<title>Properties</title>

<style>

body 
{
    font-family: Arial, sans-serif;
    background: #f8f9fa;
}

/* GRID */
.property-grid
{
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
    padding: 20px;
}

/* Tablet */
@media (max-width: 992px) {
    .property-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

/* Mobile */
@media (max-width: 576px) {
    .property-grid {
        grid-template-columns: 1fr;
    }
}

/* CARD */
.property-card {
    background: #fff;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 6px 20px rgba(0,0,0,0.1);
    transition: transform 0.2s;
    cursor: pointer;
}

.property-card:hover {
    transform: translateY(-5px);
}

/* IMAGE */
.property-image {
    position: relative;
    height: 200px;
}

.property-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.badge {
    position: absolute;
    top: 10px;
    left: 10px;
    background: #28a745;
    color: #fff;
    padding: 4px 10px;
    font-size: 12px;
    border-radius: 20px;
}

.price {
    position: absolute;
    bottom: 10px;
    left: 10px;
    color: white;
    font-size: 18px;
    font-weight: bold;
}

/* BODY */
.property-body {
    padding: 15px;
}

.property-title {
    font-size: 16px;
    font-weight: bold;
}

.property-city {
    color: #777;
    font-size: 13px;
    margin: 5px 0;
}

.property-meta {
    display: flex;
    justify-content: space-between;
    font-size: 13px;
    color: #555;
}

/* ACTIONS */
.property-actions {
    margin-top: 10px;
    padding-top: 8px;
    border-top: 1px solid #eee;
    display: flex;
    gap: 15px;
}

.property-actions a {
    text-decoration: none;
    font-weight: bold;
    font-size: 13px;
}

.property-actions a.delete {
    color: red;
}
</style>
</head>

<body>

<h2 style="padding-left:20px;">Properties</h2>

<%
List<Property> properties = (List<Property>) request.getAttribute("properties");
User loggedUser = (User) session.getAttribute("user");

if (properties == null || properties.isEmpty()) {
%>
    <p style="padding:20px;">No properties found</p>
<%
} else {
%>

<div class="property-grid">

<%
for (Property property : properties) {
%>

<div class="property-card"
     onclick="window.location.href='property-details?id=<%= property.getId() %>'">

    <!-- IMAGE -->
    <div class="property-image">
        <%
        if (property.getImages() != null && !property.getImages().isEmpty()) {
        %>
            <img src="property-image?id=<%= property.getImages().get(0).getImageId() %>">
        <%
        } else {
        %>
            <img src="default.jpg">
        <%
        }
        %>

        <div class="badge"><%= property.getPropetystatus() %></div>
        <div class="price">₹ <%= property.getPrice() %></div>
    </div>

    <!-- BODY -->
    <div class="property-body">

        <div class="property-title"><%= property.getTitle() %></div>
        <div class="property-city"><%= property.getCity() %></div>

        <div class="property-meta">
            <span>🛏 <%= property.getBedrooms() %></span>
            <span>🛁 <%= property.getBathrooms() %></span>
            <span><%= property.getAreaSqarefit() %> sqft</span>
        </div>

      


    </div>
</div>

<%
}
%>

</div>

<%
}
%>

</body>
</html>
