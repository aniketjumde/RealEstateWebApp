package com.realestate.service;

import java.util.List;

import com.realestate.dao.PropertyDAO;
import com.realestate.enums.PropertyVerificationStatus;
import com.realestate.factory.PropertyDaoFactory;
import com.realestate.model.Property;

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
	public List<Property> searchProperties(String city, String type, Integer minBedrooms, Integer maxPrice) 
	{
		PropertyDAO propertiesDao=PropertyDaoFactory.getDaoInstance(); 
		return propertiesDao.searchProperties(city, type, minBedrooms, maxPrice);
	}

	@Override
	public List<Property> findByStatus(PropertyVerificationStatus status) 
	{
		PropertyDAO propertiesDao=PropertyDaoFactory.getDaoInstance(); 
		
		return propertiesDao.findByStatus(status);
	}

	

	
	
	
}
