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
import java.io.PrintWriter;

import org.apache.jasper.tagplugins.jstl.core.Out;

import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.Posts;
import com.tech.blog.entities.Users;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

@MultipartConfig
public class PostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public PostServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		int cid = Integer.parseInt(req.getParameter("cid"));
		String title = req.getParameter("ptitle");
		String content = req.getParameter("pcontent");
		String code = req.getParameter("pcode");
		
		Part part = req.getPart("ppic");
		String pic = part.getSubmittedFileName();
		
		HttpSession ses = req.getSession();
		Users user = (Users) ses.getAttribute("currentUser");
		int uid = user.getId();
		
		Posts post = new Posts(title, content, code, pic, cid, uid);
		PostDao dao = new PostDao(ConnectionProvider.getConnection());
		PrintWriter pw = res.getWriter();
		if(dao.savePost(post)) {
			//success
			String path = req.getServletContext().getRealPath("/") + "images/blog_pics" + File.separator + pic;
			Helper.saveFile(part.getInputStream(), path);
			pw.print("done");
		}else {
			//error
			pw.print("error");
		}
		pw.close();
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

}
