package com.trisilco.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class Database {

	private String datasourceName;
	private Context initialContext;
	private Context environmentContext;
	private DataSource dataSource;
	private Connection conn;
	
	public boolean INIT() {
		this.datasourceName = "jdbc/lazypeondb";

		try {
			this.initialContext = (Context) new InitialContext();
			this.environmentContext = (Context) ((InitialContext) initialContext).lookup("java:comp/env");
			this.dataSource = (DataSource) environmentContext.lookup(datasourceName);

			this.conn = dataSource.getConnection();

		} catch (NamingException e) {
			e.printStackTrace();
			
			return false;
		} catch (SQLException e) {
			e.printStackTrace();

			return false;
		} 
		
		return true;
	}
	
	public int closeConnectionDB() {
		try {
			if (conn != null) {
				conn.close();
			}

			conn = null;

			return 0;
		} catch (Exception e) {
			return 1;
		}
	}
	
	public String doLogin(String username, String password) {
		PreparedStatement ps;
		
		try {
			// Preparing SQL query to retrieve user credential
			ps = conn.prepareStatement("SELECT USERID, USERNAME, PASSWORDS FROM USER WHERE USERNAME COLLATE utf8_bin = ?");
			ps.setString(1, username);
			
			ResultSet rs = ps.executeQuery();
			
			// If ResultSet is empty return status 
			if (!rs.next()) {
				System.out.println("Username <" + username + "> doesn't exist.");
				
				return "USER_NOT_EXIST";
			} else {
				if (rs.getString("PASSWORDS").equals(password)) {
					int tempID = rs.getInt("USERID");
					
					System.out.println("Credential matched. Employee ID <" + tempID + ">");
					
					return String.valueOf(tempID);
				} else {
					
					System.out.println("Credential mismatched for user <" + username + ">");
					
					return "CREDENTIAL_MISMATCH";
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			
			return "SQL_EXCEPTION";
		}
	}
	
	public List<DailyTask> retreivePreviousEntry(int userID) {
		PreparedStatement ps;
		List<DailyTask> dailyTask = new LinkedList<DailyTask>();
		//Map<String, List<DailyTask>> monthlyTasks = new Map<String, List<DailyTask>>();
		
		try {
			// Preparing SQL query to retrieve previous entries
			ps = conn.prepareStatement("SELECT DATE, FROMTIME, TOTIME, PROJECTNAME, TASKTYPE, LOCATION, TASKDESCRIPTION, TRANSPORTCLAIMAMOUNT, PLEASESPECIFY, OTHERCLAIMAMOUNT, STATE, SUBMISSIONMONTH " + 
					"FROM dailytask dt " + 
					"JOIN userdailytasks udt ON dt.dailyTaskID = udt.dailyTaskID " + 
					"WHERE udt.state = ? AND udt.userID = ?");
			ps.setString(1, "SUBMITTED");
			ps.setInt(2, userID);
			
			ResultSet rs = ps.executeQuery();
			
			// If result set is not empty, process result set to DailyTask list
			while (rs.next()) {
				DailyTask tempDT = new DailyTask(rs.getString("date"), rs.getString("fromtime"), rs.getString("totime"),
						rs.getString("projectname"), rs.getString("tasktype"), rs.getString("location"),
						rs.getString("pleasespecify"), rs.getString("taskdescription"), 
						rs.getString("transportclaimamount"), rs.getString("otherclaimamount"), rs.getString("submissionmonth"));

				dailyTask.add(tempDT);
			}
			
			return dailyTask;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public List<DailyTask> retrieveDraftEntry(int userID){
		PreparedStatement ps;
		List<DailyTask> dailyTask = new LinkedList<DailyTask>();
		
		try {
			ps = conn.prepareStatement("SELECT DATE, FROMTIME, TOTIME, PROJECTNAME, TASKTYPE, LOCATION, TASKDESCRIPTION, TRANSPORTCLAIMAMOUNT, OTHERCLAIMAMOUNT, PLEASESPECIFY, STATE " + 
					"FROM dailytask dt " + 
					"JOIN userdailytasks udt ON dt.dailyTaskID = udt.dailyTaskID " + 
					"WHERE udt.userID = ? AND udt.state = 'DRAFT'");
			ps.setInt(1, userID);
			
			ResultSet rs = ps.executeQuery();
			
			// If result set is not empty, process result set to DailyTask list
			while (rs.next()) {
				DailyTask tempDT = new DailyTask(rs.getString("date"), rs.getString("fromtime"), rs.getString("totime"),
				rs.getString("projectname"), rs.getString("tasktype"), rs.getString("location"),
				rs.getString("pleasespecify"), rs.getString("taskdescription"), 
				rs.getString("transportclaimamount"), rs.getString("otherclaimamount"));

				dailyTask.add(tempDT);
			}
			
			return dailyTask;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public List<String> loadRelatedProject(int userID) {
		PreparedStatement ps;
		List<String> tempList = new ArrayList<>();
		
		try {
			// Preparing SQL query to retrieve related project entries
			ps = conn.prepareStatement("SELECT p.projectName "
					+ "FROM project p "
					+ "WHERE p.assignedGroup IN "
					+ "(SELECT groupID FROM usergroups WHERE userID = ?);");
			
			ps.setInt(1, userID);
			
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				tempList.add(rs.getString("projectname"));
			}
			
			return tempList;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
	}

	public List<String> loadTaskType() {
		PreparedStatement ps;
		List<String> tempList = new ArrayList<>();
		
		try {
			// Preparing SQL query to retrieve related project entries
			ps = conn.prepareStatement("SELECT taskType FROM lazypeondb.tasktype");

			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				tempList.add(rs.getString("tasktype"));
			}
			
			return tempList;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public List<String> loadUserGroup(String userID){
		PreparedStatement ps;
		List<String> tempList = new ArrayList<>();
		
		try {
			// Preparing SQL query to retrieve current user groups
			ps = conn.prepareStatement("SELECT eg.groupName FROM existinggroup eg JOIN usergroups ug ON eg.groupID = ug.groupID WHERE ug.userID = ?");
			
			ps.setInt(1, Integer.parseInt(userID));
			
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				tempList.add(rs.getString("groupname"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return tempList;
	}
	
	public void archivePreviousEntry (int userID) {
		PreparedStatement ps;
		
		try {
			ps = conn.prepareStatement("UPDATE userdailytasks SET state='ARCHIVE' WHERE userID=? AND state='DRAFT'");
			
			ps.setInt(1, userID);
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Integer> saveTasks(List<DailyTask>taskEntry, int userID) {
		ArrayList<Integer> dailyTaskID = new ArrayList<>();
		String sqlQuery;
		
		try {
			// Archiving previous daily task entries before new batch INSERT
			archivePreviousEntry(userID);
			
			sqlQuery = "INSERT dailytask (date, fromtime, totime, projectname, tasktype, location, pleasespecify, taskdescription, transportclaimamount, otherclaimamount) VALUES (?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sqlQuery, Statement.RETURN_GENERATED_KEYS);

			// Constructing INSERT statement based on number of entries
			for (int i = 0; i < taskEntry.size(); i++) {
				ps.setString(1, taskEntry.get(i).getDate());
				ps.setString(2, taskEntry.get(i).getFrom_time());
				ps.setString(3, taskEntry.get(i).getTo_time());
				ps.setString(4, taskEntry.get(i).getProjectName());
				ps.setString(5, taskEntry.get(i).getTaskType());
				ps.setString(6, taskEntry.get(i).getLocation());
				ps.setString(7, taskEntry.get(i).getPlease_specify());
				ps.setString(8, taskEntry.get(i).getTaskDescription());
				ps.setFloat(9, Float.valueOf(taskEntry.get(i).getTransportClaimAmount()));
				ps.setFloat(10, Float.valueOf(taskEntry.get(i).getOtherClaimAmount()));

				ps.addBatch();
			}

			int[] affectedRow = ps.executeBatch();

			if (affectedRow.length > 0) {
				// Obtaining all the inserted dailyTask ID
				ResultSet rs = ps.getGeneratedKeys();
				
				while (rs.next()) {
					dailyTaskID.add(rs.getInt(1));
				}
			}
			
			// Linking all newly inserted dailyTaskID with userID
			int size = linkUserDailyTask(userID, dailyTaskID, taskEntry);
			
			if (size == -1) {
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return dailyTaskID;
	}

	public int linkUserDailyTask(int userID, ArrayList<Integer> dailyTaskID, List<DailyTask>taskEntry) {
		int size = 0;
		
		try {
			PreparedStatement ps = conn.prepareStatement("INSERT userdailytasks (userID, dailyTaskID, state, submissionMonth) VALUES (?, ?, 'DRAFT', ?)");
			
			for (int i = 0 ; i < dailyTaskID.size() ; i++) {
				ps.setInt(1, userID);
				ps.setInt(2, dailyTaskID.get(i));
				ps.setString(3, taskEntry.get(i).getSubmissionMonth());
				
				ps.addBatch();
			}
			
			int[] affectedRow = ps.executeBatch();
			
			size = affectedRow.length;
			
		} catch (SQLException e) {
			e.printStackTrace();
			
			size = -1;
		}
		
		return size;
	}
	
	public List<Group> loadAllGroups() {	
		List<Group> allGroups = new ArrayList<>();
		
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT groupID, groupName, groupDescription FROM existinggroup WHERE groupStatus = 'ACTIVE'");
			
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				Group g = new Group(rs.getInt("groupID"), rs.getString("groupName"), rs.getString("groupDescription"));
				
				allGroups.add(g);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return allGroups;
	}
	
	public int addNewGroup(Group newGroup) {
		int status=0, row=0;
		
		try {
			String sqlQuery ="INSERT INTO existinggroup (groupName, groupDescription, groupStatus) VALUES (?, ?, 'ACTIVE')";
			PreparedStatement ps = conn.prepareStatement(sqlQuery, Statement.RETURN_GENERATED_KEYS);
			
			ps.setString(1, newGroup.getGroupName());
			ps.setString(2, newGroup.getGroupDescription());
			
			row = ps.executeUpdate();
			
			if (row > 0) {
				// Obtaining inserted ID
				ResultSet rs = ps.getGeneratedKeys();
				
				if (rs.next()) {
					status = rs.getInt(1);
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		
		return status;
	}
	
	public int archiveGroup(String[] groupID) {		
		int row=0;
		
		try {
			PreparedStatement ps = conn.prepareStatement("UPDATE existinggroup SET groupStatus ='ARCHIVE' WHERE groupID = ?");
			
			for (int i = 0 ; i < groupID.length ; i++) {
				ps.setInt(1, Integer.parseInt(groupID[i]));

				ps.addBatch();
			}
			
			int[] rowArray = ps.executeBatch();
			
			row = rowArray.length;

		} catch (SQLException e) {
			e.printStackTrace();
		} 
		
		return row;
	}
	
	public int addNewUser(User newUser, ArrayList<Integer> groupID) {
		int row=0, status=0;
		
		try {
			String sqlQuery = "INSERT INTO user (username, passwords, email) VALUES (?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sqlQuery, Statement.RETURN_GENERATED_KEYS);
			
			ps.setString(1, newUser.getUsername());
			ps.setString(2, newUser.getPassword());
			ps.setString(3, newUser.getEmail());

			row = ps.executeUpdate();
			
			if (row > 0) {
				// Obtaining inserted ID
				ResultSet rs = ps.getGeneratedKeys();
				
				if (rs.next()) {
					status = rs.getInt(1);
					
					// Linking user & group in usergroup table
					status = linkNewUser(groupID, status);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		
		return status;
	}
	
	public int linkNewUser(ArrayList<Integer> groupID, int userID) {	
		int row = 0;
		
		try {
			PreparedStatement ps = conn.prepareStatement("INSERT INTO usergroups (userID, groupID) VALUES (?, ?)");
			
			for (int i = 0 ; i < groupID.size() ; i++) {
				ps.setInt(1, userID);
				ps.setInt(2, groupID.get(i));
				
				ps.addBatch();
			}
			
			int[] rowArray = ps.executeBatch();
			
			// If row.length equals to groupID.size all groupID linked successfully
			if (rowArray.length != groupID.size()) {
				row = 0;
			} else {
				row = groupID.size();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return row;
	}
	
	public int maintainGroup(ArrayList<Group> groupList) {
		int row=0;
		
		 try {
			 PreparedStatement ps = conn.prepareStatement("UPDATE existinggroup SET groupName = ?, groupDescription = ? WHERE groupID = ?");
			 
			 for (int i = 0 ; i < groupList.size() ; i++) {
				 ps.setString(1, groupList.get(i).getGroupName());
				 ps.setString(2, groupList.get(i).getGroupDescription());
				 ps.setInt(3, groupList.get(i).getGroupID()); 
			 
				 ps.addBatch();
			 }
			 
			 int[] affectedRow = ps.executeBatch();
			 
			 row = affectedRow.length;
			 
		 }catch (Exception e) {
			e.printStackTrace();
		}
		 
		 return row;
	}
	
	public List<Customer> loadAllCustomer() {
		List<Customer> customerList = new ArrayList<>();
		
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT customerID, customerName, customerDescription FROM customer");
			
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				Customer temp = new Customer(rs.getInt("customerID"), rs.getString("customerName"), rs.getString("customerDescription"));
				
				customerList.add(temp);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return customerList;
	}
	
	public int addNewProject(Project newProject) {
		int row=0, status=0;
		
		try {
			String sqlQuery = "INSERT INTO project (projectname, projectdescription, customerID, quotedDuration, quotedProjectPrice, sitDeliveryDate, uatDeliveryDate, goLiveDeliveryDate, assignedGroup) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = conn.prepareStatement(sqlQuery, Statement.RETURN_GENERATED_KEYS);
			
			ps.setString(1, newProject.getProjectName());
			ps.setString(2, newProject.getProjectDescription());
			ps.setInt(3, newProject.getClientID());
			ps.setInt(4, newProject.getQuotedDuration());
			ps.setFloat(5,  newProject.getProjectPrice());
			ps.setString(6, newProject.getSitDeliveryDate());
			ps.setString(7,  newProject.getUatDeliveryDate());
			ps.setString(8,  newProject.getGoLiveDeliveryDate());
			ps.setInt(9, newProject.getAssignedProjectGroup());
			
			row = ps.executeUpdate();
			
			if (row > 0) {
				// Obtaining inserted ID
				ResultSet rs = ps.getGeneratedKeys();
				
				if (rs.next()) {
					status = rs.getInt(1);
				}
			} else {
				row = status;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return status;
	}
	
	public List<User> loadAllUsers() {
		List<User> allUsers = new ArrayList<>();
		
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT userid, username, passwords, email FROM lazypeondb.user");
			
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				
				int userID = rs.getInt("userid");
				String username = rs.getString("username");
				String password = rs.getString("passwords");
				String email = rs.getString("email");
				
				User temp = new User(userID, username, password, email);
				
				allUsers.add(temp);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return allUsers;
	}
	
	public User loadUserDetails (int userID) {
		User user = new User();
		
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT userid, username, passwords, email FROM lazypeondb.user WHERE userid = ?");
			
			ps.setInt(1, userID);
			
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) {
				user.setUserID(rs.getInt("userID"));
				user.setUsername(rs.getString("username"));
				user.setEmail(rs.getString("email"));
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return user;
	}
}
