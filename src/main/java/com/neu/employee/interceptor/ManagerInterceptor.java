/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neu.employee.interceptor;

import com.neu.employee.model.User;
import java.util.Enumeration;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Sindhu
 */
public class ManagerInterceptor implements HandlerInterceptor{

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
         HttpSession session = (HttpSession) request.getSession();
        if (session.getAttribute("user") != null) {
                User user = (User) session.getAttribute("user");
                if (user.getRole().equalsIgnoreCase("manager")) {
                     try{
                            Enumeration<String> params = request.getParameterNames();
                            while(params.hasMoreElements()){
                                String paramName = (String) params.nextElement();
                                String paramValue = request.getParameter(paramName);
                                if(xssCheck(paramValue)){
                                    request.setAttribute("unsafe_input", "true");
                                    break;
                                }
                            }   
                        } 
                    catch(Exception e){
                             System.out.println(e);
                         }
                        System.out.println("Inside manager interceptor");
                        return true;
                }
        }
	response.sendRedirect(request.getContextPath() + "/login.htm");
	return false;
    }
    
     private boolean xssCheck(String value) {
        if (value != null) {
            return (value.matches("<script>(.*?)</script>") || value.matches("\"<script(.*?)>\""));
        }
        return false;
    }

    @Override
    public void postHandle(HttpServletRequest hsr, HttpServletResponse hsr1, Object o, ModelAndView mav) throws Exception {
        System.out.println("Post Handle");
    }

    @Override
    public void afterCompletion(HttpServletRequest hsr, HttpServletResponse hsr1, Object o, Exception excptn) throws Exception {
       System.out.println("After Completion");
    }
    
}
