<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="com.realestate.model.Property" %>
<%@ page import="com.realestate.enums.PropertyVerificationStatus" %>

<%
    Property property = (Property) request.getAttribute("property");

    if (property == null) {
%>
    <h3>Invalid property access</h3>
    <a href="property">Back</a>
<%
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Property</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f6f8;
    }

    .modal {
        width: 450px;
        margin: 30px auto;
        background: #ffffff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0,0,0,0.15);
    }

    h2 {
        margin-bottom: 5px;
    }

    .sub {
        color: #777;
        font-size: 14px;
        margin-bottom: 15px;
    }

    label {
        font-weight: bold;
        display: block;
        margin-top: 12px;
    }

    input, textarea, select {
        width: 100%;
        padding: 8px;
        margin-top: 5px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }

    .row {
        display: flex;
        gap: 10px;
    }

    .row div {
        flex: 1;
    }

    button {
        margin-top: 20px;
        width: 100%;
        padding: 10px;
        background-color: #0f766e;
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        cursor: pointer;
    }

    button:hover {
        background-color: #115e59;
    }

    .warning {
        background: #fff3cd;
        color: #856404;
        padding: 10px;
        border-radius: 6px;
        margin-bottom: 15px;
        font-size: 14px;
    }
</style>
</head>

<body>

<div class="modal">

    <h2>Edit Property</h2>
    <div class="sub">Update your property details</div>

    <!-- ADMIN RE-APPROVAL WARNING -->
    <div class="warning">
        ⚠ After editing, this property will be sent for
        <b>admin re-approval</b>.
    </div>

    <form action="property-edit" method="post" enctype="multipart/form-data">

        <!-- PROPERTY ID -->
        <input type="hidden" name="id" value="<%= property.getId() %>">

        <!-- BASIC DETAILS -->
        <label>Property Title</label>
        <input type="text" name="title"
               value="<%= property.getTitle() %>" required>

        <label>Description</label>
        <textarea name="description" rows="3"><%= property.getDescription() %></textarea>

        <div class="row">
            <div>
                <label>Price</label>
                <input type="number" name="price"
                       value="<%= property.getPrice() %>" required>
            </div>

            <div>
                <label>Property Type</label>
                <select name="type">
                    <option <%= "House".equals(property.getPropertyType()) ? "selected" : "" %>>House</option>
                    <option <%= "Apartment".equals(property.getPropertyType()) ? "selected" : "" %>>Apartment</option>
                    <option <%= "Villa".equals(property.getPropertyType()) ? "selected" : "" %>>Villa</option>
                    <option <%= "Plot".equals(property.getPropertyType()) ? "selected" : "" %>>Plot</option>
                </select>
            </div>
        </div>

        <label>Purpose</label>
        <select name="purpose">
            <option value="SELL" <%= "SELL".equals(property.getPurpose()) ? "selected" : "" %>>Sell</option>
            <option value="RENT" <%= "RENT".equals(property.getPurpose()) ? "selected" : "" %>>Rent</option>
        </select>

        <div class="row">
            <div>
                <label>Bedrooms</label>
                <input type="number" name="bedrooms"
                       value="<%= property.getBedrooms() %>">
            </div>

            <div>
                <label>Bathrooms</label>
                <input type="number" name="bathrooms"
                       value="<%= property.getBathrooms() %>">
            </div>
        </div>

		<div class="row">
		 	<div>
                <label>Status</label>
                <select name="status">
                    <option>Available</option>
                    <option>Sold</option>
                </select>
            </div>
			<div>
		        <label>Area (sqft)</label>
		        <input type="number" name="area"
		               value="<%= property.getAreaSqarefit() %>">
	         </div>
		</div>
        <!-- LOCATION -->
        <label>City</label>
        <input type="text" name="city"
               value="<%= property.getCity() %>">

        <label>State</label>
        <input type="text" name="state"
               value="<%= property.getState() %>">

        <label>Pincode</label>
        <input type="text" name="zip"
               value="<%= property.getPincode() %>">

        <!-- MAP -->
        <div class="row">
            <div>
                <label>Latitude</label>
                <input type="text" name="latitude"
                       value="<%= property.getLatitude() %>">
            </div>

            <div>
                <label>Longitude</label>
                <input type="text" name="longitude"
                       value="<%= property.getLongitude() %>">
            </div>
        </div>

        <!-- IMAGES -->
        <label>Replace Images (optional)</label>
        <input type="file" name="images" multiple accept="image/*">

        <button type="submit">Update Property</button>

    </form>

</div>

</body>
</html>
