package com.bjpowernode.secondshop.settings.service.impl;

import com.bjpowernode.secondshop.settings.domain.SecondType;
import com.bjpowernode.secondshop.settings.mapper.SecondTypeMapper;
import com.bjpowernode.secondshop.settings.service.SecondTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class SecondTypeServiceImpl implements SecondTypeService {
    @Autowired
    SecondTypeMapper secondTypeMapper;
    @Override
    public List<SecondType> querySecondTypeByFirstTypeId(int firstTypeId) {
        List<SecondType> secondTypes = secondTypeMapper.selectSecondTypeByFirstTypeId(firstTypeId);
        return secondTypes;
    }

    @Override
    public List<SecondType> queryAllSecondType() {
        List<SecondType> secondTypes = secondTypeMapper.selectAllSecondType();
        return secondTypes;
    }

    @Override
    public int moveSecondTypeByFirstTypeId(Integer firstTypeId) {
        int i = secondTypeMapper.deleteSecondTypeByFirstTypeId(firstTypeId);
        return i;
    }

    @Override
    public int moveSecondTypeById(Integer secondTypeId) {
        int i = secondTypeMapper.deleteSecondTypeById(secondTypeId);
        return i;
    }

    @Override
    public int addSecondType(SecondType secondType) {
        int insert = secondTypeMapper.insert(secondType);
        return insert;
    }


}
