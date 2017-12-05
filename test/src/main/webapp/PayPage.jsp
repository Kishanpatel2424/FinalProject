<!DOCTYPE html>
<%@ page import="com.items.*" %> 
<%@ include file = "home.jsp" %>

<html>
<head>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.simplify.com/commerce/v1/simplify.js"></script>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" ></script>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js'></script>
<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css'>
<link rel="stylesheet" href="css/payment.css">
</head>
<body>
<%
ItemBean ItemBean =null;
double total=0;

Object objCartBean = session.getAttribute("cart");
if(objCartBean !=null){
	 ItemBean = (ItemBean) objCartBean ;
	 total = ItemBean.orderTotal;	
	 String result = String.format("%.2f", total);
	 total = Double.parseDouble(result);
}
%>
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">

<div class="container"  align:center">

	
  <div id="Checkout" class="inline">
      <h1>Pay Invoice By Cash</h1>
      <div class="card-row">
          <h2><span >CASH</span></h2>
      </div>
      <form id="simplify-payment-form" action="cashierR" method="POST">
          <div class="form-group">
              <label for="PaymentAmount">Payment amount</label>
              <div class="amount-placeholder" >
                  <span>$</span><spam><%=total%></spam>
                  <span><input type="hidden" name="Amount" value="<%=total%>" step="0.01"/></span>
              </div>
          </div>
          
           <div id="sdkinputid_CC_Num" >
        		<label>Amount Given: </label>
        		<input id="Cash" name="Cash" type="number" class="null card-image form-control" maxlength="10" autocomplete="off" min="0" max="3000"value="" autofocus />
        		
    	  </div>
     	<br>  
      <input id="Process" name = "Process" class="btn btn-block btn-success submit-button" value="$<%=total%>" type="submit">
              
      
      </form>
      
  </div><br>
  <div id="Checkout" class="inline">
      <h1>Pay Invoice By Card</h1>
      <a href="/test/Payment.jsp">
      <div class="card-row">
          <span class="visa"></span>
          <span class="mastercard"></span>
          <span class="amex"></span>
          <span class="discover"></span>
       </div>
       </a>
  </div>
</div>

<%-- <div data-role="page">
  <div data-role="header">
    <h1>Checkout </h1>
    Amount Due:- <fmt:formatNumber type="number" maxFractionDigits="2" value="<%=total%>" />
  </div>

  <div data-role="main" class="ui-content">
    <a href="#myPopup" data-rel="popup" class="ui-btn ui-btn-inline ui-corner-all ">Cash</a>
    <div data-role="popup" id="myPopup" class="ui-content" style="min-width:250px;">
      <form method="post" action="cashierR">
        <div>
          <h3>Amount Due:-$ &nbsp <fmt:formatNumber type="number" maxFractionDigits="2" value="<%=total%>" /></h3>
          <label for="usrnm" class="ui-hidden-accessible">Username:</label>
          
          <input type="number" name="Cash" onchange="setTwoNumberDecimal"  step="0.01" id="Amount" value="<%=total%>">
          <input type="number" value="1"name="Type" style="visibility:hidden"/>
         
          <input type="submit" value="Process" name="Process">
        </div>
      </form>
    </div>
    <a href ="#myPopup1" data-rel="popup" class="ui-btn ui-btn-inline ui-corner-all ">Credit Card</a>
    <div data-role="popup" id="myPopup1" class="ui-content" style="min-width:250px;">
      <form method="post" action="cashierR">
        <div>
          <h3>Amount Due:-$ <fmt:formatNumber type="number" maxFractionDigits="2" value="<%=total%>" /></h3>
          <label for="usrnm" class="ui-hidden-accessible">Username:</label>
          <input type="number" name="Card"onchange="setTwoNumberDecimal(this)"  step="0.01" id="Amount" value="<%=total%>">
          <input type="number" value="2"name="Type" style="visibility:hidden"/>
         
          <input type="submit" value="Process" name="Process">
        </div>
      </form>
    </div>
  </div> 
</div>
 --%>
</body>


</html>


