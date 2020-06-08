package com.shop.entity;

import com.shop.common.entity.CommonEntity;
import lombok.Data;

import javax.persistence.Table;

@Data
@Table(name = "t_storage")
public class ProductStorage extends CommonEntity {

     private String productId;

     private Integer total;

     //已使用库存
     private Integer used;

     //库存减少
     private Integer residue;
}
