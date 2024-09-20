package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

import com.tech.blog.dao.UsersDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.Users;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

@MultipartConfig
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public EditServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		//Fetch all data
		String name = req.getParameter("user_name");
		String email = req.getParameter("user_email");
		String password = req.getParameter("user_password");
		String gender = req.getParameter("user_gender");
		Part picture = req.getPart("profile_pic");
		String picName = null;
		if(picture != null) {
			picName = picture.getSubmittedFileName();
		}else {
//			picture = "default.png";
			picName = "default.png";
		}
		
		//Get the user from session
		HttpSession ses = req.getSession();
		Users user = (Users)ses.getAttribute("currentUser");
		user.setName(name);
		user.setEmail(email);
		user.setPassword(password);
		user.setGender(gender);
		String oldPath = user.getProfile();
		user.setProfile(picName);
		
		//Execute update method
		UsersDao dao = new UsersDao(ConnectionProvider.getConnection());
		boolean result = dao.updateUser(user);
		if(result) {
			//Update successful
			String path = req.getServletContext().getRealPath("/") + "images" + File.separator + user.getProfile();
			
			//Delete existing file
			if(!oldPath.equals("default.png"))
				Helper.deleteFile(path);
			
			//Create new file
			if(Helper.saveFile(picture.getInputStream(), path)) {
				//Saved
				Message msg = new Message("Profile is updated successfully", "success", "alert-success");
				ses.setAttribute("msg", msg);
				res.sendRedirect("profile.jsp");
			}else {
				//Not saved
				Message msg = new Message("Something went wrong!!!", "danger", "alert-danger");
				ses.setAttribute("msg", msg);
				res.sendRedirect("profile.jsp");
			}
		}else {
			//Update refused
			Message msg = new Message("Something went wrong!!!", "danger", "alert-danger");
			ses.setAttribute("msg", msg);
			res.sendRedirect("profile.jsp");
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

}
