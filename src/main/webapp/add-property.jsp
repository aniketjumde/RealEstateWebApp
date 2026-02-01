<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/Header.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Property</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- Leaflet for maps -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f6f8;
        margin: 0;
        padding: 20px;
    }

    .container {
        max-width: 900px;
        margin: 0 auto;
        background: #ffffff;
        padding: 25px;
        border-radius: 10px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
    }

    h2 {
        color: #0f766e;
        margin-bottom: 5px;
        border-bottom: 3px solid #0f766e;
        padding-bottom: 10px;
    }

    .sub {
        color: #666;
        font-size: 14px;
        margin-bottom: 25px;
    }

    label {
        font-weight: bold;
        display: block;
        margin-top: 15px;
        color: #333;
    }

    input, textarea, select {
        width: 100%;
        padding: 10px;
        margin-top: 5px;
        border-radius: 6px;
        border: 1px solid #ddd;
        box-sizing: border-box;
        font-size: 14px;
    }

    input:focus, textarea:focus, select:focus {
        outline: none;
        border-color: #0f766e;
        box-shadow: 0 0 0 2px rgba(15, 118, 110, 0.2);
    }

    .row {
        display: flex;
        gap: 15px;
        margin-bottom: 10px;
    }

    .row > div {
        flex: 1;
    }

    button {
        margin-top: 25px;
        width: 100%;
        padding: 12px;
        background: linear-gradient(135deg, #0f766e, #115e59);
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    button:hover {
        background: linear-gradient(135deg, #115e59, #0f766e);
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(15, 118, 110, 0.3);
    }

    .form-section {
        background: #f8fafc;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 20px;
        border-left: 4px solid #0f766e;
    }

    .section-title {
        color: #0f766e;
        margin-top: 0;
        font-size: 18px;
        margin-bottom: 15px;
    }

    /* Location Selector Styles */
    .location-selector {
        background: white;
        border-radius: 8px;
        border: 1px solid #e2e8f0;
        overflow: hidden;
        margin-bottom: 20px;
    }

    .search-box {
        padding: 15px;
        background: #f8fafc;
        border-bottom: 1px solid #e2e8f0;
    }

    .search-box h4 {
        margin: 0 0 10px 0;
        color: #1e293b;
        font-size: 16px;
    }

    .search-input {
        width: 100%;
        padding: 10px 15px;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        font-size: 14px;
    }

    .search-input:focus {
        outline: none;
        border-color: #0f766e;
        box-shadow: 0 0 0 3px rgba(15, 118, 110, 0.1);
    }

    .quick-cities {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        margin-top: 10px;
    }

    .city-btn {
        padding: 6px 12px;
        background: white;
        border: 1px solid #cbd5e1;
        border-radius: 20px;
        font-size: 13px;
        cursor: pointer;
        transition: all 0.2s;
    }

    .city-btn:hover {
        background: #0f766e;
        color: white;
        border-color: #0f766e;
    }

    .map-section {
        display: flex;
        height: 400px;
    }

    .map-container {
        flex: 2;
        height: 100%;
    }

    .coordinates-panel {
        flex: 1;
        padding: 20px;
        background: #f8fafc;
        border-left: 1px solid #e2e8f0;
        display: flex;
        flex-direction: column;
    }

    .coordinates-panel h4 {
        margin: 0 0 15px 0;
        color: #1e293b;
        font-size: 16px;
    }

    .instruction {
        font-size: 13px;
        color: #64748b;
        margin-bottom: 15px;
        line-height: 1.4;
    }

    .selected-coords {
        background: white;
        padding: 15px;
        border-radius: 6px;
        border: 1px solid #e2e8f0;
        margin-bottom: 20px;
    }

    .selected-coords p {
        margin: 0;
        font-size: 14px;
        color: #64748b;
    }

    .selected-coords .coords-value {
        font-size: 18px;
        font-weight: bold;
        color: #0f766e;
        margin-top: 5px;
        font-family: monospace;
    }

    .coord-inputs {
        margin-top: auto;
    }

    .coord-group {
        margin-bottom: 15px;
    }

    .coord-group label {
        font-size: 13px;
        color: #475569;
        margin-bottom: 5px;
    }

    .coord-input {
        width: 100%;
        padding: 8px 12px;
        border: 1px solid #cbd5e1;
        border-radius: 4px;
        font-family: monospace;
        font-size: 14px;
    }

    .coord-input:read-only {
        background: #f1f5f9;
        color: #64748b;
    }

    .required::after {
        content: " *";
        color: #dc2626;
    }

    @media (max-width: 768px) {
        .map-section {
            flex-direction: column;
            height: 500px;
        }
        
        .map-container {
            height: 300px;
        }
        
        .coordinates-panel {
            border-left: none;
            border-top: 1px solid #e2e8f0;
        }
        
        .row {
            flex-direction: column;
            gap: 0;
        }
    }
</style>
</head>

<body>

<div class="container">
    <h2>Add New Property</h2>
    <div class="sub">Fill in the details below to list your property on our platform</div>

    <form id="propertyForm" action="property" method="post" enctype="multipart/form-data">

        <!-- BASIC INFORMATION SECTION -->
        <div class="form-section">
            <h3 class="section-title">Basic Information</h3>
            
            <label class="required">Property Title</label>
            <input type="text" name="title" placeholder="e.g., Modern 3-Bedroom Apartment" required maxlength="100">
            
            <label class="required">Description</label>
            <textarea name="description" rows="4" placeholder="Describe your property features, amenities, neighborhood..." required></textarea>

            <div class="row">
                <div>
                    <label class="required">Price (₹)</label>
                    <input type="number" name="price" min="1" required placeholder="e.g., 5000000">
                </div>
                <div>
                    <label class="required">Property Type</label>
                    <select name="type" required>
                        <option value="">-- Select Type --</option>
                        <option>House</option>
                        <option>Apartment</option>
                        <option>Villa</option>
                        <option>Plot</option>
                    </select>
                </div>
            </div>

            <div class="row">
                <div>
                    <label class="required">Purpose</label>
                    <select name="purpose" required>
                        <option value="">-- Select Purpose --</option>
                        <option value="SELL">Sell</option>
                        <option value="RENT">Rent</option>
                    </select>
                </div>
                <div>
                    <label>Status</label>
                    <select name="status">
                        <option value="AVAILABLE">Available</option>
                        <option value="SOLD">Sold</option>
                        <option value="RENTED">Rented</option>
                        <option value="PENDING">Pending</option>
                    </select>
                </div>
            </div>

            <div class="row">
                <div>
                    <label class="required">Area (sq ft)</label>
                    <input type="number" name="area" min="1" required placeholder="e.g., 1500">
                </div>
            </div>

            <div class="row">
                <div>
                    <label>Bedrooms</label>
                    <select name="bedrooms">
                        <option value="0">Studio</option>
                        <option value="1">1</option>
                        <option value="2" selected>2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5+</option>
                    </select>
                </div>
                <div>
                    <label>Bathrooms</label>
                    <select name="bathrooms">
                        <option value="1">1</option>
                        <option value="2" selected>2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5+</option>
                    </select>
                </div>
            </div>
        </div>

        <!-- LOCATION SELECTOR SECTION (Like Screenshot) -->
        <div class="form-section">
            <h3 class="section-title">Pin Location on Map</h3>
            
            <div class="location-selector">
                <!-- Search Box -->
                <div class="search-box">
                    <h4>Search for an address...</h4>
                    <input type="text" id="mapSearch" class="search-input" placeholder="Enter city, address, or landmark">
                    
                   
                </div>
                
                <!-- Map and Coordinates Panel -->
                <div class="map-section">
                    <!-- Map Container -->
                    <div id="map" class="map-container"></div>
                    
                    <!-- Coordinates Panel -->
                    <div class="coordinates-panel">
                        <h4>Selected Location</h4>
                        <p class="instruction">Click on the map to select location</p>
                        
                        <div class="selected-coords">
                            <p>Selected Coordinates:</p>
                            <div class="coords-value" id="selectedCoords">19.0760, 72.8777</div>
                        </div>
                        
                        <div class="coord-inputs">
                            <div class="coord-group">
                                <label>Latitude</label>
                                <input type="text" id="latitude" name="latitude" class="coord-input" value="19.0760" required readonly>
                            </div>
                            <div class="coord-group">
                                <label>Longitude</label>
                                <input type="text" id="longitude" name="longitude" class="coord-input" value="72.8777" required readonly>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Address Fields -->
            <div class="row">
                <div>
                    <label class="required">Street Address</label>
                    <input type="text" name="street" id="streetAddress" placeholder="e.g., Marine Drive" required>
                </div>
            </div>

            <div class="row">
                <div>
                    <label class="required">City</label>
                    <input type="text" name="city" id="city" required>
                </div>
                <div>
                    <label class="required">State</label>
                    <input type="text" name="state" id="state" required>
                </div>
            </div>

            <div class="row">
                <div>
                    <label class="required">ZIP Code</label>
                    <input type="text" name="zip" id="zipCode" required>
                </div>
                <div>
                    <label>Country</label>
                    <input type="text" name="country" id="country" value="India" required>
                </div>
            </div>
        </div>

        <!-- IMAGES SECTION -->
        <div class="form-section">
            <h3 class="section-title">Property Images</h3>
            
            <label class="required">Upload Images</label>
            <input type="file" name="images" multiple accept="image/*" required>
            <div style="font-size: 13px; color: #666; margin-top: 5px;">
                <i class="fas fa-info-circle"></i> You can select multiple images (JPEG, PNG format). First image will be used as thumbnail.
            </div>
        </div>

      

        <!-- Success Message Display -->
        <%
            String successMessage = (String) session.getAttribute("successMessage");
            if (successMessage != null) {
        %>
        <script>
            Swal.fire({
                icon: 'success',
                title: 'Success',
                text: '<%= successMessage %>',
                confirmButtonColor: '#2563EB'
            });
        </script>
        <%
            session.removeAttribute("successMessage");
        }
        %>

        <button type="submit" id="submitBtn">Add Property</button>

    </form>
</div>

<script>
// Use CDATA section to prevent JSP from parsing JavaScript
/*<![CDATA[*/
let map;
let marker;

// Initialize map
function initMap() {
    // Default to Mumbai, India
    const defaultLocation = [19.0760, 72.8777];
    
    // Create map
    map = L.map('map').setView(defaultLocation, 13);
    
    // Add OpenStreetMap tiles
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
        maxZoom: 19
    }).addTo(map);
    
    // Create initial marker
    marker = L.marker(defaultLocation, {
        draggable: true
    }).addTo(map);
    
    // Handle map click
    map.on('click', function(e) {
        updateMarker(e.latlng.lat, e.latlng.lng);
        reverseGeocode(e.latlng.lat, e.latlng.lng);
    });
    
    // Handle marker drag
    marker.on('dragend', function(e) {
        const position = marker.getLatLng();
        updateCoordinates(position.lat, position.lng);
        reverseGeocode(position.lat, position.lng);
    });
    
    // Set up search functionality
    setupSearch();
    
    // Initialize with Mumbai location
    //setAddressFields("Mumbai", "Maharashtra", "400001", "India", "Marine Drive");
}

// Set up search functionality
function setupSearch() {
    const searchInput = document.getElementById('mapSearch');
    
    searchInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            const query = searchInput.value.trim();
            if (query) {
                searchLocation(query);
            }
        }
    });
}

