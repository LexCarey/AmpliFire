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
    <title>AmpliFire - Edit Profile</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/style.css"> <!-- change to match your file/naming structure -->
    <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/myjs.js"></script>
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
					<c:when test="${user != null }">
						<c:set var="img" value="${user.profilepic.getProfileImagePath() }"/>
						 <c:choose>
							<c:when test="${img == null }" > 	
						 		<a class="image-link" href="/profile/${user.userName}"><img class="profile_pic_sm" src="/imgs/AmpliFire_default_pfp.png"></a> 
						 	</c:when>
						 	<c:otherwise>
								<a class="image-link" href="/profile/${user.userName}"><img src="${user.profilepic.getProfileImagePath()}" alt="pfp" /></a>
						 	</c:otherwise>
						 </c:choose>
						<h1><a href="/profile/${user.userName}">Profile</a></h1>
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
			<div class="looks-now text-center">
				<h2>Current Profile</h2>		
			</div>
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
			
				<div class="edit-profile d-flex align-items-center">
					<div class="col-1 text-center pfp-edit">
					 	<h3>Edit Profile Picture</h3>
					 	<c:set var="img" value="${user.profilepic.getProfileImagePath() }"/>
						 <c:choose>
							<c:when test="${img == null }" > 	
						 		<a class="image-link" href="/profile/${user.userName}"><img class="profile_pic_sm" src="/imgs/AmpliFire_default_pfp.png"></a> 
						 	</c:when>
						 	<c:otherwise>
								<a class="image-link" href="/profile/${user.userName}"><img src="${user.profilepic.getProfileImagePath()}" alt="pfp" /></a>
						 	</c:otherwise>
						 </c:choose>
					 	<form:form action="/edit/profile/pfp" method="post" enctype="multipart/form-data">
					 		 <div class="file-upload">
						 		 <label id="file-image" for="fileImage">
						 		 	Upload Pfp
						           <input type="file" name="fileImage" id="fileImage" accept="image/png, image/jpeg, image/jpg" />
						 		 </label>
					 		 </div>
					           <input type="submit" value="Submit" />
					 	</form:form>
					</div>
					<div class="edit-profile-inputs col-1">
						<form:form action="/edit/profile/${editUser.id}" method="post" modelAttribute="editUser">
							<input type="hidden" name="_method" value="put" />
							<form:errors path="*"/>
							<p>
								<label for="userName">Username:</label>
					        	<form:input path="userName" placeholder="User Name"/>
					        	<br />
					       		<form:errors path="userName"/>
							</p>
							<p>
								<label for="favSong">Favorite Song:</label>
					        	<form:input path="favSong" placeholder="Favorite Song"/>
					        	<br />
					        	<form:errors path="favSong"/>
							</p>
							<p>
								<label for="favGenre">Favorite Genre:</label>
					        	<form:select path="favGenre">
					        	
					        		<c:choose>
					        			<c:when test="${user.favGenre == 'pop'}">
					        				<option selected="selected" value="Pop">Pop</option>
					        			</c:when>
					        			<c:otherwise>
											<option value="Pop">Pop</option>
					        			</c:otherwise>
					        		</c:choose>
									
									<c:choose>
					        			<c:when test="${user.favGenre == 'Hip-Hop'}">
					        				<option selected="selected" value="Hip-Hop">Hip-Hop</option>
					        			</c:when>
					        			<c:otherwise>
											<option value="Hip-Hop">Hip-Hop</option>
					        			</c:otherwise>
					        		</c:choose>
									
									<c:choose>
					        			<c:when test="${user.favGenre == 'EDM'}">
					        				<option selected="selected" value="EDM">EDM</option>
					        			</c:when>
					        			<c:otherwise>
											<option value="EDM">EDM</option>
					        			</c:otherwise>
					        		</c:choose>
									
									<c:choose>
					        			<c:when test="${user.favGenre == 'Rock'}">
					        				<option selected="selected" value="Rock">Rock</option>
					        			</c:when>
					        			<c:otherwise>
											<option value="Rock">Rock</option>
					        			</c:otherwise>
					        		</c:choose>
									
									<c:choose>
					        			<c:when test="${user.favGenre == 'R&B'}">
					        				<option selected="selected" value="R&B">R&B</option>
					        			</c:when>
					        			<c:otherwise>
											<option value="R&B">R&B</option>
					        			</c:otherwise>
					        		</c:choose>
									
									<c:choose>
					        			<c:when test="${user.favGenre == 'Latin'}">
					        				<option selected="selected" value="Latin">Latin</option>
					        			</c:when>
					        			<c:otherwise>
											<option value="Latin">Latin</option>
					        			</c:otherwise>
					        		</c:choose>
									
									<c:choose>
					        			<c:when test="${user.favGenre == 'K-Pop'}">
					        				<option selected="selected" value="K-Pop">K-Pop</option>
					        			</c:when>
					        			<c:otherwise>
											<option value="K-Pop">K-Pop</option>
					        			</c:otherwise>
					        		</c:choose>
									
									<c:choose>
					        			<c:when test="${user.favGenre == 'Country'}">
					        				<option selected="selected" value="Country">Country</option>
					        			</c:when>
					        			<c:otherwise>
											<option value="Country">Country</option>
					        			</c:otherwise>
					        		</c:choose>
									
									<c:choose>
					        			<c:when test="${user.favGenre == 'Classical'}">
					        				<option selected="selected" value="Classical">Classical</option>
					        			</c:when>
					        			<c:otherwise>
											<option value="Classical">Classical</option>
					        			</c:otherwise>
					        		</c:choose>
									
									<c:choose>
					        			<c:when test="${user.favGenre == 'Metal'}">
					        				<option selected="selected" value="Metal">Metal</option>
					        			</c:when>
					        			<c:otherwise>
											<option value="Metal">Metal</option>
					        			</c:otherwise>
					        		</c:choose>
									<option value="Metal">Metal</option>
									
									<c:choose>
					        			<c:when test="${user.favGenre == 'Indie'}">
					        				<option selected="selected" value="Indie">Indie</option>
					        			</c:when>
					        			<c:otherwise>
											<option value="Indie">Indie</option>
					        			</c:otherwise>
					        		</c:choose>
									
									<c:choose>
					        			<c:when test="${user.favGenre == 'Jazz'}">
					        				<option selected="selected" value="Jazz">Jazz</option>
					        			</c:when>
					        			<c:otherwise>
											<option value="Jazz">Jazz</option>
					        			</c:otherwise>
					        		</c:choose>
									
								</form:select>
					        	<br />
					        	<form:errors path="favGenre"/>
							</p>
							<p>
								<label for="favArtsit">Favorite Artist:</label>
					        	<form:input path="favArtist" placeholder="Favorite Artist"/>
					        	<br />
					        	<form:errors path="favArtist"/>
							</p>
							<p>
								<label for="bio">Bio:</label>
					        	<form:input path="bio" placeholder="Bio"/>
					        	<br />
					        	<form:errors path="bio"/>
							</p>
							<input type="hidden" name="email" value="placeholder@placeholder.placeholder" />
							<input type="hidden" name="password" value="placeholder" />
							<div><input type="submit" value="Confirm" /></div>
						</form:form>
					</div>
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
			<div class="logout">
				<h1><a href="/logout">Logout</a></h1>
			</div>
		</div>
		
	</div>
	
	<script type="text/javascript"></script>
</body>
</html>