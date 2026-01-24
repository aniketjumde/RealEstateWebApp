<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.realestate.model.Property" %>
<%@ page import="com.realestate.enums.PropertyVerificationStatus" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>
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


<body>

<%
List<Property> properties = (List<Property>) request.getAttribute("properties");
%>

<h2>My Properties</h2>

<table border="1">
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
        <% if (p.getVerification() != PropertyVerificationStatus.APPROVED) { %>
            <a href="property-edit?id=<%= p.getId() %>">Edit</a>
        <% } %>
        <a href="property-delete?id=<%= p.getId() %>"
           onclick="return confirm('Delete property?')">Delete</a>
    </td>
</tr>
<% } %>
</table>

</body>
</html>