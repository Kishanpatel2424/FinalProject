<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mysql.*" %>
<%@ page import="java.sql.*" %>
<%@ include file = "home.jsp" %>
<%@ page import="com.items.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.simplify.com/commerce/v1/simplify.js"></script>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" ></script>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js'></script>
<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css'>
<link rel="stylesheet" href="css/payment.css">

<style type="text/css">

#conventionorder th { text-align: center; }
.convorddiv { clear: both; }
#convord_info { width: 60%; margin-right: auto; margin-left: auto; height: auto;}
#convord_payments { width: 355px; margin-right: auto; margin-left: auto; margin-bottom: 2em; height:auto; }
#scancardprompt { display: none; text-align: center; }
#scancardprompt span { background-color:yellow; font-weight: bold; margin:3px;}

#conventionorder table { 
border-style: solid; 
border-width: 1px;
border-color: #000; 
}
#conventionorder table table {
border: none;
}
#conventionorder td,
#conventionorder th { padding: 3px; }
</style>

<script type="text/javascript">

/* sdkCardReader parses the credit card data into the form fields */

var cardParsed = false;


$(function() {
	$("#cc-number").change(function () { checkForReaderInput($(this).val()); } )
	.focus(function() { $('#scancardprompt').fadeIn('slow'); })
	.keypress(function() { $('#scancardprompt').hide(); });
	$('#ConvOrdForm').submit(function () { return checkPaySubmit(); });
	$(':input:visible').each(function(i,e){ $(e).attr('tabindex',i) });
	if (!$("#adminAlert").length && $("#cc-number").length) { 
	if ($("#cc-number").val().length==0) { $("#cc-number").focus(); }
	else { $("#btnsubmitorder").focus(); }
	} else { $('#conventionorder input:visible:first').focus(); }

	});

	function checkForReaderInput(string) {
	if (string.substring(0,2) == "%B") {
	string = string.replace('%B', '');
	var arr = string.split('^');
	if (arr[0].length <= 16) {
	$('#cc-number').val(arr[0]);
	$('#cc-exp-month').val(arr[2].substring(2, 4));
	$('#cc-exp-year').val(arr[2].substring(0, 2));
	
	var nameArr = arr[1].split('/');
	$('#CC_Name').val(nameArr[1]+' '+nameArr[0]);
	
	setMOP(arr[0].substring(0,1));
	}
	cardParsed = true;
	$('#sdkinputid_CC_Num span.errortext').hide();
	return false;
	}
	setMOP(string.substring(0,1));	// for manual CC# entry
	}

	function checkPaySubmit() {
	 if (cardParsed) { 
	cardParsed = false;
	$('#CC_CVC').focus();
	return false;
	} 
	return true;
	}
	
	
	function setMOP(ccnum) {
	// set #CC_MOP based on first number of cc-number..
	//alert(ccnum);
	switch (ccnum) {
	
	case "0": $('#CC_MOP').val('AX'); break;
	case "4": $('#CC_MOP').val('VC'); break;
	case "5": $('#CC_MOP').val('MC'); break;
	
	}
	}

//***************SImplify Varification code here CC_Nun, cc-exp-month, CC_ExpYe in //$(document).ready(function()// this method fo valid inputes*/

</script>

</head>
<%
ItemBean ItemBean =null;
double total=0;
double change_Due=0;

Object objCartBean = session.getAttribute("cart");
if(objCartBean !=null){
	
	 ItemBean = (ItemBean) objCartBean ;
	 total = ItemBean.orderTotal;
	 String result = String.format("%.2f", total);
	 change_Due=ItemBean.change_Due;
	 total = Double.parseDouble(result);
}
%>
<body>
<!-- <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
 -->
<div class="container">
		
  <div id="Checkout" class="inline">
      <h1>Pay Invoice</h1>
      <div class="card-row">
          <span class="visa"></span>
          <span class="mastercard"></span>
          <span class="amex"></span>
          <span class="discover"></span>
      </div>
      <form id="simplify-payment-form" action="paymentServlet" method="POST">
          <div class="form-group">
              <label for="PaymentAmount">Payment amount</label>
              <div class="amount-placeholder" >
                  <span>$</span><spam><%=total%></spam>
                  <span><input type="hidden" name="Amount" value="<%=total%>" step="0.01"/></span>
              </div>
          </div>
          
           <div id="sdkinputid_CC_Num">
        		<label for="CC_Num">Credit Card Number: </label>
        		<input id="cc-number" type="text" class="null card-image form-control" maxlength="150" autocomplete="off" value="" autofocus />
    	  </div>
     	  <div class="form-group">
              <label for="CC_Name">Name on card</label>
              <div id="sdkinputid_CC_Name">
              <input id="CC_Name" name="CC_Name" class="form-control" type="text" maxlength="255"></input>
          	  </div>
          </div>
      <table>
      <tbody>
		<div>
		<tr>
			<th>
			<label for="cc-exp-month">Expiry Date: </label>
			</th>
			<th style="padding:10px">
				<select name="cc-exp-month" id="cc-exp-month" class="form-control">
					<option value="01">01</option>
					<option value="02">02</option>
					<option value="03">03</option>
					<option value="04">04</option>
					<option value="05">05</option>
					<option value="06">06</option>
					<option value="07">07</option>
					<option value="08">08</option>
					<option value="09">09</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
				</select>
			</th>
				<th>
					<select name="cc-exp-year" id="cc-exp-year" class="form-control">

						
						<option value="17">2017</option>
						<option value="18">2018</option>
						<option value="19">2019</option>
						<option value="20">2020</option>
						<option value="21">2021</option>
						<option value="22">2022</option>
						<option value="23">2023</option>
						<option value="24">2024</option>
						<option value="25">2025</option>
						<option value="26">2026</option>
						<option value="27">2027</option>
						<option value="28">2028</option>
						<option value="29">2029</option>
					</select>
				</th>

				
		</tr>
		</div>
     </tbody>
     </table>        
      <button id="process-payment-btn" class="btn btn-block btn-success submit-button" type="submit">
              <span class="align-middle">$ <%=total%></span>
          </button>
      </form>
  </div>
  
