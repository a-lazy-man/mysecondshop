package com.bjpowernode.secondshop.workbench.mapper;

import com.bjpowernode.secondshop.workbench.domain.Message;

import java.util.List;

public interface MessageMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table message
     *
     * @mbggenerated Sun Jan 29 13:52:31 CST 2023
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table message
     *
     * @mbggenerated Sun Jan 29 13:52:31 CST 2023
     */
    int insert(Message record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table message
     *
     * @mbggenerated Sun Jan 29 13:52:31 CST 2023
     */
    int insertSelective(Message record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table message
     *
     * @mbggenerated Sun Jan 29 13:52:31 CST 2023
     */
    Message selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table message
     *
     * @mbggenerated Sun Jan 29 13:52:31 CST 2023
     */
    int updateByPrimaryKeySelective(Message record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table message
     *
     * @mbggenerated Sun Jan 29 13:52:31 CST 2023
     */
    int updateByPrimaryKey(Message record);

    /**
     * 根据该商品的主键id在message表中查找该商品的所有的留言
     * @param goodId
     * @return
     */
    List<Message> selectMessagesByGoodId(Integer goodId);

    /**
     * 添加一条留言
     * @param message
     * @return
     */
    int insertMessage(Message message);
}