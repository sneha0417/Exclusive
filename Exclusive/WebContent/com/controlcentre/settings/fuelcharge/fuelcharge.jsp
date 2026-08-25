<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
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
</style>
<script type="text/javascript">

 $(document).ready(function () {
	 
   	 $("#masterdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});   
   	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});  
   	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});  
   	 
   	 $("#btnEdit").attr('disabled', true );
   	 $("#btnDelete").attr('disabled', true );
   	$('#todate').on('change', function (event) {
   		if($('#mode').val()=="A")
		{
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   document.getElementById("errormsg").innerText=" To Date Less Than From Date";
				 $('#todate').jqxDateTimeInput('focus');
			 
		   return false;
		  }  
		 	 
		 	 
		   else
			   {
			   document.getElementById("errormsg").innerText="";
			   }
		}
	 });
   	 
	});
        
	  
    function funReset(){
		//$('#frmEnquiry')[0].reset(); 
		
	}
	function funReadOnly(){
	
		$('#frmfuel input').attr('readonly', true );
	
		$('#masterdate').jqxDateTimeInput({ disabled: true});
		$('#fromdate').jqxDateTimeInput({ disabled: true});
		$('#todate').jqxDateTimeInput({ disabled: true});
		$('#docno').attr('readonly', true);
	}
	function funRemoveReadOnly(){
		
		$('#frmfuel input').attr('readonly', false );
		
		$('#masterdate').jqxDateTimeInput({ disabled: false});
		$('#fromdate').jqxDateTimeInput({ disabled: false});
		$('#todate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		
		if($('#mode').val()=="A")
		{
		 $('#fromdate').val(new Date());
		 $('#todate').val(new Date());
		 $('#masterdate').val(new Date());
		}
		
		
		
	}


	       
	       
	function funNotify(){

			
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 
			  // out date
			 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
			 	 
			   if(fromdates>todates){
					document.getElementById("errormsg").innerText=" To Date Less Than From Date";
					 $('#todate').jqxDateTimeInput('focus');
				     
				 
			           return 0;
			  }   
			   else{
					 document.getElementById("errormsg").innerText="";
				}
	
		   var petrolchg=document.getElementById("petrolcharge").value;
			
			if(parseFloat(petrolchg)<=0 ||petrolchg=="")
				{
				document.getElementById("errormsg").innerText=" Enter Petrol Charge";
				document.getElementById("petrolcharge").focus();  
				return 0;
				}
			else{
				 document.getElementById("errormsg").innerText="";
			}
			 
			   var deisal=document.getElementById("deccharge").value;
				
				if(parseFloat(deisal)<=0 ||deisal=="" )
					{
					document.getElementById("errormsg").innerText=" Enter Diesel Charge";
					document.getElementById("deccharge").focus();  
					return 0;
					}
				else{
					 document.getElementById("errormsg").innerText="";
				}
      return 1;
	} 

	function funChkButton() {
		
		//frmEnquiry.submit();
	}

	function funSearchLoad(){
		 changeContent('masterSearch.jsp'); 
	}

		
	function funFocus(){
		 
		$('#fromdate').jqxDateTimeInput('focus'); 
	   
	   
	}

	
	
	 
	 
	function setValues() {
	
	
		
		if($('#hidmaster').val()){
			$("#masterdate").jqxDateTimeInput('val', $('#hidmaster').val());
		}
		if($('#hidfrmdate').val()){
			$("#fromdate").jqxDateTimeInput('val', $('#hidfrmdate').val());
		}
	
		if($('#hidtodate').val()){
			$("#todate").jqxDateTimeInput('val', $('#hidtodate').val());
		}
	
	
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
	    }
		
	
	
		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		funSetlabel();
		
		
		
		
		
	}

    function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
        	{
     	   document.getElementById("errormsg").innerText=" Enter Numbers Only";  
           
            return false;
        	}
        document.getElementById("errormsg").innerText="";  
        return true;
    }	
	
	
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmfuel" action="savefuelcharge" autocomplete="OFF" >

<jsp:include page="../../../../header.jsp"></jsp:include><br/><br/>
<fieldset>
<legend>Fuel Charge</legend>
<br/>
<br/>
<table  width="100%">
<tr >
<td align="right">Date</td><td><div id='masterdate' name='masterdate' value='<s:property value="masterdate"/>'></div> </td>  
<td align="right">From Date</td>
<td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div> </td>                       
<td align="right">To Date</td>
<td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div> </td>
<td align="right">Doc No</td>
<td><input type="text" id="docno" name="docno" tabindex="-1" readonly="readonly" value='<s:property value="docno"/>' /></td>
</tr>

<%-- <tr>
<td>&nbsp; </td>
<td>&nbsp;</td>
<td align="right">From Date</td>
<td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div> </td>
<td align="right">To Date</td>
<td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div> </td>
<td>&nbsp; </td>
<td>&nbsp;</td>
</tr> --%>
</table>
<br/>
<br/>
</fieldset>
<table width="100%">
<tr>

<td>

<fieldset style="background-color:#ECF8E0"> 
<legend><b>Petrol Fuel Charge</b></legend> 
<table  width="100%">

<tr >
<td align="right">Fuel price/litre</td><td><input type="text" id="petrolcharge" name="petrolcharge" value='<s:property value="petrolcharge"/>'  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);" /></td>
</tr>
</table>
<br/>
<br/>
</fieldset>
</td>
<td>

<fieldset style="background-color:#ffe4e1;">
<legend><b>Diesel Fuel Charge</b></legend>
<table  width="100%">
<tr >
<td align="right">Fuel price/litre</td><td><input type="text" id="deccharge" name="deccharge" value='<s:property value="deccharge"/>'  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);" /></td>
</tr>
</table>
<br/>
<br/>
</fieldset>
</td>
</tr>
</table>

<input type="hidden" id="hidmaster" name="hidmaster" value='<s:property value="hidmaster"/>' /> 
<input type="hidden" name="hidfrmdate" id="hidfrmdate" value='<s:property value="hidfrmdate"/>' />
<input type="hidden" id="hidtodate" name="hidtodate"  value='<s:property value="hidtodate"/>'/>


<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>


</form>


</div>
</body>
</html>