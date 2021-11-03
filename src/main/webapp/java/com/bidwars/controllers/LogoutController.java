package com.bidwars.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.logging.Logger;

@Controller
public class LogoutController {

    private static final Logger logger = Logger.getLogger(LogoutController.class.getName());

    @GetMapping(value="/logout")
    public ModelAndView getLogout(HttpServletRequest request) {
        try {
            request.getSession().removeAttribute("user");
            return new ModelAndView("redirect:/");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    @PostMapping(value="/logout")
    public ModelAndView postLogout(HttpServletRequest request) {
        try {
            request.getSession().removeAttribute("user");
            return new ModelAndView("redirect:/");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

}
