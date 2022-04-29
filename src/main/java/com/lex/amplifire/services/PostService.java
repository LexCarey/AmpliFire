package com.lex.amplifire.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.lex.amplifire.models.Post;
import com.lex.amplifire.models.User;
import com.lex.amplifire.repos.PostRepo;

@Service
public class PostService {
	
	@Autowired
    private PostRepo postRepo;

	public Post post(Post newPost, BindingResult result) {
		//Long userId = (Long) session.getAttribute("userId");
		//if (userId==null) {
		//	result.rejectValue("caption", "postErrors", "Login or create an account to make posts");
		//}
		if (result.hasErrors()) {
			return null;
		} else {
			return postRepo.save(newPost);
		}
	}
	
	public List<Post> findPostByGenre(String genre) {
		return postRepo.findByGenreOrderByCreatedAtDesc(genre);
	}
	
	public List<Post> findPostByUser(User user) {
		return postRepo.findByUserOrderByCreatedAtDesc(user);
	}
	
	public List<Post> findPostByCaption(String caption) {
		return postRepo.findByCaptionContainingOrderByCreatedAtDesc(caption);
	}
	
	public List<Post> findAllPosts() {		
		return postRepo.findAll();
	}
	
	public List<Post> findNewestPosts() {		
		return postRepo.findByOrderByCreatedAtDesc();
	}
	
	
}
