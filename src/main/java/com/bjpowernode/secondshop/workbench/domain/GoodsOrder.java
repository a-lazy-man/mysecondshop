package com.bjpowernode.secondshop.workbench.domain;

public class GoodsOrder {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column goods_order.id
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    private String id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column goods_order.good_id
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    private Integer goodId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column goods_order.good_name
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    private String goodName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column goods_order.seller_id
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    private String sellerId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column goods_order.customer_id
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    private String customerId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column goods_order.money
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    private Double money;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column goods_order.submit_time
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    private String submitTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column goods_order.end_time
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    private String endTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column goods_order.status_id
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    private Integer statusId;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column goods_order.id
     *
     * @return the value of goods_order.id
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    public String getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column goods_order.id
     *
     * @param id the value for goods_order.id
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column goods_order.good_id
     *
     * @return the value of goods_order.good_id
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    public Integer getGoodId() {
        return goodId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column goods_order.good_id
     *
     * @param goodId the value for goods_order.good_id
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    public void setGoodId(Integer goodId) {
        this.goodId = goodId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column goods_order.good_name
     *
     * @return the value of goods_order.good_name
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    public String getGoodName() {
        return goodName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column goods_order.good_name
     *
     * @param goodName the value for goods_order.good_name
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    public void setGoodName(String goodName) {
        this.goodName = goodName == null ? null : goodName.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column goods_order.seller_id
     *
     * @return the value of goods_order.seller_id
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    public String getSellerId() {
        return sellerId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column goods_order.seller_id
     *
     * @param sellerId the value for goods_order.seller_id
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    public void setSellerId(String sellerId) {
        this.sellerId = sellerId == null ? null : sellerId.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column goods_order.customer_id
     *
     * @return the value of goods_order.customer_id
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    public String getCustomerId() {
        return customerId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column goods_order.customer_id
     *
     * @param customerId the value for goods_order.customer_id
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    public void setCustomerId(String customerId) {
        this.customerId = customerId == null ? null : customerId.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column goods_order.money
     *
     * @return the value of goods_order.money
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    public Double getMoney() {
        return money;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column goods_order.money
     *
     * @param money the value for goods_order.money
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    public void setMoney(Double money) {
        this.money = money;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column goods_order.submit_time
     *
     * @return the value of goods_order.submit_time
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    public String getSubmitTime() {
        return submitTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column goods_order.submit_time
     *
     * @param submitTime the value for goods_order.submit_time
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    public void setSubmitTime(String submitTime) {
        this.submitTime = submitTime == null ? null : submitTime.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column goods_order.end_time
     *
     * @return the value of goods_order.end_time
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    public String getEndTime() {
        return endTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column goods_order.end_time
     *
     * @param endTime the value for goods_order.end_time
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    public void setEndTime(String endTime) {
        this.endTime = endTime == null ? null : endTime.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column goods_order.status_id
     *
     * @return the value of goods_order.status_id
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    public Integer getStatusId() {
        return statusId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column goods_order.status_id
     *
     * @param statusId the value for goods_order.status_id
     *
     * @mbggenerated Thu Feb 02 16:39:08 CST 2023
     */
    public void setStatusId(Integer statusId) {
        this.statusId = statusId;
    }
}