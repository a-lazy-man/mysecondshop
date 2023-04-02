package com.bjpowernode.secondshop.workbench.service.impl;

import com.bjpowernode.secondshop.workbench.domain.Remark;
import com.bjpowernode.secondshop.workbench.mapper.RemarkMapper;
import com.bjpowernode.secondshop.workbench.service.RemarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RemarkServiceImpl implements RemarkService {
    @Autowired
    RemarkMapper remarkMapper;
    @Override
    public List<Remark> queryRemarksByMessageId(String[] messageIds) {
        List<Remark> remarks = remarkMapper.selectRemarksByMessageId(messageIds);
        return remarks;
    }

    @Override
    public int addRemark(Remark remark) {
        int i = remarkMapper.insertRemark(remark);
        return i;
    }
}
