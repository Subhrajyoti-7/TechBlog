<%@page import="com.tech.blog.entities.Message"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Page</title>
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
</head>
<body>
	<!-- Navbar -->
	<%@include file="normal_navbar.jsp" %>
	
	<main class="d-flex align-items-center primary-background banner-clip-path anim-drop" style="height: 80vh">
		<div class="container">
			<div class="row">
				<div class="col-md-4 offset-md-4">
					<div class="card">
						<div class="card-header primary-background text-white text-center">
							<span class="fa fa-user-circle fa-3x"></span>
							<h5>Login here</h5>
						</div>
						
						<%
							Message msg = (Message)session.getAttribute("msg");
							if(msg != null)
							{
						%>
								<div class="alert <%= msg.getCssClass() %> text-center" role="alert">
									<%= msg.getContent() %>
								</div>	
						<%
							session.removeAttribute("msg");
							}
						%>
						
						<div class="card-body">
							<form id="lg-frm" class="d-flex flex-column" action="LoginServlet" method="POST">
							  <div class="mb-3">
							    <label for="email" class="form-label">Email address</label>
							    <input name="user_email" type="email" required="required" class="form-control" id="email" aria-describedby="emailHelp">
							  </div>
							  <div class="mb-3">
							    <label for="password" class="form-label">Password</label>
							    <input name="user_pass" type="password" required="required" class="form-control" id="password">
							  </div>
							  <button id="lg-btn" type="submit" class="btn btn-success mx-5">Login</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>	
	</main>

</body>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
<!-- Bootstrap-js -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<!-- My js files -->
<script type="text/javascript" src="js/myjs.js"></script>
</html>