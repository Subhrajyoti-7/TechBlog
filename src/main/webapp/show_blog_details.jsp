<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UsersDao"%>
<%@page import="com.tech.blog.entities.Categories"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Posts"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Users"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page errorPage="error_page.jsp" %>
<%
	Users user = (Users) session.getAttribute("currentUser");
	if(user == null){
		response.sendRedirect("login.jsp");
	}

%>
<%
	int post_id = Integer.parseInt(request.getParameter("post_id"));
	PostDao dao = new PostDao(ConnectionProvider.getConnection());
	Posts p = dao.getPostByPostId(post_id);
	UsersDao uDao = new UsersDao(ConnectionProvider.getConnection());
	Users u = uDao.fetchUserByUserId(p.getUid());
%>
<%
	LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
	int count = ldao.getLikeCount(p.getPid());
	boolean isLiked = ldao.isLikedByUser(p.getPid(), user.getId());
	String colour = isLiked ? "blue" : "white";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%= p.getPtitle() %> || TechBlog by Biswal</title>
<!-- Bootstrap css -->
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
<style type="text/css">
body{
	background: url(images/glass-morphism1.jpg);
	background-size: cover;
	background-attachment: fixed;
}
.user p{
	font-size: 12px;
	font-weight: 100px;
}
.user a{
	text-decoration: none;
	margin-left: 10px
}

