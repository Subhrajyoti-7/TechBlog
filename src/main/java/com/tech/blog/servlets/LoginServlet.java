package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.tech.blog.dao.UsersDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.Users;
import com.tech.blog.helper.ConnectionProvider;

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String userName = req.getParameter("user_email");
		String password = req.getParameter("user_pass");
		
		UsersDao dao = new UsersDao(ConnectionProvider.getConnection());
		Users user = dao.fetchUserByEmailAndPassword(userName, password);
		if(user == null) {
			//error
			Message msg = new Message("Invalid details!, please try again", "error", "alert-danger");
			HttpSession ses = req.getSession();
			ses.setAttribute("msg", msg);
			res.sendRedirect("login.jsp");
		}else {
			//success
			HttpSession ses = req.getSession();
			ses.setAttribute("currentUser", user);
			res.sendRedirect("profile.jsp");
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

}
