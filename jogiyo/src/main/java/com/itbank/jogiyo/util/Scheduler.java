package com.itbank.jogiyo.util;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class Scheduler {
	@Autowired
	private SqlSession sqlSession;
	
	@Scheduled(cron = "0 0/1 * * * ?")
    public void autoInsert() {
		System.out.println("스케줄러 실행");
        sqlSession.insert("login.test");
    }
}
