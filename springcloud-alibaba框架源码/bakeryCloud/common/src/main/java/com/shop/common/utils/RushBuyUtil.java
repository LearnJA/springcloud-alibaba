package com.shop.common.utils;

import com.google.common.collect.Maps;

import java.util.Map;

public class RushBuyUtil {

    public static Map<String, Boolean> RUSH_BUY_MAP = Maps.newConcurrentMap();

    public static Map<String, Integer> RUSH_BUY_COUNT_MAP = Maps.newHashMap();

}
