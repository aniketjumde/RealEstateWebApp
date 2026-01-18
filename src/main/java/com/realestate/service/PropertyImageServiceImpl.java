package com.realestate.service;

import com.realestate.dao.PropertyImageDAO;
import com.realestate.factory.PropertyImageDaoFactory;
import com.realestate.model.PropertyImage;

public class PropertyImageServiceImpl implements PropertyImageService
{


    private PropertyImageDAO dao=null;
    
    public PropertyImageServiceImpl()
    {
    	this.dao=PropertyImageDaoFactory.getDaoInstance();
    }

    @Override
    public PropertyImage getImageById(Long id) {
        return dao.findById(id);
    }

}
