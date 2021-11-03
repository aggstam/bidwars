package com.bidwars.controllers;

import com.bidwars.forms.LoginForm;
import com.bidwars.forms.UserForm;
import com.bidwars.models.Gender;
import com.bidwars.models.User;
import com.bidwars.services.ListingService;
import com.bidwars.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.logging.Logger;

@Controller
public class LoginController {

    private static final Logger logger = Logger.getLogger(LoginController.class.getName());

    @Autowired
    private UserService userService;

    @Autowired
    private ListingService listingService;

    @GetMapping(value="/")
    public ModelAndView getLogin() {
        try {
            return newLoginModelAndView(null);
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    @PostMapping(value="/login")
    public ModelAndView postLogin(HttpServletRequest request, @Valid @ModelAttribute LoginForm loginForm) {
        try {
            User user = userService.findUserByUsernameAndPassword(loginForm.getLoginUsername(), loginForm.getLoginPassword());
            if (user != null) {
                request.getSession().setAttribute("user", user);
                return new ModelAndView("redirect:/home");
            }
            return newLoginModelAndView("Username or password is incorrect. Please try again...");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    @PostMapping(value="/signup")
    public ModelAndView postSignup(HttpServletRequest request, @Valid @ModelAttribute UserForm userForm) {
        try {
            User user = new User();
            user.setUsername(userForm.getUsername());
            user.setPassword(userForm.getPassword());
            user.setEmail(userForm.getEmail());
            user.setHistory(false);
            user.setManagement(false);
            user.setName(userForm.getName());
            user.setSurname(userForm.getSurname());
            user.setAge(userForm.getAge());
            user.setGender(userForm.getGender());
            user.setLikedCategories(userForm.getLikedCategories());
            try {
                user = userService.save(user);
            } catch (Exception e) {
                return newLoginModelAndView("User already exists. Please choose another username...");
            }
            request.getSession().setAttribute("user", user);
            return new ModelAndView("redirect:/home");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    private ModelAndView newLoginModelAndView(String errorMessage) {
        ModelAndView mav = new ModelAndView("login");
        mav.addObject("loginForm", new LoginForm(errorMessage));
        mav.addObject("userForm", new UserForm());
        mav.addObject("categories", listingService.findCategories());
        mav.addObject("genders", Gender.values());
        return mav;
    }

}
