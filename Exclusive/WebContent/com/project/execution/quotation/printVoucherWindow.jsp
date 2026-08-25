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

 	function printHeaderVoucher() {

        var url=document.URL;
        var reurl=url.split("saveBankReceipt");
        $("#docno").prop("disabled", false);  
        
        var win= window.open(reurl[0]+"printBankReceipt?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	    win.focus();
				
 	}
 	
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
		     
		  	  /*  var win= window.open(reurl[0]+"printQuotation?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&id="+id+"&header=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
			     win.focus(); */
			     
		    /*   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){ */
						  var win= window.open(reurl[0]+"printQuotation?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&id="+id+"&header=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
					     win.focus();  
					     
					     /*  var win= window.open(reurl[0]+"printQuotationJasper?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&id="+id+"&header=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
					     win.focus();  */
					     
					/*  }
					else{ */
						/*  var win= window.open(reurl[0]+"printQuotation?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&id="+id+"&header=0","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
					    win.focus();  */
				//new	 
				/*  var win= window.open(reurl[0]+"printQuotationJasper?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&id="+id+"&header=0","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
						    win.focus(); 
						    */
					    
					    
				/* 	}
		        });  */
		    
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

</script>
</head>
<body >
<div id=search>
<br/><br/><br/><br/><br/><br/>
<table width="100%">
  <tr>
    <td align="center"><input type="button" name="btnvoucherhead" id="btnsjobamt" class="myButton" value="Print(With UnitPrice)"  onclick="funPrint(1);"></td>
    <td align="center"><input type="button" name="btncheque" id="btnamc" class="myButton" value="Print"  onclick="funPrint(0);"></td> 
    <td align="center"><input type="button" name="btnvoucherwithouthead" id="btnsjobwoamt" class="myButton" value="Print(WithOut UnitPrice)"  onclick="funPrint(2);"></td>
  </tr>
</table>
<br/><br/><br/><br/><br/><br/>
  </div>
</body>
</html>