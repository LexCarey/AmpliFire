package com.lex.amplifire.services;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.lex.amplifire.models.LoginUser;
import com.lex.amplifire.models.User;
import com.lex.amplifire.repos.UserRepo;

@Service
public class UserService {

	@Autowired
    private UserRepo userRepo;
    
    // TO-DO: Write register and login methods!
    public User register(User newUser, BindingResult result) {
    	Optional<User> possibleUser = userRepo.findByEmail(newUser.getEmail());
    	Optional<User> possibleUserName = userRepo.findByUserName(newUser.getUserName());
        if (possibleUser.isPresent()) {
        	result.rejectValue("email", "registerErrors", "This email is already taken!");
        }
        if (possibleUserName.isPresent()) {
        	result.rejectValue("userName", "registerErrors", "This Username is already taken!");
        }
        if (!newUser.getPassword().equals(newUser.getConfirm())) {
        	result.rejectValue("confirm", "registerErrors", "Password and confirm password must match!");
        }
        if (result.hasErrors()) {
        	return null;
        } else {
        	String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
        	newUser.setPassword(hashed);
        	return userRepo.save(newUser);
        }
    }
    
    public User login(LoginUser newLoginObject, BindingResult result) {
        // TO-DO: Additional validations!
    	Optional<User> possibleUser = userRepo.findByEmail(newLoginObject.getEmail());
    	if (!possibleUser.isPresent()) {
    		result.rejectValue("email", "loginErrors", "An account with this email does not exist.");
    	} else {    		
    		User user = possibleUser.get();
    		if (!BCrypt.checkpw(newLoginObject.getPassword(), user.getPassword())) {
    			result.rejectValue("password", "loginErrors", "Incorrect password.");
    		}
    		if (result.hasErrors()) {
    			return null;    		
    		} else {
    			return user;
    		}
    	}
    	return null;
    }
    
    public User findOne(Long id) {
    	Optional<User> possibleUser = userRepo.findById(id);
    	if (possibleUser.isPresent()) {
    		return possibleUser.get();
    	} else {    		
    		return null;
    	}
    }
    
    public User findByUserName(String userName) {
    	Optional<User> possibleUser = userRepo.findByUserName(userName);
    	if (possibleUser.isPresent()) {
    		return possibleUser.get();
    	} else {    		
    		return null;
    	}
    }
    
    public User editAccount(User editUser, BindingResult result, String currentName) {
    	Optional<User> possibleUserName = userRepo.findByUserName(editUser.getUserName());
        if (possibleUserName.isPresent()) {
        	if (possibleUserName.get().getUserName() != currentName) {
        		result.rejectValue("userName", "registerErrors", "This Username is already taken!");        		
        	}
        }
        if (result.hasErrors()) {
        	return null;
        } else {
        	return userRepo.save(editUser);
        }
    }
    
    public User editPfp(User user) {
    	return userRepo.save(user);
    }
    
}
