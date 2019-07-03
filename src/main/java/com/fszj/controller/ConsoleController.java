package com.fszj.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fszj.service.ConsoleService;

@Controller
public class ConsoleController {

	@Resource
	private ConsoleService consoleService;

	public void setConsoleService(ConsoleService consoleService) {
		this.consoleService = consoleService;
	}
	 

	

	 

	

	@RequestMapping(value="console",produces="application/json;charset=utf-8")
	public String console(Model model,HttpSession httpSession){

		return "console";
	}
	 

	 
}
