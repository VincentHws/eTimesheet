package com.trisilco.model;

public class Group {
	private int groupID;
	private String groupName;
	private String groupDescription;
	
	public Group(int groupID, String groupName, String groupDescription) {
		this.groupID = groupID;
		this.groupName = groupName;
		this.groupDescription = groupDescription;
	}
	
	public Group(String groupName, String groupDescription) {
		this.groupName = groupName;
		this.groupDescription = groupDescription;
	}

	public int getGroupID() {
		return groupID;
	}

	public void setGroupID(int groupID) {
		this.groupID = groupID;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getGroupDescription() {
		return groupDescription;
	}

	public void setGroupDescription(String groupDescription) {
		this.groupDescription = groupDescription;
	}
}
