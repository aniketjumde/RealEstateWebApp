package com.realestate.service;

import java.util.List;

import com.realestate.dao.PropertyDAO;
import com.realestate.enums.PropertyVerificationStatus;
import com.realestate.factory.PropertyDaoFactory;
import com.realestate.model.Property;
import com.realestate.model.User;

public class PropertyServiceImpl implements PropertyService 
{

	

	@Override
	public Property addProperty(Property property) 
	{
		PropertyDAO propertiesDao=PropertyDaoFactory.getDaoInstance(); 
		return propertiesDao.save(property);
	}

	@Override
	public void updateProperty(Property property) 
	{
		PropertyDAO propertiesDao=PropertyDaoFactory.getDaoInstance();
		propertiesDao.updateProperty(property);

	}

	@Override
	public void deleteProperty(Long id) 
	{
		PropertyDAO propertiesDao=PropertyDaoFactory.getDaoInstance(); 
		propertiesDao.deleteProperty(id);
	}

	@Override
	public  Property getPropertyById(Long id) 
	{
		PropertyDAO propertiesDao=PropertyDaoFactory.getDaoInstance(); 
		return propertiesDao.getPropertyById(id);
	}

	@Override
	public List<Property> getAllProperties() 
	{
		PropertyDAO propertiesDao=PropertyDaoFactory.getDaoInstance(); 
		return propertiesDao.getAllProperties();
	}

	@Override
	public List<Property> getPropertiesByTypeAndPurpose(String type, String purpose) 
	{
		PropertyDAO propertiesDao=PropertyDaoFactory.getDaoInstance(); 
		return propertiesDao.getPropertiesByTypeAndPurpose(type, purpose);
	}

	@Override
	public List<Property> searchApprovedProperties(String city, String type,String purpose, Integer minBedrooms) 
	{
		PropertyDAO propertiesDao=PropertyDaoFactory.getDaoInstance(); 
		return propertiesDao.searchApprovedProperties(city, type,purpose, minBedrooms);
	}

	@Override
	public List<Property> findByStatus(PropertyVerificationStatus status) 
	{
		PropertyDAO propertiesDao=PropertyDaoFactory.getDaoInstance(); 
		
		return propertiesDao.findByStatus(status);
	}

	@Override
	public List<Property> getApprovedProperties() 
	{	
		PropertyDAO propertiesDao=PropertyDaoFactory.getDaoInstance(); 
        return propertiesDao.findByStatus(PropertyVerificationStatus.APPROVED);

	}

	@Override
	public List<Property> getPendingProperties() 
	{
		PropertyDAO propertiesDao=PropertyDaoFactory.getDaoInstance(); 
        return propertiesDao.findByStatus(PropertyVerificationStatus.PENDING);
	}

	@Override
	public boolean approveProperty(Long propertyId) 
	{
		PropertyDAO propertiesDao=PropertyDaoFactory.getDaoInstance();
		Property property=propertiesDao.getPropertyById(propertyId);
		if (property != null) {
            property.setVerification(PropertyVerificationStatus.APPROVED);
            propertiesDao.updateProperty(property);
            return true;
        }
        return false;
 
	}

	@Override
	public boolean rejectProperty(Long propertyId) 
	{
		PropertyDAO propertiesDao=PropertyDaoFactory.getDaoInstance();
		Property property=propertiesDao.getPropertyById(propertyId);
		if (property != null) {
            property.setVerification(PropertyVerificationStatus.REJECTED);
            propertiesDao.updateProperty(property);
            return true;
        }
        return false;
	}

	@Override
	public List<Property> getPropertiesByUser(User user) {
		PropertyDAO propertiesDao=PropertyDaoFactory.getDaoInstance();
		return propertiesDao.getPropertiesByUser(user);
	}

	@Override
	public List<Property> searchProperties(String city, String type, Integer minBedrooms) 
	{
		PropertyDAO propertiesDao=PropertyDaoFactory.getDaoInstance(); 
		return propertiesDao.searchProperties(city, type, minBedrooms);
	}

	

	
	
	
}
