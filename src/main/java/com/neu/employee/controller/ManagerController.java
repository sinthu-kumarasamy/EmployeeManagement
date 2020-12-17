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
import com.neu.employee.validator.TaskValidator;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Sindhu
 */
@Controller
public class ManagerController {
    
    @Autowired
    TasksDao tasksDao;
    
    @Autowired
    UserDao userDao;
    
    @Autowired
    LeaveDao leaveDao;
    
    @Autowired
    TaskValidator taskValidator;
    
   
    
    @RequestMapping(value="/manager/list_tasks.htm",method = RequestMethod.GET)
    protected ModelAndView doGet(HttpServletRequest request,HttpSession session) throws CreateException {
	User user = (User) session.getAttribute("user");
        List<Tasks> taskList = tasksDao.getTasks(user.getUser_id());
        return  new ModelAndView("list_tasks","taskList",taskList);
    }
    
    @RequestMapping(value="/manager/add_tasks.htm",method = RequestMethod.GET)
    protected ModelAndView addTasks(Model model,HttpServletRequest request) throws CreateException {
        model.addAttribute("task",new Tasks());
        HttpSession session = (HttpSession) request.getSession();
	User user = (User) session.getAttribute("user");
        List<User>employeeList = userDao.getEmployeesByManagerId(user.getUser_id());
        return  new ModelAndView("add_tasks","employeeList",employeeList);
    }
    
    @RequestMapping(value="/manager/add_tasks.htm",method = RequestMethod.POST)
    public ModelAndView createNewTask(@ModelAttribute("task")Tasks task, BindingResult result,Model model,HttpServletRequest request) throws CreateException, ParseException { 
        taskValidator.validate(task, result);
        if(result.hasErrors()){
            HttpSession session = (HttpSession) request.getSession();
            User user = (User) session.getAttribute("user");
            List<User>employeeList = userDao.getEmployeesByManagerId(user.getUser_id());
           return  new ModelAndView("add_tasks","employeeList",employeeList); 
        }
        String user_id = request.getParameter("user_id");
        User user = userDao.getUserById(Integer.parseInt(user_id));
        Date start_date = new SimpleDateFormat("yyyy-mm-dd").parse(request.getParameter("start_date")); 
        Date end_date=new SimpleDateFormat("yyyy-mm-dd").parse(request.getParameter("end_date")); 
        task.setStart_date(start_date);
        task.setEnd_date(end_date);
        task.setUser(user);
        tasksDao.addTask(task);
        HttpSession session = (HttpSession) request.getSession();
	User manager = (User) session.getAttribute("user");
        List<Tasks> taskList = tasksDao.getTasks(manager.getUser_id());
        model.addAttribute("addedTask",true);
        return  new ModelAndView("list_tasks","taskList",taskList);
    } 
    
    @RequestMapping(value="/manager/approve_leaves.htm",method = RequestMethod.GET)
    protected ModelAndView approveLeaves(HttpServletRequest request,Model model) throws CreateException {
        HttpSession session = (HttpSession) request.getSession();
	User user = (User) session.getAttribute("user");
         model.addAttribute("approve", false);
        List<EmployeeLeave>leavesList = leaveDao.getLeavesForApproval(user.getUser_id());
        return  new ModelAndView("approve_leaves","leaveList",leavesList);
    }
    
    @RequestMapping(value="/manager/approve_leaves.htm",method = RequestMethod.POST)
    protected ModelAndView approveLeaveByManager(HttpServletRequest request,Model model) throws CreateException {
        int id = Integer.parseInt(request.getParameter("id"));
        EmployeeLeave leave = leaveDao.getLeaveById(id);
        leave.setStatus(request.getParameter("action"));
        HttpSession session = (HttpSession) request.getSession();
	User user = (User) session.getAttribute("user");
        model.addAttribute("approve", true);
        List<EmployeeLeave>leavesList = leaveDao.getLeavesForApproval(user.getUser_id());
        return  new ModelAndView("approve_leaves","leaveList",leavesList);
    }
}
