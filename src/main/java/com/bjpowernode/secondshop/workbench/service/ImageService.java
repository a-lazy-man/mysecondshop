package com.bjpowernode.secondshop.workbench.service;

import com.bjpowernode.secondshop.workbench.domain.Image;

import java.util.List;

public interface ImageService {
    /**
     * 向图片表中插入记录
     * @param image
     * @return
     */
    int addImage(Image image);

    /**
     * 根据商品id查询
     * @param goodId
     * @return
     */
    List<Image> queryImagesByGoodsId(int goodId);

    /**
     * 删除某个商品在image的所有的图片
     * @param goodsId
     * @return
     */
    int moveImageByGoodsId(Integer goodsId);
}
