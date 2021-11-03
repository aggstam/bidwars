package com.bidwars.controllers;

import com.bidwars.forms.BidForm;
import com.bidwars.models.Bid;
import com.bidwars.models.Listing;
import com.bidwars.forms.ListingForm;
import com.bidwars.models.User;
import com.bidwars.services.BidService;
import com.bidwars.services.ListingService;
import com.bidwars.services.MailService;
import com.bidwars.services.UserService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.logging.Logger;
import java.util.stream.Collectors;

import static java.util.Comparator.comparing;

@Controller
public class ListingController {

    private static final Logger logger = Logger.getLogger(ListingController.class.getName());
    private final String STATIC_FOLDER_PATH = "WEB-INF/resources/images/listings/";

    @Autowired
    private ListingService listingService;

    @Autowired
    private BidService bidService;

    @Autowired
    private UserService userService;

    @Autowired
    private MailService mailService;

    @Autowired
    ServletContext context;

    @GetMapping(value="/listing/{id}")
    public ModelAndView getListing(HttpServletRequest request, @PathVariable Integer id) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            Listing listing = listingService.findListingById(id);
            ModelAndView mav = new ModelAndView("listing");
            mav.addObject("user", user);
            mav.addObject("listing", listing);
            if (listing.getBids() != null && !listing.getBids().isEmpty()) {
                List<Listing> suggestedListings = listingService.findSuggestedListings(user, listing);
                if (suggestedListings != null && !suggestedListings.isEmpty()) {
                    mav.addObject("hasSuggestedListings", true);
                    mav.addObject("suggestedListings", suggestedListings);
                } else {
                    mav.addObject("hasSuggestedListings", false);
                }
            }
            if (user.getHistory()) {
                mav.addObject("listingForm", new ListingForm());
            }
            Boolean isActive = (listing != null && new Date().before(listing.getEnding()));
            mav.addObject("isActive", isActive);
            if (isActive) {
                mav.addObject("bidForm", new BidForm());
                listing.getBids().sort(comparing(Bid::getPrice));
                Collections.reverse(listing.getBids());
                mav.addObject("bids", listing.getBids());
            } else if (listing != null){
                if (!user.getHistory()) {
                    return new ModelAndView("redirect:/notFound");
                }
                listing.getBids().stream().max(Comparator.comparing(Bid::getPrice)).ifPresent(winnerBid -> {
                    mav.addObject("winner", winnerBid.getUser().getUsername());
                    mav.addObject("winnerPrice", winnerBid.getPrice());
                });
            } else {
                mav.getModel().remove("user");
                mav.getModel().remove("listing");
                mav.getModel().remove("isActive");
                mav.getModel().remove("listingForm");
                mav.setViewName("redirect:/notFound");
            }
            return mav;
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    @PostMapping(value="/listing")
    public ModelAndView addListing(HttpServletRequest request, @Valid @ModelAttribute ListingForm listingForm) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            if (!user.getHistory()) {
                return new ModelAndView("redirect:/notFound");
            }
            Listing listing = new Listing();
            listing.setPrice(listingForm.getPrice());
            setListingInformation(listing, listingForm);
            sendEmailToAppropriateUsersForNewListing(listing.getCategory());
            return new ModelAndView("redirect:/listing/" + listing.getId());
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    @PostMapping(value="/listing/{id}")
    public ModelAndView editListing(HttpServletRequest request, @PathVariable Integer id, @Valid @ModelAttribute ListingForm listingForm) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            if (!user.getHistory()) {
                return new ModelAndView("redirect:/notFound");
            }
            Listing listing = listingService.findListingById(id);
            if (listing == null) {
                return new ModelAndView("redirect:/notFound");
            }
            setListingInformation(listing, listingForm);
            return new ModelAndView("redirect:/listing/" + id);
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    private void setListingInformation(Listing listing, ListingForm listingForm) throws IOException {
        listing.setName(listingForm.getName());
        listing.setCategory(listingForm.getCategory());
        listing.setDescription(listingForm.getDescription());
        listing.setEnding(listingForm.getEnding());
        if (listing.getId() == null && listingForm.getFile() != null && !listingForm.getFile().isEmpty()) {
            listing.setImage(listingForm.getFile().getOriginalFilename());
        }
        listingService.save(listing);
        if (listingForm.getFile() != null && !listingForm.getFile().isEmpty()) {
            String listingFolderPath = context.getRealPath(STATIC_FOLDER_PATH) + listing.getId();
            Files.createDirectories(Paths.get(listingFolderPath));
            listingFolderPath += File.separator;
            Files.deleteIfExists(new File(listingFolderPath + listing.getImage()).toPath());
            listingForm.getFile().transferTo(new File(listingFolderPath + listingForm.getFile().getOriginalFilename()));
        }
    }

    @PostMapping(value="/listing/delete/{id}")
    public ModelAndView deleteListing(HttpServletRequest request, @PathVariable Integer id) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            if (!user.getHistory()) {
                return new ModelAndView("redirect:/notFound");
            }
            Listing listing = listingService.findListingById(id);
            if (listing == null) {
                return new ModelAndView("redirect:/notFound");
            }
            File file = new File(context.getRealPath(STATIC_FOLDER_PATH) + listing.getId());
            if (file.exists()) {
                FileUtils.forceDelete(file);
            }
            listingService.delete(listing);
            return new ModelAndView("redirect:/home");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    @PostMapping(value="/listing/placeBid/{id}")
    public ModelAndView placeBid(HttpServletRequest request, @PathVariable Integer id, @Valid @ModelAttribute BidForm bidForm) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            Listing listing = listingService.findListingById(id);
            if (listing == null) {
                return new ModelAndView("redirect:/notFound");
            }
            Date bidDate = new Date();
            if (bidDate.before(listing.getEnding())) {
                Bid bid = new Bid();
                bid.setListing(listing);
                bid.setUser(user);
                bid.setTimestamp(bidDate);
                bid.setPrice(bidForm.getPrice());
                if (bid.getPrice() > listing.getPrice()) {
                    Bid lastBid = listing.getBids().stream().filter(b -> b.getPrice().equals(listing.getPrice())).findAny().orElse(null);
                    if (lastBid != null) {
                        sendEmailToOutbidUser(listing.getName(), lastBid.getUser().getEmail());
                    }
                    bidService.save(bid);
                    listing.setPrice(bid.getPrice());
                    listingService.save(listing);
                    userService.checkCategorySuggestion(user, bidDate, listing.getCategory());
                }
            }
            return new ModelAndView("redirect:/listing/" + id);
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    private void sendEmailToAppropriateUsersForNewListing(String category) {
        List<User> appropriateUsers = userService.findUsersThatLikeACategory(category);
        if (appropriateUsers != null && !appropriateUsers.isEmpty()) {
            mailService.sendEmail("New listing!", appropriateUsers.stream().map(User::getEmail).collect(Collectors.toList()),
                    "<p>A new Listing that you may like has been created in our platform!</p>"
                            +"<p>Don't waste time, start bidding <b>now</b>!!!</p>"
                            +"<p>You received this email because you like " + category + " category.</p>");
        }
    }

    private void sendEmailToOutbidUser(String name, String email) {
        mailService.sendEmail("Outbid!", email,
                "<p>Someone outbid you on Listing " + name + " that you participate in our platform!</p>"
                        +"<p>Don't waste time, start bidding again <b>now</b>!!!</p>"
                        +"<p>You may lost the battle, but not the war!</p>");
    }

}
