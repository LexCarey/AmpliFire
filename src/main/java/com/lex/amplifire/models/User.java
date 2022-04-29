package com.lex.amplifire.models;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="users")
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@NotEmpty(message = "Username is required!")
	@Size(min = 3, max = 15, message = "Username must be between 3 and 15 characters.")
	private String userName;
	
	@NotEmpty(message = "Email is required!")
	@Email(message = "Please enter a valid email!")
	private String email;
	
	@NotEmpty(message = "Password is required!")
	@Size(min = 8, max = 60, message = "Password must be between 8 and 128 characters.")
	private String password;
	
	@Transient
	@Size(min = 8, max = 60, message = "Confirm password must be between 8 and 128 characters.")
	private String confirm;
	
	@Size(min = 0, max = 15, message = "Favorite Song must be less than 15 characters.")
	private String favSong;
	
	@Size(min = 0, max = 15, message = "Favorite Genre must be less than 15 characters.")
	private String favGenre;
	
	@Size(min = 0, max = 15, message = "Favorite Artist must be less than 15 characters.")
	private String favArtist;
	
	@Size(min = 0, max = 255, message = "Bio must be less than 255 characters.")
	private String bio;
	
	@OneToMany(mappedBy="user", fetch = FetchType.LAZY)
	private List<Post> posts;
	
	@Column(length=45, nullable=true)
    private String profilePicString;
    
    @OneToOne(mappedBy="user", cascade=CascadeType.ALL, fetch=FetchType.LAZY)
    private Profilepic profilepic;
	
	@Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createdAt;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updatedAt;
	
	public User() {	
	}
	
	@PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConfirm() {
		return confirm;
	}

	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}

	public String getFavSong() {
		return favSong;
	}

	public void setFavSong(String favSong) {
		this.favSong = favSong;
	}

	public String getFavGenre() {
		return favGenre;
	}

	public void setFavGenre(String favGenre) {
		this.favGenre = favGenre;
	}

	public String getFavArtist() {
		return favArtist;
	}

	public void setFavArtist(String favArtist) {
		this.favArtist = favArtist;
	}

	public String getBio() {
		return bio;
	}

	public void setBio(String bio) {
		this.bio = bio;
	}

	public List<Post> getPosts() {
		return posts;
	}

	public void setPosts(List<Post> posts) {
		this.posts = posts;
	}

	public String getProfilePicString() {
		return profilePicString;
	}

	public void setProfilePicString(String profilePicString) {
		this.profilePicString = profilePicString;
	}

	public Profilepic getProfilepic() {
		return profilepic;
	}

	public void setProfilepic(Profilepic profilepic) {
		this.profilepic = profilepic;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	
}
