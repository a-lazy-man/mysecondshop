package com.bjpowernode.secondshop.settings.service.impl;

import com.bjpowernode.secondshop.settings.domain.FirstType;
import com.bjpowernode.secondshop.settings.mapper.FirstTypeMapper;
import com.bjpowernode.secondshop.settings.service.FirstTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class FirstTypeServiceImpl implements FirstTypeService {
    @Autowired
    FirstTypeMapper firstTypeMapper;
    @Override
    public List<FirstType> queryAllFirstType() {
        List<FirstType> firstTypes = firstTypeMapper.selectAllFirstType();
        return firstTypes;
    }

    @Override
    public int moveFirstTypeById(Integer firstTypeId) {
        int i = firstTypeMapper.deleteFirstTypeById(firstTypeId);
        return i;
    }

    @Override
    public int addFirstType(FirstType firstType) {
        int insert = firstTypeMapper.insert(firstType);
        return insert;
    }
}
