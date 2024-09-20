
<%@page import="com.tech.blog.entities.Users"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Posts"%>
<div class="row mt-4">
<%
	PostDao dao = new PostDao(ConnectionProvider.getConnection());
	int id = Integer.parseInt(request.getParameter("cid"));
	List<Posts> list = null;
	if(id == 0){
		list = dao.getAllPosts();
	}else{
		list = dao.getPostsByCatId(id);
	}
	if(list.size() == 0){
		%>
		<h3 class="display-3 text-center">No posts in this category</h3>
		<%
		return;
	}
	for(Posts p : list)
	{
		String[] sr = p.getPcontent().split(" ");
		String[] s = new String[5];
		if(sr.length > 7)
			s = Arrays.copyOf(sr,	7); //Update need
		else
			s = sr;
		String cont = String.join(" ", s);
%>
<%
	Users user = (Users) session.getAttribute("currentUser");
	if(user == null){
		response.sendRedirect("login.jsp");
	}

	LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
	int count = ldao.getLikeCount(p.getPid());
	boolean isLiked = ldao.isLikedByUser(p.getPid(), user.getId());
	String colour = isLiked ? "blue" : "white";
%>

	<div class="col-md-4">
		<div class="card mt-4" style="width: 15rem;  height: 310px">
		  <img src="images/blog_pics/<%= p.getPpic() %>" class="card-img-top" alt="..." height="150px">
		  <div class="card-body">
		    <h5 class="card-title"><%= p.getPtitle() %></h5>
		    <p class="card-text"><%= cont %></p>
		  </div>
		  <div class="card-footer text-center">
		  	<a href="show_blog_details.jsp?post_id=<%= p.getPid() %>" class="btn btn-outline-primary btn-sm">Read more...</a>
		  	<button onclick="doLike(<%= p.getPid() %>, <%= user.getId() %>)" class="btn btn-outline-primary btn-sm like-counter" style="background-color: <%= colour %>"><i class="fa fa-thumbs-o-up"></i><span><%= count %></span></button>
		  	<button class="btn btn-outline-primary btn-sm"><i class="fa fa-commenting-o"></i><span>0</span></button>
		  </div>
		</div>
	</div>

<%
	}
%>
</div>