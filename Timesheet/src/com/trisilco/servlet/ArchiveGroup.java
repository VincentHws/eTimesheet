package com.trisilco.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trisilco.model.Database;

/**
 * Servlet implementation class ArchiveGroup
 */
@WebServlet("/ArchiveGroup")
public class ArchiveGroup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ArchiveGroup() {
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
		Database db = new Database();

		if (isAjax) {
			db.INIT();
			
			// | is regex meta character, hence need to be delimited with \\
			String checkedGroupIDList = request.getParameter("checkedGroupIDList");
			String[] checkedGroupID = checkedGroupIDList.split("\\|");
			
			int status = db.archiveGroup(checkedGroupID);
			
			if (status == 0) {
				response.getWriter().write("ERROR_ARCHIVE_GROUP");
			} else {
				response.getWriter().write("SUCCESS_ARCHIVE_GROUP");
			}
		}
		
		db.closeConnectionDB();
	}

}
