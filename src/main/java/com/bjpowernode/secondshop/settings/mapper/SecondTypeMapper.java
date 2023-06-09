package com.bjpowernode.secondshop.settings.mapper;

import com.bjpowernode.secondshop.settings.domain.SecondType;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SecondTypeMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table second_type
     *
     * @mbggenerated Thu Jan 26 17:36:47 CST 2023
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table second_type
     *
     * @mbggenerated Thu Jan 26 17:36:47 CST 2023
     */
    int insert(SecondType secondType);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table second_type
     *
     * @mbggenerated Thu Jan 26 17:36:47 CST 2023
     */
    int insertSelective(SecondType record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table second_type
     *
     * @mbggenerated Thu Jan 26 17:36:47 CST 2023
     */
    SecondType selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table second_type
     *
     * @mbggenerated Thu Jan 26 17:36:47 CST 2023
     */
    int updateByPrimaryKeySelective(SecondType record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table second_type
     *
     * @mbggenerated Thu Jan 26 17:36:47 CST 2023
     */
    int updateByPrimaryKey(SecondType record);

    List<SecondType> selectSecondTypeByFirstTypeId(@Param("firsTypeId") int firsTypeId);

    /**
     * 查询所有的二级商品的类型
     * @return
     */
    List<SecondType> selectAllSecondType();

    /**
     * 删除该一级分类的所有的二级类型
     * @param firstTypeId
     * @return
     */
    int deleteSecondTypeByFirstTypeId(Integer firstTypeId);

    /**
     * 删除该二级分类
     * @param secondTypeId
     * @return
     */
    int deleteSecondTypeById(Integer secondTypeId);
}