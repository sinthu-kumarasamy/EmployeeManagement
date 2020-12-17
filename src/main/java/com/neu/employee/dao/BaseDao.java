/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neu.employee.dao;

import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author Surya
 */
public class BaseDao {
    private static final Logger log = Logger.getAnonymousLogger();
    
    private static final ThreadLocal sessionThread = new ThreadLocal();
    protected static final SessionFactory sessionFactory = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();

    protected BaseDao() {
    }

    public static Session getSession()
    {
        Session session = (Session) BaseDao.sessionThread.get();
        
        if (session == null)
        {
            session = sessionFactory.openSession();
            BaseDao.sessionThread.set(session);
        }
        return session;
    }

    protected void begin() {
        getSession().beginTransaction();
    }

    protected void commit() {
        getSession().getTransaction().commit();
    }

    protected void rollback() {
        try {
            getSession().getTransaction().rollback();
        } catch (HibernateException e) {
            log.log(Level.WARNING, "Cannot rollback", e);
        }
        try {
            getSession().close();
        } catch (HibernateException e) {
            log.log(Level.WARNING, "Cannot close", e);
        }
        BaseDao.sessionThread.set(null);
    }

    public static void close() {
        getSession().close();
        BaseDao.sessionThread.set(null);
    }
}
