package com.trisilco.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trisilco.model.DailyTask;
import com.trisilco.model.Database;

/**
 * Servlet implementation class SaveTask
 */
@WebServlet(description = "Servlet to update database when user clicked save button", urlPatterns = { "/SaveTask" })
public class SaveTask extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaveTask() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<DailyTask> dailyTask = new LinkedList<DailyTask>();
		boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
		Database db = new Database();
		int i =0;
		
		if (isAjax) {
			// Obtaining all the entries from the daily task table
			String[] date = request.getParameterValues("datepicker");
			String[] from_time = request.getParameterValues("from_time");
			String[] to_time = request.getParameterValues("to_time");
			String[] project_name = request.getParameterValues("project_name");
			String[] taskType = request.getParameterValues("task_type");
			String[] location = request.getParameterValues("location");
			String[] pleaseSpecify = request.getParameterValues("please_specify");
			String[] taskDescription = request.getParameterValues("task_description");
			String[] ttl_transport = request.getParameterValues("transportClaimAmount");
			String[] ttl_other_claim = request.getParameterValues("otherClaimsAmount");

			int userID = (int) request.getSession().getAttribute("userID");
			
			while (i < date.length) {
				
				// Instantiating new daily task object and add it to the list
				DailyTask temp;
				temp = new DailyTask(date[i], from_time[i], to_time[i], project_name[i], taskType[i], location[i], 
						pleaseSpecify[i].trim() , taskDescription[i].trim() , ttl_transport[i], ttl_other_claim[i]);

				if (temp.getLocation().equals("Offsite")) {
					temp.setPlease_specify("Office");
				}

				dailyTask.add(temp);

				i++;
			}
			
			db.INIT();

			ArrayList<Integer> dailyTaskID = db.saveTasks(dailyTask, userID);
			
			// Sending response JSP
			if(dailyTaskID.size() == 0) {
				response.getWriter().write("ERROR_SAVE_TASK");
			} else {
				response.getWriter().write("SUCCESS_SAVE_TASK");
			}
			
			db.closeConnectionDB();
		}
	}
}
