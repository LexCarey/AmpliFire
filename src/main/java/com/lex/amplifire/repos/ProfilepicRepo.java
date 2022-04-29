package com.lex.amplifire.repos;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.lex.amplifire.models.Profilepic;

@Repository
public interface ProfilepicRepo extends CrudRepository<Profilepic, Long>{
	List<Profilepic> findAll();
}