</div>
<!-- <h5>testString :- %B4111111111111111^PATEL/KISHAN D^19032010000000697000000?;4111111111111111=19032010000069700000?</h5>
 -->
<!-- <div id="conventionorder">
<h1>Charge $10 with Simplify Commerce</h1>

<form id="simplify-payment-form" action="/paymentServlet" method="POST">
    The $10 amount is set on the server side
    <div>Amount:
        <input type="number" name="Amount" step="0.01"/></div>
    <div id="sdkinputid_CC_Num">
        <label for="CC_Num">Credit Card Number: </label>
        <input id="cc-number" type="text" maxlength="150" autocomplete="off" value="" autofocus />
    </div>
    <div>
        <label>CVC: </label>
        <input id="cc-cvc" type="text" maxlength="4" autocomplete="off" value=""/>
    </div>
    <div>
        <label for="cc-exp-month">Expiry Date: </label>
        
        <select name="cc-exp-month" id="cc-exp-month">
            <option value="01">01</option>
            <option value="02">02</option>
            <option value="03">03</option>
            <option value="04">04</option>
            <option value="05">05</option>
            <option value="06">06</option>
            <option value="07">07</option>
            <option value="08">08</option>
            <option value="09">09</option>
            <option value="10">10</option>
            <option value="11">11</option>
            <option value="12">12</option>
        </select>
        <select name="cc-exp-year" id="cc-exp-year">
        
            <option value="15">2015</option>
            <option value="16">2016</option>
            <option value="17">2017</option>
            <option value="18">2018</option>
            <option value="19">2019</option>
            <option value="20">2020</option>
            <option value="21">2021</option>
            <option value="22">2022</option>
            <option value="23">2023</option>
            <option value="24">2024</option>
        </select>
        
    </div>
    
    <button id="process-payment-btn" type="submit">Process Payment</button>
</form>
</div> -->
<script type="text/javascript">
    function simplifyResponseHandler(data) {
        var $paymentForm = $("#simplify-payment-form");
       
        
        // Remove all previous errors
        $(".error").remove();
        // Check for errors
        if (data.error) {
            // Show any validation errors
            if (data.error.code == "validation") {
                var fieldErrors = data.error.fieldErrors,
                        fieldErrorsLength = fieldErrors.length,
                        errorList = "";
                for (var i = 0; i < fieldErrorsLength; i++) {
                    errorList += "<div class='error'>Field: '" + alert(fieldErrors[i].field +
                            "' is invalid - " + fieldErrors[i].message) + "</div>";
                }
                // Display the errors
                $paymentForm.after(errorList);
            }
            // Re-enable the submit button
            $("#process-payment-btn").removeAttr("disabled");
        } else {
            // The token contains id, last4, and card type
            var token = data["id"];
            // Insert the token into the form so it gets submitted to the server
            $paymentForm.append("<input type='hidden' name='simplifyToken' value='" + token + "' />");
            // Submit the form to the server
            $paymentForm.get(0).submit();
        }
    }
    $(document).ready(function() {
        $("#simplify-payment-form").on("submit", function() {
            // Disable the submit button
            $("#process-payment-btn").attr("disabled", "disabled");
            // Generate a card token & handle the response
            SimplifyCommerce.generateToken({
                key: "sbpb_YTEwN2U0MWQtMWZlZS00NjczLThkYjAtMmUwNDJmZWQ0N2Uz",
                card: {
                    number: $("#cc-number").val(),
                    //cvc: $("#cc-cvc").val(),
                    expMonth: $("#cc-exp-month").val(),
                    expYear: $("#cc-exp-year").val()
                }
            }, simplifyResponseHandler);
            // Prevent the form from submitting
            return false;
        });
    });
</script>

</body>
</html>