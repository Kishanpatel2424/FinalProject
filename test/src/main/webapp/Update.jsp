<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mysql.*" %>
<%@ page import="java.sql.*" %>
<%@ include file = "home.jsp" %>
<%@ page import="com.items.*" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Update Item</title>



<br>
</head>
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

Connection conn = ConnectionManager.getConnection();
//String SearchList =request.getParameter("SearchList");
ResultSet rs = null;
PreparedStatement insertActor;
%>
<%
	
	String Empty = (String)request.getAttribute("BarCodeEmpty");
	String NotExist = (String)request.getAttribute("NotExist");
	String succ = (String)request.getAttribute("Successfull");
	if(Empty!=null){
	%>
		 <script type="text/javascript">
	    var msg = "Enter Barcode";
	    alert(msg);
	</script><%
	}
	
	if(NotExist!=null){
		%>
			 <script type="text/javascript">
		    var msg = "Item Not Exist";
		    alert(msg);
		</script><%
		}
	
	if(succ!= null){
		%>
		 <script type="text/javascript">
	    var msg = "<%=succ%>";
	    alert(msg);
	</script><%
	}
%>



<body onload="document.MyForm.iCode.focus();" onload="ClearForm()">
	
<div class="container">

<div class="row">
    <div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
			<div class="row">
		<form name="MyForm" action="update" method="POST" role="form">
			<h2>Update/Edit Item </h2>
			<hr class="colorgraph">
			
				
					<div class="form-group">Scan BarCode
                        <input type="text" name="iCode" value=""  class="form-control input-lg" placeholder="Barcode" tabindex="1">
					</div>
					<hr class="colorgraph">
			<div class="row">
				<div class="col-xs-12 col-md-6"><input type="submit" value="Search" name="search" class="btn btn-primary btn-block btn-lg" tabindex="7"></div>
				<div class="col-xs-12 col-md-6"><input type="reset" value="Clear" name="clear" class="btn btn-success btn-block btn-lg"/></div>
			</div>
			
		</form>
		<%request.getAttribute("iCode");%>
		<form name="MyForm" action="update" method="POST" role="form">
			
			<hr class="colorgraph">
			<div class="row">
				<div class="col-xs-12 col-sm-6 col-md-6">
					<div class="form-group">Scan BarCode
                        <input type="text" name="iCode" value="<%=request.getAttribute("iCode")%>" onkeypress="return tabE(this,event)" class="form-control input-lg" placeholder="Barcode" tabindex="1">
					</div>
				</div>
				<div class="col-xs-12 col-sm-6 col-md-6">
					<div class="form-group">Min Quantity
                        <input type="number" name="Min_Qty" value="<%=request.getAttribute("Min_Qty")%>"  class="form-control input-lg" placeholder="Min Qty Allowed" tabindex="2">
					</div>
				</div>
			</div>
			<div class="form-group">Item Name
				<input type="text" name="iName" value="<%=request.getAttribute("iName")%>" class="form-control input-lg" placeholder="Product Name" tabindex="3">
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-6 col-md-6">
					<div class="form-group"> Choose Vendor
				 <%
                /* Class.forName("com.mysql.jdbc.Driver");
                Connection conn = null;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "password");
                //conn = DriverManager.getConnection("jdbc:mysql://node23485-onlinepos.njs.jelastic.vps-host.net /test","root","BPNivr47456");
                Statement stmt = null;
                stmt = conn.createStatement(); */
                
                
                String query = "SELECT Vendor_Name FROM Vendors";
                
                insertActor = conn.prepareStatement(query);
                rs = insertActor.executeQuery(query);
                int num =0;
                %>
               <%=request.getAttribute("Vendor_Name")%>
				
						<select name="Vendor_Name" class="form-control input-lg" placeholder="Vendors" tabindex="4">
							<%
		                while(rs.next()){
		                	num++;
		                
		            		%>
									<option value="<%=rs.getString("Vendor_Name") %>"><%=rs.getString("Vendor_Name") %></option>
						<%} 
		                %>
						</select>
					</div>
				</div>
				
				<div class="col-xs-12 col-sm-6 col-md-6">
					<div class="form-group"> Choose Category
					<%=request.getAttribute("Category_Name")%>
					<select name="Category_Name"  class="form-control input-lg" tabindex="4">
						<%
						query = "SELECT Category_Name FROM Category";
		                rs = null;
		                insertActor = conn.prepareStatement(query);
		                rs = insertActor.executeQuery(query);
		                num =0;
                while(rs.next()){
                	num++;
                
           		 %>
							<option value="<%=rs.getString("Category_Name") %>"><%=rs.getString("Category_Name") %></option>
				<%} 
					%>
					</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-4 col-md-4">
					<div class="form-group">Item Cost
						<input type="number" step=0.01 id="iCost" name="iCost" value="<%=request.getAttribute("iCost")%>" class="form-control input-lg" placeholder="Item Cost" tabindex="5">
					</div>
				</div>
				<div class="col-xs-12 col-sm-4 col-md-4">
					<div class="form-group">Sell Price
						<input type="number" step=0.01 id="iPrice" name="iPrice" value="<%=request.getAttribute("iPrice")%>" class="form-control input-lg" placeholder="Item Sell Price" tabindex="5">
					</div>
				</div>
				<div class="col-xs-12 col-sm-4 col-md-4">
					<div class="form-group">On Hand Qty
						<input type="number" id="OtyOnHand" name="OtyOnHand" value="<%=request.getAttribute("QuantityOnHand")%>" class="form-control input-lg" placeholder="Qty On Hand" tabindex="6">
					</div>
				</div>
			</div>
			<hr class="colorgraph">
			<div class="row">
				<div class="col-xs-12 col-md-6"><input type="submit" value="Update" name="Update" class="btn btn-primary btn-block btn-lg" tabindex="7"></div>
				<div class="col-xs-12 col-md-6"><input type="reset" value="Clear" name="clear" class="btn btn-success btn-block btn-lg"/></div>
			</div>
		</form>
		</div>	
			</div>
</div>
</div>
</body>
</html>