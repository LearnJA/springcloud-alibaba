package com.shop.common.entity;

import lombok.Data;

import java.util.List;

@Data
public class BatchResultDTO<T> {

    private List<T> data;

    private Long count;

    private String code = "0";

    private String msg;

}
