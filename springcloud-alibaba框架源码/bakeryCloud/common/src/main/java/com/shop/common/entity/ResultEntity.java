package com.shop.common.entity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * AJAX结果返回实体
 *
 * @author wgyi
 * @vision 2015年8月16日
 */
public class ResultEntity extends HashMap<String, Object> {

    public static final int SUCCESS = 0;
    public static final int ERROR = -1;
    public static final int NOT_LOGIN = 1001;
    private static final long serialVersionUID = 457278793578226564L;


    public ResultEntity() {
        this.setCode(SUCCESS);
    }

    public ResultEntity(int code) {
        this.setCode(code);
    }

    public static ResultEntity ok() {
        return ok("操作成功", SUCCESS);
    }

    public static ResultEntity ok(String msg) {
        return ok(msg, SUCCESS);
    }

    public static ResultEntity ok(String msg, int code) {
        ResultEntity re = new ResultEntity();
        re.setCode(code);
        re.setMsg(msg);
        return re;
    }

    public static ResultEntity ok(String msg, int code, Map<String, Object> map) {
        ResultEntity re = new ResultEntity();
        re.setCode(code);
        re.setMsg(msg);
        re.putAll(map);
        return re;
    }

    public static ResultEntity ok(Map<String, Object> map) {
        ResultEntity re = new ResultEntity();
        re.setCode(SUCCESS);
        re.setMsg("操作成功");
        re.putAll(map);
        return re;
    }

    public static ResultEntity error() {
        return error("未知异常，请联系管理员", ERROR);
    }

    public static ResultEntity error(String msg) {
        return error(msg, ERROR);
    }

    public static ResultEntity error(String msg, int code) {
        ResultEntity re = new ResultEntity();
        re.setCode(code);
        re.setMsg(msg);
        return re;
    }

    public static ResultEntity error(String msg, int code, Map<String, Object> map) {
        ResultEntity re = new ResultEntity();
        re.setCode(code);
        re.setMsg(msg);
        re.putAll(map);
        return re;
    }

    public static ResultEntity error(Map<String, Object> map) {
        ResultEntity re = new ResultEntity();
        re.setCode(ERROR);
        re.setMsg("未知异常，请联系管理员");
        re.putAll(map);
        return re;
    }

    public int getCode() {
        return (Integer) this.get("code");
    }

    /**
     * 设置结果代码
     *
     * @param code
     */
    public void setCode(int code) {
        this.put("code", code);
    }

    public Integer getCount() {
        return (Integer) this.get("count");
    }

    /**
     * 设置结果集总数量
     *
     * @param count
     */
    public void setCount(Integer count) {
        this.put("count", count);
    }

    public Object getObject() {
        return (this.get("obj"));
    }

    /**
     * 设置返回实体（不是list的时候）
     *
     * @param obj
     */
    public void setObject(Object obj) {
        this.put("obj", obj);
    }

    @SuppressWarnings("unchecked")
    public <T> List<T> getList() {
        return (List<T>) this.get("list");
    }

    /**
     * 设置结果集
     *
     * @param list
     */
    public void setList(List<?> list) {
        this.put("list", list);
    }

    public String getError() {
        return (String) this.get("error");
    }

    /**
     * 设置错误信息
     *
     * @param error
     */
    public void setError(String error) {
        this.put("error", error);
    }

    public String getRedirect() {
        return (String) this.get("redirect");
    }

    /**
     * 设置需要跳转的页面地址
     *
     * @param redirect
     */
    public void setRedirect(String redirect) {
        this.put("redirect", redirect);
    }

    public String getMsg() {
        return (String) this.get("msg");
    }

    /**
     * 设置需要显示的消息
     *
     * @param msg
     */
    public void setMsg(String msg) {
        this.put("msg", msg);
    }

}
