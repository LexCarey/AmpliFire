package com.lex.amplifire.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lex.amplifire.models.Profilepic;
import com.lex.amplifire.repos.ProfilepicRepo;

@Service
public class ProfilepicService {
	@Autowired
	ProfilepicRepo profilepicRepository;
	
//	READ ALL
	public List<Profilepic> allProfilepics(){
		return profilepicRepository.findAll();
	}
//	CREATE
	public Profilepic createProfilepic(Profilepic p) {
		return profilepicRepository.save(p);
	}
//	UPDATE
	public Profilepic updateProfilepic(Profilepic p) {
		return profilepicRepository.save(p);
	}
//	READ ONE
	public Profilepic findProfilepic(Long id) {
		Optional<Profilepic> optionalProfilepic = profilepicRepository.findById(id);
		if (optionalProfilepic.isPresent()) {
			return optionalProfilepic.get();
		}
		return null;
	}
//	DELETE
	public void deleteProfilepic(Long id) {
		profilepicRepository.deleteById(id);
	}
	
}