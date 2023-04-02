package com.bjpowernode.secondshop.workbench.service.impl;

import com.bjpowernode.secondshop.workbench.domain.Message;
import com.bjpowernode.secondshop.workbench.mapper.MessageMapper;
import com.bjpowernode.secondshop.workbench.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class MessageServiceImpl implements MessageService {
    @Autowired
    private MessageMapper messageMapper;
    @Override
    public List<Message> queryMessagesByGoodId(Integer goodId) {
        List<Message> messages = messageMapper.selectMessagesByGoodId(goodId);
        return messages;
    }

    @Override
    public int addMessage(Message message) {
        int i = messageMapper.insertMessage(message);
        return i;
    }
}
