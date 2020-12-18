/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neu.employee.validator;

import com.neu.employee.model.EmployeeLeave;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

/**
 *
 * @author Sindhu
 */
public class EmployeeLeaveValidator implements Validator{

    @Override
    public boolean supports(Class c) {
        return c.equals(EmployeeLeave.class);
    }

    @Override
    public void validate(Object o, Errors errors) {
         ValidationUtils.rejectIfEmptyOrWhitespace(errors, "reason","empty-reason", "Please enter the reason*");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "start_date", "empty-start", "Please enter the start date");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "end_date", "empty-end", "Please enter the end date");
        
    }
    
}
