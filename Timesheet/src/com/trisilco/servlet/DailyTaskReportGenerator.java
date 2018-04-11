package com.trisilco.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DailyTaskReportGenerator
 */
@WebServlet("/DailyTaskReportGenerator")
public class DailyTaskReportGenerator extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DailyTaskReportGenerator() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
		
		if (isAjax) {
			
			// Returning URL to BIRT web viewer with reporting month and userID
			response.getWriter().write("http://localhost:8080/Birt/frameset?__report=DailyTask_Timesheet_DB.rptdesign&__format=pdf&userID=" + 
					request.getSession(false).getAttribute("userID") + 
						"&reportMonth=" + request.getParameter("ReportMonth"));
		}
	}
}