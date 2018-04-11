package com.trisilco.model;

import java.util.ArrayList;

public class User {
	private int userID;
	private String username;
	private String password;
	private String email;
	private ArrayList<Integer> groupID;
	
	public User () {}
	
	public User (int userID, String username, String password) {
		this.userID = userID;
		this.username = username;
		this.password = password;
	}
	
	public User (String username, String password, String email) {
		this.username = username;
		this.password = password;
		this.email = email;
	}
	
	public User (int userID, String username, String password, String email) {
		this.userID = userID;
		this.username = username;
		this.password = password;
		this.email = email;
	}
	
	public User (String username, String password, String email, ArrayList<Integer> groupID_int) {
		this.username = username;
		this.password = password;
		this.email = email;
		this.groupID = groupID_int;
	}
	
	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	public ArrayList<Integer> getGroupID() {
		return groupID;
	}

	public void setGroupID(ArrayList<Integer> groupID) {
		this.groupID = groupID;
	}
}
