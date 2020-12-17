/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neu.employee.controller;

import com.neu.employee.dao.UserDao;
import com.neu.employee.exception.CreateException;
import com.neu.employee.model.User;
import com.neu.employee.validator.UserValidator;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
public class UserRegistrationContoller {
    
    @Autowired
    UserValidator userValidator;
    
    @Autowired
    UserDao userDao;
    
    @RequestMapping(value="/register.htm",method = RequestMethod.GET)
    protected String doGet(Model model) {
        User user = new User();
        model.addAttribute("user", user);
        return "user_register";
    }
    
    @RequestMapping(value="/register.htm",method = RequestMethod.POST)
    public ModelAndView submitUserData(@ModelAttribute("user")User user, BindingResult result,HttpServletRequest request) throws CreateException {
        if(request.getAttribute("unsafe_input")=="true"){
            return new  ModelAndView("login_error","errorMessage","Unsafe string literals are not allowed");
        }
        userValidator.validate(user, result);
        if(result.hasErrors()){
            return new ModelAndView("user_register");
        }
        userDao.registerNewUser(user);
        return new ModelAndView("added_user","user",user);
    } 
    
    
}
