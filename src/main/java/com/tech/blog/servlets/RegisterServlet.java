package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.UsersDao;
import com.tech.blog.entities.Users;
import com.tech.blog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@MultipartConfig
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public RegisterServlet() {
        super();
    }
    
    //doGet
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		try {
			PrintWriter pw = res.getWriter();
			res.setContentType("text/html");
			
			//Fetching all data from jsp-form page
			String name = req.getParameter("user_name");
			String email = req.getParameter("user_email");
			String password = req.getParameter("user_pass");
			String gender = req.getParameter("user_gender");
			String terms = req.getParameter("user_terms");
			
			if(terms == null) {
				pw.print("You have not accepted terms and conditions");
			}else {
				//Create user object and set all data to that object
				Users user = new Users(name, email, password, gender);
				
				//Create a UsersDao object
				UsersDao dao = new UsersDao(ConnectionProvider.getConnection());
				boolean result = dao.saveUser(user);
				if(result) {
					pw.print("done");
				}
				else {
					pw.print("Something went wrong");
				}
			}
			pw.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	//doPost
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

}
