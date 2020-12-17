/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neu.employee.validator;

import com.neu.employee.model.LeaveInfo;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

/**
 *
 * @author Sindhu
 */
public class LeaveInfoValidator implements Validator{

    @Override
    public boolean supports(Class c) {
        return c.equals(LeaveInfo.class);
    }

    @Override
    public void validate(Object o, Errors errors) {
        LeaveInfo leave = (LeaveInfo) o;
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "no_of_days","empty-days", "Please enter number of days!");
    }
    
}
