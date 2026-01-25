<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.realestate.model.Inquiry" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2>Buyer Inquiries</h2>

<table border="1" cellpadding="10" width="100%">
    <tr>
        <th>Property</th>
        <th>Buyer</th>
        <th>Message</th>
        <th>Status</th>
        <th>Action</th>
    </tr>

<%
List<Inquiry> inquiries = (List<Inquiry>) request.getAttribute("inquiries");

for (Inquiry i : inquiries) {
%>
<tr>
    <td><%= i.getProperty().getTitle() %></td>
    <td><%= i.getSender().getName() %></td>
    <td><%= i.getMessage() %></td>
    <td><%= i.getStatus() %></td>

    <td>
        <% if ("NEW".equals(i.getStatus())) { %>
            <form method="post" style="display:inline">
                <input type="hidden" name="inquiryId" value="<%= i.getInquiryId() %>">
                <input type="hidden" name="status" value="RESPONDED">
                <button>Mark Responded</button>
            </form>
        <% } %>

        <form method="post" style="display:inline">
            <input type="hidden" name="inquiryId" value="<%= i.getInquiryId() %>">
            <input type="hidden" name="status" value="CLOSED">
            <button>Close</button>
        </form>
    </td>
</tr>
<%
}
%>
</table>

</body>
</html>