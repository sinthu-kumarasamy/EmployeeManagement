/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neu.employee.validator;

import com.neu.employee.dao.UserDao;
import com.neu.employee.exception.CreateException;
import com.neu.employee.model.User;
import static java.lang.System.err;
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
public class UserValidator implements Validator{
    
    @Autowired
    UserDao userDao;

    @Override
    public boolean supports(Class c) {
        return c.equals(User.class);
    }

    @Override
    public void validate(Object o, Errors err) {
        User user = (User) o;
        ValidationUtils.rejectIfEmptyOrWhitespace(err, "first_name","empty-fname", "Please enter First Name!");
        ValidationUtils.rejectIfEmptyOrWhitespace(err, "last_name", "empty-lname","Please enter Last Name!");
        ValidationUtils.rejectIfEmptyOrWhitespace(err, "email", "empty-email","Please enter your e-mail address!");
        ValidationUtils.rejectIfEmptyOrWhitespace(err, "password", "empty-pwd","Please enter a password!");
        ValidationUtils.rejectIfEmptyOrWhitespace(err, "title", "empty-title","Please enter title!");
        try {
                User userData = userDao.fetchUserByEmail(user.getEmail());
                if (userData != null) {
                        err.rejectValue("email","email-exists","This email has already been registered!");
                }
        } catch (CreateException e) {
                System.out.println("Exception: " + e.getMessage());
        }
    }
    
}
