package com.realestate.service;

import java.util.List;

import com.realestate.enums.PropertyVerificationStatus;
import com.realestate.model.Property;
import com.realestate.model.User;

public interface PropertyService 
{
	 public Property  addProperty(Property property);
	 public void updateProperty(Property property); 
     public void deleteProperty(Long id);
     public Property getPropertyById(Long id);
     public List<Property> getPropertiesByUser(User user);
     public List<Property> findByStatus(PropertyVerificationStatus status);
	 public List<Property> getAllProperties();
     public List<Property> getPropertiesByTypeAndPurpose(String type, String purpose);
     public List<Property> searchApprovedProperties(String city, String type,String purpose, Integer minBedrooms);
     List<Property> getApprovedProperties();
     List<Property> getPendingProperties();
     boolean approveProperty(Long propertyId);
     boolean rejectProperty(Long propertyId);
 	public List<Property> searchProperties(String city, String type, Integer minBedrooms) ;

     

}
