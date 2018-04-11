package com.trisilco.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DailyTask {
	private String date;
	private String from_time;
	private String to_time;
	private String projectName;
	private String taskType;
	private String location;
	private String please_specify;
	private String taskDescription;
	private String transportClaimAmount;
	private String otherClaimAmount;
	private double duration;
	private String submissionMonth;

	public DailyTask() {
	};

	public DailyTask(String date, String from_time, String to_time, String projectName, String taskType,
			String location, String please_specify, String taskDescription, String transportClaimAmount, String otherClaimAmount) {
		this.date = date;
		this.from_time = from_time;
		this.to_time = to_time;
		this.projectName = projectName;
		this.taskType = taskType;
		this.location = location;
		this.please_specify = please_specify;
		this.taskDescription = taskDescription;
		this.transportClaimAmount = transportClaimAmount;
		this.otherClaimAmount = otherClaimAmount;
		this.submissionMonth = date.substring(date.indexOf(" ") + 1, date.indexOf(","));
		
		SimpleDateFormat dateFormtter = new SimpleDateFormat("hh:mm:ss");
		Date temp_to, temp_from;

		try {
			temp_from = dateFormtter.parse(from_time);
			temp_to = dateFormtter.parse(to_time);

			long temp_duration = (temp_to.getTime() - temp_from.getTime());
			this.duration = Math.abs(temp_duration / (double) (1000 * 60 * 60));
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
	
	public DailyTask(String date, String from_time, String to_time, String projectName, String taskType,
			String location, String please_specify, String taskDescription, String transportClaimAmount, String otherClaimAmount, String submissionMonth) {
		this.date = date;
		this.from_time = from_time;
		this.to_time = to_time;
		this.projectName = projectName;
		this.taskType = taskType;
		this.location = location;
		this.please_specify = please_specify;
		this.taskDescription = taskDescription;
		this.transportClaimAmount = transportClaimAmount;
		this.otherClaimAmount = otherClaimAmount;
		this.submissionMonth = submissionMonth;
		
		SimpleDateFormat dateFormtter = new SimpleDateFormat("hh:mm:ss");
		Date temp_to, temp_from;

		try {
			temp_from = dateFormtter.parse(from_time);
			temp_to = dateFormtter.parse(to_time);

			long temp_duration = (temp_to.getTime() - temp_from.getTime());
			this.duration = Math.abs(temp_duration / (double) (1000 * 60 * 60));
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getFrom_time() {
		return from_time;
	}

	public void setFrom_time(String from_time) {
		this.from_time = from_time;
	}

	public String getTo_time() {
		return to_time;
	}

	public void setTo_time(String to_time) {
		this.to_time = to_time;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getTaskType() {
		return taskType;
	}

	public void setTaskType(String taskType) {
		this.taskType = taskType;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getPlease_specify() {
		return please_specify;
	}

	public void setPlease_specify(String please_specify) {
		this.please_specify = please_specify;
	}

	public String getTaskDescription() {
		return taskDescription;
	}

	public void setTaskDescription(String taskDescription) {
		this.taskDescription = taskDescription;
	}

	public String getTransportClaimAmount() {
		return transportClaimAmount;
	}

	public void setTotalClaimAmount(String transportClaimAmount) {
		this.transportClaimAmount = transportClaimAmount;
	}

	public double getDuration() {
		return duration;
	}

	public void setDuration(double duration) {
		this.duration = duration;
	}

	public String getSubmissionMonth() {
		return submissionMonth;
	}

	public void setSubmissionMonth(String submissionMonth) {
		this.submissionMonth = submissionMonth;
	}

	public String getOtherClaimAmount() {
		return otherClaimAmount;
	}

	public void setOtherClaimAmount(String otherClaimAmount) {
		this.otherClaimAmount = otherClaimAmount;
	}
}
