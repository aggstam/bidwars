package com.bidwars.services;

import com.bidwars.models.Bid;
import com.bidwars.repositories.BidRepository;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BidService {

    @Resource
    private BidRepository bidRepository;

    public void save(Bid bid) {
        bidRepository.save(bid);
    }

    public List<Bid> findUserActiveBids(Integer userId) {
        return bidRepository.findUserActiveBids(userId);
    }

    public Map<String, Long> retrieveAgeRangeStatisticsPerCategory(Integer min, Integer max) {
        List<Object[]> statistics = bidRepository.retrieveAgeRangeStatisticsPerCategory(min, max);
        return extractStatisticsMap(statistics);
    }

    public Map<String, Long> retrieveCategoryStatisticsPerAgeRange(String category) {
        List<Object[]> statistics = bidRepository.retrieveCategoryStatisticsPerAgeRange(category);
        return extractStatisticsMap(statistics);
    }

    public Map<String, Long> retrieveGenderStatisticsPerCategory(String gender) {
        List<Object[]> statistics = bidRepository.retrieveGenderStatisticsPerCategory(gender);
        return extractStatisticsMap(statistics);
    }

    public Map<String, Long> retrieveCategoryStatisticsPerGender(String category) {
        List<Object[]> statistics = bidRepository.retrieveCategoryStatisticsPerGender(category);
        return extractStatisticsMap(statistics);
    }

    public Map<String, Long> retrieveCombinationStatisticsPerCategory(String gender, Integer min, Integer max) {
        List<Object[]> statistics = bidRepository.retrieveCombinationStatisticsPerCategory(gender, min, max);
        return extractStatisticsMap(statistics);
    }

    public Map<String, Long> retrieveCategoryStatisticsPerCombination(String category) {
        List<Object[]> statistics = bidRepository.retrieveCategoryStatisticsPerCombination(category);
        return extractCombinationStatisticsMap(statistics);
    }

    private Map<String, Long> extractStatisticsMap(List<Object[]> statistics) {
        Map<String, Long> statisticsMap = new HashMap<>();
        for (Object[] statistic : statistics) {
            statisticsMap.put(statistic[0].toString(), (Long) statistic[1]);
        }
        return statisticsMap;
    }

    private Map<String, Long> extractCombinationStatisticsMap(List<Object[]> statistics) {
        Map<String, Long> statisticsMap = new HashMap<>();
        for (Object[] statistic : statistics) {
            statisticsMap.put(statistic[0].toString() + " -> " + statistic[1].toString(), (Long) statistic[2]);
        }
        return statisticsMap;
    }

}