// Search for a location using Nominatim
function searchLocation(query) {
    // Use string concatenation instead of template literals to avoid JSP parsing issues
    const url = 'https://nominatim.openstreetmap.org/search?format=json&q=' + encodeURIComponent(query) + '&limit=1';
    
    fetch(url)
        .then(function(response) {
            return response.json();
        })
        .then(function(data) {
            if (data && data.length > 0) {
                const result = data[0];
                const lat = parseFloat(result.lat);
                const lon = parseFloat(result.lon);
                
                // Update map and marker
                map.setView([lat, lon], 13);
                updateMarker(lat, lon);
                
                // Update address fields
                updateAddressFieldsFromResult(result);
            } else {
                Swal.fire({
                    icon: 'warning',
                    title: 'Location Not Found',
                    text: 'Could not find the specified location',
                    confirmButtonColor: '#f59e0b'
                });
            }
        })
        .catch(function(error) {
            console.log('Search failed:', error);
            Swal.fire({
                icon: 'error',
                title: 'Search Error',
                text: 'Unable to search for location',
                confirmButtonColor: '#dc2626'
            });
        });
}

// Update marker position
function updateMarker(lat, lng) {
    marker.setLatLng([lat, lng]);
    updateCoordinates(lat, lng);
}

// Update coordinate displays
function updateCoordinates(lat, lng) {
    document.getElementById('latitude').value = lat.toFixed(6);
    document.getElementById('longitude').value = lng.toFixed(6);
    document.getElementById('selectedCoords').textContent = lat.toFixed(6) + ', ' + lng.toFixed(6);
}