</style>
</head>
<body>
	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark primary-background" style="z-index: 10">
	  <div class="container-fluid">
	    <a class="navbar-brand" href="index.jsp"><span class="fa fa-mortar-board"></span>Tech Blog</a>
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="navbarSupportedContent">
	      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
	        <li class="nav-item">
	          <a class="nav-link active" aria-current="page" href="profile.jsp">Your Blogs</a>
	        </li>
	        <li class="nav-item dropdown">
	          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
	           <span class="fa fa-caret-square-o-down"></span> Category
	          </a>
	          <ul class="dropdown-menu">
	            <li><a class="dropdown-item" href="#">Programming Language</a></li>
	            <li><a class="dropdown-item" href="#">Project Implementation</a></li>
	            <li><hr class="dropdown-divider"></li>
	            <li><a class="dropdown-item" href="#">Data Structure</a></li>
	          </ul>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="#"><span class="fa fa-address-book-o"></span> Contact</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#posts-modal"><span class="fa fa-film"></span> Posts</a>
	        </li>
	      </ul>
	      <form class="d-flex me-auto" role="search">
	        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
	        <button class="btn btn-success" type="submit">Search</button>
	      </form>
	      <ul class="navbar-nav">
	      	<li class="nav-item" style="margin-left: 20px">
	          <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#profile-modal"><img alt="" src="images/<%= user.getProfile() %>" width="25px" height="25px" style="border-radius: 25px"> <%= user.getName() %> </a>
	        </li>
	      	<li class="nav-item" style="margin-left: 20px">
	          <a class="nav-link" href="LogoutServlet"><span class="fa fa-sign-out"></span> Logout</a>
	        </li>
	      </ul>
	    </div>
	  </div>
	</nav>
	<!-- End of Navbar -->
	
	<!-- Main content -->
	<main>
	
		<div class="container">
			<div class="row mt-3 d-flex justify-content-center">
				<div class="col-md-6">
					<div class="card">
						<div class="card-header">
							<h3><%= p.getPtitle() %></h3>
						</div>
						<div class="card-body">
							<div class="text-center">
								<img alt="" src="images/blog_pics/<%= p.getPpic() %>" height="200px">
							</div>
							<div class="d-flex justify-content-between user">
								<div class="d-flex">
									<p class="mt-1">Posted by : </p>
									<a href="#"><%= u.getName() %></a>
								</div>
								<p><i><%= DateFormat.getDateInstance().format(p.getPdate()) %></i></p>
							</div>
							<h5>Description : </h5>
							<p><%= p.getPcontent() %></p>
							<h5>Code : </h5>
							<p><%= p.getPcode() %></p>
						</div>
						<div class="card-footer d-flex justify-content-evenly">
		  				<button onclick="doLike(<%= p.getPid() %>, <%= user.getId() %>)" class="btn btn-outline-primary btn-sm like-counter" style="background-color: <%= colour %>"><i class="fa fa-thumbs-o-up"></i><span><%= count %></span></button>
		  				<button class="btn btn-outline-primary btn-sm"><i class="fa fa-commenting-o"></i><span>0</span></button>	
						</div>
					</div>
				</div>
			</div>
		</div>
	
	</main>
	<!-- End of main -->

	<!-- Modal -->
	<div class="modal fade" id="profile-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header primary-background text-white">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">TechBlog</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        
	        <div class="container text-center">
	        	<div id="profile-details">
		        	<img alt="Profile picture" src="images/<%= user.getProfile() %>" width="150px" height="150px" style="border-radius: 50%">
		        	<h5><%= user.getName() %></h5>
		        	<!-- Details -->
		        	<table class="table table-borderless text-start">
					    <tr>
					      <th scope="row">ID</th>
					      <td><%= user.getId() %></td>
					    </tr>
					    <tr>
					      <th scope="row">Email</th>
					      <td><%= user.getEmail() %></td>
					    </tr>
					    <tr>
					      <th scope="row">Gender</th>
					      <td><%= user.getGender() %></td>
					    </tr>
					    <tr>
					      <th scope="row">Registered on</th>
					      <td><%= user.getRedg_date() %></td>
					    </tr>
					</table>
				</div>
				
				<!-- Edit -->
				<div id="profile-edit" style="display: none">
					<form id="edit-frm" action="EditServlet" method="POST" enctype="multipart/form-data">
						<img alt="Profile picture" src="images/<%= user.getProfile() %>" width="100px">
						<table class="table table-borderless text-start">
							<tr>
								<th scope="row">Select Photo</th>
								<td><input type="file" name="profile_pic" class="form-control"></td>
							</tr>
						</table>
			        	<h5><input type="text" name="user_name" class="form-control" value="<%= user.getName() %>"></h5>
						<table class="table table-borderless text-start">
						    <tr>
						      <th scope="row">ID</th>
						      <td><%= user.getId() %></td>
						    </tr>
						    <tr>
						      <th scope="row">Email</th>
						      <td><input type="email" name="user_email" class="form-control" value="<%= user.getEmail() %>"></td>
						    </tr>
						    <tr>
						      <th scope="row">Password</th>
						      <td><input type="password" name="user_password" class="form-control" value="<%= user.getPassword() %>"></td>
						    </tr>
						    <tr>
						      <th scope="row">Gender</th>
						      <td><input type="radio" name="user_gender" value="male" checked="checked">Male &nbsp;&nbsp;&nbsp;
						      	  <input type="radio" name="user_gender" value="female">Female</td>
						    </tr>
						</table>
						<button type="submit" class="btn btn-success" id="save-btn">Save</button>
					</form>
				</div>
	        </div>
	        
	      </div>
	      <div class="modal-footer">
	        <button id="close-btn" type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	        <button id="edit-btn" type="button" class="btn btn-primary">Edit</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- End of modal -->
	
	<!-- Posts modal -->
	<div class="modal fade" id="posts-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="staticBackdropLabel">Post Details</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <form id="post-frm" enctype="multipart/form-data" action="PostServlet" method="POST">
	        	<div class="form-group mb-3">
	        		<select class="form-control" name="cid">
	        			<option selected="selected" disabled="disabled">---select category---</option>
	        			<%
	        			PostDao pdao = new PostDao(ConnectionProvider.getConnection());
	        			List<Categories> list = pdao.fetchAllCategories();
	        			for(Categories c : list)
	        			{
	        			%>
	        			<option value="<%= c.getCid() %>"><%= c.getName() %></option>
	  					<%
	        			}
	  					%>
	        		</select>
	        	</div>
	        	<div class="form-group mb-3">
	        		<input type="text" name="ptitle" class="form-control" placeholder="Enter Title">
	        	</div>
	        	<div class="form-group mb-3">
	        		<textarea rows="4" name="pcontent" class="form-control" placeholder="Write your content ..."></textarea>
	        	</div>
	        	<div class="form-group mb-3">
	        		<textarea rows="3" name="pcode" class="form-control" placeholder="Write your code (if any)"></textarea>
	        	</div>
	        	<div class="form-group">
	        		<label>Select a photo</label><br>
	        		<input type="file" name="ppic" class="form-control">
	        	</div>
	        	<div class="mt-3 text-center">
			        <button type="submit" class="btn btn-outline-success">Post</button>
			    </div>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- End of posts modal -->
	
</body>
<!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
<!-- Bootstrap-js -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<!-- Sweet alert js -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- My js files -->
<script type="text/javascript" src="js/like.js"></script>
<script type="text/javascript" src="js/myjs.js"></script>

<script>
	//Profile edit
	$(document).ready(function(){
		let editStatus = true;
		$('#edit-btn').click(function(){
			if(editStatus){
				$('#profile-details').hide();
				$('#profile-edit').show();
				$('#edit-btn').html("Back");
				editStatus = false;
			}else{
				$('#profile-details').show();
				$('#profile-edit').hide();
				$('#edit-btn').html("Edit");
				editStatus = true;
			}
		});
	});
	
	setTimeout(function(){
		$('#msg').hide();
	}, 5000);

</script>

</html>














