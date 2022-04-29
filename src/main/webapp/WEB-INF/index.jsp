<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. --> 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Formatting (dates) --> 
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AmpliFire - Login</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/style.css"> <!-- change to match your file/naming structure -->
    <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>

	<div class="container">
		<div class="login-header text-center">
			<h1 class="mpliire"><span class="A">A</span>mpli<span class="F">F</span>ire</h1>
			<p>If you aren't quite ready to make an account yet, you can always head back to the <a href="/home">Home Page</a></p>
		</div>
		<div class="d-flex justify-content-around">
			<div class="register">
				<form:form action="/register" method="post" modelAttribute="newUser">
					<h1>Register</h1>
					<p>
			        	<form:input path="userName" placeholder="User Name"/>
			        	<br />
			       		<form:errors path="userName"/>
					</p>
					<p>
			        	<form:input path="email" placeholder="Email"/>
			        	<br />
			        	<form:errors path="email"/>
					</p>
					<p>
			        	<form:input path="password" placeholder="Password"/>
			        	<br />
			        	<form:errors path="password"/>
					</p>
					<p>
			        	<form:input path="confirm" placeholder="Confirm Password"/>
			        	<br />
			        	<form:errors path="confirm"/>
					</p>
					<div><input type="submit" value="Register" /></div>
				</form:form>
			</div>
			<div class="login">
				<form:form action="/login" method="post" modelAttribute="newLogin">
					<h1>Login</h1>
					<p>
			        	<form:input path="email" placeholder="Email"/>
			        	<form:errors path="email"/>
					</p>
					<p>
			        	<form:input path="password" placeholder="Password"/>
			        	<form:errors path="password"/>
					</p>
					<div><input type="submit" value="Login" /></div>
				</form:form>	
			</div>
		</div>
	</div>
	
</body>
</html>