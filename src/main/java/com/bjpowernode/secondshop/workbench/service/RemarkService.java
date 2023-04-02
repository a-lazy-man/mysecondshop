package com.bjpowernode.secondshop.workbench.service;

import com.bjpowernode.secondshop.workbench.domain.Remark;

import java.util.List;

public interface RemarkService {
    /**
     * 根据留言id查出该留言的所有的回复
     * @param messageIds
     * @return
     */
    List<Remark> queryRemarksByMessageId(String[] messageIds);

    /**
     * 添加一条留言
     * @param remark
     * @return
     */
    int addRemark(Remark remark);
}
