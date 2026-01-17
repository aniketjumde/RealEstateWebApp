<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Property</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f6f8;
    }

    .modal {
        width: 420px;
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
</style>

</head>
<body>

<div class="modal">
    <h2>Add New Property</h2>
    <div class="sub">Fill in the details below to list your property</div>

    <form action="property" method="post">

        <!-- BASIC INFORMATION -->
        <label>Property Title</label>
        <input type="text" name="title" placeholder="e.g., Modern Downtown Apartment" required>

        <label>Description</label>
        <textarea name="description" rows="3" placeholder="Describe your property..."></textarea>

        <div class="row">
            <div>
                <label>Price ($)</label>
                <input type="number" name="price" required>
            </div>

            <div>
                <label>Property Type</label>
                <select name="type">
                    <option>House</option>
                    <option>Apartment</option>
                    <option>Villa</option>
                    <option>Plot</option>
                </select>
            </div>
        </div>
        
        
        <div class="row">
            <div>
        
				 <label>Purpose</label>
				<select name="purpose" required>
				    <option value="">-- Select Purpose --</option>
				    <option value="SELL">Sell</option>
				    <option value="RENT">Rent</option>
				</select>
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
                <label>Area (sq ft)</label>
                <input type="number" name="area">
            </div>
        </div>

        <div class="row">
            <div>
                <label>Bedrooms</label>
                <select name="bedrooms">
                    <option>1</option><option>2</option><option>3</option>
                    <option>4</option><option>5</option>
                </select>
            </div>

            <div>
                <label>Bathrooms</label>
                <select name="bathrooms">
                    <option>1</option><option>2</option><option>3</option>
                </select>
            </div>
        </div>

        <!-- LOCATION -->
        <label>Street Address</label>
        <input type="text" name="street" placeholder="123 Main Street">

        <div class="row">
            <div>
                <label>City</label>
                <input type="text" name="city">
            </div>

            <div>
                <label>State</label>
                <input type="text" name="state">
            </div>
        </div>

        <label>ZIP Code</label>
        <input type="text" name="zip">

        <!-- MAP COORDINATES -->
        <div class="row">
            <div>
                <label>Latitude</label>
                <input type="text" name="latitude" placeholder="e.g., 40.7128">
            </div>

            <div>
                <label>Longitude</label>
                <input type="text" name="longitude" placeholder="e.g., -74.0060">
            </div>
        </div>

        <button type="submit">Add Property</button>

    </form>
</div>

</body>
