package com.items;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.simplify.payments.Authentication;
import com.simplify.payments.PaymentsApi;
import com.simplify.payments.PaymentsMap;
import com.simplify.payments.domain.Authorization;
import com.simplify.payments.domain.Payment;
import com.simplify.payments.exception.ApiCommunicationException;
import com.simplify.payments.exception.AuthenticationException;
import com.simplify.payments.exception.InvalidRequestException;
import com.simplify.payments.exception.NotAllowedException;
import com.simplify.payments.exception.SystemException;

/**
 * Servlet implementation class Payment
 */    

public class PaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	Connection MyConn;
	PreparedStatement insertActor;
	ItemBean ItemBean;
	Object objCartBean;
	String Card_Token=null;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	System.out.println(" request Payment Servlet");
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		PaymentsApi.PUBLIC_KEY = "sbpb_YTEwN2U0MWQtMWZlZS00NjczLThkYjAtMmUwNDJmZWQ0N2Uz";
		PaymentsApi.PRIVATE_KEY = "dbT1VYinuA/Qyy3XFYkJhV3j0f7yrJQnf6dg0AIVNnp5YFFQL0ODSXAOkNtXTToq";
		
		
		String parameter = request.getParameter("currency");
		String paymentDescription = request.getParameter("description");
		String tokenId = request.getParameter("simplifyToken");
		 Double amount =  Double.parseDouble(request.getParameter("Amount"))*100; //Double.parseDouble(request.getParameter("amount"));
		 //Double amount = Double.parseDouble(request.getParameter("amount"));
		String reference ="7a6ef6be31RRRTEST343";
		paymentDescription = "payment description";
		System.out.println("Amount :" +  amount/100. +  "Token id:" + tokenId + "  Payment desc:" +paymentDescription + " currentcy:" +parameter);
		Payment payment = null;
		HttpSession session = request.getSession();
	
		try {
			PaymentsMap map = new PaymentsMap()
	        .set("amount", amount)
	        .set("currency", "USD")
	        .set("description", paymentDescription)
	        .set("reference", reference)
	        .set("token", tokenId);
 			payment = Payment.create(map);
			
			
		} catch (ApiCommunicationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (AuthenticationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvalidRequestException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NotAllowedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Payment Response is: "+payment);
		if (payment != null && "APPROVED".equals(payment.get("paymentStatus"))) {
			System.out.println("Payment Id:"+payment.get("id"));
			Card_Token=(String) payment.get("id");
		    PrintWriter writer = response.getWriter();
		    writer.write("Payment approved");
		    writer.write("Use this Payment Id for Refund:" + ""+payment.get("id")+"");
		    request.setAttribute("Card Payment Approved", payment.get("id"));
		    createInvoice(request,response);
		    request.getRequestDispatcher("/Cashier.jsp").forward(request, response);
		} else {
			PrintWriter writer = response.getWriter();
			System.out.println("Payment Response is: "+payment);
			session.setAttribute("Not Approved", "Not Approved");
		    writer.write("Fails" +  ". Payment Response is: "+payment);
		    request.getRequestDispatcher("/Payment.jsp").forward(request, response);
		}
	}
	protected void createInvoice(HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession();
		objCartBean = session.getAttribute("cart");
		ItemBean = (ItemBean) objCartBean;
		
			
			try {
				String payment_Type = "Card";
				MyConn = ConnectionManager.getConnection();
				//myStmt = MyConn.createStatement();
				System.out.println(session.getAttribute("user_id"));
				//System.out.println(ItemBean.orderTotal+" ChangeDue "+ItemBean.change_Due+" pType "+payment_Type+" Tax "+ItemBean.orderTotalTax+" From Payment Servlet");
				ItemBean.change_Due =0;
				
				int InvoiceNumber = 0;
				
				Calendar cal = Calendar.getInstance();
				java.sql.Timestamp timestamp = new java.sql.Timestamp(cal.getTimeInMillis());
				//Statement
				insertActor = MyConn.prepareStatement("INSERT INTO Invoice(InvoiceTotal,ChangeDue,PaymentType,Card_Token,Tax,Date,user_Id,Status) VALUES(?,?,?,?,?,?,?,?)");
				insertActor.setDouble(1,ItemBean.orderTotal);
				insertActor.setDouble(2, ItemBean.change_Due);
				insertActor.setString(3,payment_Type);
				insertActor.setString(4, Card_Token);
				insertActor.setDouble(5, ItemBean.orderTotalTax);
				insertActor.setTimestamp(6, timestamp);
				insertActor.setInt(7,(Integer)session.getAttribute("user_id"));
				insertActor.setString(8,"Open");
				
				//System.out.println(ItemBean.orderTotalTax+" Payment Type");
				int result =insertActor.executeUpdate();
					if(result>=0){
						System.out.println("Invoice Created");
					}
				insertActor = MyConn.prepareStatement("SELECT MAX(InvoiceNumber) from Invoice");
				ResultSet rs = insertActor.executeQuery();
				while(rs.next()){
					InvoiceNumber = rs.getInt(1);
					
				}
				System.out.println(InvoiceNumber +" Inv #");
				session.setAttribute("maxInvNum", InvoiceNumber);
				session.setAttribute("timestamp", timestamp);
				System.out.println("Now Creating Inv # Item Details");
				
				for(int i=0;i<ItemBean.getCartItems().size();i++){
					
					insertActor = MyConn.prepareStatement("INSERT INTO InvoiceDetail(InvoiceNumber, ItemCode, ItemName,ItemPrice,Quantity,Tax,ItemTotal,Date,Status,Cashier_Name) VALUES (?,?,?,?,?,?,?,?,?,?)");
					
					insertActor.setInt(1, InvoiceNumber);
					insertActor.setString(2, ItemBean.getCartItem(i).getiCode());
					insertActor.setString(3, ItemBean.getCartItem(i).getiName());
					insertActor.setDouble(4, ItemBean.getCartItem(i).getiPrice());
					insertActor.setDouble(5, ItemBean.getCartItem(i).getiQty());
					insertActor.setDouble(6, ItemBean.getCartItem(i).getTax());
					insertActor.setDouble(7, ItemBean.getCartItem(i).getTotalTax());
					insertActor.setTimestamp(8, timestamp);
					insertActor.setString(9, "Open");
					insertActor.setString(10, (String)session.getAttribute("Cashier_Name"));
					
					//System.out.println("Item add to InvoideDetail with Inv# "+InvoiceNumber+" Item"+ItemBean.getCartItem(i).getiName()+" Qty"+ItemBean.getCartItem(i).getiQty()+" TTl"+ItemBean.getCartItem(i).getTotalTax()+" tax"+ItemBean.getCartItem(i).getTax());
					result =insertActor.executeUpdate();
					System.out.println(result+" Execute result");
					
					PreparedStatement ps = MyConn.prepareStatement("Update Item set QuantityOnHand =QuantityOnHand-? where ItemCode =?");
					ps.setDouble(1, ItemBean.getCartItem(i).getiQty());
					ps.setString(2, ItemBean.getCartItem(i).getiCode());
					
					ps.executeUpdate();
					clearCart(request,response);
				}
				
				
			}
			catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
	}
	protected void clearCart(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		objCartBean = session.getAttribute("cart");
		ItemBean = (ItemBean) objCartBean;
		
		ItemBean.clearCartItem();
	}
}
