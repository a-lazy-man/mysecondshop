package com.bjpowernode.secondshop.settings.service;

import com.bjpowernode.secondshop.settings.domain.FirstType;

import java.util.List;

public interface FirstTypeService {
    /**
     * 查询商品的所有的一级类型
     * @return
     */
    List<FirstType> queryAllFirstType();

    /**
     * 删除某个一级分类
     * @param firstTypeId
     * @return
     */
    int moveFirstTypeById(Integer firstTypeId);

    /**
     * 添加一级分类类型
     * @param firstType
     * @return
     */
    int addFirstType(FirstType firstType);
}
