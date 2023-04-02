package com.bjpowernode.secondshop.workbench.service.impl;

import com.bjpowernode.secondshop.workbench.domain.Goods;
import com.bjpowernode.secondshop.workbench.mapper.GoodsMapper;
import com.bjpowernode.secondshop.workbench.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class GoodsServiceImpl implements GoodsService {
    //注入mapper接口实现类
    @Autowired
    private GoodsMapper goodsMapper;

    /**
     * 查询所有的商品
     * @return
     */
    @Override
    public List<Goods> queryAllGoods() {
        List<Goods> goods = goodsMapper.selectAllGoods();
        return goods;
    }

    /**
     * 查询最新发布的5件商品
     * @return
     */
    @Override
    public List<Goods> queryGoodsByUploadTimeForFive() {
        List<Goods> goods = goodsMapper.selectGoodsByUploadTimeForFive();
        return goods;
    }

    @Override
    public int publishGoods(Goods goods) {
        int i = goodsMapper.insertGoodsByCondition(goods);
        return i;
    }

    /**
     * 查询goods表中有多少条记录
     * @return
     */
    @Override
    public int queryGoodsNum() {
        int i = goodsMapper.selectGoodsNum();
        return i;
    }

    /**
     * 修改用户图片
     * @param map
     * @return
     */
    @Override
    public int modifyPhotoUrlByGoodsId(Map<String, Object> map) {
        int i = goodsMapper.updatePhotoUrlByGoodsId(map);
        return i;
    }

    @Override
    public Goods queryGoodsByGoodsId(int goodsId) {
        Goods goods = goodsMapper.selectGoodsByGoodsId(goodsId);
        return goods;
    }

    @Override
    public List<Goods> queryRelatedGoodsBySecondTypeId(int secondTypeId) {
        List<Goods> goods = goodsMapper.selectRelatedGoodsBySecondTypeId(secondTypeId);
        return goods;
    }

    @Override
    public List<Goods> queryGoodsByUserId(String userId) {
        List<Goods> goods = goodsMapper.selectGoodsByUserId(userId);
        return goods;
    }

    @Override
    public List<Goods> queryCollectGoodsByGoodsIds(Integer[] goodsIds) {
        List<Goods> goods = goodsMapper.selectCollectGoodsByGoodsIds(goodsIds);
        return goods;
    }

    @Override
    public List<Goods> queryGoodsBySecondTypeId(int secondTypeId) {
        List<Goods> goods = goodsMapper.selectGoodsBySecondTypeId(secondTypeId);
        return goods;
    }

    @Override
    public List<Goods> pageQueryByConditions(Map<String, Object> map) {
        List<Goods> goods = goodsMapper.pageSelectByConditions(map);
        return goods;
    }

    @Override
    public int pageQueryCountsByConditions(Map<String, Object> map) {
        int i = goodsMapper.pageSelectCountsByConditions(map);
        return i;
    }

    @Override
    public String queryUserIdByGoodsId(int goodsId) {
        String userId = goodsMapper.selectUserIdByGoodsId(goodsId);
        return userId;
    }

    @Override
    public int editGoods(Goods goods) {
        int i = goodsMapper.updateGoods(goods);
        return i;
    }

    @Override
    public List<Goods> queryAllGoodsForAdmin() {
        List<Goods> goods = goodsMapper.selectAllGoodsForAdmin();
        return goods;
    }

    @Override
    public int modifyGoodsStatus(Integer goodsId) {
        int update = goodsMapper.updateGoodsStatus(goodsId);
        return update;
    }

    @Override
    public int moveGoodsById(Integer goodsId) {
        int i = goodsMapper.deleteGoodsById(goodsId);
        return i;
    }
}
