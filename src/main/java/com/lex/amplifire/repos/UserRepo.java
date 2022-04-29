package com.lex.amplifire.repos;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.lex.amplifire.models.User;

@Repository
public interface UserRepo extends CrudRepository<User, Long> {

	List<User> findAll();
	
	Optional<User> findById(Long id);
	
	Optional<User> findByEmail(String email);
	
	Optional<User> findByUserName(String userName);
	
}
