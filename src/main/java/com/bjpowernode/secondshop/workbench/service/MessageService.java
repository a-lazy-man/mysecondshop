package com.bjpowernode.secondshop.workbench.service;


import com.bjpowernode.secondshop.workbench.domain.Message;

import java.util.List;

public interface MessageService {
    /**
     * 根据该商品的id在message表中查询该商品的所有的留言记录
     * @param goodId
     * @return
     */
    List<Message> queryMessagesByGoodId(Integer goodId);

    /**
     * 添加一条留言
     * @param message
     * @return
     */
    int addMessage(Message message);
}
