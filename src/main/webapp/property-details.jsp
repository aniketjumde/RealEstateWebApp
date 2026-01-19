<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.realestate.model.Property" %>

<%
Property property = (Property) request.getAttribute("property");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

h2><%= property.getTitle() %></h2>

<!-- Images -->
<%
if (property.getImages() != null && !property.getImages().isEmpty()) {
%>
    <img src="property-image?id=<%= property.getImages().get(0).getImageId() %>"
         width="400">
<%
}
%>

<p><b>Price:</b> ₹ <%= property.getPrice() %></p>
<p><b>City:</b> <%= property.getCity() %></p>
<p><b>Type:</b> <%= property.getPropertyType() %></p>

<p><b>Description:</b></p>
<p><%= property.getDescription() %></p>

<p>
    🛏 <%= property.getBedrooms() %> |
    🛁 <%= property.getBathrooms() %> |
    📐 <%= property.getAreaSqarefit() %> sqft
</p>

<p><b>Owner:</b> <%= property.getUser().getName() %></p>

<a href="property">⬅ Back to list</a>

</body>
</html>