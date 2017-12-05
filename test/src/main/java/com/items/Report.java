package com.items;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Report
 */
public class Report extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Report() {
        super();
        // TODO Auto-generated constructor stub
    }
    Connection MyConn =null;
	Statement myStmt =null;
	PreparedStatement insertActor =null;
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		
		
		boolean generateReport = request.getParameter("Close") !=null;
		if(generateReport == true){
			try {
				closeReport(request,response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	protected void closeReport(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException{
		HttpSession session = request.getSession();
		int seq_num =0;
		try {
			MyConn = ConnectionManager.getConnection();
			
			Calendar cal = Calendar.getInstance();
			java.sql.Timestamp timestamp = new java.sql.Timestamp(cal.getTimeInMillis());
			PrintWriter out = response.getWriter();
			
			insertActor = MyConn.prepareStatement("Insert into reportHeader (Closing_Date) VALUES (?)");
			insertActor.setTimestamp(1, timestamp);
			int rs = insertActor.executeUpdate();
			
			System.out.println(rs+" Inserted");
			insertActor = MyConn.prepareStatement("SELECT MAX(Closed_Seq_num) from reportHeader");
			ResultSet rs1 = insertActor.executeQuery();
			
			while(rs1.next()){
				seq_num = rs1.getInt(1);
				
			}
			System.out.println(seq_num+" Closing seq Num");
			
			insertActor = MyConn.prepareStatement("Update Invoice set Status =? where Closed_Seq_num =?");
			insertActor.setString(1, "Closed");
			insertActor.setInt(2, seq_num-1);
			
			int finishUpdate = insertActor.executeUpdate();
			System.out.println(finishUpdate+" for Invoice Table");
			
			insertActor = MyConn.prepareStatement("Update InvoiceDetail set Status =? where Status =?");
			insertActor.setString(1, "Closed");
			insertActor.setString(2, "Open");
			
			finishUpdate = insertActor.executeUpdate();
			System.out.println(finishUpdate+" for InvoiceDetail Table");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Report Saved');");
				out.println("</script>");
				
			
			
			
		}
		catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("/test/Cashier.jsp");
		
	}

}
