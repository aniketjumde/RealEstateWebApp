package com.realestate.dao;

import java.util.Collections;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.realestate.enums.PropertyVerificationStatus;
import com.realestate.model.Property;
import com.realestate.util.HibernateUtil;

import jakarta.persistence.Query;


public class PropertyDaoImpl implements PropertyDAO 
{

	@Override
	 public Property  save(Property property)
	{
		Transaction transaction=null;
		
		try(Session session=HibernateUtil.getSessionFactory().openSession())
		{
			transaction=session.beginTransaction();
			
				session.persist(property);
			
			transaction.commit();
			return property;

		}
		catch(Exception e)
		{
			if(transaction!=null)
			{
				transaction.rollback();			
			}
				e.printStackTrace();
				return null;
			}

		}
    

	@Override
	public void updateProperty(Property property) 
	{
		Transaction transaction=null;
		
		try(Session session=HibernateUtil.getSessionFactory().openSession())
		{
			transaction=session.beginTransaction();

			session.merge(property);

			transaction.commit();

		}
		catch(Exception e)
		{
			if(transaction!=null)
			{
				transaction.rollback();			
			}
				e.printStackTrace();

		}	
	}
		

	@Override
	public void deleteProperty(Long id) 
	{
		Transaction transaction=null;
		try(Session session=HibernateUtil.getSessionFactory().openSession())
		{
			transaction = session.beginTransaction();
			Property properties=session.get(Property.class, id);
			
			if(properties!=null)
			{
				session.remove(properties);
			}
			
			transaction.commit();
		}
		catch(Exception e)
		{
			if(transaction!=null)
			{
				transaction.rollback();			
			}
				e.printStackTrace();

		}	
	}
	

	@Override
	public Property getPropertyById(Long id) 
	{
		try (Session session = HibernateUtil.getSessionFactory().openSession()) 
		{
            return session.get(Property.class, id);
        }
	}

	@Override
	public List<Property> getAllProperties() 
	{
		try (Session session = HibernateUtil.getSessionFactory().openSession()) 
		{
            return session.createQuery("FROM Properties ",Property.class).list();
        }	
    }


	@Override
	public List<Property> getPropertiesByTypeAndPurpose(String type, String purpose) 
	{
		try (Session session = HibernateUtil.getSessionFactory().openSession()) 
		{
			 Query query = session.createQuery("FROM Properties p WHERE p.propertyType = :type AND p.purpose = :purpose",Property.class);

			  query.setParameter("type", type);
			  query.setParameter("purpose", purpose);

			  return query.getResultList();

		}
		catch (Exception e) 
		{
			  e.printStackTrace();
			  return Collections.emptyList();
	    }
	}


	@Override
	public List<Property> searchProperties(String city, String type, Integer minBedrooms, Integer maxPrice) 
	{

		try (Session session = HibernateUtil.getSessionFactory().openSession()) 
		{
			StringBuilder hql=new StringBuilder("from Propertes where 1=1");
			
			if(city!=null && !city.isEmpty())
			{
				hql.append(" AND city=:city");
			}
			
			if(type!=null && !type.isEmpty())
			{
				hql.append(" AND type:type");
			}
			
			 if (minBedrooms != null) 
			 {
	                hql.append(" and bedrooms >= :minBedrooms");
	         }
			 
			 if (minBedrooms != null) 
			 {
	                hql.append(" and bedrooms >= :minBedrooms");
	         }
			 
			 if(maxPrice !=null)
			 {
	                hql.append(" and price >= :maxPrice");
			 }
			 
			 Query query = session.createQuery(hql.toString(), Property.class);
	            
	            if (city != null && !city.isEmpty()) {
	                query.setParameter("city", city);
	            }
	            if (type != null && !type.isEmpty()) {
	                query.setParameter("type", type);
	            }
	            if (minBedrooms != null) {
	                query.setParameter("minBedrooms", minBedrooms);
	            }
	            if (maxPrice != null) {
	                query.setParameter("maxPrice", maxPrice);
	            }
	           
	          return query.getResultList();
		}
		catch (Exception e) 
		{
			  e.printStackTrace();
			  return Collections.emptyList();
	    }
	}


	@Override
	public List<Property> findByStatus(PropertyVerificationStatus status) {

		try (Session session = HibernateUtil.getSessionFactory().openSession()) 
		{
			 Query query = session.createQuery("FROM Properties WHERE statau=:status",Property.class);
			 query.setParameter("status",status);
			  
			  return query.getResultList();

		}
		catch (Exception e) 
		{
			  e.printStackTrace();
			  return Collections.emptyList();
	    }
	}

	
	

}
