package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.LikeDao;
import com.tech.blog.helper.ConnectionProvider;

public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LikeServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try(PrintWriter out = response.getWriter()){
			int pid = Integer.parseInt(request.getParameter("pid"));
			int uid = Integer.parseInt(request.getParameter("uid"));
			String operation = request.getParameter("operation");
			LikeDao dao = new LikeDao(ConnectionProvider.getConnection());
			if(dao.isLikedByUser(pid, uid)) {
				dao.deleteLike(pid, uid);
				out.println("disliked");
			}else {
				dao.saveLike(pid, uid);
				out.println("liked");
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
