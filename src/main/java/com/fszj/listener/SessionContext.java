package com.fszj.listener;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import com.fszj.bean.User;

public class SessionContext {
	private static SessionContext instance;
    private HashMap<String,HttpSession> sessionMap;
 
    private SessionContext() {
    	sessionMap = new HashMap<String,HttpSession>();
    }
 
    public static SessionContext getInstance() {
        if (instance == null) {
            instance = new SessionContext();
        }
        return instance;
    }
 
    public synchronized void AddSession(HttpSession session) {
        if (session != null) {
        	sessionMap.put(session.getId(), session);
        }
    }
 
    public synchronized void DelSession(HttpSession session) {
        if (session != null) {
        	sessionMap.remove(session.getId());
            if(session.getAttribute("user")!=null || session.getAttribute("student")!=null){
            	User u = (User) session.getAttribute("user");
            	String userid = "";
            	if(u!=null){
            		userid = u.getUid();
            	}

            	sessionMap.remove(userid);
            }
        }
    }
 
    public synchronized HttpSession getSession(String session_id) {
        if (session_id == null) return null;
        return (HttpSession) sessionMap.get(session_id);
    }
 
	public HashMap getSessionMap() {
		return sessionMap;
	}
 
	public void setMymap(HashMap sessionMap) {
		this.sessionMap = sessionMap;
	}
 
}
