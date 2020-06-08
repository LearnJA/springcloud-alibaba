package com.shop.entity;

import com.shop.common.entity.CommonEntity;
import lombok.Data;

import javax.persistence.Table;
import java.math.BigDecimal;

@Data
@Table(name = "t_order")
public class OrderInfo extends CommonEntity {

    private Long userId;

    private Integer count;

    private BigDecimal money;

    private Long productId;

    /**
     * 订单状态0- 创建， 1-完成
     */
    private Integer status;
}
