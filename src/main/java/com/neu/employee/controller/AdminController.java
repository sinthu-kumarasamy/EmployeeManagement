/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neu.employee.controller;

import com.neu.employee.dao.LeaveDao;
import com.neu.employee.dao.UserDao;
import com.neu.employee.exception.CreateException;
import com.neu.employee.model.LeaveInfo;
import com.neu.employee.model.User;
import com.neu.employee.validator.LeaveInfoValidator;
import com.neu.employee.validator.UserValidator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.apache.commons.text.RandomStringGenerator;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author Sindhu
 */
@Controller
public class AdminController {
    
    @Autowired
    UserDao userDao;
    
    @Autowired
    LeaveDao leaveDao;
    
    @Autowired
    UserValidator userValidator;
    
    @Autowired
    LeaveInfoValidator leaveValidator;
    
    @Autowired
    private JavaMailSender mailSender;
    
    @RequestMapping(value="/admin/list_employee.htm",method = RequestMethod.GET)
    protected ModelAndView doGet() throws CreateException {
        List<User> employeeList = userDao.getAllEmployees();
        if(employeeList.size()>0){
            for(User user: employeeList){
                String manager = userDao.getManager(user.getManager_id());
                System.out.println(manager);
                user.setManager(manager);

            }
        }
        return  new ModelAndView("list_employee","employeeList",employeeList);
    }
    
    @RequestMapping(value="/admin/list_leaves.htm",method = RequestMethod.GET)
    protected ModelAndView viewLeaves() throws CreateException {
       List<LeaveInfo> leavesList = leaveDao.getLeaveInfo();
        return  new ModelAndView("list_leaves","leaveList",leavesList);
    }
    
    @RequestMapping(value="/admin/add_employee.htm",method = RequestMethod.GET)
    protected ModelAndView addEmployee(Model model) throws CreateException {
        model.addAttribute("user",new User());
        List<User>managerList = userDao.getAllManagers();
        return  new ModelAndView("add_employee","managerList",managerList);
    }
    
    
    @RequestMapping(value="/admin/add_employee.htm",method = RequestMethod.POST)
    public ModelAndView submitUserData(@ModelAttribute("user")User user, HttpServletRequest request,BindingResult result,Model model) throws CreateException {
        userValidator.validate(user, result);
        List<User>managerList = userDao.getAllManagers();
         if(result.hasErrors()){
            return  new ModelAndView("add_employee","managerList",managerList);
            
        }
        if(request.getAttribute("unsafe_input")=="true"){
            return new  ModelAndView("login_error","errorMessage","Unsafe string literals are not allowed");
        } 
        RandomStringGenerator generator = new RandomStringGenerator.Builder().withinRange('a','z').build();
        String password = generator.generate(10);
        user.setPassword(password);
        userDao.registerNewUser(user);
        SimpleMailMessage email = new SimpleMailMessage();
        email.setTo(user.getEmail());
        email.setSubject("Welcome Abroad!");
        email.setText("Hello " + user.getFirst_name() + "," + "\n"
                        + "\nThanks for joining our organization as " + user.getTitle() + "\n"
                        + "We’re thrilled to have you in our organization. Please find your login credentials below:"
                        + "\n" + "\nUsername : " + user.getEmail() + "\n" 
                        + "\nPassowrd : " + password + "\n" + ""
                        + "\nAn temporary password has been given. Please reset you password using forgot passowrd option available in Login section\n" + ""
                        + "\n" + "\nRegards," + "\nHuman Resources Management");

        mailSender.send(email);
        List<User> employeeList = userDao.getAllEmployees();
        for(User u: employeeList){
            String manager = userDao.getManager(u.getManager_id());
            u.setManager(manager);
        }
        model.addAttribute("addedEmployee",true);
        return  new ModelAndView("list_employee","employeeList",employeeList);
           
        
    } 
    
    
    @RequestMapping(value="/admin/add_leaves.htm",method = RequestMethod.GET)
    protected ModelAndView addLeave(Model model) throws CreateException {
        model.addAttribute("leaveInfo",new LeaveInfo());
        List<User>employeeList = userDao.getAllEmployees();
        return  new ModelAndView("add_leave","employeeList",employeeList);
    }
    
    @RequestMapping(value="/admin/add_leaves.htm",method = RequestMethod.POST)
    public ModelAndView submitLeaveData(@ModelAttribute("leaveInfo")LeaveInfo leaveInfo, BindingResult result,Model model,HttpServletRequest request) throws CreateException { 
        leaveValidator.validate(leaveInfo, result);
        List<User>employeeList = userDao.getAllEmployees();
        if(result.hasErrors()){
            return  new ModelAndView("add_leave","employeeList",employeeList);
        }
        if(request.getAttribute("unsafe_input")=="true"){
            return new  ModelAndView("login_error","errorMessage","Unsafe string literals are not allowed");
        }
        String user_id = request.getParameter("user_id");
        User user = userDao.getUserById(Integer.parseInt(user_id));
        leaveInfo.setUser(user);
        leaveDao.addLeaveInfo(leaveInfo);
        List<LeaveInfo> leavesList = leaveDao.getLeaveInfo();
        model.addAttribute("addedLeave",true);
        return  new ModelAndView("list_leaves","leaveList",leavesList);
    }
    
