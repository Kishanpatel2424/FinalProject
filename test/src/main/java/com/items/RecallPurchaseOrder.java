package com.items;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;

import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class RecallPurchaseOrder
 */
public class RecallPurchaseOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RecallPurchaseOrder() {
        super();
        // TODO Auto-generated constructor stub
    }

    Connection MyConn=null;
	PreparedStatement ps;
	String query=null;
	ItemBean VendorBean = null;//Saving all vendor Items
	Object objVendorBean =null;
	ResultSet rs;
	String vendor_Name =null;
	ItemsDescription OrderItems = new ItemsDescription();
	ArrayList<ItemsDescription> OrderList = new ArrayList<ItemsDescription>();
	
	int vendor_Id =0;
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
		
		vendor_Name = (String)request.getParameter("Vendor_Name");
		String date = (String)request.getParameter("date");
		
		boolean actionAddOrder = request.getParameter("AddOrder") !=null;
		boolean actionClear = request.getParameter("Clear") !=null;
		//System.out.println("Vendor Name is from RecallP-Order"+vendor_Name+" name " + date);
		
		if(vendor_Name != null && !vendor_Name.equals("null") && !vendor_Name.equals(" ")){
			//clearVendorItem(request, response);	
			try{
				
					recall_POrder(request, response, vendor_Name, date);
				}
			catch(NullPointerException e){
				
			}
			
			request.getRequestDispatcher("/RecallPurchaseOrder.jsp").forward(request, response);
		}
		if(actionClear == true){
			clearVendorItem(request,response);
			request.getRequestDispatcher("/RecallPurchaseOrder.jsp").forward(request, response);
		}
		if(actionAddOrder == true){
			AddOrder(request,response);
			clearVendorItem(request,response);
			
		}
		
	}
	
	protected void AddOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

		int []temp = null;
		
		HttpSession session = request.getSession(true);
		Object objVendorBean = session.getAttribute("Update_Vendor_List");
		ItemBean VendorBean =null;
		VendorBean = (ItemBean) objVendorBean ;
		
		int j=0;
		//VendorOrderList = new ItemBean();
		Enumeration allParameterNames = request.getParameterNames();
		while(allParameterNames.hasMoreElements())
		{
			
			ItemsDescription list = new ItemsDescription();
		    Object object = allParameterNames.nextElement();
		    String param =  "qRecieved";
		    String[] value =  request.getParameterValues(param);
		    temp = new int[value.length];
		    for(int i=0;i<value.length;i++){
		    	temp[i] = Integer.parseInt(value[i].trim());
		    	System.out.println("Parameter Name is '"+param+"' and Parameter Value is '"+temp[i]+"'");
		    }
		    
		 break;   
		}
		PrintWriter out = response.getWriter();
		MyConn = ConnectionManager.getConnection();
		PreparedStatement insertActor=null, selectQty;
		Calendar cal = Calendar.getInstance();
		java.sql.Timestamp timestamp = new java.sql.Timestamp(cal.getTimeInMillis());
		int OrderHeaderNum=0;
		try {
			
			insertActor = MyConn.prepareStatement("Update Purchase_Order Set Status = ?, DateCreated=? where Vendor_Id=? and Status=?");
			insertActor.setString(1, "Closed");
			insertActor.setTimestamp(2, timestamp);
			insertActor.setInt(3, vendor_Id);
			insertActor.setString(4, "Open");
			
			int result =insertActor.executeUpdate();
			if(result>=0){
				System.out.println("Order Header Updated");
			}
			
			
			for(ItemsDescription b:VendorBean.getVendorItemList()){
				selectQty = MyConn.prepareStatement("Select QuantityOnHand From Item where ItemCode=?");
				selectQty.setString(1, b.getiCode());
				ResultSet rs = selectQty.executeQuery();

				int ttl = 0;
				
				while(rs.next()){
					if(ttl <0)
						ttl =0;
					else
						ttl = rs.getInt("QuantityOnHand");
				}
				
				insertActor = MyConn.prepareStatement("Update Item set QuantityOnHand =? where ItemCode=?");
				//insertActor = MyConn.prepareStatement("INSERT INTO Purchase_Order_Detail(Purchase_Order_Index, Vendor_Id, ItemCode,ItemName, ItemPrice,ItemOrdered,DateCreated) VALUES (?,?,?,?,?,?,?)");
				insertActor.setInt(1, b.getQtyToOrder()+ttl);
				insertActor.setString(2, b.getiCode());

				
				result =insertActor.executeUpdate();
				
			}
			System.out.println(result+" result accquired");
			if(result>=1){
				VendorBean.clearPurchaseOrder();
				session.setAttribute("Action", "Successfull");
				response.sendRedirect("/test/RecallPurchaseOrder.jsp");
			}
		
		} catch (SQLException e) {
			try {
				MyConn.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	protected void clearVendorItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		HttpSession session = request.getSession(true);
		objVendorBean = session.getAttribute("Update_Vendor_List");
		VendorBean = (ItemBean)objVendorBean;
		if(VendorBean!=null)
			VendorBean.clearVendorItem();
		
	}
	protected void recall_POrder(HttpServletRequest request, HttpServletResponse response, String vendor_Name, String Date) throws ServletException, IOException{
		
		HttpSession session = request.getSession(true);
		Object objVendorBean = session.getAttribute("Update_Vendor_List");
		
		int Purchase_Order_Index=0;
		
		////FInish the Vendor clearList Code
		if(VendorBean!=null){
			clearVendorItem(request,response);
		}
		
		try{
			session.setAttribute("Vendor_Name", vendor_Name);
			MyConn = ConnectionManager.getConnection();
			/// TO find Vendor ID
			query =("SELECT * FROM Vendors where Vendor_Name like ?");
			ps = MyConn.prepareStatement(query);
			ps.setString(1, vendor_Name);
			rs = ps.executeQuery();
			while(rs.next()){
				vendor_Id = rs.getInt("Vendor_Id");
				System.out.println(vendor_Name+" and "+vendor_Id+" From Recall P Order");
				break;
			}

			java.sql.Timestamp timestamp = java.sql.Timestamp.valueOf(Date+" 00:00:00");
			
			
			query = ("SELECT * FROM Purchase_Order WHERE Vendor_Id=? AND Status=? AND DateCreated>=?");
			ps = MyConn.prepareStatement(query);
			ps.setInt(1, vendor_Id);
			ps.setString(2, "Open");
			ps.setTimestamp(3, timestamp);
			
			rs = ps.executeQuery();
			while(rs.next()){
				Purchase_Order_Index = rs.getInt("Purchase_Order_Index");
			}
			System.out.println(Purchase_Order_Index+" Purchase_Order_Index ");
			
			query = ("SELECT * FROM Purchase_Order_Detail WHERE Purchase_Order_Index=?");
			ps = MyConn.prepareStatement(query);
			ps.setInt(1, Purchase_Order_Index);
			
			rs = ps.executeQuery();
			objVendorBean = session.getAttribute("Update_Vendor_List");
			
			while(rs.next()){
				String ItemName= rs.getString("ItemName");
				String ItemCode= rs.getString("ItemCode");
				double ItemPrice = rs.getDouble("ItemPrice");
				int ItemOrder = rs.getInt("ItemOrdered");
				//System.out.println(vendor_Id+" "+ItemCode+" "+ItemPrice+" "+" "+ItemOrder);
				if(objVendorBean!=null) {
					  VendorBean = (ItemBean) objVendorBean ;
					  //ItemBean.getCartItem(0);
					  
					  
					  session.setAttribute("Update_Vendor_List", VendorBean);
				  } else {
					  VendorBean = new ItemBean();
					  
					  session.setAttribute("Update_Vendor_List", VendorBean);
				   
				  }
				VendorBean.createPurchaseOrder(vendor_Id, ItemName,ItemCode, ItemPrice, ItemOrder);
				OrderList = VendorBean.getpurchaseOrder();
				VendorBean.setVendorItemList(OrderList);
			}
			/*for(ItemsDescription b:VendorBean.getVendorItemList()){
				System.out.println(b.getQtyToOrder()+" recall orderlist");
				
			}*/
			
		}
		catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
