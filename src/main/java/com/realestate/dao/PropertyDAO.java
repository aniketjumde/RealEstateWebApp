package com.realestate.dao;

import java.util.List;

import com.realestate.enums.PropertyVerificationStatus;
import com.realestate.model.Property;
import com.realestate.model.User;

public interface PropertyDAO 
{
	 public Property  save(Property properties);
	 public void updateProperty(Property properties); 
     public void deleteProperty(Long id);
     public Property getPropertyById(Long id);
	 public List<Property> getAllProperties();
     public List<Property> getPropertiesByTypeAndPurpose(String type, String purpose);
     public List<Property> searchProperties(String city, String type, Integer minBedrooms);
 	 public List<Property> findByStatus(PropertyVerificationStatus status); 
 	public List<Property> getPropertiesByUser(User user);

	 


}
