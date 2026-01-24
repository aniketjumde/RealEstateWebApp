<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.realestate.model.User" %>

<%
User user = (User) session.getAttribute("user");

if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<%
String success = (String) session.getAttribute("profileSuccess");
if (success != null) {
%>
<script>
    Swal.fire({
        icon: 'success',
        title: 'Success',
        text: '<%= success %>',
        confirmButtonColor: '#0f766e'
    });
</script>
<%
    session.removeAttribute("profileSuccess");
}
%>

<body>
<div class="card">

    <h2>Profile  info</h2>

    <form action="profile-update" method="post">

		
    <!-- Profile Photo -->
    <img src="profile-image?id=<%= user.getId() %>" width="120"><br><br>
    <input type="file" name="profilePhoto">

        <!-- NAME (Editable) -->
        <label>Full Name</label>
        <input type="text" name="name"
               value="<%= user.getName() %>" required> <br>

        <!-- EMAIL (Read-only) -->
        <label>Email</label>
        <input type="email"
               value="<%= user.getEmail() %>"
               class="readonly"
               readonly> <br>

        
        <!-- ROLE (Read-only) -->
        <label>Role</label>
        <input type="text"
               value="<%= user.getRole() %>"
               class="readonly"
               readonly> <br>

		<label>Member since</label>
		<%user.getCreatedAt(); %>
        <button type="submit">Save Changes</button> <br>

    </form>	

</div>
</body>
</html>