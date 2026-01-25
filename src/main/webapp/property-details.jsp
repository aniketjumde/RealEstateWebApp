<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.realestate.model.Property" %>
<%@ page import="com.realestate.model.User" %>
<%@ page import="com.realestate.enums.PropertyVerificationStatus" %>


<%
Property property = (Property) request.getAttribute("property");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	.inquiry-box {
    margin-top: 20px;
    padding: 15px;
    background: #f9fafb;
    border-radius: 8px;
}

.inquiry-box textarea {
    width: 100%;
    padding: 8px;
}
	
</style>
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


<%
User loggedUser = (User) session.getAttribute("user");
boolean canInquire =
    loggedUser != null &&
    !property.getUser().getId().equals(loggedUser.getId()) &&
    property.getVerification() == PropertyVerificationStatus.APPROVED;
%>

<% if (canInquire) { %>

<div class="inquiry-box">
    <h3>Contact Owner</h3>

    <form action="send-inquiry" method="post">
        <input type="hidden" name="propertyId" value="<%= property.getId() %>">

        <textarea name="message" rows="4"
                  placeholder="Write your message..."
                  required></textarea>

        <button type="submit">Send Inquiry</button>
    </form>
</div>

<% } else if (loggedUser == null) { %>

<p>
    <a href="login.jsp">Login</a> to contact the owner
</p>

<% } %>

<a href="property">⬅ Back to list</a>

</body>
</html>