package com.realestate.service;

import java.util.List;

import com.realestate.dao.PropertyDAO;
import com.realestate.enums.PropertyVerificationStatus;
import com.realestate.factory.PropertyDaoFactory;
import com.realestate.model.Property;
import com.realestate.model.User;

public class PropertyServiceImpl implements PropertyService 
{
	private PropertyDAO propertiesDao;
	
	public PropertyServiceImpl()
	{
		 propertiesDao=PropertyDaoFactory.getDaoInstance();
	}
	

	@Override
	public Property addProperty(Property property) 
	{
		property.setCity(property.getCity().toLowerCase());
		return propertiesDao.save(property);
	}

	@Override
	public void updateProperty(Property property) 
	{
		propertiesDao.updateProperty(property);

	}

	@Override
	public void deleteProperty(Long id) 
	{
		propertiesDao.deleteProperty(id);
	}

	@Override
	public  Property getPropertyById(Long id) 
	{
		return propertiesDao.getPropertyById(id);
	}

	@Override
	public List<Property> getAllProperties() 
	{
		return propertiesDao.getAllProperties();
	}

	@Override
	public List<Property> getPropertiesByTypeAndPurpose(String type, String purpose) 
	{
		return propertiesDao.getPropertiesByTypeAndPurpose(type, purpose);
	}

	@Override
	public List<Property> searchApprovedProperties(String city, String type,String purpose, Integer minBedrooms) 
	{
		return propertiesDao.searchApprovedProperties(city, type,purpose, minBedrooms);
	}

	@Override
	public List<Property> findByStatus(PropertyVerificationStatus status) 
	{
		
		return propertiesDao.findByStatus(status);
	}

	@Override
	public List<Property> getApprovedProperties() 
	{	
        return propertiesDao.findByStatus(PropertyVerificationStatus.APPROVED);

	}

	@Override
	public List<Property> getPendingProperties() 
	{
        return propertiesDao.getPendingProperties();
	}

	@Override
	public boolean approveProperty(Long propertyId) 
	{
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
		Property property=propertiesDao.getPropertyById(propertyId);
		if (property != null) {
            property.setVerification(PropertyVerificationStatus.REJECTED);
            propertiesDao.updateProperty(property);
            return true;
        }
        return false;
	}

	@Override
	public List<Property> getPropertiesByUser(User user) 
	{
			return propertiesDao.getPropertiesByUser(user);
	}

	@Override
	public List<Property> searchProperties(String city, String type, Integer minBedrooms) 
	{
		return propertiesDao.searchProperties(city.toLowerCase(), type, minBedrooms);
	}

	@Override
	public long getTotalPropertiesByUser(Long userId) 
	{
		return propertiesDao.getTotalPropertiesByUser(userId);
	}

	@Override
	public long getApprovedPropertiesByUser(Long userId) 
	{
		
		return propertiesDao.getApprovedPropertiesByUser(userId);
	}

	@Override
	public long getPendingPropertiesByUser(Long userId) 
	{
		return propertiesDao.getPendingPropertiesByUser(userId);
	}

	@Override
	public long getRejectedPropertiesByUser(Long userId) 
	{
		return propertiesDao.getRejectedPropertiesByUser(userId);
	}


	


	@Override
	public long getTotalProperties() 
	{
		return propertiesDao.getTotalProperties();
	}


	@Override
	public long getPendingPropertiesCount() 
	{
		return propertiesDao.getPendingPropertiesCount();
	}


	@Override
	public long getApprovedPropertiesCount() 
	{
		return propertiesDao.getApprovedPropertiesCount();
	}


	@Override
	public long getRejectedPropertiesCount() 
	{
		return propertiesDao.getRejectedPropertiesCount();
	}


	@Override
	public List<Property> getLatestApprovedProperties(int limit)
	{
		return propertiesDao.findLatestApproved(limit);

	}


	
}
