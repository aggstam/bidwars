package com.bidwars.controllers;

import com.bidwars.forms.UserForm;
import com.bidwars.models.User;
import com.bidwars.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.List;
import java.util.logging.Logger;

@Controller
public class ManagementController {

    private static final Logger logger = Logger.getLogger(ManagementController.class.getName());

    @Autowired
    private UserService userService;

    @GetMapping(value="/management")
    public ModelAndView getManagement(HttpServletRequest request) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            if (!user.getManagement()) {
                return new ModelAndView("redirect:/notFound");
            }
            List<User> users = userService.findAll();
            ModelAndView mav = new ModelAndView("management");
            mav.addObject("user", user);
            mav.addObject("users", users);
            mav.addObject("userForm", new UserForm());
            return mav;
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    @PostMapping(value="/management")
    public ModelAndView addUser(HttpServletRequest request, @Valid @ModelAttribute UserForm userForm) {
        try {
            User sessionUser = (User) request.getSession().getAttribute("user");
            if (sessionUser == null) {
                return new ModelAndView("redirect:/");
            }
            if (!sessionUser.getManagement()) {
                return new ModelAndView("redirect:/notFound");
            }
            setUserInformation(new User(), userForm);
            return new ModelAndView("redirect:/management");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    @PostMapping(value="/management/{id}")
    public ModelAndView editUser(HttpServletRequest request, @PathVariable Integer id, @Valid @ModelAttribute UserForm userForm) {
        try {
            User sessionUser = (User) request.getSession().getAttribute("user");
            if (sessionUser == null) {
                return new ModelAndView("redirect:/");
            }
            if (!sessionUser.getManagement()) {
                return new ModelAndView("redirect:/notFound");
            }
            User user = userService.findUserById(id);
            if (user == null) {
                return new ModelAndView("redirect:/notFound");
            }
            setUserInformation(user, userForm);
            return new ModelAndView("redirect:/management");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    private void setUserInformation(User user, UserForm userForm) {
        user.setUsername(userForm.getUsername());
        user.setPassword(userForm.getPassword());
        user.setHistory(userForm.getHistory());
        user.setManagement(userForm.getManagement());
        userService.save(user);
    }

    @PostMapping(value="/management/delete/{id}")
    public ModelAndView deleteUser(HttpServletRequest request, @PathVariable Integer id) {
        try {
            User sessionUser = (User) request.getSession().getAttribute("user");
            if (sessionUser == null) {
                return new ModelAndView("redirect:/");
            }
            if (!sessionUser.getManagement()) {
                return new ModelAndView("redirect:/notFound");
            }
            User user = userService.findUserById(id);
            if (user == null) {
                return new ModelAndView("redirect:/notFound");
            }
            userService.delete(user);
            if (sessionUser.getId().equals(user.getId())) {
                return new ModelAndView("redirect:/logout");
            }
            return new ModelAndView("redirect:/management");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

}
