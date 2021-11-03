package com.bidwars.services;

import com.bidwars.models.User;
import com.bidwars.repositories.UserRepository;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

@Service
public class UserService {

    @Resource
    private UserRepository userRepository;

    public User save(User user) {
        return userRepository.save(user);
    }

    public void delete(User user) {
        userRepository.delete(user);
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public User findUserById(Integer id) {
        return userRepository.findUserById(id);
    }

    public User findUserByUsernameAndPassword(String username, String password) {
        return userRepository.findUserByUsernameAndPassword(username, password);
    }

    public List<User> findUsersThatLikeACategory(String category){
        return userRepository.findUsersThatLikeACategory(category);
    }

    public void checkCategorySuggestion(User user, Date bidDate, String category) {
        if (!user.getLikedCategories().contains(category)) {
            GregorianCalendar calendar = new GregorianCalendar();
            calendar.setTime(bidDate);
            calendar.add(Calendar.DATE,  -10);
            Date thresholdDate = calendar.getTime();
            Integer similarBidsCount = userRepository.getSimilarBidsCount(user.getId(), thresholdDate, category);
            if (similarBidsCount >= 5) {
                if (user.getLikedCategories() != null && !user.getLikedCategories().equals("")) {
                    user.setLikedCategories(user.getLikedCategories() + "," + category);
                } else {
                    user.setLikedCategories(category);
                }
                save(user);
            }
        }
    }

}
