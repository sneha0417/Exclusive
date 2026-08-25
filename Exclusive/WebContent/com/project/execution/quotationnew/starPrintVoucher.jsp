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
		  		var brandstat=$("#brandstat").val();
		  		var totalstat=$("#totalstat").val();
		  		
		  		if(totalstat==""){
		  			$.messager.alert('Message','Select a Total Option...','warning');
		  			return false;
		  		}
		  		if(brandstat==""){
		  			$.messager.alert('Message','Select a Brand option...','warning');
		  		}
		  		
		  		if(hedderstat==""){
		  			$.messager.alert('Message','Select a Headder Option...','warning');
		  			return false;
		  		}
		  		//alert("unitprice"+unitpricestat);
		  	  
						  var win= window.open(reurl[0]+"printQuotationnewtaxstar?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&id="+id+"&hedderstat="+hedderstat+"&header=1"+"&reviseno="+reviseno+"&totalstat="+totalstat+"&brandstat="+brandstat,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
						 
						  win.focus();  
			
		    
  }
 	
  	function hidedat(){
 		
 		var contrtype=document.getElementById("hidradio").value;
 		if(contrtype=='AMC'){
 			
 			 $("#btnamc").show();
 			// $("#btngroupby").hide();
 			 $("#btnsjobamt").hide();
 			 $("#btnsjobwoamt").hide();
 			 
 			 $("#rdbntotalhide").hide();
 			 $("#rdbntotalshow").hide();
 			 
 			 $("#rdbnbrandhide").hide();
 			 $("#rdbnbrandshow").hide();
 			 
 			 $("#lblwithtotal").hide();
 			 $("#lblwithouttotal").hide();
 			 $("#lblwithbrand").hide();
 			 $("#lblwithoutbrand").hide();
 			  	
 		}
 		
 		if(contrtype=='SJOB'){
 			
 			 //$("#btngroupby").show();
 			 $("#btnamc").hide();
 			 $("#btnsjobamt").show();
 			 $("#btnsjobwoamt").show();
 			 
 			 $("#rdbntotalhide").show();
 			 $("#rdbntotalshow").show();
 			 		 
 			 $("#rdbnbrandhide").show();
 			 $("#rdbnbrandshow").show();
 			
 			 $("#lblwithtotal").show();
			 $("#lblwithouttotal").show();
			 $("#lblwithbrand").show();
			 $("#lblwithoutbrand").show();
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
 	function funbrandshowcheck(){
 		if(document.getElementById("rdbnbrandshow").checked){
 				$('#brandstat').val("1");
 			}
 			if(document.getElementById("rdbnbrandhide").checked){
 				$('#brandstat').val("0");
 			}
 	}
 	function funtotshowcheck(){
 		if(document.getElementById("rdbntotalshow").checked){
 				$('#totalstat').val("1");
 			}
 			if(document.getElementById("rdbntotalhide").checked){
 				$('#totalstat').val("0");
 			}
 	}
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
  
  	<td align="right" width="50%"><input type="radio" id="rdbhdrshow" name="rdo" onchange="funcheck();" value="Show Headder" checked="checked">With Headder</td>
    
    <td  align="left" width="50%"><input type="radio" id="rdbhdrhide" name="rdo" onchange="funcheck();" value="Hide Headder">Without Headder
    </td> 
     <td><input type="hidden" id="hedderstat" name="hedderstat" value="1" /></td>
    
    </tr>
    <tr>
    <td align="right" width="50%"><input type="radio" id="rdbntotalshow" name="rdbntot" onchange="funtotshowcheck();" value="Show Total" checked="checked"><label id="lblwithtotal">With Total</label></td>
    
    <td  align="left" width="50%"><input type="radio" id="rdbntotalhide" name="rdbntot" onchange="funtotshowcheck();" value="Hide Total" ><label id="lblwithouttotal">Without Total</label>
    							  <input type="hidden" id="totalstat" name="totalstat" value="1" /></td>
    
    </tr>
      <tr>
    <td align="right" width="50%"><input type="radio" id="rdbnbrandshow" name="rdbnbrand" onchange="funbrandshowcheck();" value="Show Brand" checked="checked">&nbsp;<label id="lblwithbrand">With Brand</label></td>
    
    <td  align="left" width="50%"><input type="radio" id="rdbnbrandhide" name="rdbnbrand" onchange="funbrandshowcheck();" value="Hide Brand" ><label id="lblwithoutbrand">Without Brand</label>
    							  <input type="hidden" id="brandstat" name="brandstat" value="1" /></td>
    
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
	  	<td>
		</td>
	 <td align="center" width="33%"><input type="button" name="btncheque" id="btnamc" class="myButton" value="Print"  onclick="funPrint(0);"></td>
	<td></td>
	</tr>
    <tr >
    <td align="center"  width="33%"><input type="button" name="btnvoucherhead" id="btnsjobamt" class="myButton" value="Print(With UnitPrice)"  onclick="funPrint(1);"></td>
    <td align="center"  width="33%"><input type="button" name="btngroupby" id="btngroupby" class="myButton" value="Print (Grouped)"  onclick="funPrint(3);"></td>
    <td align="center"  width="34%"><input type="button" name="btnvoucherwithouthead" id="btnsjobwoamt" class="myButton" value="Print(WithOut UnitPrice)" onChange="funupcheck();" onclick="funPrint(2);"></td> 
  </tr>
</table>
<br/><br/><br/><br/><br/><br/>
  </div>
</body>
</html>