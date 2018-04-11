package com.trisilco.model;

public class Customer {
	private int customerID;
	private String customerName;
	private String customerDescription;
	
	public Customer (int customerID, String customerName, String customerDescription) {
		this.customerID = customerID;
		this.customerName = customerName;
		this.customerDescription = customerDescription;
	}
	
	public Customer (String customerName, String customerDescription) {
		this.customerName = customerName;
		this.customerDescription = customerDescription;
	}

	public int getCustomerID() {
		return customerID;
	}

	public void setCustomerID(int customerID) {
		this.customerID = customerID;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getCustomerDescription() {
		return customerDescription;
	}

	public void setCustomerDescription(String customerDescription) {
		this.customerDescription = customerDescription;
	}
}
