package com.bjpowernode.secondshop.workbench.service;

import com.bjpowernode.secondshop.workbench.domain.GoodsOrder;

import java.util.List;
import java.util.Map;

public interface GoodsOrderService {
    /**
     * 生成一条订单记录
     * @param goodsOrder
     * @return
     */
    int addGoodsOrder(GoodsOrder goodsOrder);

    /**
     * 查询所有的商品的订单
     * @return
     */
    List<GoodsOrder> queryOthersGoodsOrder(Map<String,Object> map);

    GoodsOrder queryGoodsOrderById(String id);

    /**
     * 修改订单信息
     * @param map
     * @return
     */
    int modifyGoodsOrder(Map<String,Object>map);

    /**
     * 取消订单
     * @param goodsOrderId
     * @return
     */
    int moveGoodsOrderById(String goodsOrderId);

    /**
     * 查询该用户的所有的订单
     * @param customerId
     * @return
     */
    List<GoodsOrder> queryAllGoodsOrderByCustomerId(String customerId);

    /**
     * 查询已经支付完成的订单的id
     * @param map
     * @return
     */
    Integer[] queryGoodsId(Map<String,Object>map);

    /**
     * 查询所有的订单记录
     * @return
     */
    List<GoodsOrder> queryAllGoodsOrder();
}
