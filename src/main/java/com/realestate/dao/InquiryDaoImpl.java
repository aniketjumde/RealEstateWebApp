package com.realestate.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.realestate.model.Inquiry;
import com.realestate.util.HibernateUtil;

public class InquiryDaoImpl implements InquiryDAO
{

	@Override
	public void saveInquiry(Inquiry inquiry) 
	{
        Transaction transaction=null;
		try(Session session=HibernateUtil.getSessionFactory().openSession();)
		{
			transaction=session.beginTransaction();
			
			session.persist(inquiry);
			
			transaction.commit();
		}
		catch(Exception e)
		{
			 if (transaction != null) transaction.rollback();
	           
			e.printStackTrace();
		}
		
	}

	@Override
	public List<Inquiry> getInquiriesByReceiver(Long sellerId) 
	{
		try(Session session=HibernateUtil.getSessionFactory().openSession();)
		 {
			return session.createQuery(
		            "SELECT i FROM Inquiry i " +
		            "JOIN FETCH i.property p " +
		            "JOIN FETCH i.sender s " +
		            "WHERE i.receiver.id = :sellerId " +
		            "ORDER BY i.inquiryId DESC",
		            Inquiry.class
		        )
		        .setParameter("sellerId", sellerId)
		        .getResultList();
		 }
		 catch(Exception e)
		 {
				e.printStackTrace();
		
		 }
		return null;
	}

	@Override
	public List<Inquiry> getInquiriesBySender(Long buyerId)
	{
		try(Session session=HibernateUtil.getSessionFactory().openSession();)
		 {
			return session.createQuery(
		            "SELECT i FROM Inquiry i " +
		            "JOIN FETCH i.property p " +
		            "JOIN FETCH i.receiver r " +
		            "WHERE i.sender.id = :buyerId " +
		            "ORDER BY i.inquiryId DESC",
		            Inquiry.class
		        )
		        .setParameter("buyerId", buyerId)
		        .getResultList();
		 }
		 catch(Exception e)
		 {
				e.printStackTrace();
		
		 }
		return null;
	}

	@Override
	public Inquiry getInquiryById(Long inquiryId)
	{
		 try (Session session = HibernateUtil.getSessionFactory().openSession()) 
		 {
	            return session.get(Inquiry.class, inquiryId);
	     }
		 catch(Exception e)
		 {
				e.printStackTrace();
		
		 }
		return null;
	}

	@Override
	public void updateInquiry(Inquiry inquiry) 
	{
		 Transaction transaction=null;
		 try(Session session=HibernateUtil.getSessionFactory().openSession();)
		 {
			 transaction=session.beginTransaction();

			 session.merge(inquiry);
			 
			 transaction.commit();
		 }
		 catch(Exception e)
		 {
			 if (transaction != null) transaction.rollback();

			 e.printStackTrace();
		
		 }
	}
}
