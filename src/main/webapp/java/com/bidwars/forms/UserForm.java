package com.bidwars.forms;

import com.bidwars.models.User;
import org.springframework.lang.Nullable;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class UserForm {

    @NotNull
    @Size(min=6, max=20)
    private String username;

    @NotNull
    @Size(min=8, max=20)
    private String password;

    @NotNull
    @Size(min=4, max=50)
    @Email
    private String email;

    private Boolean history;

    private Boolean management;

    @NotNull
    @Size(min=3, max=20)
    private String name;

    @NotNull
    @Size(min=3, max=20)
    private String surname;

    @NotNull
    @Size(min=1, max=150)
    private Integer age;

    @NotNull
    @Size(min=4, max=20)
    private String gender;

    @Nullable
    private String likedCategories;

    public UserForm() {}

    public UserForm(User user) {
        this.username = user.getUsername();
        this.email = user.getEmail();
        this.name = user.getName();
        this.surname = user.getSurname();
        this.age = user.getAge();
        this.gender = user.getGender();
        this.likedCategories = user.getLikedCategories();
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Boolean getHistory() {
        return history;
    }

    public void setHistory(Boolean history) {
        this.history = history;
    }

    public Boolean getManagement() {
        return management;
    }

    public void setManagement(Boolean management) {
        this.management = management;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getLikedCategories() {
        return likedCategories;
    }

    public void setLikedCategories(String likedCategories) {
        this.likedCategories = likedCategories;
    }

}
