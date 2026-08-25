<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}

.style1 {
	color: #FF0000;
	font-weight: bold;
}
</style>
<script type="text/javascript">
      $(document).ready(function () {  
    	  //Date
          $("#compaccdate1").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 
          $("#compaccdate2").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
     document.getElementById("datediv").style.display="none";
     document.getElementById("formdet").innerText="Company(COM)";
	 document.getElementById("formdetail").value="Company";
	 document.getElementById("formdetailcode").value="COM";
	 window.parent.formCode.value="COM";
	 window.parent.formName.value="Company";
	 getTimezone();
      });
  
  function funFocus()
  {
  	document.getElementById("txtcompid").focus();
  		
  }
  
  $(function(){
      $('#frmCompany').validate({
               rules: {
               txtcompid:{
            	 required:true,
            	 maxlength:5
               } ,
              txtcompname:"required",
              cmbcurr:"required"/* ,
              txttel1:{
            	  required:true,
            	  digits:true,
            	  maxlength:12,
            	  minlength:12
              } */
              
               },
               messages: {
            	   txtcompid:{
            		   required:" *",
            		   maxlength:"max 5 chars"
            	   },
            	   txtcompname:" *",
            	   cmbcurr:" *"/* ,
            	   txttel1:{
            		   required:" *",
            		   digits:'Digits Only',
            		   maxlength:'Max 12 nos',
            		   minlength:'Min 12 nos'
            	   } */
               }
      });});
   function funNotify(){
  	 var date1 = $('#compaccdate1').jqxDateTimeInput('getDate');
		var date2 = $('#compaccdate2').jqxDateTimeInput('getDate');
  		if(date1>date2){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Accounting To Date cannot be less than From Date"
					$('#compaccdate1').jqxDateTimeInput('focus');
  			return 0;
  		}   
  		document.getElementById("errormsg").innerText="";
  		return 1;
	} 
   
   
  function funSearchLoad(){
		changeContent('companySearch.jsp', $('#window')); 
	 }
     function getCurrency()
	 {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('***');
		        var currItems=items[0].split(",");
		        var curridItems=items[1].split(",");
		        	var optionscurr = '<option value="">--Select--</option>';
		        for ( var i = 0; i < currItems.length; i++) {
		    	   optionscurr += '<option value="' + curridItems[i] + '">' + currItems[i] + '</option>';
		        }
		         $("select#cmbcurr").html(optionscurr);
		        // alert($('#hidcmbcurr').val());
			     $('#cmbcurr').val($('#hidcmbcurr').val()) ;
				   // alert($('#cmbcurr').val());
			    }
		       else
			  {
			  }
	     }
	      x.open("GET","getCurrency.jsp",true);
	     x.send();
	    
        }
     
     
     
     function getTimezone()
	 {
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
		        // alert($('#hidcmbcurr').val());
		        if($('#hidcmbtimezone').val()!=""){
		        	$('#cmbtimezone').val($('#hidcmbtimezone').val()) ;	
		        }
			     
				   // alert($('#cmbcurr').val());
			    }
		       else
			  {
			  }
	     }
	      x.open("GET","getTimezone.jsp",true);
	     x.send();
	    
        }
     
     //Ajax Method for checking Company Id Duplication
function checkcompid(value){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		 	var items=x.responseText;
		 	//alert(items.trim()!='undefine');
		 	if(items.trim()!='undefine'){
		 		document.getElementById("txtcompid").focus();
		 		document.getElementById("errormsg").innerText="Company ID Already Exists";
		 	}
		 	else{
		 		
		 		document.getElementById("errormsg").innerText="";
		 		
		 	}
		    }
	       else
		  {
		  }
     }
      x.open("GET","checkCompid.jsp?code="+value+"&doc="+document.getElementById("docno").value,true);
     x.send();
    
}
 
	function funReadOnly(){
		$('#frmCompany input').attr('readonly', true );
		$('#frmCompany select').attr('disabled', true );
		 $('#compaccdate1').jqxDateTimeInput({ disabled: true}); 
		 $('#compaccdate2').jqxDateTimeInput({ disabled: true});
	}
	function funRemoveReadOnly(){
		$('#frmCompany input').attr('readonly', false );
		$('#frmCompany select').attr('disabled', false );
		$('#compaccdate1').jqxDateTimeInput({ disabled: false}); 
		 $('#compaccdate2').jqxDateTimeInput({ disabled: false});
	}
	
    function setValues(){
    	
    		 if($('#msg').val()!=""){
        		   $.messager.alert('Message',$('#msg').val());
        		  }
    		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    			funSetlabel();
    	
    }
 </script> 
</head>
<body onload="getCurrency();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCompany" action="saveActionCompany" autocomplete="off">

	<jsp:include page="../../../../header.jsp" />
	<br/> 
  
