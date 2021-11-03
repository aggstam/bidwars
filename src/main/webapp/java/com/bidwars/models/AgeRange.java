package com.bidwars.models;

public enum AgeRange {
    RANGE_0_15("0-15", 0, 15),
    RANGE_16_24("16-24", 16, 24),
    RANGE_25_34("25-34", 25, 34),
    RANGE_35_44("35-44", 35, 44),
    RANGE_45_54("45-54", 45, 54),
    RANGE_55_64("55-64", 55, 64),
    RANGE_65_74("65-74", 65, 74),
    RANGE_75_84("75-84", 75, 84),
    RANGE_85PLUS("85+", 85, 150);

    private final String range;
    private final Integer min;
    private final Integer max;

    AgeRange(String range, Integer min, Integer max) {
        this.range = range;
        this.min = min;
        this.max = max;
    }

    public String getRange() {
        return range;
    }

    public Integer getMin() {
        return min;
    }

    public Integer getMax() {
        return max;
    }

}
