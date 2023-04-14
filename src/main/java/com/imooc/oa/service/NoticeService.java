package com.imooc.oa.service;

import com.imooc.oa.dao.NoticeDao;
import com.imooc.oa.entity.Notice;
import com.imooc.oa.utils.MybatisUtils;

import java.util.List;

public class NoticeService {

    /**
     * 查询指定员工的系统消息记录
     * @param receiverId
     * @return 最经100条记录列表
     */
    public List<Notice> getNoticeList(Long receiverId){
        return (List<Notice>) MybatisUtils.executeQuery(SqlSession->{
            NoticeDao noticeDao = SqlSession.getMapper(NoticeDao.class);
            return noticeDao.selectByReceiverId(receiverId);
        });
    }
}
