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
      });
  </script>
  <script>
  function funFocus()
  {
  	document.getElementById("txtcompid").focus();
  		
  }
  function funReset(){
  	document.getElementById("frmCompany").reset();
  }
  $(function(){
      $('#frmCompany').validate({
               rules: {
               txtcompid: "required",
              txtcompname:"required",
              cmbcurr:"required"
               },
               messages: {
            	   txtcompid: " *",
            	   txtcompname:" *",
            	   cmbcurr:" *"
               }
      });});
   function funNotify(){
  	 var date1 = $('#compaccdate1').jqxDateTimeInput('getDate');
		var date2 = $('#compaccdate2').jqxDateTimeInput('getDate');
  		if(date1>date2){
				document.getElementById("datediv").style.display="block";
  			return 0;
  		}   
  		document.getElementById("datediv").style.display="none";
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

    function funReset(){
		$('#frmCompany')[0].reset(); 
	}
	function funReadOnly(){
		$('#frmCompany input').attr('readonly', true );
		/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly(){
		$('#frmCompany input').attr('readonly', false );
		//$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: false});
	}
	
    function setValues(){
    	 if($('#hidcompaccdate1').val()){
    			$("#compaccdate1").jqxDateTimeInput('val', $('#hidcompaccdate1').val());
    		}
    		if($('#hidcompaccdate2').val()){
    			$("#compaccdate2").jqxDateTimeInput('val', $('#hidcompaccdate2').val());
    		}
	    if(<%=!(request.getAttribute("SAVED")==null) || !(request.getAttribute("SAVED")=="") %>){
			 <%System.out.println("request.getAttribute(SAVED)"+request.getAttribute("SAVED"));%>
				if(<%=(request.getAttribute("SAVED")=="Successfully Saved") || (request.getAttribute("SAVED")=="Updated Successfully") || (request.getAttribute("SAVED")=="Successfully Deleted")%>){
					$('#eventWindowSuccess').jqxWindow('open'); 
				}
				if(<%=(request.getAttribute("SAVED")=="Not Saved") || (request.getAttribute("SAVED")=="Not Updated") || (request.getAttribute("SAVED")=="Not Deleted")%>){
					$('#eventWindowFailure').jqxWindow('open');
				}
			}
    }
 </script> 
</head>
<body onload="funReadOnly();getCurrency();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCompany" action="saveActionCompany" >
<%  session.setAttribute("FormName", "Company");
		session.setAttribute("Code", "COM"); %>
<jsp:include page="../../../../header.jsp" /><br/>     
<fieldset >
<table width="100%">
  <tr>
    <td width="17%" align="right">Company</td>
    <td width="14%"><input type="text" id="txtcompid" name="txtcompid" style="width:80%;" value='<s:property value="txtcompid"/>'></td>
    <td colspan="5"><input type="text" id="txtcompname" name="txtcompname" style="width:40%;" value='<s:property value="txtcompname"/>'></td>
  </tr>
  <tr>
    <td align="right">Address</td>
    <td colspan="6"><textarea id="txtaddress" name="txtaddress" style="width:50%;resize: none;" value='<s:property value="txtaddress"/>'><s:property value="txtaddress"/></textarea></td>
  </tr>
  <tr>
    <td align="right">P.B.No</td>
    <td colspan="6"><input type="text" id="txtpbno" name="txtpbno" style="width:50%;" value='<s:property value="txtpbno"/>'></td>
  </tr>
  <tr>
    <td align="right">Tel</td>
    <td colspan="3"><input type="text" id="txttel1" name="txttel1" style="width:50%;" value='<s:property value="txttel1"/>'></td>
    <td width="12%" align="right">Tel</td>
    <td colspan="2"><input type="text" id="txttel2" name="txttel2" style="width:40%;" value='<s:property value="txttel2"/>'></td>
  </tr>
  <tr>
    <td align="right">Fax</td>
    <td colspan="3"><input type="text" id="txtfax1"  name="txtfax1" style="width:50%;" value='<s:property value="txtfax1"/>'></td>
    <td align="right">Fax</td>
    <td colspan="2"><input type="text" id="txtfax2" name="txtfax2" style="width:40%;" value='<s:property value="txtfax2"/>'></td>
  </tr>
  <tr>
    <td align="right">Email</td>
    <td colspan="6"><input type="email" id="txtemail1" name="txtemail1" style="width:50%;" value='<s:property value="txtemail1"/>'></td>
  </tr>
  <tr>
    <td align="right">Website</td>
    <td colspan="6"><input type="text"  id="txtwebsite" name="txtwebsite" style="width:50%;" value='<s:property value="txtwebsite"/>'></td>
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
    <td width="4%" align="center">To</td>
    <td width="15%"><div id="compaccdate2" name="compaccdate2" value='<s:property value="compaccdate2"/>'></div>
    <input type="hidden" id="hidcompaccdate2" name="hidcompaccdate2" value='<s:property value="hidcompaccdate2"/>'/></td>
    <td align="right">Currency</td>
    <td><select name="cmbcurr" id="cmbcurr" value='<s:property value="cmbcurr"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcurr" name="hidcmbcurr" value='<s:property value="hidcmbcurr"/>'/></td>
  </tr>
  <tr>
    <td  align="right">&nbsp;</td>
    <td colspan="3"><div class="style1" id="datediv">
      <div align="right">Please select a valid Date</div>
    </div></td>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>

<input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'>
<input type="text" name="delete" id="delete" value='<s:property value="delete"/>' hidden="true"/>
<input type="hidden" id="mode" name="mode"/><br/>
</fieldset>
</form>
 </div>                                  
</body>
</html>