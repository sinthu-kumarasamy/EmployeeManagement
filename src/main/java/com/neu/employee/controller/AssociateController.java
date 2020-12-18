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
import com.neu.employee.model.LeaveInfo;
import com.neu.employee.model.Tasks;
import com.neu.employee.model.User;
import com.neu.employee.validator.EmployeeLeaveValidator;
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
import org.springframework.ui.ModelMap;
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
public class AssociateController {
    @Autowired
    TasksDao tasksDao;
    
    @Autowired
    UserDao userDao;
    
    @Autowired
    LeaveDao leaveDao;
    
    @Autowired
    EmployeeLeaveValidator empLeaveValidator;
    
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");
        format.setLenient(true);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
    }
    
    @RequestMapping(value="/associate/employee_tasks.htm",method = RequestMethod.GET)
    protected ModelAndView doGet(HttpServletRequest request,ModelMap map) throws CreateException {
        HttpSession session = (HttpSession) request.getSession();
	User user = (User) session.getAttribute("user");
        List<Tasks>completedTasks = tasksDao.getAllCompletedTasks(user);
        List<Tasks>overdueTasks = tasksDao.getOverdueTasks(user);
        List<Tasks>pendingTasks = tasksDao.getAllActiveTasks(user);
        Long credits = tasksDao.getCredits(user);
        session.setAttribute("credits", credits);
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
        return  new ModelAndView("apply_leaves","leave",new EmployeeLeave());
    }
    
    
    @RequestMapping(value="/associate/apply_leaves.htm",method = RequestMethod.POST)
    protected ModelAndView applyLeave(@ModelAttribute("leave")EmployeeLeave leave, BindingResult result,Model model,HttpServletRequest request) throws CreateException, ParseException {
        if(request.getAttribute("unsafe_input")=="true"){
            model.addAttribute("errorMessage","Please enter valid input");
             return  new ModelAndView("apply_leaves"); 
         }
        empLeaveValidator.validate(leave, result);
        if(result.hasErrors()){
           return  new ModelAndView("apply_leaves"); 
        }
        HttpSession session = (HttpSession) request.getSession();
	User user = (User) session.getAttribute("user");
        List<LeaveInfo> leaveData = leaveDao.getUserLeaveById(user);
        Date start_date = new SimpleDateFormat("yyyy-mm-dd").parse(request.getParameter("start_date")); 
        Date end_date=new SimpleDateFormat("yyyy-mm-dd").parse(request.getParameter("end_date"));
        boolean flag = false; 
        for(LeaveInfo l  : leaveData){
            System.out.println(start_date.getYear());
            if(((start_date.getYear()+1900)== l.getYear() || (end_date.getYear()+1900)==l.getYear()) && l.getNo_of_days()>0){
                flag=true;
            }
        }
        if(flag){
           leave.setStart_date(start_date);
            leave.setEnd_date(end_date);
            leaveDao.applyLeave(leave, user);
             List<EmployeeLeave>leavesList = leaveDao.getLeaveByUserId(user);
            return  new ModelAndView("employee_leaves","leaveList",leavesList);  
        }else{
            model.addAttribute("applyLeave",true);
             List<EmployeeLeave>leavesList = leaveDao.getLeaveByUserId(user);
            return  new ModelAndView("employee_leaves","leaveList",leavesList);  
        }
        
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
    @RequestMapping(value="/associate/editLeaves/{id}", method = RequestMethod.GET)
    public ModelAndView updateLeaveView(@PathVariable int id,HttpServletRequest request,Model model) throws CreateException {
            EmployeeLeave leave = leaveDao.getLeaveById(id);
            model.addAttribute("leave", leave);
            return  new ModelAndView("update_appliedLeaves");
    }
    @RequestMapping(value="/associate/deleteLeave/{id}",method=RequestMethod.GET)    
    public String deleteTask(@PathVariable int id) throws CreateException{   
       EmployeeLeave leave = leaveDao.getLeaveById(id);
       leaveDao.deleteLeave(leave);
        return "redirect:/associate/employee_leaves.htm";   
    }
    
    @RequestMapping(value="/associate/editLeaves.htm", method = RequestMethod.POST)
     public ModelAndView updateleave(@ModelAttribute("leave")EmployeeLeave leave,HttpServletRequest request,Model model,BindingResult result) throws CreateException, ParseException {
          if(request.getAttribute("unsafe_input")=="true"){
                model.addAttribute("errorMessage","Please enter valid input");
                return  new ModelAndView("update_leaves"); 
            } 
           empLeaveValidator.validate(leave, result);
            if(result.hasErrors()){
               return  new ModelAndView("update_leaves"); 
            }
           int leave_id = Integer.parseInt(request.getParameter("id"));
             EmployeeLeave leaveData = leaveDao.getLeaveById(leave_id);
            leaveData.setReason(leave.getReason());
            System.out.println(leaveData.getStart_date());
            HttpSession session = (HttpSession) request.getSession();
            User user = (User) session.getAttribute("user");
            Date start_date = new SimpleDateFormat("yyyy-mm-dd").parse(request.getParameter("start_date")); 
            Date end_date=new SimpleDateFormat("yyyy-mm-dd").parse(request.getParameter("end_date")); 
            leaveData.setStart_date(start_date);
            leaveData.setEnd_date(end_date);
            leaveData.setUser(user);
            leaveData.setStatus("Applied");
            leaveDao.updateLeave(leaveData);
            model.addAttribute("updatedLeave",true);
            List<EmployeeLeave>leavesList = leaveDao.getLeaveByUserId(user);
            return  new ModelAndView("employee_leaves","leaveList",leavesList);
    }
    
}
