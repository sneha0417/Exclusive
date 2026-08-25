<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">
	$(document).ready(function () {    
	    $("#date").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" ,value:new Date()});
	   // $("#dateupto").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy",value:null});
	    $("#dateupto").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy",value:null});
	    $("#yclosedate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy",value:null });
	   
	 /*    $('#yclosedate').on('change', function (event) 
	    		{  
	    		    checkDate(); 
	    		});  */
	   /*  $('#yclosedate').focusout(function(){
	    	 checkDate(); 
	    	 $('#yclosedate').jqxDateTimeInput('focus');
	    }); */
	    
	    
	    
	    
		  $('#yclosedate').focusout(function(){
	    
	    if($('#yclosedate').jqxDateTimeInput('getDate')<=$('#dateupto').jqxDateTimeInput('getDate')){
    		document.getElementById("errormsg").innerText="";
    		document.getElementById("errormsg").innerText="Year Close Date Cannot be less than Upto Date";
    		return 0;
    	}
	    else
	    	{
	    	document.getElementById("errormsg").innerText="";
	    	}
	    
		  });
	    
	    
        });
	
	function getUptodate(){
		
		var year = window.parent.txtaccountperiodto.value;
		
	// var closedate=new Date(year);
		
		// var lastday=new Date(new Date(closedate).setMonth(closedate.getMonth()+1)); 
		
    //	var lastday= new Date(closedate.getFullYear(), closedate.getMonth() + 1).getDate();
		
		
/* 		   var newDate = lastday.split('-');
		   year = newDate[1] + "-" + newDate[0] + "-" + newDate[2];
		   $('#dateupto').jqxDateTimeInput('setDate', new Date(year));
		   
		   
		   var dateout = $('#dateupto').jqxDateTimeInput('getDate');
		   //alert("dateout"+dateout);
		 //  var plusoneday=new Date(new Date(dateout).setDate(dateout.getDate()+1));
		   
		   var onemounth=new Date(new Date(dateout).setMonth(dateout.getDate()+1)); 
		    
           $('#dateupto').jqxDateTimeInput('setDate', new Date(onemounth)); */

		
		//alert(document.getElementById("brchName").value);
	<%-- var	items='<%=session.getAttribute("STYEAR")%>';
		
		alert(items);
		//	var items = x.responseText.trim();
		
		if(items!=null){
			
			$('#dateupto').val(items);
		}
		else{
			$('#dateupto').jqxDateTimeInput('val',null); 
		} --%>
 	var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				
				if(items!=null){
					
					$('#dateupto').jqxDateTimeInput('val',new Date(items)); 
	  
				}
				
				else
					{
					$('#dateupto').jqxDateTimeInput('val',null); 
					}
				
				
			} else {
			}
		}
		x.open("GET", "getDateUpto.jsp?year="+year, true);
		x.send();  
		
	}
	function funSearchLoad(){
		changeContent('yearCloseSearch.jsp?branch='+document.getElementById("brchName").value, $('#window')); 
	 }

	function funReadOnly() {
		$('#frmYearClose input').attr('readonly', true);
		$('#dateupto').jqxDateTimeInput({disabled:true});
		$('#date').jqxDateTimeInput({disabled:true});
		$('#yclosedate').jqxDateTimeInput({disabled:true});
		
	}
	function funRemoveReadOnly() {
		$('#frmYearClose input').attr('readonly', false);
		$('#yclosedate').jqxDateTimeInput({disabled:false});
		$('#docno').attr('readonly', true);
		if(document.getElementById("mode").value=="A"){
			$('#date').jqxDateTimeInput('setDate',new Date());
			$('#dateupto').jqxDateTimeInput('setDate',null);
			$('#yclosedate').jqxDateTimeInput('setDate',null);
			getUptodate();
		}
		if(document.getElementById("mode").value=="D"){
		
			
			$('#dateupto').jqxDateTimeInput({disabled:false});
			$('#date').jqxDateTimeInput({disabled:false});
			$('#yclosedate').jqxDateTimeInput({disabled:false});	
			
		}
		
		
	}

	function setValues() {
		// getUptodate();
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
	}
	
	/*  $(function(){
	        $('#frmBrand').validate({
	                 rules: {
	                 brand: {
	                	 required:true,
	                	 maxlength:40
	                 }
	                 },
	                 messages: {
	                  brand: {
	                	  required:" *",
	                	  maxlength:"max 40 only"
	                  } 
	                 }
	        });}); */
	     function funNotify(){
	    
	        	if($('#yclosedate').jqxDateTimeInput('getDate')==null){
	        		document.getElementById("errormsg").innerText="";
	        		document.getElementById("errormsg").innerText="Year Close Date  is Mandatory";
	        		return 0;
	        	}
	        	if($('#dateupto').jqxDateTimeInput('getDate')==null){
	        		document.getElementById("errormsg").innerText="";
	        		document.getElementById("errormsg").innerText="Year Close Date  is Mandatory";
	        		return 0;
	        	}
	        	if($('#yclosedate').jqxDateTimeInput('getDate')<=$('#dateupto').jqxDateTimeInput('getDate')){
	        		document.getElementById("errormsg").innerText="";
	        		document.getElementById("errormsg").innerText="Year Close Date Cannot be less than Upto Date";
	        		return 0;
	        	}
	        //	checkDate();
	        	$('#dateupto').jqxDateTimeInput({disabled:false});
	    		$('#date').jqxDateTimeInput({disabled:false});
	    		return 1;
		} 
	     function funFocus(){
	    	 $('#yclosedate').jqxDateTimeInput('focus');
	     }
	  function checkDate(){
		/*   var closedate=new Date($('#yclosedate').jqxDateTimeInput('getDate'));
      	var lastday= new Date(closedate.getFullYear(), closedate.getMonth() + 1, 0).getDate();
      	var currentday=new Date($('#yclosedate').jqxDateTimeInput('getDate')).getDate();
      	
      	if(lastday!=currentday){
      		document.getElementById("errormsg").innerText="";
      		document.getElementById("errormsg").innerText="Year Close Date must be at Month End";
      		 $('#yclosedate').jqxDateTimeInput('focus');
      		return false;
      	}
      	else{
      		document.getElementById("errormsg").innerText="";
      		return true;
      	} */
	  }
</script>  
 
</head>
<body onLoad="setValues();" >
<form id="frmYearClose" action="saveYearClose"  autocomplete="off">
	<jsp:include page="../../../../header.jsp" />
	
	<br>
	<fieldset><legend>Year Close Details</legend>
	<table width="100%">
  <tr>
    <td width="8%" align="right">Date</td>
    <td width="12%" align="left"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
    <td width="14%">&nbsp;</td>
    <td align="right">Doc No</td>
    <td align="left"> <input type="text" name="docno" id="docno" value='<s:property value="docno"/>'></td> 
   
    <td width="10%" align="right">&nbsp;</td>
    <td width="11%" align="left">&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Period Upto</td>
    <td align="left"><div id="dateupto" name="dateupto" value='<s:property value="dateupto"/>'></div></td>
    <td>&nbsp;</td>
    <td width="19%" align="right">Year Close Date</td>
    <td width="26%" align="left"><div id="yclosedate" name="yclosedate" value='<s:property value="yclosedate"/>'></div></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</fieldset>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
</form>
</body>
</html>