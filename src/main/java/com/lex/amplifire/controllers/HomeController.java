package com.lex.amplifire.controllers;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.lex.amplifire.models.LoginUser;
import com.lex.amplifire.models.Post;
import com.lex.amplifire.models.Profilepic;
import com.lex.amplifire.models.User;
import com.lex.amplifire.services.PostService;
import com.lex.amplifire.services.ProfilepicService;
import com.lex.amplifire.services.UserService;

@Controller
public class HomeController {

	@Autowired
	private UserService userServ;
	
	@Autowired
	private PostService postServ;
	
	@Autowired
	private ProfilepicService profilepicServ;

	
	
	
	
	
	// LOGIN AND REGISTRATION ROUTES
	@GetMapping("/login")
	public String index(Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
		model.addAttribute("newUser", new User());
        model.addAttribute("newLogin", new LoginUser());
        return "index.jsp";
		} else {
			return "redirect:/home";
		}
	}
	
	@PostMapping("/login")
	public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin,
			BindingResult result, Model model, HttpSession session) {
		User user = userServ.login(newLogin, result);
		if(result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "index.jsp";
		} else {			
			session.setAttribute("userId", user.getId());
			return "redirect:/home";
		}
	}
	
	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User newUser,
						   BindingResult result, Model model, HttpSession session) {
		userServ.register(newUser, result);
		if(result.hasErrors()) {
			model.addAttribute("newLogin", new LoginUser());
			return "index.jsp";
		} else {
			
			session.setAttribute("userId", newUser.getId());
			return "redirect:/edit/profile";
		}
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}

	
	
	
	
	
	// HOME ROUTES
	@RequestMapping("/")
	public String goHome() {
		return "redirect:/home";
	}
	
	@RequestMapping("/home")
	public String home(HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			User loggedInUser = null;
			model.addAttribute("loggedInUser", loggedInUser);
		} else {
			User loggedInUser = userServ.findOne(userId);
			model.addAttribute("loggedInUser", loggedInUser);
		}
			model.addAttribute("newPost", new Post());
			List<Post> posts = postServ.findNewestPosts();
			model.addAttribute("posts", posts);
			return "home.jsp";
	}
	
	@PostMapping("/post/new")
	public String post(@Valid @ModelAttribute("newPost") Post newPost,
			   		   BindingResult result, Model model, HttpSession session) {
		postServ.post(newPost, result);
		if(result.hasErrors()) {
			Long userId = (Long) session.getAttribute("userId");
			User loggedInUser = userServ.findOne(userId);
			model.addAttribute("loggedInUser", loggedInUser);
			List<Post> posts = postServ.findNewestPosts();
			model.addAttribute("posts", posts);
			return "home.jsp";
		} else {
			return "redirect:/home";
		}
	}

	
	
	
	
	
	// GENRE AND SEARCH ROUTES
	@GetMapping("/search/")
	public String search(@RequestParam(value="search") String search,
						 Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			User loggedInUser = null;
			model.addAttribute("loggedInUser", loggedInUser);
		} else {
			User loggedInUser = userServ.findOne(userId);
			model.addAttribute("loggedInUser", loggedInUser);
		}
		List<Post> posts = postServ.findPostByCaption(search);
		model.addAttribute("posts", posts);
		model.addAttribute("search", search);
		return "genres.jsp";
	}
	
	@RequestMapping("/genres")
	public String genresDefault(HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			User loggedInUser = null;
			model.addAttribute("loggedInUser", loggedInUser);
		} else {
			User loggedInUser = userServ.findOne(userId);
			model.addAttribute("loggedInUser", loggedInUser);
		}
		List<Post> posts = Collections.emptyList();
		model.addAttribute("posts", posts);
		return "genres.jsp";
	}
	
	@GetMapping("/genres/{genre}")
	public String genres(@PathVariable("genre") String genre, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			User loggedInUser = null;
			model.addAttribute("loggedInUser", loggedInUser);
		} else {
			User loggedInUser = userServ.findOne(userId);
			model.addAttribute("loggedInUser", loggedInUser);
		}
		List<Post> posts = postServ.findPostByGenre(genre);
		model.addAttribute("posts", posts);
		model.addAttribute("genre", genre);
		return "genres.jsp";
	}
	
	
	
	
	
	
	// PROFILE ROUTES
	@RequestMapping("/profile/{username}")
	public String profile(@PathVariable("username") String userName, Model model,
						  HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			User loggedInUser = null;
			model.addAttribute("loggedInUser", loggedInUser);
		} else {
			User loggedInUser = userServ.findOne(userId);
			model.addAttribute("loggedInUser", loggedInUser);
		}
		User user = userServ.findByUserName(userName);
		if (user == null) {
			return "redirect:/home";
		} else {
			model.addAttribute("user", user);
			List<Post> posts = postServ.findPostByUser(user);
			model.addAttribute("posts", posts);
			return "profile.jsp";
		}
	}
	
	@RequestMapping("/edit/profile")
	public String profileEdit(Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/home";
		} else {
			User loggedInUser = userServ.findOne(userId);
			model.addAttribute("editUser", loggedInUser);
			model.addAttribute("user", loggedInUser);
			return "edit-profile.jsp";
		}
	}
	
	@PutMapping("/edit/profile/{id}")
	public String profileUpdate(@Valid @ModelAttribute("editUser") User editUser,
								BindingResult result, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		User realUser = userServ.findOne(userId);
		editUser.setEmail(realUser.getEmail());
		editUser.setPassword(realUser.getPassword());
		User loggedInUser = userServ.findOne(userId);
		userServ.editAccount(editUser, result, loggedInUser.getUserName());
		if(result.hasErrors()) {
			model.addAttribute("user", loggedInUser);
			return "edit-profile.jsp";
		} else {
			return "redirect:/profile/" + loggedInUser.getUserName();
		}
	}

	
	
	
	
	
	//Profile Picture Upload
	@PostMapping("/edit/profile/pfp")
	public String profilePictureEdit(HttpSession session,
									 @RequestParam("fileImage") MultipartFile multipartFile) throws IOException {
    	//    	image save!---------------------------------------------
//    	write the original file name 
    	String fileName = StringUtils.cleanPath(multipartFile.getOriginalFilename());
    	
    	System.out.println("fileName:");
    	System.out.println(fileName.toString());
    	
    	if (fileName != null) {
    		
    		Profilepic profilePic = new Profilepic();
    		profilePic.setPic(fileName);
    		Profilepic savedProfilepic = profilepicServ.createProfilepic(profilePic);
    		
    		String uploadDir = "./src/main/resources/static/profile-pics/" +savedProfilepic.getId();
    		
    		Path uploadPath = Paths.get(uploadDir);
    		
    		if (!Files.exists(uploadPath)) {
    			Files.createDirectories(uploadPath);
    		}
    		
//    	read inputs form the multipart file
    		try (InputStream inputStream = multipartFile.getInputStream()) {
    			
    			//    	construct file path
    			Path filePath = uploadPath.resolve(fileName);
    			System.out.println(filePath.toString());
    			System.out.println(filePath.toFile().getAbsolutePath());
    			
    			Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
    		} catch (IOException e) {
    			throw new IOException("Could not save uploaded file: "+ fileName);
    		}
    		
    		
    		Long userId = (Long) session.getAttribute("userId");
    		User realUser = userServ.findOne(userId);
			User u = userServ.editPfp(realUser);
//	    	---------------------------------------
    		
			savedProfilepic.setUser(u);
			profilepicServ.updateProfilepic(savedProfilepic);
    		
    		
//	    	---- REGISTER - SAVE -THE NEW USERS ---------------
    		return "redirect:/home";
    	}
    	
//    	------ else if no profile pic ---------
    	Long userId = (Long) session.getAttribute("userId");
		User realUser = userServ.findOne(userId);
		User u = userServ.editPfp(realUser);
//    	---------------------------------------
//    	---- REGISTER - SAVE -THE NEW USERS ---------------
		return "redirect:/home";

	}
	
}
