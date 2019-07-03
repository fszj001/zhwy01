package com.fszj.task;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class SubmitExamTask {


	
	@Scheduled(cron = "* */30 * * * ? ") // 间隔30执行
	//@Scheduled(cron = "0/10 * * * * ? ") // 间隔5秒执行
    public void SubmitExam() {

    }
}
