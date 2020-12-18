/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neu.employee.dao;

import static com.neu.employee.dao.BaseDao.getSession;
import com.neu.employee.exception.CreateException;
import com.neu.employee.model.EmployeeLeave;
import com.neu.employee.model.LeaveInfo;
import com.neu.employee.model.User;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.query.Query;

/**
 *
 * @author Sindhu
 */
public class LeaveDao extends BaseDao{
    
     public LeaveInfo addLeaveInfo(LeaveInfo leaveInfo) throws CreateException {
		try {
			begin();
			LeaveInfo leaveData = new LeaveInfo();
                        leaveData.setUser(leaveInfo.getUser());
                        leaveData.setNo_of_days(leaveInfo.getNo_of_days());
                        leaveData.setYear(leaveInfo.getYear());
			getSession().save(leaveData);
			commit();
			return leaveData;
		} catch (HibernateException e) {
			rollback();
			throw new CreateException("Unable to add leave data for the user " + e.getMessage());
		}
	}
    
    public List<LeaveInfo> getLeaveInfo() throws CreateException {
		try {
			begin();
			Query query = getSession().createQuery("from LeaveInfo");
			List<LeaveInfo> leavesList = query.list();
			commit();
			return leavesList;
		} catch (HibernateException e) {
			rollback();
			throw new CreateException("Unable to fetch all employees", e);
		}
	}
    
    public List<EmployeeLeave> getLeavesForApproval(int manager_id) throws CreateException {
		try {
			begin();
			Query query = getSession().createQuery("select e.id, e.user,e.reason,e.start_date,e.end_date,"
                                + "e.status from EmployeeLeave e JOIN User u on u.user_id = e.user where u.manager_id=:manager_id");
                        query.setParameter("manager_id", manager_id);
                        List<Object[]> res = query.getResultList(); 
                        List<EmployeeLeave> leavesList= new ArrayList<EmployeeLeave>(); 
                        Iterator it = res.iterator();
                        while(it.hasNext()){
                             Object[] obj = (Object[]) it.next();
                             EmployeeLeave leave = new EmployeeLeave();
                             leave.setId(Integer.parseInt(obj[0].toString()));
                             leave.setUser((User)obj[1]);
                             leave.setReason(obj[2].toString());
                             Timestamp start_date = (Timestamp)obj[3];
                             leave.setStart_date(new Date(start_date.getTime()));
                             Timestamp end_date = (Timestamp)obj[4];
                             leave.setEnd_date(new Date(end_date.getTime()));
                             leave.setStatus(obj[5].toString());
                             leavesList.add(leave);
                        }
			commit();
			return leavesList;
		} catch (HibernateException e) {
			rollback();
			throw new CreateException("Unable to fetch all employees", e);
		}
	}
    
    public EmployeeLeave getLeaveById(int id) throws CreateException{
        try {
			begin();
			Query query = getSession().createQuery("from EmployeeLeave where id=:id");
			query.setParameter("id", id);
			EmployeeLeave leave = (EmployeeLeave) query.uniqueResult();
			commit();
			return leave;
		} catch (HibernateException e) {
			rollback();
			throw new CreateException("Data not found for given id", e);
		}
    }
     public List<LeaveInfo> getUserLeaveById(User user) throws CreateException{
        try {
			begin();
			Query query = getSession().createQuery("from LeaveInfo where user=:user");
			query.setParameter("user", user);
			List<LeaveInfo> leavesList = query.list();
			commit();
			return leavesList;
		} catch (HibernateException e) {
			rollback();
			throw new CreateException("Data not found for given id", e);
		}
    }
    
    
      public LeaveInfo getLeaveInfoById(int id) throws CreateException{
        try {
			begin();
			Query query = getSession().createQuery("from LeaveInfo where id=:id");
			query.setParameter("id", id);
			LeaveInfo leave = (LeaveInfo) query.uniqueResult();
			commit();
			return leave;
		} catch (HibernateException e) {
			rollback();
			throw new CreateException("Data not found for given id", e);
		}
    }
    
       public void updateleaveDetails(LeaveInfo leaveData) {
    	try {
                begin();
                getSession().update(leaveData);
                commit();
        } catch (HibernateException e) {
		rollback();
		throw new HibernateException("Unable to update the leave details " + e.getMessage());
        }
    }
    
    
     public List<EmployeeLeave> getLeaveByUserId(User user) throws CreateException{
        try {
			begin();
			Query query = getSession().createQuery("from EmployeeLeave where user=:user");
			query.setParameter("user", user);
			List<EmployeeLeave> leavesList = query.list();
			commit();
			return leavesList;
		} catch (HibernateException e) {
			rollback();
			throw new CreateException("Data not found for given id", e);
		}
    }
   
    public void updateLeave(EmployeeLeave leave) throws CreateException {
		try {
			begin();
			getSession().update(leave);
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new CreateException("Unable to update leave information", e);
		}
    }
    
     public EmployeeLeave applyLeave(EmployeeLeave leave,User user) throws CreateException {
		try {
			begin();
			EmployeeLeave addLeave = new EmployeeLeave();
                        addLeave.setReason(leave.getReason());
                        addLeave.setStart_date(leave.getStart_date());
                        addLeave.setEnd_date(leave.getEnd_date());
                        if(addLeave.getStatus()==null){
                            addLeave.setStatus("Applied");
                        }
                        addLeave.setUser(user);
			getSession().save(addLeave);
			commit();
			return addLeave;
		} catch (HibernateException e) {
			rollback();
			throw new CreateException("Unable to add leave data for the user " + e.getMessage());
		}
	}
      public void deleteLeaveInfo(LeaveInfo leave) {
    	
    	try {
			begin();
			getSession().delete(leave);
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new HibernateException("Unable to delete" + e.getMessage());
		}
    }
      
      public void deleteLeave(EmployeeLeave leave) {
    	
    	try {
			begin();
			getSession().delete(leave);
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new HibernateException("Unable to delete" + e.getMessage());
		}
    }
     
        
    
}
