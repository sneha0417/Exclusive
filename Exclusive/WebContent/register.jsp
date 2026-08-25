<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html >
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="shortcut icon" href="<%=contextPath+"/"%>gatelogo.ico" > 
<title>Gateway ERP(Integrated) Copyright &#169; 2012 GW TECHNOLOGIES</title>
<link rel="stylesheet" type="text/css" href="css/registerationStyle.css" media="all" />
<script type="text/javascript" src="js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/jquery.inputfocus-0.9.min.js"></script>
<script type="text/javascript" src="js/jquery.main.js"></script>
	
<script type="text/javascript">
      $(document).ready(function () {  
	 	getTimezone();
      });
      
      function functionProductKey() {
    	    var regex = new RegExp("^[a-zA-Z0-9]+$");
		    var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
		    if (!regex.test(key)) {
		       event.preventDefault();
		       return false;
		    }
		    
    	  if($('#txtproduct').val().trim()!=""){
    		  var productKeyLength = $("#txtproduct").val().trim().length;
    		  if(productKeyLength==4 || productKeyLength==9 || productKeyLength==14) {
    			  $('#txtproduct').val($('#txtproduct').val().trim()+"-");
    		  }
    	  }
	 	}
      
      function getTimezone() {
 		var x=new XMLHttpRequest();
 		x.onreadystatechange=function(){
 		if (x.readyState==4 && x.status==200)
 			{
 			 	items= x.responseText;
 			 	items=items.split('***');
 		        var zoneItems=items[0].split(":::");
 		        var zoneidItems=items[1].split(":::");
 		        	var optionszone = '<option value="">--Select--</option>';
 		        for ( var i = 0; i < zoneItems.length; i++) {
 		    	   optionszone += '<option value="' + zoneidItems[i] + '">' + zoneItems[i] + '</option>';
 		        }
 		         $("select#cmbtimezone").html(optionszone);
 		        if($('#hidcmbtimezone').val()!=""){
 		        	$('#cmbtimezone').val($('#hidcmbtimezone').val()) ;	
 		        }

 			   }
 		       else { }
 	     }
 	      x.open("GET","getTimezone.jsp",true);
 	     x.send();
 	    
         }
</script>
</head>
<body>
<div id="container">
<form id="frmRegister" action="saveRegister" method="post" autocomplete="off">

<!-- #first_step -->
<div id="first_step">
<h1><span>COMPANY</span></h1>

<div class="form">
<label for=companycode>Company</label><input type="text" id="txtcompid" name="txtcompid" Style="width: 40px;" placeholder="Code">&nbsp;<input Style="width: 250px;" type="text" id="txtcompname" name="txtcompname" placeholder="Company Name">
<label for="companyaddress">Address</label><input type="text" id="txtaddress" name="txtaddress" placeholder="Address">
<label for="companytel">Telephone</label><input type="text" id="txttel" name="txttel" placeholder="Telephone" maxlength="12">
<label for="companyemail">Email</label><input type="text" id="txtemail" name="txtemail" placeholder="Email">
<label for="activate">Product Key</label><input type="text" id="txtproduct" name="txtproduct" placeholder="****-****-****-****" maxlength="19" required onkeypress="functionProductKey();">
<label for="timezone">Time Zone</label><select name="cmbtimezone" id="cmbtimezone"><option value="">--Select--</option></select>
<input type="hidden" name="hidcmbtimezone" id="hidcmbtimezone" value='<s:property value="hidcmbtimezone"/>'/>

</div> <!-- clearfix --><div class="clear"></div><!-- /clearfix -->
<input class="submit" type="submit" name="submit_first" id="submit_first" value="NEXT" />
</div> <!-- clearfix --><div class="clear"></div><!-- /clearfix --> 

<div id="second_step">
<h1><span>BRANCH</span></h1>

<div class="form">
<br/>
<table>
<tr><td><h2 align="center">Company</h2></td><td><h2 align="center">:</h2></td><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;"></td></tr>
</table>
<label for=branchcode>Branch</label><input type="text" id="txtbranchid" name="txtbranchid" Style="width: 40px;" placeholder="Code">&nbsp;<input Style="width: 250px;" type="text" id="txtbranchname" name="txtbranchname" placeholder="Branch Name">
<label for="branchaddress">Address</label><input type="text" id="txtbranchaddress" name="txtbranchaddress" placeholder="Address">
<label for="branchtel">Telephone</label><input type="text" id="txtbranchtel" name="txtbranchtel" placeholder="Telephone" maxlength="12">
<label for="branchemail">Email</label><input type="text" id="txtbranchemail" name="txtbranchemail" placeholder="Email">

</div> <!-- clearfix --><div class="clear"></div><!-- /clearfix -->
<input class="submit" type="submit" name="submit_second" id="submit_second" value="NEXT" />
</div> <!-- clearfix --><div class="clear"></div><!-- /clearfix --> 

<div id="third_step">
<h1><span>USER</span></h1>

<div class="form">
<br/>
<table>
<tr><td><h2 align="center">Company</h2></td><td><h2 align="center">:</h2></td><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;"></td></tr>
<tr><td><h2 align="center">Branch</h2></td><td><h2 align="center">:</h2></td><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;"></td></tr>
</table>

<label for="userid">User ID</label><input type="text" id="txtuserid" name="txtuserid" maxlength="10" required placeholder="User ID">
<label for="username">User Name</label><input type="text" id="txtusername" name="txtusername" placeholder="User Name">
<label for=password>Password</label><input type="password" id="txtuserpassword" name="txtuserpassword" Style="width: 150px;" placeholder="Password">&nbsp;<input Style="width: 150px;" type="password" id="txtuserpasswordconfirm" name="txtuserpasswordconfirm" placeholder="Confirm Password">
<label for="useremail">Email</label><input type="text" id="txtuseremail" name="txtuseremail" placeholder="Email">

</div> <!-- clearfix --><div class="clear"></div><!-- /clearfix -->
<input class="submit" type="submit" name="submit_third" id="submit_third" value="NEXT" />
</div> <!-- clearfix --><div class="clear"></div><!-- /clearfix --> 


<!-- #fourth_step -->
<div id="fourth_step">
<h1><span>Registration</span></h1>

<div class="form">
<h2>Summary</h2>

<table>
<tr><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;">Company</td><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;">:</td><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;"></td></tr>
<tr><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;">Address</td><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;">:</td><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;"></td></tr>
<tr><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;">Product Key</td><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;">:</td><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;"></td></tr>
<tr><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;">Branch</td><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;">:</td><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;"></td></tr>
<tr><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;">Address</td><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;">:</td><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;"></td></tr>
<tr><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;">User ID</td><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;">:</td><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;"></td></tr>
<tr><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;">User Name</td><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;">:</td><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;"></td></tr>
<tr><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;">Email</td><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;">:</td><td style="color:#717171;font-size: 20px;font-size: Cantarell, Verdana, sans-serif;"></td></tr>
</table>
</div> <!-- clearfix --><div class="clear"></div><!-- /clearfix -->
<input class="submit" type="submit" name="submit_fourth" id="submit_fourth" value="DONE" />
</div>

</form>
</div>
<div id="progress_bar">
<div id="progress"></div>
<div id="progress_text">0% Complete</div>
</div>

</body>
</html>