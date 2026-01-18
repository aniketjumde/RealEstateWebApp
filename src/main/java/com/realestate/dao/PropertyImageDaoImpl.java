package com.realestate.dao;

import org.hibernate.Session;

import com.realestate.model.PropertyImage;
import com.realestate.util.HibernateUtil;

public class PropertyImageDaoImpl implements PropertyImageDAO
{

	@Override
	public PropertyImage findById(Long id) 
	{
		try(Session session=HibernateUtil.getSessionFactory().openSession();)
		{
            return session.get(PropertyImage.class, id);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return null;
		}
	}

}
