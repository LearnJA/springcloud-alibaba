package com.shop.common.service;

import com.shop.common.entity.BatchResultDTO;
import com.shop.common.entity.PageDO;
import com.shop.common.mapper.MyMapper;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.util.Assert;

import java.util.List;

public abstract class BaseService<M extends MyMapper, T> {

    @Autowired
    public M mapper;

    /**
     * 新增
     *
     * @param obj
     * @return
     */
    public void add(T obj) {
        mapper.insertSelective(obj);
    }


    /**
     * 删除
     *
     * @param key
     * @return
     */
    public void del(Object key) {
        mapper.deleteByPrimaryKey(key);
    }

    /**
     * 根据主键编辑
     *
     * @param obj
     * @return
     */
    public void editByPK(T obj) {
        mapper.updateByPrimaryKeySelective(obj);
    }

    /**
     * 根据条件编辑
     *
     * @param obj     需要编辑的内容
     * @param example 编辑条件
     */
    public void editByExample(T obj, Example example) {
        mapper.updateByExampleSelective(obj, example);
    }

    /**
     * 根据主键查询
     *
     * @param key
     * @return
     */
    public T queryByPK(Object key) {
        return (T) mapper.selectByPrimaryKey(key);
    }

    /**
     * 根据条件查询list
     *
     * @param obj
     * @return
     */
    public List<T> queryForList(T obj) {
        return mapper.select(obj);
    }

    /**
     * 根据条件count
     *
     * @param obj
     * @return
     */
    public Integer queryForCount(T obj) {
        return mapper.selectCount(obj);
    }

    /**
     * 分页查询list
     *
     * @param obj
     * @return
     */
    public BatchResultDTO<T> queryForPageList(T obj) {
        Assert.isTrue(obj instanceof PageDO, String.format("%s need to extends pageDo", obj.getClass().getName()));
        BatchResultDTO<T> resultDTO = new BatchResultDTO<>();
        PageHelper.startPage(((PageDO) obj).getPage(), ((PageDO) obj).getLimit());
        Page<T> page = (Page<T>) mapper.select(obj);
        resultDTO.setData(page.getResult());
        resultDTO.setCount(page.getTotal());
        return resultDTO;
    }

    public BatchResultDTO<T> queryForPageList(PageDO pageDO, Example example) {
        BatchResultDTO<T> resultDTO = new BatchResultDTO<>();
        PageHelper.startPage(pageDO.getPage(), pageDO.getLimit());
        Page<T> page = (Page<T>) mapper.selectByExample(example);
        resultDTO.setData(page.getResult());
        resultDTO.setCount(page.getTotal());
        return resultDTO;
    }

    /**
     * 根据条件查询
     *
     * @param example
     * @return
     */
    public List<T> selectByExample(Example example) {
        return mapper.selectByExample(example);
    }

    /**
     * 根据条件查询
     *
     * @param example
     * @return
     */
    public List<T> queryByExample(Example example) {
        return mapper.selectByExample(example);
    }

}