// Set location from quick city buttons
function setLocation(lat, lng, cityName) {
    map.setView([lat, lng], 13);
    updateMarker(lat, lng);
    reverseGeocode(lat, lng);
    
    // Update search input
    document.getElementById('mapSearch').value = cityName;
}

// Reverse geocode to get address
function reverseGeocode(lat, lng) {
    // Use string concatenation instead of template literals
    const url = 'https://nominatim.openstreetmap.org/reverse?format=json&lat=' + lat + '&lon=' + lng + '&addressdetails=1';
    
    fetch(url)
        .then(function(response) {
            return response.json();
        })
        .then(function(data) {
            if (data && data.address) {
                updateAddressFieldsFromResult(data);
            }
        })
        .catch(function(error) {
            console.log('Reverse geocoding failed:', error);
        });
}

// Update address fields from geocoding result
function updateAddressFieldsFromResult(data) {
    const address = data.address || {};
    
    // Extract address components
    const street = address.road || '';
    const houseNumber = address.house_number || '';
    const city = address.city || address.town || address.village || '';
    const state = address.state || address.region || '';
    const zip = address.postcode || '';
    const country = address.country || '';
    
    // Build street address using string concatenation
    let streetAddress = '';
    if (houseNumber) streetAddress = houseNumber + ' ';
    if (street) streetAddress += street;
    
    // Update form fields
    if (streetAddress.trim()) {
        document.getElementById('streetAddress').value = streetAddress.trim();
    }
    if (city) {
        document.getElementById('city').value = city;
    }
    if (state) {
        document.getElementById('state').value = state;
    }
    if (zip) {
        document.getElementById('zipCode').value = zip;
    }
    if (country) {
        document.getElementById('country').value = country;
    }
}

