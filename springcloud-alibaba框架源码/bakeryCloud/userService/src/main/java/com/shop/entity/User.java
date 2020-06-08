package com.shop.entity;

import com.shop.common.entity.CommonEntity;
import lombok.Data;

import javax.persistence.Table;
import java.io.Serializable;
import java.util.Set;

/**
 * 用户（用户实体）
 */
@Data
@Table(name = "t_user")
public class User extends CommonEntity implements Serializable {

    /**
     * 用户名
     */
    private String userName;

    /**
     * 用户密码
     */
    private String password;

    /**
     * 用户token
     */
    private String token;

    private Set<String> roles;
    private Set<String> permissions;
}
