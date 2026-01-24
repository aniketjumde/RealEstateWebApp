package com.realestate.dao;

import java.util.List;
import java.util.Optional;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.realestate.enums.Role;
import com.realestate.model.User;
import com.realestate.util.HibernateUtil;

public class UserDaoImpl implements UserDAO
{

	@Override
	public User save(User user) 
	{
		Transaction transaction = null;
	    try (Session session = HibernateUtil.getSessionFactory().openSession()) 
	    {
	        transaction = session.beginTransaction();
	       if(user.getId()==null)
	       {
	            session.persist(user);
	       }
	       else
	       {
	            session.merge(user);

	       }
	        transaction.commit();
	        return user;
	    } 
	    catch (Exception e) 
	    {
	        if (transaction != null) transaction.rollback();
	        e.printStackTrace();
	        return null;
	    }
	}

	@Override
	public Optional<User> findByEmail(String email) 
	{
		
		try (Session session = HibernateUtil.getSessionFactory().openSession()) 
	    {
	        Query<User> query = session.createQuery(
	            "FROM User WHERE email = :email", User.class);
	        query.setParameter("email", email);

	        return query.uniqueResultOptional();
	    } 
	    catch (Exception e) 
	    {
	        // Log the exception if needed
	    	e.printStackTrace();
			return null;

	    }
	}

	

	@Override
	public Optional<User> findByFirebaseUid(String uid) {
	    Session session = null;

	    try {
	        session = HibernateUtil.getSessionFactory().openSession();

	        return session.createQuery(
	            "FROM User u WHERE u.firebaseUid = :uid",
	            User.class
	        ).setParameter("uid", uid)
	         .uniqueResultOptional();

	    } finally {
	        if (session != null) session.close();
	    }
	}


	@Override
	public void updateRole(String email, Role role) 
	{
		Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) 
        {
            transaction = session.beginTransaction();
            Query<?> query = session.createQuery("UPDATE User SET role = :role WHERE email = :email");
            query.setParameter("role", role);
            query.setParameter("email", email);
            query.executeUpdate();
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw e;
        }
		
	}

	@Override
	public List<User> findAll() 
	{
		try (Session session = HibernateUtil.getSessionFactory().openSession()) 
		{
            return session.createQuery("FROM User", User.class).list();
        }
	}

	@Override
	public void updateUser(User user) 
	{

		Transaction transaction = null;
	    try (Session session = HibernateUtil.getSessionFactory().openSession()) 
	    {
	        transaction = session.beginTransaction();
	       
	            session.merge(user);
	       
	        transaction.commit();
	    } 
	    catch (Exception e) 
	    {
	        if (transaction != null) transaction.rollback();
	        e.printStackTrace();

	    }
	    
	}

}
