<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sorry! something went wrong...</title>
<link rel="icon" href="images/warning.png">
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
	<div class="container text-center">
		<img alt="Error occured" src="images/computer.png" class="img-fluid" width="300px">
		<h5 class="display-3">Sorry! Something went wrong...</h5>
		<%= exception %>
		<a class="btn btn-lg mt-3 primary-background text-white" href="index.jsp">Home</a>
	</div>
</body>
</html>