package com.bjpowernode.secondshop.workbench.web.controller;

import com.bjpowernode.secondshop.conmons.Constants;
import com.bjpowernode.secondshop.conmons.ReturnMessage;
import com.bjpowernode.secondshop.conmons.utils.UUIDUtils;
import com.bjpowernode.secondshop.settings.domain.FirstType;
import com.bjpowernode.secondshop.settings.domain.SecondType;
import com.bjpowernode.secondshop.settings.service.FirstTypeService;
import com.bjpowernode.secondshop.settings.service.SecondTypeService;
import com.bjpowernode.secondshop.workbench.domain.Goods;
import com.bjpowernode.secondshop.workbench.domain.Image;
import com.bjpowernode.secondshop.workbench.service.GoodsService;
import com.bjpowernode.secondshop.workbench.service.ImageService;
import org.apache.commons.collections4.queue.PredicatedQueue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class GoodsEditController {
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private FirstTypeService firstTypeService;
    @Autowired
    private SecondTypeService secondTypeService;
    @Autowired
    private ImageService imageService;
    @RequestMapping("/workbench/goods/toGoodsEditPage.do")
    public String toGoodsEditPage(Integer goodsId, HttpServletRequest request){
        Goods goods = goodsService.queryGoodsByGoodsId(goodsId);
        request.setAttribute("goods",goods);
        //查询出所有的一级类型
        List<FirstType> firstTypes = firstTypeService.queryAllFirstType();
        request.setAttribute("firstTypes",firstTypes);
        //查询出当前一级类型对应的所有的二级类型商品
        List<SecondType> secondTypes = secondTypeService.querySecondTypeByFirstTypeId(goods.getFirstTypeId());
        request.setAttribute("secondTypes", secondTypes);
        //查询出 最新发布的5件商品
        List<Goods> latestGoods = goodsService.queryGoodsByUploadTimeForFive();
        request.setAttribute("latestGoods",latestGoods);
        return "workbench/goods/goodsEdit";
    }

    @RequestMapping("/workbench/goods/editGoodsMes.do")
    @ResponseBody
    public Object editGoodsMes(Integer goodsId,String goodsName,Integer firstTypeId,Integer secondTypeId,Float prise,String describe){
        //封装参数
        Goods goods = new Goods();
        goods.setId(goodsId);
        goods.setName(goodsName);
        goods.setFirstTypeId(firstTypeId);
        goods.setSecondTypeId(secondTypeId);
        goods.setPrise(prise);
        goods.setDescribe(describe);
        ReturnMessage res = new ReturnMessage();
        try {
            int i = goodsService.editGoods(goods);
            if(i == 1){
                res.setCode(Constants.RETURN_OBJECT_CODE_SUCCESS);
            }else{
                res.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
                res.setMessage("系统忙，请稍后!!");
            }
        } catch (Exception e) {
            res.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
            res.setMessage("系统忙，请稍后!!");
            e.printStackTrace();
        }
        return res;
    }

    @RequestMapping("/workbench/goods/editGoodsMesForPhoto.do")
    @ResponseBody
    public Object editGoodsMesForPhoto(@RequestParam("multipartFiles") MultipartFile[] multipartFiles,
                                    int id) {
        ReturnMessage returnMessage = new ReturnMessage();
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        //删除掉该商品在image表中的所有的图片
        try {
            int result = imageService.moveImageByGoodsId(id);
            if(result<0){
                throw new RuntimeException("系统忙，请稍后！！");
            }
        } catch (Exception e) {
            throw new RuntimeException("系统忙，请稍后！！");
        }
        //遍历mutipartFile数组
        for (int i = 0; i < multipartFiles.length; i++) {
            //定义上传文件的存放位置
            String filePath = "D:\\bishe-useravatar\\";
            String virtualPath = "bishe-useravatar/";
            String fileName = multipartFiles[i].getOriginalFilename();
            String newFilePath = filePath + fileName; //新文件的路径
            try {
                multipartFiles[i].transferTo(new File(newFilePath));  //将传来的文件写入新建的文件
            } catch (IllegalStateException | IOException e) {
                e.printStackTrace();
            }
            if (i == 0) {
                map.put("photoUrl", virtualPath + fileName);
                //修改goods表中的图片路径
                int count1 = goodsService.modifyPhotoUrlByGoodsId(map);
                if (count1 != 1) {
                    throw new RuntimeException("系统忙，请稍后！！！");
                }
            } else {
                //其它记录全部插入到image表中
                Image image = new Image();   //id, good_id,  name, url
                //给image实体类设置主键
                image.setId(UUIDUtils.generateUUID());
                //给image实体类设置goodsId
                image.setGoodId(id);
                //给image实体类设置name
                image.setName(fileName);
                //给image实体类设置url
                image.setUrl(virtualPath + fileName);
                int count2 = imageService.addImage(image);
                if (count2 != 1) {
                    throw new RuntimeException("系统忙，请稍后！！！");
                }
            }

        }
        returnMessage.setCode(Constants.RETURN_OBJECT_CODE_SUCCESS);
        return returnMessage;
    }
}
