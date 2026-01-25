<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.realestate.model.Property" %>

<!DOCTYPE html>
<html>
<head>
<title>Property Approval</title>

<style>
body{font-family:Arial;background:#f4f6f8;}
table{
    width:95%;
    margin:20px auto;
    border-collapse:collapse;
    background:#fff;
}
th,td{
    padding:12px;
    border-bottom:1px solid #eee;
    text-align:left;
}
th{background:#f1f5f9;}
button{
    padding:6px 12px;
    border:none;
    border-radius:6px;
    cursor:pointer;
}
.approve{background:#16a34a;color:#fff;}
.reject{background:#dc2626;color:#fff;}
</style>
</head>

<body>

<h2 style="padding-left:30px;">Pending Property Approvals</h2>

<table>
<tr>
    <th>Title</th>
    <th>Owner</th>
    <th>City</th>
    <th>Price</th>
    <th>Action</th>
</tr>

<%
List<Property> properties =
    (List<Property>) request.getAttribute("pendingProperties");

if (properties == null || properties.isEmpty()) {
%>
    <tr>
        <td colspan="5">No pending properties</td>
    </tr>
<%
} 
else {
	for(Property p : properties){
%>
<tr>
    <td><%= p.getTitle() %></td>
    <td><%= p.getUser().getName() %></td>
    <td><%= p.getCity() %></td>
    <td>₹ <%= p.getPrice() %></td>

    <td>
        <form action="property-approval" method="post" style="display:inline;">
            <input type="hidden" name="propertyId" value="<%= p.getId() %>">
            <input type="hidden" name="action" value="APPROVE">
            <button class="approve">Approve</button>
        </form>

        <form action="property-approval" method="post" style="display:inline;">
            <input type="hidden" name="propertyId" value="<%= p.getId() %>">
            <input type="hidden" name="action" value="REJECT">
            <button class="reject">Reject</button>
        </form>
    </td>
</tr>
<%
	}	
}
%>

</table>

</body>
</html>
