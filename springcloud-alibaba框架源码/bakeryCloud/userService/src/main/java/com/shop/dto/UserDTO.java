package com.shop.dto;

import com.shop.common.entity.CommonEntity;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class UserDTO extends CommonEntity {

    /**
     * 会员姓名
     */
    @ApiModelProperty(value = "会员姓名", name = "name", example = "最可爱的人")
    private String userName;

    /**
     * 会员密码
     */
    @ApiModelProperty(value = "会员密码", name = "password", example = "123456")
    private String password;

}
