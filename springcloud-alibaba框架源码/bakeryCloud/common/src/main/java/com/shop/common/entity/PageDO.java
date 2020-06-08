package com.shop.common.entity;


import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

import javax.persistence.Transient;

/**
 * 针对分页显示
 */
@Data
public class PageDO {

    /**
     * 当前页码
     */
    @JsonIgnore
    @Transient
    private Integer page;

    /**
     * 每页显示条数
     */
    @JsonIgnore
    @Transient
    private Integer limit;


    public Integer getLimit() {
        if (this.limit == null) {
            //pageHelper pageSizeZero 参数设置为true，pageSize=0时，查询全部结果
            return 0;
        }
        return limit;
    }

    public Integer getPage() {
        if (this.page == null) {
            return 1;
        }
        return page;
    }
}
