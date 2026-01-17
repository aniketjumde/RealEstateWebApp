<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Property Listings</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <h1>Property Listings</h1>
        
        <!-- Search Form -->
        <form action="${pageContext.request.contextPath}/properties/search" method="get" class="search-form">
            <input type="text" name="city" placeholder="City" value="${searchCity}">
            <select name="type">
                <option value="">All Types</option>
                <option value="apartment" ${searchType == 'apartment' ? 'selected' : ''}>Apartment</option>
                <option value="house" ${searchType == 'house' ? 'selected' : ''}>House</option>
                <option value="villa" ${searchType == 'villa' ? 'selected' : ''}>Villa</option>
            </select>
            <input type="number" name="minBedrooms" placeholder="Min Bedrooms" value="${searchBedrooms}">
            <button type="submit">Search</button>
            <a href="${pageContext.request.contextPath}/properties" class="btn">Clear</a>
        </form>
        
        <a href="${pageContext.request.contextPath}/properties/new" class="btn btn-primary">Add New Property</a>
        
        <table class="property-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Type</th>
                    <th>Purpose</th>
                    <th>Price</th>
                    <th>Bedrooms</th>
                    <th>City</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="property" items="${properties}">
                    <tr>
                        <td>${property.propertyId}</td>
                        <td>${property.title}</td>
                        <td>${property.propertyType}</td>
                        <td>${property.purpose}</td>
                        <td>$${property.price}</td>
                        <td>${property.bedrooms}</td>
                        <td>${property.city}</td>
                        <td>
                            <span class="status-${property.status}">${property.status}</span>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/properties/view?id=${property.propertyId}" class="btn btn-view">View</a>
                            <a href="${pageContext.request.contextPath}/properties/edit?id=${property.propertyId}" class="btn btn-edit">Edit</a>
                            <a href="${pageContext.request.contextPath}/properties/delete?id=${property.propertyId}" 
                               class="btn btn-delete" 
                               onclick="return confirm('Are you sure you want to delete this property?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <c:if test="${empty properties}">
            <p class="no-data">No properties found.</p>
        </c:if>
    </div>
</body>
</html>