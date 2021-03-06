/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neu.employee.controller;

import com.neu.employee.dao.UserDao;
import com.neu.employee.exception.CreateException;
import com.neu.employee.model.User;
import com.neu.employee.validator.LoginValidator;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Sindhu
 */
@Controller
public class UserLoginContoller {
    
    @Autowired
    UserDao userDao;
    
    @Autowired
    LoginValidator loginValidator;
       
    @RequestMapping(value="/login.htm",method = RequestMethod.GET)
    protected String doGet(Model model) {
        model.addAttribute("user",new User());
        return "home";
    }
    
    @RequestMapping(value="/reset_password.htm",method = RequestMethod.GET)
    protected String resetView(Model model) {
        model.addAttribute("user",new User());
        return "reset_password";
    }
    
    @RequestMapping(value="/reset_password.htm",method = RequestMethod.POST)
    protected ModelAndView resetPassword(@ModelAttribute("user")User user,Model model,BindingResult result,HttpServletRequest request) throws CreateException {
       if(request.getAttribute("unsafe_input")=="true"){
            return new  ModelAndView("reset_password","errorMessage","Please enter valid input");
        }
        loginValidator.validate(user, result);
        if (result.hasErrors()) {
                return new ModelAndView("reset_password");
        }
        User userData = userDao.fetchUserByEmail(user.getEmail());
        userData.setPassword(user.getPassword());
        userDao.updateUserDetails(userData);
        model.addAttribute("resetSuccess", true);
        return new ModelAndView("home");
    }
    
    @RequestMapping(value = "/login.htm", method = RequestMethod.POST)
    protected ModelAndView user_login(@ModelAttribute("user")User user, BindingResult result,HttpServletRequest request,HttpServletResponse response,Model model,HttpSession session) throws Exception {
        if(request.getAttribute("unsafe_input")=="true"){
            return new  ModelAndView("home","errorMessage","Please enter valid input");
        }
        loginValidator.validate(user, result);
        if (result.hasErrors()) {
                return new ModelAndView("home");
        }
        try {
                    User userData = userDao.getUser(user.getEmail(), user.getPassword());
                    if (userData == null) {
                        return new ModelAndView("home","errorMessage", "Invalid username and password! Please try again!");
                    }
                    session.setAttribute("user", userData);
                    String role = userData.getRole().trim();
                    if (role.equals("admin")) {
                            return new ModelAndView("admin_page");
                    } else if (role.equals("manager")) {
                            return new ModelAndView("manager_page","user_id",userData.getUser_id());
                    } else if (role.equals("associate")) {
                            return new ModelAndView("employee_page");
                    } else
                        return null;
		} catch (CreateException e) {
                         model.addAttribute("errorMessage", "Invalid username and password! Please try again!");
			return new ModelAndView("login_error");
		}
            
    }
    
}
