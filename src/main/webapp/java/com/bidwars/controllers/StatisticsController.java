package com.bidwars.controllers;

import com.bidwars.models.AgeRange;
import com.bidwars.models.Gender;
import com.bidwars.models.User;
import com.bidwars.services.BidService;
import com.bidwars.services.ListingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.EnumSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

@Controller
public class StatisticsController {

    private static final Logger logger = Logger.getLogger(StatisticsController.class.getName());

    @Autowired
    private ListingService listingService;

    @Autowired
    private BidService bidService;

    @GetMapping(value="/statistics")
    public ModelAndView getStatistics(HttpServletRequest request) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            if (!user.getHistory()) {
                return new ModelAndView("redirect:/notFound");
            }
            List<String> categories = listingService.findCategories();
            Map<String, Map<String, Long>> ageRangePerCategoryStatisticsMap = new HashMap<>();
            for (AgeRange ageRange : AgeRange.values()) {
                Map<String, Long> statistics = bidService.retrieveAgeRangeStatisticsPerCategory(ageRange.getMin(), ageRange.getMax());
                if (!statistics.isEmpty()) {
                    ageRangePerCategoryStatisticsMap.put(ageRange.getRange(), statistics);
                }
            }
            Map<String, Map<String, Long>> categoryPerAgeRangeStatisticsMap = new HashMap<>();
            for (String category : categories) {
                Map<String, Long> statistics = bidService.retrieveCategoryStatisticsPerAgeRange(category);
                if (!statistics.isEmpty()) {
                    categoryPerAgeRangeStatisticsMap.put(category, mergeAgeRanges(statistics));
                }
            }
            Map<String, Map<String, Long>> genderPerCategoryStatisticsMap = new HashMap<>();
            for (Gender gender : Gender.values()) {
                Map<String, Long> statistics = bidService.retrieveGenderStatisticsPerCategory(gender.getText());
                if (!statistics.isEmpty()) {
                    genderPerCategoryStatisticsMap.put(gender.getText(), statistics);
                }
            }
            Map<String, Map<String, Long>> categoryPerGenderStatisticsMap = new HashMap<>();
            for (String category : categories) {
                Map<String, Long> statistics = bidService.retrieveCategoryStatisticsPerGender(category);
                if (!statistics.isEmpty()) {
                    categoryPerGenderStatisticsMap.put(category, statistics);
                }
            }
            Map<String, Map<String, Long>> combinationPerCategoryStatisticsMap = new HashMap<>();
            for (Gender gender : Gender.values()) {
                for (AgeRange ageRange : AgeRange.values()) {
                    Map<String, Long> statistics = bidService.retrieveCombinationStatisticsPerCategory(gender.getText(), ageRange.getMin(), ageRange.getMax());
                    if (!statistics.isEmpty()) {
                        combinationPerCategoryStatisticsMap.put(gender.getText() + " -> " + ageRange.getRange(), statistics);
                    }
                }
            }
            Map<String, Map<String, Long>> categoryPerCombinationStatisticsMap = new HashMap<>();
            for (String category : categories) {
                Map<String, Long> statistics = bidService.retrieveCategoryStatisticsPerCombination(category);
                if (!statistics.isEmpty()) {
                    categoryPerCombinationStatisticsMap.put(category, mergeCombinationAgeRanges(statistics));
                }
            }
            ModelAndView mav = new ModelAndView("statistics");
            mav.addObject("user", user);
            mav.addObject("ageRangePerCategoryStatisticsMap", ageRangePerCategoryStatisticsMap);
            mav.addObject("categoryPerAgeRangeStatisticsMap", categoryPerAgeRangeStatisticsMap);
            mav.addObject("genderPerCategoryStatisticsMap", genderPerCategoryStatisticsMap);
            mav.addObject("categoryPerGenderStatisticsMap", categoryPerGenderStatisticsMap);
            mav.addObject("combinationPerCategoryStatisticsMap", combinationPerCategoryStatisticsMap);
            mav.addObject("categoryPerCombinationStatisticsMap", categoryPerCombinationStatisticsMap);
            return mav;
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    private Map<String, Long> mergeAgeRanges(Map<String, Long> statistics) {
        Map<String, Long> mergedMap = new HashMap<>();
        statistics.forEach((k, v) -> {
            Integer age = Integer.valueOf(k);
            AgeRange ageRange = EnumSet.allOf(AgeRange.class)
                                       .stream()
                                       .filter(e -> age >= e.getMin() && age <= e.getMax())
                                       .findAny()
                                       .orElse(AgeRange.RANGE_85PLUS);
            mergedMap.merge(ageRange.getRange(), v, Long::sum);
        });
        return mergedMap;
    }

    private Map<String, Long> mergeCombinationAgeRanges(Map<String, Long> statistics) {
        Map<String, Long> mergedMap = new HashMap<>();
        statistics.forEach((k, v) -> {
            String[] combination = k.split(" -> ");
            Integer age = Integer.valueOf(combination[1]);
            AgeRange ageRange = EnumSet.allOf(AgeRange.class)
                    .stream()
                    .filter(e -> age >= e.getMin() && age <= e.getMax())
                    .findAny()
                    .orElse(AgeRange.RANGE_85PLUS);
            mergedMap.merge(combination[0] + " -> " + ageRange.getRange(), v, Long::sum);
        });
        return mergedMap;
    }

}
