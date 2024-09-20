<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.tech.blog.entities.Posts"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="ISO-8859-1">
<title>TechBlog</title>
<!-- Bootstrap-css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<!-- Font Awesome W3S-->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- My css -->
<link rel="stylesheet" type="text/css" href="css/mystyle.css">
</head>

<body>
	<!-- Navbar -->
	<div class="navBar">
		<%@include file="normal_navbar.jsp"%>
	</div>

	<!-- Banner -->
	<div class="container-fluid p-0 m-0">
		<div class="jumbotron primary-background text-white">
			<div class="container">
				<h1 class="display-3">Welcome to TechBlog</h1>
				<p>Welcome to technical blog, The world of technology</p>
				<!-- <p>Programming languages are described in terms of their syntax
					(form) and semantics (meaning), usually defined by a formal
					language. Languages usually provide features such as a type system,
					variables, and mechanisms for error handling. An implementation of
					a programming language is required in order to execute programs,
					namely an interpreter or a compiler. An interpreter directly
					executes the source code, while a compiler produces an executable
					program.</p> -->
				<button class="btn btn-outline-light btn-lg">
					<span class="fa fa-user-plus"></span> Start! its free
				</button>
				<a href="login.jsp" class="btn btn-outline-light"> <span
					class="fa fa-user-circle fa-spin"></span> Login
				</a>
			</div>
			<br>
		</div>
	</div>
	<br>

	<!-- Cards -->
	<div class="container">
		<div class="row">
			<%
				PostDao dao = new PostDao(ConnectionProvider.getConnection());
				List<Posts> list = dao.getAllPosts();
				if(list.size() == 0)
				{
			%>
					<h3 class="display-3 text-center">No posts to display</h3>
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
			
					LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
					int count = ldao.getLikeCount(p.getPid());
			%>
			<div class="col-md-4 mb-3">
				<div class="card">
					<img src="images/blog_pics/<%= p.getPpic() %>" class="card-img-top" alt="..." height="150px">
				  <div class="card-body">
				    <h5 class="card-title"><%= p.getPtitle() %></h5>
				    <p class="card-text"><%= cont %></p>
				  </div>
				  <div class="card-footer text-center">
				  	<a href="show_blog_details.jsp?post_id=<%= p.getPid() %>" class="btn btn-outline-primary btn-sm">Read more...</a>
				  	<button class="btn btn-outline-primary btn-sm like-counter"><i class="fa fa-thumbs-o-up"></i><span><%= count %></span></button>
				  	<button class="btn btn-outline-primary btn-sm"><i class="fa fa-commenting-o"></i><span>0</span></button>
				  </div>
				</div>
			</div>
			<%
				}
			%>
		</div>
	</div>

</body>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
<!-- Bootstrap-js -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<!-- Font Awesome org-->
<!-- <script src="https://kit.fontawesome.com/d1a43a1003.js" crossorigin="anonymous"></script> -->
<!-- My js files -->
<script type="text/javascript" src="js/myjs.js"></script>

</html>