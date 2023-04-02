package com.bjpowernode.secondshop.workbench.service;

import com.bjpowernode.secondshop.workbench.domain.Collect;

import java.util.Map;

public interface CollectService {
    /**
     * 往collect表中添加一条记录
     * @param collect
     * @return
     */
    int addCollectedGoods(Collect collect);


    /**
     * 查询当前商品是否是当前用户收藏的
     * @param goodsId
     * @return
     */
    Collect queryCollectByGoodsId(int goodsId);


    /**
     * 查询该用户收藏的所有的商品
     * @param userId
     * @return
     */
    Integer[] queryGoodsIdsByUserId(String userId);

    /**
     * 取消收藏
     * @return
     */
    int moveCollectByGoodsIdAndUserId(Map<String,Object>map);

}
