<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.realestate.model.User" %>
<%@ page import="com.realestate.enums.Role" %>

<!DOCTYPE html>
<html>
<head>
<title>User Management</title>

<style>
body{
    font-family: Arial, sans-serif;
    background:#f4f6f8;
}

h2{
    padding-left:30px;
}

table{
    width:95%;
    margin:20px auto;
    background:#fff;
    border-collapse:collapse;
    box-shadow:0 2px 10px rgba(0,0,0,0.1);
}

th, td{
    padding:12px;
    border-bottom:1px solid #eee;
    text-align:left;
}

th{
    background:#f1f5f9;
}

select{
    padding:6px;
}

button{
    padding:6px 12px;
    border:none;
    border-radius:5px;
    cursor:pointer;
}

.update{
    background:#2563eb;
    color:#fff;
}

.delete{
    background:#dc2626;
    color:#fff;
}

.not-allowed{
    color:#999;
    font-size:13px;
}
</style>
</head>

<body>

<h2>User Management</h2>

<%
String successMessage = (String) session.getAttribute("successMessage");
if(successMessage != null){
%>
<script>
alert("<%= successMessage %>");
</script>
<%
session.removeAttribute("successMessage");
}
%>

<table>
<tr>
    <th>Name</th>
    <th>Email</th>
    <th>Role</th>
    <th>Delete</th>
</tr>

<%
List<User> users = (List<User>) request.getAttribute("users");
User loggedAdmin = (User) session.getAttribute("user");

for(User u : users){
%>

<tr>
    <td><%= u.getName() %></td>
    <td><%= u.getEmail() %></td>

    <!-- ROLE UPDATE -->
    <td>
        <form action="<%= request.getContextPath() %>/admin/admin-user-role"
              method="post"
              onsubmit="return confirmRoleChange('<%= u.getName() %>');">

            <input type="hidden" name="userId" value="<%= u.getId() %>">

            <select name="role">
                <option value="USER" <%= u.getRole()==Role.USER ? "selected" : "" %>>
                    USER
                </option>
                <option value="ADMIN" <%= u.getRole()==Role.ADMIN ? "selected" : "" %>>
                    ADMIN
                </option>
            </select>

            <button class="update">Update</button>
        </form>
    </td>

    <!-- DELETE USER -->
    <td>
        <% if(u.getRole() != Role.ADMIN && !u.getId().equals(loggedAdmin.getId())) { %>

            <form action="<%= request.getContextPath() %>/admin/admin-user-delete"
                  method="post"
                  onsubmit="return confirmDelete('<%= u.getName() %>');">

                <input type="hidden" name="userId" value="<%= u.getId() %>">
                <button class="delete">Delete</button>
            </form>

        <% } else { %>
            <span class="not-allowed">Not Allowed</span>
        <% } %>
    </td>
</tr>

<%
}
%>

</table>

<script>
function confirmDelete(name){
    return confirm("Are you sure you want to delete user: " + name + " ?");
}

function confirmRoleChange(name){
    return confirm(
        "Are you sure you want to change role for user: " + name +
        "?\nThis action affects system security."
    );
}
</script>

</body>
</html>
