package com.bidwars.controllers;

import com.bidwars.models.Bid;
import com.bidwars.models.Listing;
import com.bidwars.models.User;
import com.bidwars.services.BidService;
import com.bidwars.services.ListingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;

@Controller
public class BidsController {

    private static final Logger logger = Logger.getLogger(BidsController.class.getName());

    @Autowired
    private ListingService listingService;

    @Autowired
    private BidService bidService;

    @GetMapping(value="/bids")
    public ModelAndView getBids(HttpServletRequest request) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            List<Bid> bids = bidService.findUserActiveBids(user.getId());
            List<Integer> listingsIds = bids.stream()
                    .map(b -> b.getListing().getId())
                    .distinct()
                    .collect(Collectors.toList());
            List<Listing> listings = listingService.findActiveListingsByIds(listingsIds);
            ModelAndView mav = new ModelAndView("bids");
            mav.addObject("user", user);
            mav.addObject("listings", listings);
            return mav;
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

}
