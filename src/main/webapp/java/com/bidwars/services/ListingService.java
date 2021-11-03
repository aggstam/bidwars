package com.bidwars.services;

import com.bidwars.models.AgeRange;
import com.bidwars.models.Bid;
import com.bidwars.models.Listing;
import com.bidwars.models.User;
import com.bidwars.repositories.ListingRepository;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class ListingService {

    @Resource
    private ListingRepository listingRepository;

    public List<Listing> findActiveListingsUsingLikedCategories(String categories) {
        Date date = new Date();
        if (categories != null && !categories.equals("")) {
            List<String> categoriesList = Arrays.asList(categories.split(","));
            List<Listing> preferredListings = new ArrayList<>();
            preferredListings.addAll(listingRepository.findUserPreferredActiveListings(date, categoriesList));
            preferredListings.addAll(listingRepository.findUserNotPreferredActiveListings(date, categoriesList));
            return preferredListings;
        }
        return listingRepository.findActiveListings(date);
    }

    public List<Listing> findActiveListingsByIds(List<Integer> ids) {
        return listingRepository.findActiveListingsByIds(new Date(), ids);
    }

    public List<Listing> findPastListings() {
        return listingRepository.findPastListings(new Date());
    }

    public Listing findListingById(Integer id) {
        return listingRepository.findListingById(id);
    }

    public void save(Listing listing) {
        listingRepository.save(listing);
    }

    public void delete(Listing listing) {
        listingRepository.delete(listing);
    }

    public List<String> findCategories() {
        return listingRepository.findCategories();
    }

    public List<Listing> findSuggestedListings(User user, Listing listing) {
        AgeRange userAgeRange = EnumSet.allOf(AgeRange.class)
                                       .stream()
                                       .filter(e -> user.getAge() >= e.getMin() && user.getAge() <= e.getMax())
                                       .findAny()
                                       .orElse(AgeRange.RANGE_85PLUS);
        List<Integer> sameAgeRangeUsersIds = listing.getBids()
                                                    .stream()
                                                    .filter(b -> b.getUser().getAge() >= userAgeRange.getMin() && b.getUser().getAge() <= userAgeRange.getMax() && !b.getUser().getId().equals(user.getId()))
                                                    .map(Bid::getUser)
                                                    .map(User::getId)
                                                    .collect(Collectors.toList());
        return listingRepository.findSuggestedListings(new Date(), listing.getCategory(), listing.getId(), sameAgeRangeUsersIds);
    }

}
