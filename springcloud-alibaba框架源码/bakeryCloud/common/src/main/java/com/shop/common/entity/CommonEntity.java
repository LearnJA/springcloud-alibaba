package com.shop.common.entity;

import com.shop.common.utils.IdGen;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.ToString;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Date;

/**
 * 公共实体，系统业务实体继承
 */
@Data
@ToString
public abstract class CommonEntity implements Serializable {

    @Id
    @KeySql(genId = IdGen.class)
    private String id;         //id

    @Column(name = "remarks")
    private String remarks;

    @Column(name = "create_date")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createDate;

    @Column(name = "create_by")
    private String createBy;

    @Column(name = "update_date")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateDate = new Date();

    @Column(name = "update_by")
    private String updateBy;

    @Column(name = "del_flag")
    private String delFlag = "0";

}
