package com.fszj.listener;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SessionListener implements HttpSessionListener  {
   
	public  static SessionContext sessionContext=SessionContext.getInstance();
	
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		// TODO Auto-generated method stub
		sessionContext.AddSession(se.getSession());
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		// TODO Auto-generated method stub
		sessionContext.DelSession(se.getSession());
	}

}
