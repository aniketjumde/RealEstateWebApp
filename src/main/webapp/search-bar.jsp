<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="property-search" method="get" class="search-bar">

    <input type="text" name="city" placeholder="City">

    <select name="type">
        <option value="">Property Type</option>
        <option>House</option>
        <option>Apartment</option>
        <option>Villa</option>
        <option>Plot</option>
    </select>

    <select name="purpose">
        <option value="">Purpose</option>
        <option value="SELL">Sell</option>
        <option value="RENT">Rent</option>
    </select>

    <select name="bedrooms">
        <option value="">Min Bedrooms</option>
        <option>1</option>
        <option>2</option>
        <option>3</option>
        <option>4</option>
    </select>


    <button type="submit">Search</button>
</form>
	

</body>
</html>