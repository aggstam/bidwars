package com.bidwars.controllers;

import com.bidwars.models.Listing;
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
public class HistoryController {

    private static final Logger logger = Logger.getLogger(HistoryController.class.getName());

    @Autowired
    private ListingService listingService;

    @GetMapping(value="/history")
    public ModelAndView getHistory(HttpServletRequest request) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            if (!user.getHistory()) {
                return new ModelAndView("redirect:/notFound");
            }
            List<Listing> listings = listingService.findPastListings();
            ModelAndView mav = new ModelAndView("history");
            mav.addObject("user", user);
            mav.addObject("listings", listings);
            return mav;
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

}