<fieldset >
<table width="100%">
  <tr>
    <td width="13%" align="right">Company</td>
    <td width="11%"><input type="text" id="txtcompid" name="txtcompid" style="width:80%;" value='<s:property value="txtcompid"/>' onblur="checkcompid(this.value);"></td>
    <td colspan="7"><input type="text" id="txtcompname" name="txtcompname" style="width:40%;" value='<s:property value="txtcompname"/>'></td>
  </tr>
  <tr>
    <td align="right">Address</td>
    <td colspan="8"><input type="text" id="txtaddress" name="txtaddress" style="width:50%;" value='<s:property value="txtaddress"/>'></td>
  </tr>
  <tr>
    <td align="right">P.B.No</td>
    <td colspan="8"><input type="text" id="txtpbno" name="txtpbno" style="width:50%;" value='<s:property value="txtpbno"/>'></td>
  </tr>
  <tr>
    <td align="right">Tel</td>
    <td colspan="3"><input type="text" id="txttel1" name="txttel1" style="width:50%;" value='<s:property value="txttel1"/>'></td>
    <td width="11%" align="right">Tel</td>
    <td colspan="4"><input type="text" id="txttel2" name="txttel2" style="width:40%;" value='<s:property value="txttel2"/>'></td>
  </tr>
  <tr>
    <td align="right">Fax</td>
    <td colspan="3"><input type="text" id="txtfax1"  name="txtfax1" style="width:50%;" value='<s:property value="txtfax1"/>'></td>
    <td align="right">Fax</td>
    <td colspan="4"><input type="text" id="txtfax2" name="txtfax2" style="width:40%;" value='<s:property value="txtfax2"/>'></td>
  </tr>
  <tr>
    <td align="right">Email</td>
    <td colspan="8"><input type="email" id="txtemail1" name="txtemail1" style="width:50%;" value='<s:property value="txtemail1"/>'></td>
  </tr>
  <tr>
    <td align="right">Website</td>
    <td colspan="8"><input type="text"  id="txtwebsite" name="txtwebsite" style="width:50%;" value='<s:property value="txtwebsite"/>'></td>
  </tr>
 <%--  <tr>
    <td colspan="4" align="center"><input type="checkbox" id="chckdefault" name="chckdefault" value='<s:property value="chckdefault"/>'/>Default</td>
    <td align="right">SMS No</td>
    <td width="38%"><input type="text" id="txtsmsno" name="txtsmsno" value='<s:property value="txtsmsno"/>'></td>
  </tr>
  <tr>
    <td align="right">Username</td>
    <td colspan="3"><input type="text"  id="txtusername" name="txtusername" style="width:50%;" value='<s:property value="txtusername"/>'></td>
    <td align="right">Password</td>
    <td><input type="text" id="txtpassword" name="txtpassword" value='<s:property value="txtpassword"/>'></td>
  </tr>
  <tr>
    <td align="right">SMS Url</td>
    <td colspan="3"><input type="text"  id="txtsmsurl" name="txtsmsurl" style="width:50%;" value='<s:property value="txtsmsurl"/>'></td>
    <td align="right">Folio Time Delay</td>
    <td><input type="text"  id="txtfoliotime" name="txtfoliotime" value='<s:property value="txtfoliotime"/>'></td>
  </tr>
 --%>  <tr>
    <td align="right">Account Period</td>
    <td><div id="compaccdate1" name="compaccdate1" value='<s:property value="compaccdate1"/>'></div>
        <input type="hidden" id="hidcompaccdate1" name="hidcompaccdate1" value='<s:property value="hidcompaccdate1"/>'/></td>
    <td width="2%" align="center">To</td>
    <td width="11%"><div id="compaccdate2" name="compaccdate2" value='<s:property value="compaccdate2"/>'></div>
    <input type="hidden" id="hidcompaccdate2" name="hidcompaccdate2" value='<s:property value="hidcompaccdate2"/>'/></td>
    <td align="right">Currency</td>
    <td width="8%"><select name="cmbcurr" id="cmbcurr" value='<s:property value="cmbcurr"/>'>
      <option value="">--Select--</option></select>
      </td>
    <td width="9%" align="right">Time Zone</td>
    <td width="28%"><select name="cmbtimezone" id="cmbtimezone" style="width:100%;"><option value="">--Select--</option></select></td>
  </tr>
  <input type="hidden" id="hidcmbcurr" name="hidcmbcurr" value='<s:property value="hidcmbcurr"/>'/>
  <tr>
    <td  align="right">&nbsp;</td>
    <td colspan="3"><div class="style1" id="datediv">
      <div align="right">Please select a valid Date</div>
    </div></td>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td width="7%">&nbsp;</td>
  </tr>
</table>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>

<input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
<input type="hidden" name="hidcmbtimezone" id="hidcmbtimezone" value='<s:property value="hidcmbtimezone"/>' hidden="true"/>
<input type="hidden" id="mode" name="mode"/><br/>
</fieldset>
</form>
 </div>                                  
</body>
</html>