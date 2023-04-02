package com.bjpowernode.secondshop.workbench.service.impl;

import com.bjpowernode.secondshop.workbench.domain.GoodsOrder;
import com.bjpowernode.secondshop.workbench.mapper.GoodsOrderMapper;
import com.bjpowernode.secondshop.workbench.service.GoodsOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class GoodsOrderServiceImpl implements GoodsOrderService {
    @Autowired
    private GoodsOrderMapper goodsOrderMapper;
    @Override
    public int addGoodsOrder(GoodsOrder goodsOrder) {
        int insert = goodsOrderMapper.insert(goodsOrder);
        return insert;
    }

    @Override
    public List<GoodsOrder> queryOthersGoodsOrder(Map<String,Object>map) {
        List<GoodsOrder> goodsOrders = goodsOrderMapper.selectOthersGoodsOrder(map);
        return goodsOrders;
    }

    @Override
    public GoodsOrder queryGoodsOrderById(String id) {
        GoodsOrder goodsOrder = goodsOrderMapper.selectGoodsOrderById(id);
        return goodsOrder;
    }

    @Override
    public int modifyGoodsOrder(Map<String, Object> map) {
        int i = goodsOrderMapper.updateGoodsOrder(map);
        return i;
    }

    @Override
    public int moveGoodsOrderById(String goodsOrderId) {
        int i = goodsOrderMapper.deleteGoodsOrderById(goodsOrderId);
        return i;
    }

    @Override
    public List<GoodsOrder> queryAllGoodsOrderByCustomerId(String customerId) {
        List<GoodsOrder> goodsOrders = goodsOrderMapper.selectAllGoodsOrderByCustomerId(customerId);
        return goodsOrders;
    }

    @Override
    public Integer[] queryGoodsId(Map<String, Object> map) {
        Integer[] goodsIds = goodsOrderMapper.selectGoodsId(map);
        return goodsIds;
    }

    @Override
    public List<GoodsOrder> queryAllGoodsOrder() {
        List<GoodsOrder> goodsOrders = goodsOrderMapper.selectAllGoodsOrder();
        return goodsOrders;
    }
}