    @RequestMapping(value="/admin/updateUser/{user_id}", method = RequestMethod.GET)
    public ModelAndView updateView(@PathVariable int user_id,HttpServletRequest request,Model model) throws CreateException {
            User user =  userDao.getUserById(user_id);
            List<User>managerList = userDao.getAllManagers();
            model.addAttribute("user", user);
            return  new ModelAndView("update_employee","managerList",managerList);
    }
    
    
    
    @RequestMapping(value="/admin/updateUser", method = RequestMethod.POST)
    public ModelAndView updateUserDetails(@ModelAttribute("user") User user,BindingResult result, HttpServletRequest request,Model model)  { 
        try {
            userValidator.validate(user, result);
            List<User>managerList = userDao.getAllManagers();
            if(result.hasErrors()){
                return  new ModelAndView("add_employee","managerList",managerList);
                
            }
            if(request.getAttribute("unsafe_input")=="true"){
                return new  ModelAndView("login_error","errorMessage","Unsafe string literals are not allowed");
            } 
            int user_id = Integer.parseInt(request.getParameter("id"));
            User userData =  userDao.getUserById(user_id); 
            userData.setAddress(user.getAddress());
            userData.setContact(user.getContact());
            userData.setEmail(user.getEmail());
            userData.setFirst_name(user.getFirst_name());
            userData.setLast_name(user.getLast_name());
            if(user.getRole().equals("associate")){
                userData.setManager_id(user.getManager_id());
            }
            userData.setRole(user.getRole());
            userData.setTitle(user.getTitle());
            userDao.updateUserDetails(userData);
            List<User> employeeList = userDao.getAllEmployees();
            for(User u: employeeList){
                String manager = userDao.getManager(u.getManager_id());
                u.setManager(manager);
            }
            model.addAttribute("updatedEmployee",true);
            return  new ModelAndView("list_employee","employeeList",employeeList);
        } catch (CreateException e) {
	      return new ModelAndView("login_error", "errorMessage", "An error occurred while updating user");
        }
    }
    
    @RequestMapping(value="/admin/deleteUser/{user_id}",method=RequestMethod.GET)    
    public String delete(@PathVariable int user_id) throws CreateException{   
        User user = userDao.getUserById(user_id);
        userDao.deleteUser(user);  
        return "redirect:/admin/list_employee.htm";   
    }
    
    @RequestMapping(value="/admin/deleteLeave/{id}",method=RequestMethod.GET)    
    public String deleteLeave(@PathVariable int id) throws CreateException{   
        LeaveInfo leave = leaveDao.getLeaveInfoById(id);
        leaveDao.deleteLeaveInfo(leave);
        return "redirect:/admin/list_leaves.htm";   
    }
   
    
    @RequestMapping(value="/admin/updateLeaves/{id}", method = RequestMethod.GET)
    public ModelAndView updateLeaveView(@PathVariable int id,HttpServletRequest request,Model model) throws CreateException {
            LeaveInfo leave = leaveDao.getLeaveInfoById(id);
            List<User> employeeList = userDao.getAllEmployees();
            model.addAttribute("leaveInfo", leave);
            return  new ModelAndView("update_leaves","employeeList",employeeList);
    }
    
     @RequestMapping(value="/admin/updateLeaves", method = RequestMethod.POST)
    public ModelAndView updateLeaveDetails(@ModelAttribute("leaveInfo")LeaveInfo leave,BindingResult result,HttpServletRequest request,Model model) throws CreateException {
            leaveValidator.validate(leave, result);
            List<User>employeeList = userDao.getAllEmployees();
            if(result.hasErrors()){
                return  new ModelAndView("add_leave","employeeList",employeeList);
            }
            if(request.getAttribute("unsafe_input")=="true"){
                return new  ModelAndView("login_error","errorMessage","Unsafe string literals are not allowed");
            }
            int leave_id = Integer.parseInt(request.getParameter("id"));
            LeaveInfo leaveData = leaveDao.getLeaveInfoById(leave_id);
            leaveData.setNo_of_days(leave.getNo_of_days());
            leaveData.setYear(leave.getYear());
            leaveDao.updateleaveDetails(leaveData);
            model.addAttribute("updatedLeave",true);
            List<LeaveInfo> leavesList = leaveDao.getLeaveInfo();
            return  new ModelAndView("list_leaves","leaveList",leavesList);
    }
    
    
}
