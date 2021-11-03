package com.bidwars.controllers;

import com.bidwars.models.Gender;
import com.bidwars.models.User;
import com.bidwars.forms.UserForm;
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
public class ProfileController {

    private static final Logger logger = Logger.getLogger(ProfileController.class.getName());

    @Autowired
    private UserService userService;

    @Autowired
    private ListingService listingService;

    @GetMapping(value="/profile")
    public ModelAndView getProfile(HttpServletRequest request) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            ModelAndView mav = new ModelAndView("profile");
            mav.addObject("user", user);
            mav.addObject("userForm", new UserForm(user));
            mav.addObject("categories", listingService.findCategories());
            mav.addObject("genders", Gender.values());
            return mav;
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    @PostMapping(value="/profile")
    public ModelAndView postProfile(HttpServletRequest request, @Valid @ModelAttribute UserForm userForm) {
        try {
            User sessionUser = (User) request.getSession().getAttribute("user");
            if (sessionUser == null) {
                return new ModelAndView("redirect:/");
            }
            sessionUser.setUsername(userForm.getUsername());
            sessionUser.setPassword(userForm.getPassword());
            sessionUser.setName(userForm.getName());
            sessionUser.setSurname(userForm.getSurname());
            sessionUser.setAge(userForm.getAge());
            sessionUser.setGender(userForm.getGender());
            sessionUser.setLikedCategories(userForm.getLikedCategories());
            sessionUser = userService.save(sessionUser);
            request.getSession().setAttribute("user", sessionUser);
            return new ModelAndView("redirect:/profile");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

}
