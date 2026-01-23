<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Access Denied</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f6f8;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .box {
        background: white;
        padding: 30px;
        border-radius: 10px;
        width: 400px;
        text-align: center;
        box-shadow: 0 0 15px rgba(0,0,0,0.15);
    }

    .icon {
        font-size: 50px;
        color: #dc3545;
    }

    h2 {
        margin-top: 10px;
        color: #dc3545;
    }

    p {
        color: #555;
        font-size: 14px;
        margin: 15px 0;
    }

    a {
        display: inline-block;
        margin-top: 15px;
        padding: 10px 18px;
        background-color: #0f766e;
        color: white;
        text-decoration: none;
        border-radius: 6px;
        font-size: 14px;
    }

    a:hover {
        background-color: #115e59;
    }
</style>
</head>

<body>

<div class="box">
    <div class="icon"></div>
    <h2>Access Denied</h2>
    <p>
        You do not have permission to access this page.<br>
        This action is restricted to the property owner.
    </p>

    <a href="property">← Back to Properties</a>
</div>

</body>
</html>
