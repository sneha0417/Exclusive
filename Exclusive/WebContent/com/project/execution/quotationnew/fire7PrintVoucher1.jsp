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
 	
 	  function funPrint(id) {
			

				 $("#docno").prop("disabled", false);
				 $("#masterdoc_no").prop("disabled", false);
				 $("#formdetailcode").prop("disabled", false);
				 
				var docno=$('#docno').val();
		  		var trno=$('#masterdoc_no').val();
		  		var dtype=$('#formdetailcode').val();
		  		var brhid=<%= session.getAttribute("BRANCHID").toString()%>
		  		var url=document.URL;
		  		//alert("=url==="+url);
		  		var reurl=url.split("com/"); 
		  		var hedderstat=$('#hedderstat').val();
		  		var reviseno=$("#txtrevise").val();
		  		//var upstat=$("#upstatus").val();
		  		
		  		if(hedderstat==""){
		  			$.messager.alert('Message','Select Options...','warning');
		  			return false;
		  		}
		     
		  	  
						  var win= window.open(reurl[0]+"printQuotationnew?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&id="+id+"&hedderstat="+hedderstat+"&header=1"+"&reviseno="+reviseno,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
					     win.focus();  
			
		    
  }
 	
  	function hidedat(){
 		
 		var contrtype=document.getElementById("hidradio").value;
 		if(contrtype=='AMC'){
 			
 			 $("#btnamc").show();
 			 $("#btnsjobamt").hide();
 			 $("#btnsjobwoamt").hide();
 			  	
 		}
 		
 		if(contrtype=='SJOB'){
 			 $("#btnamc").hide();
 			 $("#btnsjobamt").show();
 			 $("#btnsjobwoamt").show();
 			
 		}
 		
 	} 
/* function funupcheck(){
 		if(document.getElementById("rdbwithup").checked){
 			$('#upstatus').val("1");
 		}
 		if(document.getElementById("rdbwithoutup").checked){
 			$('#upstatus').val("0");
 		}
 	} */
function funcheck(){
	if(document.getElementById("rdbhdrshow").checked){
			$('#hedderstat').val("1");
		}
		if(document.getElementById("rdbhdrhide").checked){
			$('#hedderstat').val("0");
		}
}
</script>
</head>
<body >
<div id=search>
<br/><br/><br/><br/>
<table width="100%">
  <tr>
  
  	<td align="right" width="50%"><input type="radio" id="rdbhdrshow" name="rdo" onchange="funcheck();" value="Show Headder">With Headder</td>
    
    <td  align="left" width="50%"><input type="radio" id="rdbhdrhide" name="rdo" onchange="funcheck();" value="Hide Headder">Without Headder
    <input type="hidden" id="hedderstat" name="hedderstat" value='<s:property value="hedderstat"/>' /></td>
    
    </tr>
    <tr></tr>
	<%-- <tr>
	<td align="right"><input type="radio" id="rdbwithup" name="rdobtn" onchange="funupcheck();" value="With Unitprice">With Unitprice</td>
    <td  align="left"><input type="radio" id="rdbwithoutup" name="rdobtn" onchange="funupcheck();" value="Without Unitprice">Without Unitprice
    <input type="hidden" id="upstatus" name="upstatus" value='<s:property value="upstatus"/>' /></td>
	</tr>  --%> 
	<tr></tr>
	</table>
	<table width="100%">
	<tr>
	<td></td>
	 <td align="center" width="33%"><input type="button" name="btncheque" id="btnamc" class="myButton" value="Print"  onclick="funPrint(0);"></td>
	<td></td>
	</tr>
	
    <tr >
    
    <td align="center"  width="33%"><input type="button" name="btnvoucherhead" id="btnsjobamt" class="myButton" value="Print(With UnitPrice)"  onclick="funPrint(1);"></td>
    <td align="center"  width="33%"><input type="button" name="btngroupby" id="btngroupby" class="myButton" value="Print (Grouped)"  onclick="funPrint(3);"></td>
    
    <td align="center"  width="34%"><input type="button" name="btnvoucherwithouthead" id="btnsjobwoamt" class="myButton" value="Print(WithOut UnitPrice)"  onclick="funPrint(2);"></td> 
  </tr>
</table>
<br/><br/><br/><br/><br/><br/>
  </div>
</body>
</html>