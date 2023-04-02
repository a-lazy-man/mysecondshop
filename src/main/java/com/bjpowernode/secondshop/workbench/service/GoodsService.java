package com.bjpowernode.secondshop.workbench.service;

import com.bjpowernode.secondshop.workbench.domain.Goods;

import java.util.List;
import java.util.Map;

public interface GoodsService {
    List<Goods> queryAllGoods();

    /**
     * 查询出最新发布的5件商品
     * @return
     */
    List<Goods> queryGoodsByUploadTimeForFive();

    /**
     * 用户发布商品
     * @param goods
     * @return
     */
    int publishGoods(Goods goods);

    /**
     * 查询goods表中有多少条记录
     * @return
     */
    int queryGoodsNum();

    /**
     * 修改商品的图片
     * @param map
     * @return
     */
    int modifyPhotoUrlByGoodsId(Map<String,Object>map);

    /**
     * 根据商品id查询商品的详细信息
     * @param goodsId
     * @return
     */
    Goods queryGoodsByGoodsId(int goodsId);

    /**
     * 查询与该商品相关的商品
     * @param secondTypeId
     * @return
     */
    List<Goods> queryRelatedGoodsBySecondTypeId(int secondTypeId);

    /**
     * 根据卖家查询该卖家发布的所有的商品
     * @param userId
     * @return
     */
    List<Goods> queryGoodsByUserId(String userId);

    /**
     * 查询该用户收藏的所有的商品
     * @param goodsIds
     * @return
     */
    List<Goods> queryCollectGoodsByGoodsIds(Integer[] goodsIds);

    /**
     * 查询该类型的所有的商品
     * @param secondTypeId
     * @return
     */
    List<Goods> queryGoodsBySecondTypeId(int secondTypeId);

    /**
     * 分页查询
     * @param map
     * @return
     */
    List<Goods> pageQueryByConditions(Map<String,Object>map);

    /**
     * 查询满足条件的总记录条数
     * @param map
     * @return
     */
    int pageQueryCountsByConditions(Map<String,Object>map);

    /**
     * 通过该商品id查询用户id
     * @param goodsId
     * @return
     */
    String queryUserIdByGoodsId(int goodsId);

    /**
     * 更新商品信息
     * @param goods
     * @return
     */
    int editGoods(Goods goods);

    /**
     * 查询所有的物品
     * @return
     */
    List<Goods> queryAllGoodsForAdmin();

    /**
     * 下架商品
     * @param goodsId
     * @return
     */
    int modifyGoodsStatus(Integer goodsId);

    /**
     * 删除该商品
     * @param goodsId
     * @return
     */
    int moveGoodsById(Integer goodsId);
}
