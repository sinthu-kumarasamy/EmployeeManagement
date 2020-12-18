/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neu.employee.dao;

import com.neu.employee.exception.CreateException;
import com.neu.employee.model.User;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.query.Query;

/**
 *
 * @author Sindhu
 */
public class UserDao extends BaseDao{

    public UserDao() {
    }
    
   public List<User> getAllEmployees() throws CreateException {
		try {
			begin();
			Query query = getSession().createQuery("from User where role!=:role");
                        query.setParameter("role", "admin");
			List<User> employeeList = query.list();
			commit();
			return employeeList;
		} catch (HibernateException e) {
			rollback();
			throw new CreateException("Unable to fetch all employees", e);
		}
	}
   
    public List<User> getEmployeesByManagerId(int manager_id) throws CreateException {
		try {
			begin();
			Query query = getSession().createQuery("from User where manager_id=:manager_id");
                        query.setParameter("manager_id", manager_id);
			List<User> employeeList = query.list();
			commit();
			return employeeList;
		} catch (HibernateException e) {
			rollback();
			throw new CreateException("Unable to fetch  employees reporting to this manager", e);
		}
	}
   
    public List<User> getAllManagers() throws CreateException {
		try {
			begin();
			Query query = getSession().createQuery("from User where role=:role");
                        query.setParameter("role", "manager");
			List<User> employeeList = query.list();
			commit();
			return employeeList;
		} catch (HibernateException e) {
			rollback();
			throw new CreateException("Unable to fetch all managers", e);
		}
	}
     public User getUser(String email, String password) throws CreateException {
		try {
			begin();
			Query query = getSession().createQuery("from User where email = :email and password = :password");
			query.setParameter("email", email);
			query.setParameter("password", password);
			User userResult = (User) query.uniqueResult();
			commit();
			return userResult;
		} catch (HibernateException e) {
			rollback();
			throw new CreateException("User not found" + email, e);
		}
	}
     
     public User fetchUserByEmail(String email) throws CreateException {
		try {
			begin();
			Query query = getSession().createQuery("from User where email = :email");
			query.setParameter("email", email);
			User user = (User) query.uniqueResult();
			commit();
			return user;

		} catch (HibernateException e) {
			rollback();
			throw new CreateException("e-mail could not be fetched " + email, e);
		}
	}
    
   
   public String getManager(int user_id) throws CreateException{
       try {
			begin();
			String manager = (String)getSession().createQuery("select concat(first_name, ' ', last_name) as fullName from User where user_id=:user_id").setParameter("user_id",user_id).uniqueResult();
			commit();
                        return manager;
		} catch (HibernateException e) {
			rollback();
			throw new CreateException("Unable to fetch manager for given id", e);
		}
   }
    
    public User getUserById(int user_id) throws CreateException {
		try {
			begin();
			Query query = getSession().createQuery("from User where user_id = :user_id");
			query.setParameter("user_id", user_id);
			User userResult = (User) query.uniqueResult();
			commit();
			return userResult;
		} catch (HibernateException e) {
			rollback();
			throw new CreateException("User not found" + user_id, e);
		}
	}
    
    
    
    public User registerNewUser(User userData) throws CreateException {
		try {
			begin();
			User user = new User();
                        user.setFirst_name(userData.getFirst_name());
                        user.setLast_name(userData.getLast_name());
                        user.setEmail(userData.getEmail());
                        if(userData.getRole()==null){
                             user.setRole("admin");
                        }else{
                             user.setRole(userData.getRole());
                        }
                        if(userData.getRole()!=null && userData.getRole().equals("manager")){
                            user.setManager_id(0);
                        }else{
                             user.setManager_id(userData.getManager_id()); 
                        }
                       user.setPassword(userData.getPassword()); 
                        user.setAddress(userData.getAddress());
                        user.setContact(userData.getContact());
                        user.setTitle(userData.getTitle());
			getSession().save(user);
			commit();
			return user;
		} catch (HibernateException e) {
			rollback();
			throw new CreateException("Unable to register the user " + e.getMessage());
		}
	}
    
     public void deleteUser(User user) {
    	
    	try {
			begin();
			getSession().delete(user);
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new HibernateException("Unable to delete the user " + e.getMessage());
		}
    }
    
       public void updateUserDetails(User userData) {
    	try {
                begin();
                getSession().update(userData);
                commit();
        } catch (HibernateException e) {
		rollback();
		throw new HibernateException("Unable to update the user " + e.getMessage());
        }
    }
    
    
   
    
}
