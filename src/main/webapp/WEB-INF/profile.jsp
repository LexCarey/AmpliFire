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
    <title>Amplifire - ${username}</title>
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
			<div class="profile-info">
			<div class="profile-head d-flex align-items-center">			
			<div class="d-flex align-items-center name">			
				<c:set var="img" value="${user.profilepic.getProfileImagePath() }"/>
						 <c:choose>
							<c:when test="${img == null }" > 	
						 		<a class="image-link" href="/profile/${user.userName}"><img class="profile_pic_sm" src="/imgs/AmpliFire_default_pfp.png"></a> 
						 	</c:when>
						 	<c:otherwise>
								<a class="image-link" href="/profile/${user.userName}"><img src="${user.profilepic.getProfileImagePath()}" alt="pfp" /></a>
						 	</c:otherwise>
						 </c:choose>
				<h1><a href="/profile/${user.userName}">${user.userName}</a></h1>
			</div>
			</div>
				<c:if test="${not empty user.bio}">
					<div class="bio">
						<p>${user.bio}</p>
					</div>
				</c:if>
			<div class="follow d-flex justify-content-between align-items-center">
				<div class="d-flex align-items-center">
					<p><span>1m</span> Followers</p><p><span>392</span> Following</p>
				</div>
				<c:choose>
					<c:when test="${userId == user.id}">					
						<a href="/edit/profile"><button>Edit Profile</button></a>
					</c:when>
					<c:otherwise>
						<a href="/follow/${user.userName}"><button>Follow</button></a>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="music-info d-flex align-items-center justify-content-between">
				<c:if test="${not empty user.favSong}">				
					<div class="fav-song d-flex align-items-center">			
						<img src="/imgs/melodic_blue.jpg" alt="album" />
						<h6><a href="https://open.spotify.com/track/7m7zZuRVyRsQunMbcTc4e6?si=1298da74e7604a9b">${user.favSong}</a></h6>
					</div>
				</c:if>
				<c:if test="${not empty user.favGenre}">				
					<div class="fav-genre">
						<h6>Fav Genre: <a href="/genres/${user.favGenre}">${user.favGenre}</a></h6>
					</div>
				</c:if>
				<c:if test="${not empty user.favArtist}">				
				<div>
					<h6>Fav Artist: <a href="https://open.spotify.com/artist/6fxyWrfmjcbj5d12gXeiNV?si=XMg9s8k5S-uRHEID3FSvoQ">${user.favArtist}</a></h6>
				</div>
				</c:if>
			</div>
			</div>
			
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
							<p>${post.createdAt}</p>
							<p>2.7k</p>
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