// Manual address fields update function
function setAddressFields(city, state, zip, country, street) {
    if (city) document.getElementById('city').value = city;
    if (state) document.getElementById('state').value = state;
    if (zip) document.getElementById('zipCode').value = zip;
    if (country) document.getElementById('country').value = country;
    if (street) document.getElementById('streetAddress').value = street;
}

// Form validation
document.getElementById('propertyForm').addEventListener('submit', function(event) {
    const lat = document.getElementById('latitude').value;
    const lng = document.getElementById('longitude').value;
    
    // Validate coordinates
    if (!lat || !lng) {
        event.preventDefault();
        Swal.fire({
            icon: 'error',
            title: 'Location Required',
            text: 'Please select a location on the map',
            confirmButtonColor: '#dc2626'
        });
        return false;
    }
    
    // Show loading state
    const submitBtn = document.getElementById('submitBtn');
    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Adding Property...';
    submitBtn.disabled = true;
    
    return true;
});

// Initialize map when page loads
document.addEventListener('DOMContentLoaded', function() {
    initMap();
    
    // Add Font Awesome icons
    const faLink = document.createElement('link');
    faLink.rel = 'stylesheet';
    faLink.href = 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css';
    document.head.appendChild(faLink);
});
/*]]>*/
</script>

</body>
</html>