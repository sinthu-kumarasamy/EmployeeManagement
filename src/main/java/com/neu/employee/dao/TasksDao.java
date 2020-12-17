/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neu.employee.dao;

/**
 *
 * @author Sindhu
 */
//import java.sql.Date;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.query.Query;

import com.neu.employee.exception.CreateException;
import com.neu.employee.model.Tasks;
import com.neu.employee.model.User;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Iterator;

public class TasksDao extends BaseDao {

	public Tasks addTask(Tasks task) throws CreateException{
		try {
			begin();
			getSession().save(task);
			commit();
			return task;
		} catch(HibernateException e) {
			rollback();
			throw new CreateException("Unable to register the user " + e.getMessage());
		}
	}
	
	public List<Tasks> getAllTasks() throws HibernateException {
		try {
			begin();
			Query query = getSession().createQuery("from Tasks");
			List<Tasks> taskList = query.list();
			commit();
			return taskList;
		} catch (HibernateException e) {
			rollback();
			throw new HibernateException("Unable to fetch all tasks", e);
		}
	}
        
        public List<Tasks> getTasks(int manager_id) throws CreateException {
		try {
			begin();
			Query query = getSession().createQuery("select t.id, t.taskDesc, t.credits, t.user,t.start_date,t.end_date,"
                                + "t.status from Tasks t JOIN User u on u.user_id = t.user where u.manager_id=:manager_id");
                        query.setParameter("manager_id", manager_id);
                        List<Object[]> res = query.getResultList(); 
                        List<Tasks> taskList= new ArrayList<Tasks>(); 
                        Iterator it = res.iterator();
                        while(it.hasNext()){
                             Object[] obj = (Object[]) it.next();
                             Tasks task = new Tasks();
                             task.setId(Integer.parseInt(obj[0].toString()));
                             task.setTaskDesc(obj[1].toString());
                             task.setCredits(Integer.parseInt(obj[2].toString()));
                             task.setUser((User)obj[3]);
                             Timestamp start_date = (Timestamp)obj[4];
                             task.setStart_date(new Date(start_date.getTime()));
                             Timestamp end_date = (Timestamp)obj[5];
                             task.setEnd_date(new Date(end_date.getTime()));
                             task.setStatus(obj[6].toString());
                             taskList.add(task);
                        }
                        commit();
			return taskList;
		} catch (HibernateException e) {
			rollback();
			throw new CreateException("Unable to fetch all employees", e);
		}
	}
    
	public List<Tasks> getAllActiveTasks(User user) throws HibernateException {
		try {
			Query query = getSession().createQuery("from Tasks where user=:user and status=:status and end_date>=:today");
                        query.setParameter("user", user);
			query.setParameter("today", new Date());
                        query.setParameter("status", "pending");
			List<Tasks> taskList = query.list();
			return taskList;
		} catch (HibernateException e) {
			throw new HibernateException("Unable to fetch active tasks", e);
		}
	}
        
        public List<Tasks> getAllCompletedTasks(User user) throws HibernateException {
		try {
			Query query = getSession().createQuery("from Tasks where user=:user and status=:status");
                        query.setParameter("user", user);
                        query.setParameter("status", "completed");
			List<Tasks> taskList = query.list();
			return taskList;
		} catch (HibernateException e) {
			throw new HibernateException("Unable to fetch completed tasks", e);
		}
	}
	
	public List<Tasks> getOverdueTasks(User user) throws HibernateException {
		try {
			Query query = getSession().createQuery("from Tasks where user=:user and end_date<=:end_date and status=:status");
			query.setParameter("user", user);
			query.setParameter("status", "pending");
			query.setParameter("end_date", new Date());
			List<Tasks> taskList = query.list();
                         System.out.println(taskList);
			return taskList;
		} catch (HibernateException e) {
			throw new HibernateException("Unable to fetch overdue tasks", e);
		}
	}
        
        public void updateTask(int id) throws HibernateException{
            try {
                        begin();
			Query query = getSession().createQuery("from Tasks where id=:id");
			query.setParameter("id", id);
			Tasks task = (Tasks) query.uniqueResult();
                        Date current_date = new Date();
                        if(task.getEnd_date().compareTo(current_date)<0){
                            task.setCredits(0);
                        }
                        task.setStatus("completed");
                        getSession().save(task);
                        commit();
		} catch (HibernateException e) {
			throw new HibernateException("Unable to fetch overdue tasks", e);
		}
            
        }
}
