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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
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
public class ManagerController {
    
    @Autowired
    TasksDao tasksDao;
    
    @Autowired
    UserDao userDao;
    
    @Autowired
    LeaveDao leaveDao;
    
    @Autowired
    TaskValidator taskValidator;
    
   @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");
        format.setLenient(true);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
    }
    
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
        if(request.getAttribute("unsafe_input")=="true"){
                return new  ModelAndView("login_error","errorMessage","Unsafe string literals are not allowed");
            }
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
        List<EmployeeLeave>leavesList = leaveDao.getLeavesForApproval(user.getUser_id());
        return  new ModelAndView("approve_leaves","leaveList",leavesList);
    }
    
    @RequestMapping(value="/manager/approve_leaves.htm",method = RequestMethod.POST)
    protected ModelAndView approveLeaveByManager(HttpServletRequest request,Model model) throws CreateException {
         if(request.getAttribute("unsafe_input")=="true"){
                return new  ModelAndView("login_error","errorMessage","Unsafe string literals are not allowed");
            }
        int id = Integer.parseInt(request.getParameter("id"));
        EmployeeLeave leave = leaveDao.getLeaveById(id);
        leave.setStatus(request.getParameter("action"));
        HttpSession session = (HttpSession) request.getSession();
	User user = (User) session.getAttribute("user");
        model.addAttribute("approve", true);
        List<EmployeeLeave>leavesList = leaveDao.getLeavesForApproval(user.getUser_id());
        return  new ModelAndView("approve_leaves","leaveList",leavesList);
    }
    
     @RequestMapping(value="/manager/deleteTask/{id}",method=RequestMethod.GET)    
    public String deleteTask(@PathVariable int id) throws CreateException{   
       Tasks task = tasksDao.getTaskById(id);
       tasksDao.deleteTask(task);
        return "redirect:/manager/list_tasks.htm";   
    }
    
    
    @RequestMapping(value="/manager/updateTask/{id}", method = RequestMethod.GET)
    public ModelAndView updateTasksView(@PathVariable int id,HttpServletRequest request,Model model) throws CreateException {
            Tasks task = tasksDao.getTaskById(id);
            HttpSession session = (HttpSession) request.getSession();
            User user = (User) session.getAttribute("user");
            List<User>employeeList = userDao.getEmployeesByManagerId(user.getUser_id());
            model.addAttribute("task", task);
            return  new ModelAndView("update_tasks","employeeList",employeeList);
    }
    
     @RequestMapping(value="/manager/updateTask", method = RequestMethod.POST)
     public ModelAndView updateTasks(@ModelAttribute("task")Tasks task,BindingResult result,HttpServletRequest request,Model model) throws CreateException, ParseException {
           taskValidator.validate(task, result);
            if(result.hasErrors()){
                HttpSession session = (HttpSession) request.getSession();
                User user = (User) session.getAttribute("user");
                List<User>employeeList = userDao.getEmployeesByManagerId(user.getUser_id());
               return  new ModelAndView("add_tasks","employeeList",employeeList); 
            }
             if(request.getAttribute("unsafe_input")=="true"){
                return new  ModelAndView("login_error","errorMessage","Unsafe string literals are not allowed");
            }
            int task_id = Integer.parseInt(request.getParameter("id"));
            Tasks taskData = tasksDao.getTaskById(task_id); 
            taskData.setCredits(task.getCredits());
            String user_id = request.getParameter("user_id");
            User user = userDao.getUserById(Integer.parseInt(user_id));
            Date start_date = new SimpleDateFormat("yyyy-mm-dd").parse(request.getParameter("start_date")); 
            Date end_date=new SimpleDateFormat("yyyy-mm-dd").parse(request.getParameter("end_date")); 
            taskData.setStart_date(start_date);
            taskData.setEnd_date(end_date);
            taskData.setTaskDesc(task.getTaskDesc());
            taskData.setStatus(task.getStatus());
            taskData.setUser(user);
            tasksDao.updateTaskDetails(taskData);
            HttpSession session = (HttpSession) request.getSession();
            User manager = (User) session.getAttribute("user");
            List<Tasks> taskList = tasksDao.getTasks(manager.getUser_id());
            model.addAttribute("updatedTask",true);
            return  new ModelAndView("list_tasks","taskList",taskList);
    }
    
}
