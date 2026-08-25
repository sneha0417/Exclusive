 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<%-- <script type="text/javascript" src="<%=contextPath%>/js/jquery-1.11.1.min.js"></script>  --%>
<title>GatewayERP(i)</title>

<script type="text/javascript">
	
$(document).ready(function () { 
	hidedat();
});

 	/* function printHeaderVoucher() {

        var url=document.URL;
        var reurl=url.split("saveBankReceipt");
        $("#docno").prop("disabled", false);  
        
        var win= window.open(reurl[0]+"printBankReceipt?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	    win.focus();
				
 	} */
 	
 	
 	
 	
 	  function funPrint() {
			
				 $("#docno").prop("disabled", false);
				 $("#masterdoc_no").prop("disabled", false);
				 $("#formdetailcode").prop("disabled", false);
				 
				var branchval = document.getElementById("cmbbranch").value;
				var fromdate = $('#fromdate').val();
				var todate = $('#todate').val();
				var xlstat=$('#xlstat').val(); 
				
				var url=document.URL;
				var reurl=url.split("com/");
			
				var path= "com/dashboard/accounts/profitloss/profitlosslist.action?branchval="+branchval+'&fromdate='+fromdate+'&xlstat='+xlstat+'&todate='+todate;
				var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
				  	            win.focus();
				
				if(xlstat==""){
			  			$.messager.alert('Message','Select a Brand option...','warning');
			  		}
				<%-- var docno=$('#docno').val();
		  		var trno=$('#masterdoc_no').val();
		  		var dtype=$('#formdetailcode').val();
		  		var brhid=<%= session.getAttribute("BRANCHID").toString()%>
		  		var url=document.URL;
		  		//alert("=url==="+url);
		  		//var reurl=url.split("com/"); 
		  		var hedderstat=$('#hedderstat').val();
		  		var reviseno=$("#txtrevise").val();
		  		var brandstat=$("#brandstat").val();
		  		var totalstat=$("#totalstat").val();
		  		var wouptotstat=$("#wouptotstat").val();
		  		var cmprhnstat=$("#cmprhnstat").val();
		  		

		  		if(totalstat==""){
		  			$.messager.alert('Message','Select a Total Option...','warning');
		  			return false;
		  		}
		  		if(brandstat==""){
		  			$.messager.alert('Message','Select a Brand option...','warning');
		  		}
		  		
		  		if(wouptotstat==""){
		  			$.messager.alert('Message','Select a Total Option...','warning');
		  			return false;
		  		}
		  		
		  		if(hedderstat==""){
		  			$.messager.alert('Message','Select a Headder Option...','warning');
		  			return false;
		  		}
		  		if(cmprhnstat==""){
		  			$.messager.alert('Message','Select a Comprehensive Option...','warning');
		  			return false;
		  		}
		  	  
				var win= window.open(reurl[0]+"profitlosslist?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&id="+id+"&hedderstat="+hedderstat+"&header=1"+"&reviseno="+reviseno+"&totalstat="+totalstat+"&brandstat="+brandstat+"&xlstat="+xlstat+"&cmprhnstat="+cmprhnstat,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
				win.focus();   --%>
			
		    
  }
 	
  	function hidedat(){
 		
 		var contrtype=document.getElementById("hidradio").value;
 		
 		 $("#btngroupby").show();
 		 $("#rdbnxlhide").show();
 		 $("#rdbnxlshow").show();
 	
 	} 
/* function funupcheck(){
 		if(document.getElementById("rdbwithup").checked){
 			$('#upstatus').val("1");
 		}
 		if(document.getElementById("rdbwithoutup").checked){
 			$('#upstatus').val("0");
 		}
 	} */
 	
 	function funxlshowcheck(){
 		if(document.getElementById("rdbnxlshow").checked){
 				$('#xlstat').val("0");
 			}
 			if(document.getElementById("rdbnxlhide").checked){
 				$('#xlstat').val("1");
 			}
 	}
	//alert("xlstat=="+xlstat)


</script>
</head>
<body >
<div id=search>
</br>
<!-- <br/><br/><br/><br/> -->
<table width="100%">

    <tr>
    <td colspan="2" align="right" width="50%"><input type="radio" id="rdbnxlshow" name="rdbnxl" onchange="funxlshowcheck();" value="Show xl" checked="checked">&nbsp;<label id="lblwithoutxl">Print</label></td>
    
    <td  align="left" width="50%"><input type="radio" id="rdbnxlhide" name="rdbnxl" onchange="funxlshowcheck();" value="Hide xl" ><label id="lblwithxl">With Excel</label>
    							  <input type="hidden" id="xlstat" name="xlstat" value="0" /></td>
    
    </tr>
    <tr >
    <td colspan="3" align="center"  width="33%"><input type="button" name="btngroupby" id="btngroupby" class="myButton" value="Print "  onclick="funPrint();"></td> 
    </tr>
	</table>
	
<br/><br/><br/><br/><br/><br/>
 </div>
</body>
</html>