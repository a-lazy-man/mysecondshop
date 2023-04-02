package com.bjpowernode.secondshop.workbench.service.impl;

import com.bjpowernode.secondshop.workbench.domain.Image;
import com.bjpowernode.secondshop.workbench.mapper.ImageMapper;
import com.bjpowernode.secondshop.workbench.service.ImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ImageServiceImpl implements ImageService {
    @Autowired
    ImageMapper imageMapper;
    @Override
    public int addImage(Image image) {
        int insert = imageMapper.insert(image);
        return insert;
    }

    @Override
    public List<Image> queryImagesByGoodsId(int goodId) {
        List<Image> images = imageMapper.selectImagesByGoodsId(goodId);
        return images;
    }

    @Override
    public int moveImageByGoodsId(Integer goodsId) {
        int i = imageMapper.deleteImageByGoodsId(goodsId);
        return i;
    }
}
