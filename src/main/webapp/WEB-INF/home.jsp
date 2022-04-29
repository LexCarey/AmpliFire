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
    <title>AmpliFire - Home</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/style.css"> <!-- change to match your file/naming structure -->
    <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container d-flex">
	
		<div class="side-nav d-flex justify-content-between">
			<div>
				<h1 class="mpliire"><span class="A">A</span>mpli<span class="F">F</span>ire</h1>
				<h1><a href="/home">Home</a></h1>
				<h1><a href="#">Notifs</a></h1>
				<h1><a href="/genres">Genres</a></h1>
				<h1><a href="#">Settings</a></h1>
			</div>
			<div class="d-flex align-items-center">
				<c:choose>
					<c:when test="${loggedInUser != null }">
						<c:set var="img" value="${loggedInUser.profilepic.getProfileImagePath() }"/>
						 <c:choose>
							<c:when test="${img == null }" > 	
						 		<a class="image-link" href="/profile/${loggedInUser.userName}"><img class="profile_pic_sm" src="/imgs/AmpliFire_default_pfp.png"></a> 
						 	</c:when>
						 	<c:otherwise>
								<a class="image-link" href="/profile/${loggedInUser.userName}"><img src="${loggedInUser.profilepic.getProfileImagePath()}" alt="pfp" /></a>
						 	</c:otherwise>
						 </c:choose>
						<h1><a href="/profile/${loggedInUser.userName}">Profile</a></h1>
					</c:when>
					<c:otherwise>
						<img src="/imgs/AmpliFire_guest_pfp.png" alt="pfp" />
						<h1>Guest</h1>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		
		<div class="col-1 post-box d-flex">
			<div class="d-flex align-items-center no-margin">			
				<c:choose>
					<c:when test="${loggedInUser == null }">
						<img src="/imgs/AmpliFire_guest_pfp.png" alt="" />
						<h1>Guest</h1>
					</c:when>
					<c:otherwise>
						<c:set var="img" value="${loggedInUser.profilepic.getProfileImagePath() }"/>
						 <c:choose>
							<c:when test="${img == null }" > 	
						 		<a class="image-link" href="/profile/${loggedInUser.userName}"><img class="profile_pic_sm" src="/imgs/AmpliFire_default_pfp.png"></a> 
						 	</c:when>
						 	<c:otherwise>
								<a class="image-link" href="/profile/${loggedInUser.userName}"><img src="${loggedInUser.profilepic.getProfileImagePath()}" alt="pfp" /></a>
						 	</c:otherwise>
						 </c:choose>
						<h1><a href="/profile/${loggedInUser.userName}">${loggedInUser.userName}</a></h1>
					</c:otherwise>
				</c:choose>
			</div>
			
			<c:choose>
			<c:when test="${loggedInUser != null}">
			<form:form action="/post/new" method="post" modelAttribute="newPost">
		        <form:textarea path="caption" placeholder="What's on your mind..?" maxlength="255"/>
				<div class="genre-fix d-flex align-items-center">	
					<form:label path="genre">Genre:</form:label>
					<div class="select-genre">
		        	<form:select path="genre">
						<option value="Pop">Pop</option>
						<option value="Hip-Hop">Hip-Hop</option>
						<option value="EDM">EDM</option>
						<option value="Rock">Rock</option>
						<option value="R&B">R&B</option>
						<option value="Latin">Latin</option>
						<option value="K-Pop">K-Pop</option>
						<option value="Country">Country</option>
						<option value="Classical">Classical</option>
						<option value="Metal">Metal</option>
						<option value="Indie">Indie</option>
						<option value="Jazz">Jazz</option>
					</form:select>
					</div>
					<input type="submit" value="Post" />
				<form:input type="hidden" path="user" value="${userId}" />
				</div>
				<form:errors class="text-danger" path="*"/>
			</form:form>
			</c:when>
			<c:otherwise>
			<textarea placeholder="What's on your mind..?" maxlength="255"></textarea>
			<div class="genre-fix d-flex align-items-center">	
					<label>Genre:</label>
					<div class="select-genre">
		        	<select>
						<option value="Pop">Pop</option>
						<option value="Hip-Hop">Hip-Hop</option>
						<option value="EDM">EDM</option>
						<option value="Rock">Rock</option>
						<option value="R&B">R&B</option>
						<option value="Latin">Latin</option>
						<option value="K-Pop">K-Pop</option>
						<option value="Country">Country</option>
						<option value="Classical">Classical</option>
						<option value="Metal">Metal</option>
						<option value="Indie">Indie</option>
						<option value="Jazz">Jazz</option>
					</select>
					</div>
					<button onclick="alert('You must be logged in to make a post.')" >Post</button>
				</div>
			</c:otherwise>
			</c:choose>
			
			
			<div class="posts">
				<c:forEach var="post" items="${posts}">
					<div class="post">
						<div class="d-flex align-items-center">			
							<c:set var="img" value="${post.user.profilepic.getProfileImagePath() }"/>
								<c:choose>
									<c:when test="${img == null }" > 	
									 	<a class="image-link" href="/profile/${post.user.userName}"><img class="profile_pic_sm" src="/imgs/AmpliFire_default_pfp.png"></a> 
									</c:when>
									<c:otherwise>
										<a class="image-link" href="/profile/${post.user.userName}"><img src="${post.user.profilepic.getProfileImagePath()}" alt="pfp" /></a>
									</c:otherwise>
								</c:choose>
							<h2><a href="/profile/${post.user.userName}">${post.user.userName}</a> <a href="/genres/${post.genre}"><span class="text-fade">${post.genre}</span></a></h2>
						</div>
						<p>${post.caption}</p>
						<div class="d-flex align-items-center justify-content-between">
							<p><fmt:formatDate type="both" dateStyle="medium" timeStyle="short" value="${post.createdAt}" /></p>
							<p>2.7k Likes</p>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		
		<div class="search-genre d-flex">
			<div>
				<form action="/search/" method="get">
					<input type="text" name="search" placeholder="Search" />
				</form>
				<div class="genre-list">
					<h5 class="text-center top-genres">Top Genres Right Now</h5>
					<h1><a href="/genres/pop">Pop</a></h1>
					<h1><a href="/genres/hip-hop">Hip-Hop</a></h1>
					<h1><a href="/genres/edm">EDM</a></h1>
					<h1><a href="/genres/rock">Rock</a></h1>
					<h1><a href="/genres/country">Country</a></h1>
				</div>
			</div>
			
			<c:choose>
				<c:when test="${loggedInUser != null }">
				<div class="logout">
					<h1><a href="/logout">Logout</a></h1>
				</div>
				</c:when>
				<c:otherwise>
				<div class="logout">
					<h1><a href="/logout">Login</a></h1>
				</div>
				</c:otherwise>
			</c:choose>
			
		</div>
	</div>
</body>
</html>