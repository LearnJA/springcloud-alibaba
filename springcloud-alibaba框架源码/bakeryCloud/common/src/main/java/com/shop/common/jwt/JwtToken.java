package com.shop.common.jwt;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

/**
 * 描述:jwt 模型
 *
 * @Auther: lzx
 * @Date: 2019/7/9 13:42
 */
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class JwtToken {

    private String userName;

    private String password;

    private List<String> roleIdList;

}
