<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.realestate.model.Property" %>
<%@ page import="com.realestate.enums.PropertyVerificationStatus" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Properties</title>

<!-- SweetAlert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f9fafb;
    padding: 20px;
}

h2 {
    margin-bottom: 15px;
}

table {
    width: 100%;
    border-collapse: collapse;
    background-color: #ffffff;
}

th, td {
    border: 1px solid #d1d5db;
    padding: 10px;
    text-align: left;
}

th {
    background-color: #2563eb;
    color: white;
}

tr:nth-child(even) {
    background-color: #f3f4f6;
}

a {
    text-decoration: none;
    margin-right: 10px;
    font-weight: bold;
    color: #2563eb;
}

a:hover {
    text-decoration: underline;
}

.delete-link {
    color: #dc2626;
}

.no-data {
    padding: 10px;
    background-color: #fff3cd;
    border: 1px solid #ffeeba;
    width: fit-content;
}
</style>
</head>

<body>

<!-- ✅ Success Message -->
<%
String msg = (String) session.getAttribute("successMessage");
if (msg != null) {
%>
<script>
Swal.fire({
    icon: 'success',
    title: 'Success',
    text: '<%= msg %>',
    confirmButtonColor: '#16a34a'
});
</script>
<%
session.removeAttribute("successMessage");
}
%>

<h2>My Properties</h2>

<%
List<Property> properties = (List<Property>) request.getAttribute("properties");
%>

<% if (properties == null || properties.isEmpty()) { %>

    <div class="no-data">No properties found.</div>

<% } else { %>

<table>
    <tr>
        <th>Title</th>
        <th>Price</th>
        <th>City</th>
        <th>Status</th>
        <th>Verification</th>
        <th>Actions</th>
    </tr>

    <% for(Property p : properties) { %>
    <tr>
        <td><%= p.getTitle() %></td>
        <td>₹ <%= p.getPrice() %></td>
        <td><%= p.getCity() %></td>
        <td><%= p.getPropetystatus() %></td>
        <td><%= p.getVerification() %></td>
        <td>
           
                <a href="property-edit?id=<%= p.getId() %>">Edit</a>
          

            <a href="property-delete?id=<%= p.getId() %>"
               class="delete-link"
               onclick="return confirm('Delete property?')">
               Delete
            </a>
        </td>
    </tr>
    <% } %>
</table>

<% } %>

</body>
</html>
