<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.realestate.model.Inquiry" %>

<!DOCTYPE html>
<html>
<head>
<title>My Inquiries</title>

<style>
body {
    font-family: Arial, sans-serif;
    background: #f4f6f8;
}

.container {
    max-width: 1100px;
    margin: 30px auto;
    background: #fff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

h2 {
    margin-bottom: 15px;
}

/* TABLE */
table {
    width: 100%;
    border-collapse: collapse;
}

th {
    background: #2563eb;
    color: white;
    padding: 12px;
    text-align: left;
}

td {
    padding: 12px;
    border-bottom: 1px solid #e5e7eb;
    vertical-align: top;
}

tr:hover {
    background: #f9fafb;
}

/* STATUS BADGES */
.status {
    padding: 4px 10px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: bold;
    display: inline-block;
}

.NEW {
    background: #fef3c7;
    color: #92400e;
}

.RESPONDED {
    background: #d1fae5;
    color: #065f46;
}

.CLOSED {
    background: #e5e7eb;
    color: #374151;
}

/* LINK */
a {
    color: #2563eb;
    text-decoration: none;
    font-weight: bold;
}

a:hover {
    text-decoration: underline;
}

/* EMPTY */
.empty {
    text-align: center;
    padding: 20px;
    color: #6b7280;
}
</style>

</head>
<body>

<div class="container">
    <h2>📩 My Inquiries</h2>

    <table>
        <tr>
            <th>Property</th>
            <th>Seller</th>
            <th>Message</th>
            <th>Status</th>
        </tr>

<%
List<Inquiry> inquiries = (List<Inquiry>) request.getAttribute("inquiries");

if (inquiries == null || inquiries.isEmpty()) {
%>
        <tr>
            <td colspan="4" class="empty">
                You have not sent any inquiries yet.
            </td>
        </tr>
<%
} else {
    for (Inquiry i : inquiries) {
%>
        <tr>
            <td>
                <a href="property-details?id=<%= i.getProperty().getId() %>">
                    <%= i.getProperty().getTitle() %>
                </a>
            </td>

            <td><%= i.getReceiver().getName() %></td>

            <td><%= i.getMessage() %></td>

            <td>
                <span class="status <%= i.getStatus() %>">
                    <%= i.getStatus() %>
                </span>
            </td>
        </tr>
<%
    }
}
%>

    </table>
</div>

</body>
</html>
