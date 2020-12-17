/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neu.employee.controller;

import com.neu.employee.dao.LeaveDao;
import com.neu.employee.dao.TasksDao;
import com.neu.employee.dao.UserDao;
import com.neu.employee.exception.CreateException;
import com.neu.employee.model.EmployeeLeave;
import com.neu.employee.model.Tasks;
import com.neu.employee.model.User;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Sindhu
 */
@Controller
public class AssociateController {
    @Autowired
    TasksDao tasksDao;
    
    @Autowired
    UserDao userDao;
    
    @Autowired
    LeaveDao leaveDao;
    
    @RequestMapping(value="/associate/employee_tasks.htm",method = RequestMethod.GET)
    protected ModelAndView doGet(HttpServletRequest request,ModelMap map) throws CreateException {
        HttpSession session = (HttpSession) request.getSession();
	User user = (User) session.getAttribute("user");
        List<Tasks>completedTasks = tasksDao.getAllCompletedTasks(user);
        List<Tasks>overdueTasks = tasksDao.getOverdueTasks(user);
        List<Tasks>pendingTasks = tasksDao.getAllActiveTasks(user);
        map.put("pending",pendingTasks);
        map.put("overdue",overdueTasks);
        map.put("completed",completedTasks);
        return  new ModelAndView("employee_tasks","map",map);
    }
    
    @RequestMapping(value="/associate/employee_leaves.htm",method = RequestMethod.GET)
    protected ModelAndView showAppliedLeaves(HttpServletRequest request) throws CreateException {
        HttpSession session = (HttpSession) request.getSession();
	User user = (User) session.getAttribute("user");
        List<EmployeeLeave>leavesList = leaveDao.getLeaveByUserId(user);
       return  new ModelAndView("employee_leaves","leaveList",leavesList);
    }
     
    
    @RequestMapping(value="/associate/apply_leaves.htm",method = RequestMethod.GET)
    protected ModelAndView applyLeaveForm(HttpServletRequest request) throws CreateException {
        HttpSession session = (HttpSession) request.getSession();
	User user = (User) session.getAttribute("user");
        List<EmployeeLeave>leavesList = leaveDao.getLeaveByUserId(user);
        return  new ModelAndView("apply_leaves","leave",new EmployeeLeave());
    }
    
    
    @RequestMapping(value="/associate/apply_leaves.htm",method = RequestMethod.POST)
    protected ModelAndView applyLeave(@ModelAttribute("leave")EmployeeLeave leave, BindingResult result,Model model,HttpServletRequest request) throws CreateException, ParseException {
        Date start_date = new SimpleDateFormat("yyyy-mm-dd").parse(request.getParameter("start_date")); 
        Date end_date=new SimpleDateFormat("yyyy-mm-dd").parse(request.getParameter("end_date")); 
        leave.setStart_date(start_date);
        leave.setEnd_date(end_date);
        HttpSession session = (HttpSession) request.getSession();
	User user = (User) session.getAttribute("user");
        leaveDao.applyLeave(leave, user);
        List<EmployeeLeave>leavesList = leaveDao.getLeaveByUserId(user);
        return  new ModelAndView("employee_leaves","leaveList",leavesList);
    }
    
    @RequestMapping(value="/associate/updateTask.htm",method=RequestMethod.POST)
    protected ModelAndView updateTask(HttpServletRequest request,ModelMap map){
        int id = Integer.parseInt(request.getParameter("id"));
        tasksDao.updateTask(id);
        HttpSession session = (HttpSession) request.getSession();
	User user = (User) session.getAttribute("user");
        List<Tasks>completedTasks = tasksDao.getAllCompletedTasks(user);
        List<Tasks>overdueTasks = tasksDao.getOverdueTasks(user);
        List<Tasks>pendingTasks = tasksDao.getAllActiveTasks(user);
        map.put("pending",pendingTasks);
        map.put("overdue",overdueTasks);
        map.put("completed",completedTasks);
        return  new ModelAndView("employee_tasks","map",map);   
    }
    
    
}
