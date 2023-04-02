package com.bjpowernode.secondshop.settings.service;

import com.bjpowernode.secondshop.settings.domain.SecondType;

import java.util.List;

public interface SecondTypeService {
    /**
     * 根据商品的的一级类型的id 查询出所有一级类型商品的所有类型
     * @return
     */
    List<SecondType> querySecondTypeByFirstTypeId(int firstTypeId);

    /**
     * 查询所有的二级商品的类型
     * @return
     */
    List<SecondType> queryAllSecondType();

    /***
     * 删除该一级分类的所有的二级分类的类型
     * @param firstTypeId
     * @return
     */
    int moveSecondTypeByFirstTypeId(Integer firstTypeId);

    /**
     * 删除某个二级分类
     * @param secondTypeId
     * @return
     */
    int moveSecondTypeById(Integer secondTypeId);

    /**
     * 添加二级分类
     * @param secondType
     * @return
     */
    int addSecondType(SecondType secondType);
}
