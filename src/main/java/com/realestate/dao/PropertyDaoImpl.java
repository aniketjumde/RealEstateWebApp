package com.realestate.dao;

import java.util.Collections;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.realestate.enums.PropertyVerificationStatus;
import com.realestate.model.Property;
import com.realestate.model.User;
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
			 //  VERY IMPORTANT: reattach User
	        User managedUser = session.get(User.class, property.getUser().getId());
	        property.setUser(managedUser);

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
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {

	        return session.createQuery("SELECT p FROM Property p " +
	            "LEFT JOIN FETCH p.images " +
	            "LEFT JOIN FETCH p.user " +
	            "WHERE p.id = :id",
	            Property.class
	        ).setParameter("id", id)
	         .uniqueResult();
	    }
	}
	
	@Override
	public List<Property> getAllProperties() 
	{
		try (Session session = HibernateUtil.getSessionFactory().openSession()) 
		{
            return session.createQuery("SELECT DISTINCT p FROM Property p " +
                    "LEFT JOIN FETCH p.images " +
                    "LEFT JOIN FETCH p.user",
                    Property.class).getResultList();
        }
		catch(Exception e)
		{
			e.printStackTrace();
			return Collections.emptyList();
		}
    }


	@Override
	public List<Property> getPropertiesByTypeAndPurpose(String type, String purpose) 
	{
		try (Session session = HibernateUtil.getSessionFactory().openSession()) 
		{
			String hql = "FROM Property p WHERE p.propertyType = :type AND p.purpose = :purpose";
            Query query = session.createQuery(hql, Property.class);

			  query.setParameter("type", type);
			  query.setParameter("purpose", purpose);

			  return ((org.hibernate.query.Query<Property>) query).list();

		}
		catch (Exception e) 
		{
			  e.printStackTrace();
			  return Collections.emptyList();
	    }
	}


	@Override
	public List<Property> searchApprovedProperties(String city, String type, String purpose,Integer minBedrooms) 
	{

		try (Session session = HibernateUtil.getSessionFactory().openSession()) {

	        StringBuilder hql = new StringBuilder(
	            "SELECT DISTINCT p FROM Property p " +
	            "LEFT JOIN FETCH p.images " +
	            "WHERE p.verification = :status"
	        );

	        if (city != null && !city.isEmpty()) {
	            hql.append(" AND p.city = :city");
	        }

	        if (type != null && !type.isEmpty()) {
	            hql.append(" AND p.propertyType = :type");
	        }

	        if (minBedrooms != null) {
	            hql.append(" AND p.bedrooms >= :minBedrooms");
	        }

	        Query query =
	            session.createQuery(hql.toString(), Property.class);

	        query.setParameter("status", PropertyVerificationStatus.APPROVED);

	        if (city != null && !city.isEmpty()) {
	            query.setParameter("city", city);
	        }

	        if (type != null && !type.isEmpty()) {
	            query.setParameter("type", type);
	        }

	        if (minBedrooms != null) {
	            query.setParameter("minBedrooms", minBedrooms);
	        }

	        return query.getResultList(); // images loaded here
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
			 Query query = session.createQuery( "SELECT DISTINCT p FROM Property p " +
					    "LEFT JOIN FETCH p.images " +
					    "WHERE p.verification = :status",Property.class);
			 query.setParameter("status",status);
			  
			  return query.getResultList();

		}
		catch (Exception e) 
		{
			  e.printStackTrace();
			  return Collections.emptyList();
	    }
	}


	@Override
	public List<Property> getPropertiesByUser(User user) 
	{
		try (Session session = HibernateUtil.getSessionFactory().openSession()) 
		{
	        Query query=session.createQuery(
	        		 		"SELECT DISTINCT p FROM Property p " +
	        		            "LEFT JOIN FETCH p.images " +
	        		            "WHERE p.user.id = :userId",
	        		            Property.class);
	        
	        query.setParameter("userId", user.getId());
	        return query.getResultList();
	    }
	}
	
	@Override
	public List<Property> searchProperties(String city, String type, Integer minBedrooms) 
	{

		try (Session session = HibernateUtil.getSessionFactory().openSession()) 
		{
			StringBuilder hql=new StringBuilder( "SELECT DISTINCT p FROM Property p " +
				    "LEFT JOIN FETCH p.images " +
				    "WHERE 1=:1");
			
			if(city!=null && !city.isEmpty())
			{
				hql.append(" AND city=:city");
			
			if(type!=null && !type.isEmpty())
			{
				hql.append(" AND propertyType=:type");
			}
			
			 if (minBedrooms != null) 
			 {
	                hql.append(" and bedrooms >= :minBedrooms");
	         }
			 
			 if (minBedrooms != null) 
			 {
	                hql.append(" and bedrooms >= :minBedrooms");
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
	            
	           
	          return query.getResultList();
		}
			
		}
		catch (Exception e) 
		{
			  e.printStackTrace();
			  return Collections.emptyList();
	    }
		return Collections.emptyList();
	}


	@Override
	public long getTotalPropertiesByUser(Long userId) 
	{
        try (Session session = HibernateUtil.getSessionFactory().openSession()) 
        {

            Query query = session.createQuery(
                "SELECT COUNT(p.id) FROM Property p WHERE p.user.id = :userId",
                Long.class
            );

            query.setParameter("userId", userId);
            return (long) query.getSingleResult();

        } catch (Exception e) 
        {
            e.printStackTrace();
        }
        return 0;
    }

    public long getApprovedPropertiesByUser(Long userId) 
    {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) 
        {

            Query query = session.createQuery(
                "SELECT COUNT(p.id) FROM Property p " +
                "WHERE p.user.id = :userId AND p.verification = :status",
                Long.class
            );

            query.setParameter("userId", userId);
            query.setParameter("status", PropertyVerificationStatus.APPROVED);

            return (long) query.getSingleResult();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public long getPendingPropertiesByUser(Long userId)
    {
        try (Session session = HibernateUtil.getSessionFactory().openSession())
        {

            Query query = session.createQuery(
                "SELECT COUNT(p.id) FROM Property p " +
                "WHERE p.user.id = :userId AND p.verification = :status",
                Long.class
            );

            query.setParameter("userId", userId);
            query.setParameter("status", PropertyVerificationStatus.PENDING);

            return (long) query.getSingleResult();

        } 
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return 0;
    }

    public long getRejectedPropertiesByUser(Long userId) 
    {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) 
        {

            Query query = session.createQuery(
                "SELECT COUNT(p.id) FROM Property p " +
                "WHERE p.user.id = :userId AND p.verification = :status",
                Long.class
            );

            query.setParameter("userId", userId);
            query.setParameter("status", PropertyVerificationStatus.REJECTED);

            return (long) query.getSingleResult();

        } 
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return 0;
    }


	
	

	@Override
	public long getTotalProperties() 
	{
		try (Session session = HibernateUtil.getSessionFactory().openSession())
        {
            Query query = session.createQuery("SELECT COUNT(p) FROM Property p " ,Long.class);

            return (long) query.getSingleResult();
        } 
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return 0;
	}

	@Override
	public long getPendingPropertiesCount() 
	{
		try (Session session = HibernateUtil.getSessionFactory().openSession())
        {

            Query query = session.createQuery("SELECT COUNT(*) FROM Property p WHERE  p.verification = :status" ,Long.class);
            query.setParameter("status",PropertyVerificationStatus.PENDING);
            return (long) query.getSingleResult();

        } 
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return 0;
	}


	@Override
	public long getApprovedPropertiesCount() 
	{
		try (Session session = HibernateUtil.getSessionFactory().openSession())
        {

            Query query = session.createQuery("SELECT COUNT(*) FROM Property p WHERE  p.verification = :status" ,Long.class);
            query.setParameter("status",PropertyVerificationStatus.APPROVED);
            return (long) query.getSingleResult();

        } 
        catch (Exception e)
        {
            e.printStackTrace();
        }
		return 0;
	}


	@Override
	public long getRejectedPropertiesCount() 
	{
		try (Session session = HibernateUtil.getSessionFactory().openSession())
        {

            Query query = session.createQuery("SELECT COUNT(*) FROM Property p WHERE  p.verification = :status" ,Long.class);
            query.setParameter("status",PropertyVerificationStatus.REJECTED);
            return (long) query.getSingleResult();

        } 
        catch (Exception e)
        {
            e.printStackTrace();
        }
		return 0;
	}


	@Override
	public List<Property> getPendingProperties() 
	{
		 try (Session session = HibernateUtil.getSessionFactory().openSession()) 
		 {

		        return session.createQuery(
		            "select p from Property p " +
		            "join fetch p.user " +
		            "where p.verification = :status",
		            Property.class
		        )
		        .setParameter("status", PropertyVerificationStatus.PENDING)
		        .getResultList();

		    }
	}


	@Override
	public List<Property> findLatestApproved(int limit) 
	{
		try(Session session = HibernateUtil.getSessionFactory().openSession();)
		{
			List<Property> list = session.createQuery("SELECT DISTINCT p FROM Property p LEFT JOIN FETCH p.images WHERE p.verification = :status ORDER BY p.createdAt DESC",Property.class
			    )
			    .setParameter("status", PropertyVerificationStatus.APPROVED)
			    .setMaxResults(limit)
			    .getResultList();
			
			return list;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		
		return Collections.emptyList();
	}


	

}
