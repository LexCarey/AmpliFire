package com.lex.amplifire.repos;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.lex.amplifire.models.Post;
import com.lex.amplifire.models.User;

@Repository
public interface PostRepo extends CrudRepository<Post, Long> {
	
	List<Post> findAll();

	List<Post> findByGenreOrderByCreatedAtDesc(String genre);
	
	List<Post> findByUserOrderByCreatedAtDesc(User user);
	
	List<Post> findByCaptionContainingOrderByCreatedAtDesc(String search);
	
	List<Post> findByOrderByCreatedAtDesc();
}
