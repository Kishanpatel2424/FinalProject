<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.mysql.*" %>
<%@ page import="java.sql.*" %>
<%@ include file = "home.jsp" %>
<%@ page import="com.items.*" %>
<%@ page import="java.util.ArrayList" %> 



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Purchase Order</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
  $( function() {
    //$( "#datepicker" ).datepicker();
    $( "#datepicker" ).datepicker({
    	  dateFormat: "yy-mm-dd"
    	});
  } );
  
 
  var Msg ='<%=(String)session.getAttribute("Action")%>';
      if (Msg != "null") {
   function alertName(){
   	alert("Order Created "+Msg);
   } 
   }
 
 </script>
  <%

String userName = null;
//allow access only if session exists
if(session.getAttribute("user") == null || session.getAttribute("user").equals("Cashier")){
	response.sendRedirect("/test/index.jsp");
}else userName = (String) session.getAttribute("user");
String sessionID = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null){
for(Cookie cookie : cookies){
	if(cookie.getName().equals("user")) userName = cookie.getValue();
}


}


String Vendor_Name = (String)session.getAttribute("Vendor_Name");
Connection conn = ConnectionManager.getConnection();
//String SearchList =request.getParameter("SearchList");
ResultSet rs = null;
PreparedStatement insertActor;
ItemBean VendorBean =null;
ArrayList<ItemsDescription> itemList =null;

Object objVendorBean = session.getAttribute("Update_Vendor_List");

%>

  
</head>

<body>

<center><h1>Purchase Order For</h1><h2> <font color="Green"><%=Vendor_Name %></font></h2></center>
<div class="container">
<div class="row">
				
				
				<form name="MyForm" action="recallPurchaseOrder" method="POST" role="form">
				<table class="table" id="item">
				<tr>
				<th style="width:20%">
				<div class="form-group" style="font-size:20px">Date Ordered:
					<div>
						<input type="text" id="datepicker"name="date" size="10"  style="font-size:20px" tabindex="1" required class="form-control input-lg">
					</div>
				</div>
				</th>
				<th style="width:40%"> 
				<div class="form-group" style="font-size:20px">Vendor Name:</div>
				<div class="col-xs-12 col-sm-12 col-md-12">
				
				
				 <%
                
                String SearchList =request.getParameter("SearchList");
                String query = "SELECT Vendor_Name FROM Vendors";
                insertActor = conn.prepareStatement(query);
                rs = insertActor.executeQuery(query);
                int num =0;
                %>
               
				
						<select name="Vendor_Name" class="form-control input-lg" tabindex="2">
							<%
		                while(rs.next()){
		                	num++;
		                
		            		%>
									<option value="<%=rs.getString("Vendor_Name") %>"><%=rs.getString("Vendor_Name") %></option>
						<%} 
						
		                %>
						</select>
						</div>
						
						</th>
				<th style="width:40%">
				<div class="col-xs-12 col-sm-4 col-md-4">
				<input type="submit" value="Select" name="Recall" class="btn btn-primary btn-block btn-lg"></div>
				</th>
				</tr>
				
				</table>
				</form>

				
				<form name="MyForm" action="recallPurchaseOrder" method="POST">
				<table class="table" id="item">
				
				<div class="row">
					<tr style="font-size:20px; color:red">
						<td style="width:4%">#</td>
						<td style="width:14%">Bar Code</td>
						<td style="width:35%">Item Name</td>
						<td style="width:10%">Bottle Cost</td>
						<td style="width:10%">Min Qty</td>
						<td style="width:10%">Qty On Hand</td>
						<td style="width:10%">Qty Order</td>
						<td style="width:15%">Qty Recieved</td>
						<!-- <td style="width:15%">Total</td> -->
						
					</tr>
				</div>
				
				
				<div class="row">
					<tr>
				<%
						        int number =0;
						        	if(objVendorBean !=null){
						        		VendorBean = (ItemBean) objVendorBean ;	 
						        	for(ItemsDescription b : VendorBean.getVendorItemList()){
										number++;
										//System.out.println(b.getiName()+" "+b.getiCost()+" "+b.getminQty()+" "+b.getminQty());
										//System.out.println(b.getiCode()+" Price "+b.getiName()+" Name "+b.getiPrice()+" Price");
						        		//System.out.println(b.getiName()+" Name"+" "+b.getiPrice()+" Price");
									  //}
				%>
									<div class="inner_table">      
								         
								         
								         <tr> 
								        
								            <td style="width:4%"><%=number%></td>
								            
								            <td style="width:14%"><%=b.getiCode() %></td>
								            <td style="width:35%"><%=b.getiName() %><input type="text" name="iCode"value="<%=b.getiCode() %>" style="visibility: hidden; height:1px"></td>
								            <%-- <td style="width:10%"><input type="number" step=0.01 id="iCost" value="<%=b.getiCost() %>" name="iCost" onkeyup="sum()" class="form-control"></td> --%>
								            <td style="width:10%"><%=b.getiCost() %></td>
								            <td style="width:10%"><%=b.getminQty()%></td>
								            <td style="width:10%"><%=b.getQtyOnHand() %></td>
								            <td style="width:10%"><%=b.getQtyToOrder() %></td>
								            <td style="width:15%"><input type="number" id="qOrder" name="qRecieved" value="<%=b.getQtyToOrder()%>" class="form-control" min="0" ></td>
											<!-- <td style="width:10%"><input type="number" step="0.01" name="costSum" id="costSum" class="form-control"></td> -->				            
								        
								        
								        </tr> 
						            </div>
						        <%}
						        	
						        	}%>
				</tr>
			</div>
			
				</table>
				<div class="row">
				
				<div class="col-xs-12 col-md-6"><input type="submit" value="Clear" name="Clear" class="btn btn-danger btn-block btn-LG"/></div>
				<div class="col-xs-12 col-md-6"><input type="submit"  name="AddOrder" Value="Add Order" class="btn btn-success btn-block btn-LG"></div>
				</div>
				</form>
				
			
			</div>
			</div>
</body>
</html>