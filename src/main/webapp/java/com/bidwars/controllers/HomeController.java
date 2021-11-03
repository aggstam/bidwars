package com.bidwars.controllers;

import com.bidwars.models.Listing;
import com.bidwars.forms.ListingForm;
import com.bidwars.models.User;
import com.bidwars.services.ListingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.logging.Logger;

@Controller
public class HomeController {

    private static final Logger logger = Logger.getLogger(HomeController.class.getName());

    @Autowired
    private ListingService listingService;

    @GetMapping(value="/home")
    public ModelAndView getHome(HttpServletRequest request) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            List<Listing> listings = listingService.findActiveListingsUsingLikedCategories(user.getLikedCategories());
            ModelAndView mav = new ModelAndView("home");
            mav.addObject("user", user);
            mav.addObject("listings", listings);
            if (user.getHistory()) {
                mav.addObject("listingForm", new ListingForm());
            }
            return mav;
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

}
