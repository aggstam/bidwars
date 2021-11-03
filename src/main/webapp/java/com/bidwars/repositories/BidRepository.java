package com.bidwars.repositories;

import com.bidwars.models.Bid;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BidRepository extends JpaRepository<Bid, Integer> {

    @Query("SELECT b FROM Bid b WHERE b.user.id=:userId")
    List<Bid> findUserActiveBids(@Param("userId")Integer userId);

    @Query("SELECT b.listing.category, COUNT(b) FROM Bid b WHERE b.user.age >= :min and b.user.age <= :max GROUP BY b.listing.category")
    List<Object[]> retrieveAgeRangeStatisticsPerCategory(@Param("min")Integer min, @Param("max")Integer max);

    @Query("SELECT b.user.age, COUNT(b) FROM Bid b WHERE b.listing.category = :category GROUP BY b.user.age")
    List<Object[]> retrieveCategoryStatisticsPerAgeRange(@Param("category")String category);

    @Query("SELECT b.listing.category, COUNT(b) FROM Bid b WHERE b.user.gender = :gender GROUP BY b.listing.category")
    List<Object[]> retrieveGenderStatisticsPerCategory(@Param("gender")String gender);

    @Query("SELECT b.user.gender, COUNT(b) FROM Bid b WHERE b.listing.category = :category GROUP BY b.user.gender")
    List<Object[]> retrieveCategoryStatisticsPerGender(@Param("category")String category);

    @Query("SELECT b.listing.category, COUNT(b) FROM Bid b WHERE b.user.gender = :gender and b.user.age >= :min and b.user.age <= :max GROUP BY b.listing.category")
    List<Object[]> retrieveCombinationStatisticsPerCategory(@Param("gender")String gender, @Param("min")Integer min, @Param("max")Integer max);

    @Query("SELECT b.user.gender, b.user.age, COUNT(b) FROM Bid b WHERE b.listing.category = :category GROUP BY b.user.gender, b.user.age")
    List<Object[]> retrieveCategoryStatisticsPerCombination(@Param("category")String category);

}
