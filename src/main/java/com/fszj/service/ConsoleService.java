package com.fszj.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.fszj.dao.ConsoleDao;

@Component
public class ConsoleService {

	@Resource
	private ConsoleDao consoleDao;

	public void setConsoleDao(ConsoleDao consoleDao) {
		this.consoleDao = consoleDao;
	}
	
}
