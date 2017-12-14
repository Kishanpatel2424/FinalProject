package com.items;

import java.io.IOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class PurchaseOrder
 */
//@WebServlet("/PurchaseOrder")
public class PurchaseOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PurchaseOrder() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		
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
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		vendor_Name = (String)request.getParameter("Vendor_Name");
		String date = (String)request.getParameter("date");
		
		System.out.println("Vendor Name is"+vendor_Name+" name " + date);
		boolean actionCreateOrder = request.getParameter("CreateOrder") !=null;
		boolean actionClear = request.getParameter("Clear") !=null;
		//System.out.println(actionCreateOrder+" action is");
		if(vendor_Name != null && !vendor_Name.equals("null") && !vendor_Name.equals(" ")){
			//clearVendorItem(request, response);	
			try{
				
					findVendorItems(request, response, vendor_Name);
				}
			catch(NullPointerException e){
				
			}
			
			request.getRequestDispatcher("/PurchaseOrder.jsp").forward(request, response);
		}
		if(actionClear == true){
			clearVendorItem(request,response);
			request.getRequestDispatcher("/PurchaseOrder.jsp").forward(request, response);
		}
		if(actionCreateOrder == true){
				createOrder(request,response);
				clearVendorItem(request,response);
				
		}
	
	}
	protected void createOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

		int []temp = null;
		
		HttpSession session = request.getSession(true);
		Object VendorOrderBean = session.getAttribute("Vendor_List");
		ItemBean VendorOrderList = (ItemBean) VendorOrderBean; //to use createpurchaseorder method from ItemBean
		
		int j=0;
		//VendorOrderList = new ItemBean();
		
		temp = getData(request);
		if(VendorOrderBean!=null){
			//System.out.println(VendorOrderBean.hashCode()+" Obj has value");
			
		    for(ItemsDescription b:VendorBean.getVendorItemList()){
		    	b.setQtyToOrder(temp[j]);
				VendorOrderList.createPurchaseOrder(vendor_Id, b.getiName(),b.getiCode(), b.getiCost(), b.getQtyToOrder());
				
				j++;
			}
		    
		}
		VendorBean.setpurchaseOrder(VendorBean.getpurchaseOrder());
		
		savePurchaseOrder(VendorBean, vendor_Id, request,response);
	}
	private static int[] getData(HttpServletRequest request){
		int []temp =null;
		Enumeration allParameterNames = request.getParameterNames();
		while(allParameterNames.hasMoreElements())
		{
			
			ItemsDescription list = new ItemsDescription();
		    Object object = allParameterNames.nextElement();
		    String param =  "qOrder";
		    String[] value =  request.getParameterValues(param);
		    temp = new int[value.length];
		    for(int i=0;i<value.length;i++){
		    	temp[i] = Integer.parseInt(value[i]);
		    	//System.out.println("Parameter Name is '"+param+"' and Parameter Value is '"+temp[i]+"'");
		    }
		    
		 break;   
		}
		return temp;
	}
	protected void savePurchaseOrder(ItemBean purchaseOrder, int Vendor_Id, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		
		HttpSession session = request.getSession(true);
		MyConn = ConnectionManager.getConnection();
		PreparedStatement insertActor=null;
		Calendar cal = Calendar.getInstance();
		java.sql.Timestamp timestamp = new java.sql.Timestamp(cal.getTimeInMillis());
		int OrderHeaderNum=0;
		try {
			
			insertActor = MyConn.prepareStatement("INSERT INTO Purchase_Order ( Vendor_Id, DateCreated) VALUES(?,?)");
			insertActor.setInt(1, Vendor_Id);
			insertActor.setTimestamp(2, timestamp);
			int result =insertActor.executeUpdate();
			if(result>=0){
				System.out.println("Order Header Created");
			}
			insertActor = MyConn.prepareStatement("SELECT MAX(Purchase_Order_Index) from Purchase_Order");
			ResultSet rs = insertActor.executeQuery();
			while(rs.next()){
				OrderHeaderNum = rs.getInt(1);
				
			}
			System.out.println(OrderHeaderNum +" OrderHeaderNum");
			
			for(ItemsDescription b:purchaseOrder.getVendorItemList()){
				
				insertActor = MyConn.prepareStatement("INSERT INTO Purchase_Order_Detail(Purchase_Order_Index, Vendor_Id, ItemCode,ItemName, ItemPrice,ItemOrdered,DateCreated) VALUES (?,?,?,?,?,?,?)");
				insertActor.setInt(1, OrderHeaderNum);
				insertActor.setInt(2, Vendor_Id);
				insertActor.setString(3, b.getiCode());
				insertActor.setString(4, b.getiName());
				insertActor.setDouble(5, b.getiCost());
				insertActor.setInt(6, b.getQtyToOrder());
				insertActor.setTimestamp(7, timestamp);
				
				result =insertActor.executeUpdate();
				
			}
			if(result>=1){
				session.setAttribute("Action", "Successfull");
				VendorBean.clearPurchaseOrder();
				response.sendRedirect("/test/PurchaseOrder.jsp");
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
		/*purchaseOrder.clearCartItem();
		response.sendRedirect("/test/PurchaseOrder.jsp");*/
		//request.getRequestDispatcher("/PurchaseOrder.jsp").forward(request, response);
		
	}
	
	protected void clearVendorItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		HttpSession session = request.getSession(true);
		objVendorBean = session.getAttribute("Vendor_List");
		VendorBean = (ItemBean)objVendorBean;
		if(VendorBean!=null)
			VendorBean.clearVendorItem();
		
	}

	protected void findVendorItems(HttpServletRequest request, HttpServletResponse response, String vendor_Name) throws ServletException, IOException{
		
		HttpSession session = request.getSession(true);
		boolean findVendor = true;
		session.removeAttribute("Action");
		objVendorBean = session.getAttribute("Vendor_List");
		VendorBean = (ItemBean)objVendorBean;
		////FInish the Vendor clearList Code
		if(VendorBean!=null){
			clearVendorItem(request,response);
		}
		
		
		if(vendor_Name.equals(" ") || vendor_Name.equals(null)){
			//request.getRequestDispatcher("/PurchaseOrder.jsp").forward(request, response);
			findVendor = false;
		}
		//VendorBean.clearVendorItem();
		if(findVendor == true){
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
				System.out.println(vendor_Name+" "+vendor_Id);
			}
			//TO find Everythign from the Vendor Name
			query = ("SELECT * FROM Item WHERE Vendor_Name =? ORDER BY Item.ItemName ASC");
			ps = MyConn.prepareStatement(query);
			ps.setString(1, vendor_Name);
			
			
			rs = ps.executeQuery();
				
			objVendorBean = session.getAttribute("Vendor_List");
			
			while(rs.next()){
				
				String iCode = rs.getString("ItemCode");
				String iName = rs.getString("ItemName");
				double iCost = rs.getDouble("ItemCost");
				int QtyOnHand = rs.getInt("QuantityOnHand");
				int minQty = rs.getInt("Min_Qty");
				
				
				//System.out.println(iCode+" "+iName+" "+iCost+" "+QtyOnHand);
			
				//System.out.println(iName+" "+iCost);
				if(objVendorBean!=null) {
					  VendorBean = (ItemBean) objVendorBean ;
					  //ItemBean.getCartItem(0);
					  
					  
					  session.setAttribute("Vendor_List", VendorBean);
				  } else {
					  VendorBean = new ItemBean();
					  
					  session.setAttribute("Vendor_List", VendorBean);
				   
				  }
				//Create a method in ItemBean that accepts iName, iCost, QuantityOnHand, Min_Qty, Department
				VendorBean.VendorItem(iCode,iName, iCost, QtyOnHand, minQty);
				OrderList = VendorBean.getVendorItemList();
				VendorBean.setVendorItemList(OrderList);
			}
/*			for(ItemsDescription b:VendorBean.getVendorItemList()){
				
				
			}
		*/	
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}
		
		
	}

}
