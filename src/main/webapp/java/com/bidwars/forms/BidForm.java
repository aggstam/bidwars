package com.bidwars.forms;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Min;

public class BidForm {

    @NotNull
    @Min(0)
    private Integer price;

    public BidForm() {}

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

}
