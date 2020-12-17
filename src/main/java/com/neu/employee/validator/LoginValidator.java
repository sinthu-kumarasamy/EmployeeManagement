/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neu.employee.validator;

import com.neu.employee.dao.UserDao;
import com.neu.employee.exception.CreateException;
import com.neu.employee.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

/**
 *
 * @author Sindhu
 */
@Component
public class LoginValidator implements Validator{
    
    @Autowired
    UserDao userDao;
        
    @Override
    public boolean supports(Class c) {
        return c.equals(User.class);
    }

    @Override
    public void validate(Object o, Errors errors) {
        User user = (User) o;
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email","empty-email", "Please enter the registered email-id*");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "empty-pwd", "Please Enter the password");
        try {
                User userData = userDao.fetchUserByEmail(user.getEmail());
                if (userData == null) {
                        errors.rejectValue("email","email-invalid","Email has not been registered!");
                }
        } catch (CreateException e) {
                System.out.println("Exception: " + e.getMessage());
        }
    }
    
}
