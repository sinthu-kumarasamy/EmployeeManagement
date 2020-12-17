/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neu.employee.model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import org.springframework.format.annotation.NumberFormat;

/**
 *
 * @author Sindhu
 */
@Entity
@Table(name="leaveinfo")
public class LeaveInfo implements Serializable{

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name = "id", unique=true, nullable = false)
    private int id;
    
   @NumberFormat(style=NumberFormat.Style.NUMBER)
    @Column(name="no_of_days")
    private Integer no_of_days;
    
    @Column(name="year")
    private int year;

    @OneToOne
    private User user;
    
  
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


//    public int getNo_of_days() {
//        return no_of_days;
//    }
//
//    public void setNo_of_days(int no_of_days) {
//        this.no_of_days = no_of_days;
//    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Integer getNo_of_days() {
        return no_of_days;
    }

    public void setNo_of_days(Integer no_of_days) {
        this.no_of_days = no_of_days;
    }

    
    
}
