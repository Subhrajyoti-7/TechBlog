<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sign up Page</title>
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
	
	<main class="d-flex align-items-center primary-background banner-clip-path anim-drop" style="height: 90vh">
		<div class="container">
			<div class="row">
				<div class="col-md-4 offset-md-4">
					<div class="card">
						<div class="card-header primary-background text-white text-center">
							<span class="fa fa-user-plus fa-3x"></span>
							<h5>Register here</h5>
						</div>
						
						<div class="card-body">
							<form id="redg-frm" class="d-flex flex-column" action="RegisterServlet" method="post">
							  <div class="mb-3">
							    <label for="name" class="form-label">Name</label>
							    <input name="user_name" type="text" required="required" class="form-control" id="name">
							    <label for="email" class="form-label">Email address</label>
							    <input name="user_email" type="email" required="required" class="form-control" id="email" aria-describedby="emailHelp">
							  </div>
							  <div class="mb-3">
							    <label for="password" class="form-label">Password</label>
							    <input name="user_pass" type="password" required="required" class="form-control" id="password">
							  </div>
							  <div class="mb-3">
							    <label for="gender" class="form-label">Select Gender</label><br>
							    <input name="user_gender" type="radio" required="required" id="gender" value="male">Male &nbsp;&nbsp;&nbsp;&nbsp;
							    <input name="user_gender" type="radio" required="required" id="gender" value="female">Female
							  </div>
							  <div class="mb-3 form-check">
							    <input name="user_terms" type="checkbox" class="form-check-input" id="check">
							    <label class="form-check-label" for="check">agree terms and conditions</label>
							  </div>
							  <div id="loader" class="container text-center" style="display: none">
							  	<span class="fa fa-refresh fa-3x fa-spin"></span>
							  	<h4>Please wait ...</h4>
							  </div>
							  <button id="submit-btn" type="submit" class="btn btn-success mx-5">Register</button>
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
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
	$(document).ready(function(){
		console.log("loaded.....");
		
		$('#redg-frm').on('submit', function(event){
			event.preventDefault();
			
			//Get form data
			let form = new FormData(this);
			
			//Loader
			$('#submit-btn').hide();
			$('#loader').show();
			
			//send register servlet
			$.ajax({
				url: "RegisterServlet",
				type: "POST",
				data: form,
				success: function(data, textStatus, jqXHR){
					console.log(data);
					$('#submit-btn').show();
					$('#loader').hide();
					if(data === "done"){
						swal({
							  title: "Success!",
							  text: data,
							  icon: "success",
							  button: "OK!",
						}).then((value) =>{
							window.location = "login.jsp"
						});
					}else{
						swal({
							  title: "Warning!",
							  text: data,
							  icon: "warning",
							  button: "OK!",
						});
					}
				},
				error: function(jqXHR, textStatus, errorThrown){
					console.log(jqXHR);
					$('#submit-btn').show();
					$('#loader').hide();
					swal({
						  title: "Error!",
						  text: jqXHR,
						  icon: "warning",	
						  button: "OK!",
					});
				},
				processData: false,
				contentType: false
			});
			
		});
	});
</script>
</html>












