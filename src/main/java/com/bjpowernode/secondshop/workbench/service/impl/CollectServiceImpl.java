package com.bjpowernode.secondshop.workbench.service.impl;

import com.bjpowernode.secondshop.workbench.domain.Collect;
import com.bjpowernode.secondshop.workbench.mapper.CollectMapper;
import com.bjpowernode.secondshop.workbench.service.CollectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class CollectServiceImpl implements CollectService {
    @Autowired
    CollectMapper collectMapper;
    @Override
    public int addCollectedGoods(Collect collect) {
        int i = collectMapper.insertCollectedGoods(collect);
        return i;
    }

    @Override
    public Integer[] queryGoodsIdsByUserId(String userId) {
        Integer[] integers = collectMapper.selectGoodsIdsByUserId(userId);
        return integers;
    }

    @Override
    public int moveCollectByGoodsIdAndUserId(Map<String, Object> map) {
        int i = collectMapper.deleteCollectByGoodsIdAndUserId(map);
        return i;
    }

    @Override
    public Collect queryCollectByGoodsId(int goodsId) {
        Collect collect = collectMapper.selectCollectByGoodsId(goodsId);
        return collect;
    }

}
