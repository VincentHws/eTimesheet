package com.trisilco.model;

public class Project {
	private int projectID;
	private String projectName;
	private String projectDescription;
	private int clientID;
	private int quotedDuration;
	private float projectPrice;
	private String kickOffDate;
	private String sitDeliveryDate;
	private String uatDeliveryDate;
	private String goLiveDeliveryDate;
	private int assignedProjectGroup;
	
	public Project (String projectName, String projectDescription, int clientID, int quotedDuration, float projectPrice, 
			String sitDeliveryDate, String uatDeliveryDate, String goLiveDeliveryDate, int assignedProjectGroup) {
		this.projectName = projectName;
		this.projectDescription = projectDescription;
		this.clientID = clientID;
		this.quotedDuration = quotedDuration;
		this.projectPrice = projectPrice;
		this.sitDeliveryDate = sitDeliveryDate;
		this.uatDeliveryDate = uatDeliveryDate;
		this.goLiveDeliveryDate = goLiveDeliveryDate;
		this.assignedProjectGroup = assignedProjectGroup;
	}
	
	public Project (int projectID, String projectName, String projectDescription, int clientID, int quotedDuration, float projectPrice, 
			String sitDeliveryDate, String uatDeliveryDate, String goLiveDeliveryDate, int assignedProjectGroup) {
		this.projectID = projectID;
		this.projectName = projectName;
		this.projectDescription = projectDescription;
		this.clientID = clientID;
		this.quotedDuration = quotedDuration;
		this.projectPrice = projectPrice;
		this.sitDeliveryDate = sitDeliveryDate;
		this.uatDeliveryDate = uatDeliveryDate;
		this.goLiveDeliveryDate = goLiveDeliveryDate;
		this.assignedProjectGroup = assignedProjectGroup;
	}

	public int getProjectID() {
		return projectID;
	}

	public void setProjectID(int projectID) {
		this.projectID = projectID;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getProjectDescription() {
		return projectDescription;
	}

	public void setProjectDescription(String projectDescription) {
		this.projectDescription = projectDescription;
	}

	public int getClientID() {
		return clientID;
	}

	public void setClientID(int clientID) {
		this.clientID = clientID;
	}

	public int getQuotedDuration() {
		return quotedDuration;
	}

	public void setQuotedDuration(int quotedDuration) {
		this.quotedDuration = quotedDuration;
	}

	public float getProjectPrice() {
		return projectPrice;
	}

	public void setProjectPrice(float projectPrice) {
		this.projectPrice = projectPrice;
	}

	public String getUatDeliveryDate() {
		return uatDeliveryDate;
	}

	public void setUatDeliveryDate(String uatDeliveryDate) {
		this.uatDeliveryDate = uatDeliveryDate;
	}

	public int getAssignedProjectGroup() {
		return assignedProjectGroup;
	}

	public void setAssignedProjectGroup(int assignedProjectGroup) {
		this.assignedProjectGroup = assignedProjectGroup;
	}

	public String getSitDeliveryDate() {
		return sitDeliveryDate;
	}

	public void setSitDeliveryDate(String sitDeliveryDate) {
		this.sitDeliveryDate = sitDeliveryDate;
	}

	public String getGoLiveDeliveryDate() {
		return goLiveDeliveryDate;
	}

	public void setGoLiveDeliveryDate(String goLiveDeliveryDate) {
		this.goLiveDeliveryDate = goLiveDeliveryDate;
	}

	public String getKickOffDate() {
		return kickOffDate;
	}

	public void setKickOffDate(String kickOffDate) {
		this.kickOffDate = kickOffDate;
	}
}
