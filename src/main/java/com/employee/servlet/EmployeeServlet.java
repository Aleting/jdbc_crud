package com.employee.servlet;

import com.employee.dao.EmployeeDao;
import com.employee.model.Employee;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/emp")
public class EmployeeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private EmployeeDao dao;
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        String type = request.getParameter("type");
        RequestDispatcher view = request.getRequestDispatcher("/pages/EmployeeList.jsp");
        if (type.equals("select")){
            request.setAttribute("users", dao.getAllEmployees());
            view.forward(request, response);
        }else if (type.equals("delete")){
            dao.deleteId(Integer.parseInt(request.getParameter("delete_id")));
        }else if (type.equals("add")){
            dao.addUpdate(newEmployee(request),"add");
        }else if (type.equals("update")){
            dao.addUpdate(newEmployee(request),"update");
        }else {
            forwordGo(request,response);
        }
    }

    public Employee newEmployee(HttpServletRequest request){
        Employee employee = new Employee();
        if (request.getParameter("id")!=null){
            employee.setId(Integer.parseInt(request.getParameter("id")));
        }
        employee.setName(request.getParameter("name"));
        employee.setSex(request.getParameter("sex"));
        employee.setAge(Integer.parseInt(request.getParameter("age")));
        return employee;
    }

    public void forwordGo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/emp?type=select").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public void init(ServletConfig servletConfig) throws ServletException {
        dao = new EmployeeDao();
        System.out.println("初始化成功！");
    }

    @Override
    public ServletConfig getServletConfig() {
        return null;
    }
    @Override
    public String getServletInfo() {
        return null;
    }

    @Override
    public void destroy() {

    }
}


