/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neu.employee.validator;

import com.neu.employee.model.Tasks;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

/**
 *
 * @author Sindhu
 */
public class TaskValidator implements Validator{

    @Override
    public boolean supports(Class c) {
        return c.equals(Tasks.class);
    }

    @Override
    public void validate(Object o, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "taskDesc","empty-desc", "Please enter the task description*");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "credits", "empty-credits", "Please enter credits");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "start_date", "empty-start", "Please enter the start date");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "end_date", "empty-end", "Please enter the end date");
         ValidationUtils.rejectIfEmptyOrWhitespace(errors, "status", "empty-status", "Please select the status");
    }
    
}
