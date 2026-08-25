<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style type="text/css">

.tablereceipt {
    border: 1px solid rgb(139,136,120);
    border-collapse: collapse;
}

fieldSet {
  		-webkit-border-radius: 8px;
  		-moz-border-radius: 8px;
  		border-radius: 8px;
  		border: 1px solid rgb(139,136,120);
  }

legend{
        border-style:none;
        background-color:#FFF;
        padding-left:1px;
    }
    
hr { 
   		border-top: 1px solid #e1e2df  ;
    }  
    
#preparedby table { page-break-inside:avoid; }
    
</style>

<script type="text/javascript">
	
	function hidedata(){
		
		var first=document.getElementById("firstarray").value;
		var sec=document.getElementById("secarray").value;
		var header=document.getElementById("txtheader").value;
		
		if(parseInt(header)==1){
		   $("#headerdiv").prop("hidden", false);
		   $("#withoutHeaderDiv").attr("hidden", true);
		}
		else{
			$("#headerdiv").prop("hidden", true);
			$("#withoutHeaderDiv").attr("hidden", false);
		}
	
		if(parseInt(first)==1){
			   $("#firstdiv").prop("hidden", false);
			   var rows = $( "#applying tbody tr").length;
			   
			   if(rows=="2"){
			   if($( "#applying tbody tr:eq(2)")){
					 
					 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
					 $( "#accounting tbody tr:nth-child(22)").after(head.clone());
					 
					 if($( "#accounting tbody tr:gt(22)")){
						 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
						 $( "#accounting tbody tr:nth-child(59n)").after(head.clone());
					 }
					 
				 }  
			   }
			   else if(rows=="3"){
			  
				   if($( "#applying tbody tr:eq(3)")){
					 
					 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
					 $( "#accounting tbody tr:nth-child(21)").after(head.clone());
					 
					 if($( "#accounting tbody tr:gt(21)")){
						 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
						 $( "#accounting tbody tr:nth-child(59n)").after(head.clone());
					 }
				 } 
			   } else if(rows=="4"){
				   
				   if($( "#applying tbody tr:eq(4)")){
						 
						 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
						 $( "#accounting tbody tr:nth-child(20)").after(head.clone());
						 
						 if($( "#accounting tbody tr:gt(20)")){
							 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
							 $( "#accounting tbody tr:nth-child(59n)").after(head.clone());
						 }
				   } 
				} else if(rows=="5"){
					   
					   if($( "#applying tbody tr:eq(5)")){
							 
							 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
							 $( "#accounting tbody tr:nth-child(19)").after(head.clone());
							 
							 if($( "#accounting tbody tr:gt(19)")){
								 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
								 $( "#accounting tbody tr:nth-child(59n)").after(head.clone());
							 }
					   } 
				} else if(rows=="6"){
					   
					   if($( "#applying tbody tr:eq(6)")){
							 
							 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
							 $( "#accounting tbody tr:nth-child(18)").after(head.clone());
							 
							 if($( "#accounting tbody tr:gt(18)")){
								 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
								 $( "#accounting tbody tr:nth-child(59n)").after(head.clone());
							 }
					   } 
				} else if(rows=="7"){
					   
					   if($( "#applying tbody tr:eq(7)")){
							 
							 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
							 $( "#accounting tbody tr:nth-child(17)").after(head.clone());
							 
							 if($( "#accounting tbody tr:gt(17)")){
								 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
								 $( "#accounting tbody tr:nth-child(59n)").after(head.clone());
							 }
					   } 
				} else if(rows=="8"){
					   
					   if($( "#applying tbody tr:eq(8)")){
							 
							 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
							 $( "#accounting tbody tr:nth-child(16)").after(head.clone());
							 
							 if($( "#accounting tbody tr:gt(16)")){
								 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
								 $( "#accounting tbody tr:nth-child(59n)").after(head.clone());
							 }
					   } 
				} else if(rows=="9"){
					   
					   if($( "#applying tbody tr:eq(9)")){
							 
							 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
							 $( "#accounting tbody tr:nth-child(15)").after(head.clone());
							 
							 if($( "#accounting tbody tr:gt(15)")){
								 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
								 $( "#accounting tbody tr:nth-child(59n)").after(head.clone());
							 }
					   } 
				} else if(rows=="10"){
					   
					   if($( "#applying tbody tr:eq(10)")){
							 
							 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
							 $( "#accounting tbody tr:nth-child(14)").after(head.clone());
							 
							 if($( "#accounting tbody tr:gt(14)")){
								 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
								 $( "#accounting tbody tr:nth-child(59n)").after(head.clone());
							 }
					   } 
				} else if(rows=="11"){
					   
					   if($( "#applying tbody tr:eq(11)")){
							 
							 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
							 $( "#accounting tbody tr:nth-child(13)").after(head.clone());
							 
							 if($( "#accounting tbody tr:gt(13)")){
								 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
								 $( "#accounting tbody tr:nth-child(59n)").after(head.clone());
							 }
					   } 
				} else if(rows=="12"){
					   
					   if($( "#applying tbody tr:eq(12)")){
						   
							 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
							 $( "#accounting tbody tr:nth-child(13)").after(head.clone());
							 
							 if($( "#accounting tbody tr:gt(13)")){
								 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
								 $( "#accounting tbody tr:nth-child(59n)").after(head.clone());
							 }
					   } 
				} else if(rows=="13"){
					   
					   if($( "#applying tbody tr:eq(13)")){
							 
							 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
							 $( "#accounting tbody tr:nth-child(12)").after(head.clone());
							 
							 if($( "#accounting tbody tr:gt(12)")){
								 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
								 $( "#accounting tbody tr:nth-child(59n)").after(head.clone());
							 }
					   } 
				} else if(rows=="14"){
					   
					   if($( "#applying tbody tr:eq(14)")){
							 
							 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
							 $( "#accounting tbody tr:nth-child(11)").after(head.clone());
							 
							 if($( "#accounting tbody tr:gt(11)")){
								 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
								 $( "#accounting tbody tr:nth-child(59n)").after(head.clone());
							 }
					   } 
				} else if(rows=="15"){
					   
					   if($( "#applying tbody tr:eq(15)")){
						   
							 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
							 $( "#accounting tbody tr:nth-child(10)").after(head.clone());
							 
							 if($( "#accounting tbody tr:gt(10)")){
								 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
								 $( "#accounting tbody tr:nth-child(59n)").after(head.clone());
							 }
					   } 
				} else if(rows=="16"){
					   
					   if($( "#applying tbody tr:eq(16)")){
						   
							 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
							 $( "#accounting tbody tr:nth-child(10)").after(head.clone());
							 
							 if($( "#accounting tbody tr:gt(10)")){
								 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
								 $( "#accounting tbody tr:nth-child(59n)").after(head.clone());
							 }
					   } 
				} else if(rows=="17"){
					   
					   if($( "#applying tbody tr:eq(17)")){
						   
							 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
							 $( "#accounting tbody tr:nth-child(9)").after(head.clone());
							 
							 if($( "#accounting tbody tr:gt(9)")){
								 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
								 $( "#accounting tbody tr:nth-child(59n)").after(head.clone());
							 }
					   } 
				} else if(rows=="18"){
					   
					   if($( "#applying tbody tr:eq(18)")){
						   
							 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
							 $( "#accounting tbody tr:nth-child(8)").after(head.clone());
							 
							 if($( "#accounting tbody tr:gt(8)")){
								 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
								 $( "#accounting tbody tr:nth-child(59n)").after(head.clone());
							 }
					   } 
				} else if(rows=="19"){
					   
					   if($( "#applying tbody tr:eq(19)")){
						   
							 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
							 $( "#accounting tbody tr:nth-child(8)").after(head.clone());
							 
							 if($( "#accounting tbody tr:gt(8)")){
								 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
								 $( "#accounting tbody tr:nth-child(59n)").after(head.clone());
							 }
					   } 
				} else if(rows=="20"){
					   
					   if($( "#applying tbody tr:eq(20)")){
						   
							 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
							 $( "#accounting tbody tr:nth-child(7)").after(head.clone());
							 
							 if($( "#accounting tbody tr:gt(7)")){
								 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
								 $( "#accounting tbody tr:nth-child(59n)").after(head.clone());
							 }
					   } 
				} else if(rows=="21"){
					   
					   if($( "#applying tbody tr:eq(21)")){
						   
							 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
							 $( "#accounting tbody tr:nth-child(7)").after(head.clone());
							 
							 if($( "#accounting tbody tr:gt(7)")){
								 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
								 $( "#accounting tbody tr:nth-child(59n)").after(head.clone());
							 }
					   } 
				}

		} else {
			$("#firstdiv").prop("hidden", true);
			
				if($( "#accounting tbody tr:eq(27)")){
				 	var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
				 	$( "#accounting tbody tr:nth-child(27)").after(head.clone());
				}
				 
				if($( "#accounting tbody tr:gt(27)")){
					 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
					 $( "#accounting tbody tr:nth-child(68n)").after(head.clone());
				}
		   
			}
		
		if(parseInt(sec)==2){
			  $("#secdiv").prop("hidden", false);
		}
		else{
			 $("#secdiv").prop("hidden", true);
			}
		}

</script>

</head>
<body bgcolor="white" style="font-size:10px;" onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCashVoucherPrint" action="cashVoucherPrint" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">
<div id="headerdiv" hidden="true" >
<jsp:include page="../../../common/printDrivenHeader.jsp"></jsp:include>
</div>
<div id="withoutHeaderDiv" hidden="true" style="height: 100px;" >
<br/><br/>
<center><b><font size="5"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></center>
</div>

<fieldset>
<table width="100%">
  <tr>
    <td width="16%" align="left"><label id="lblmainname" name="lblmainname"><s:property value="lblmainname"/></label></td>
    <td>: <label id="lblname" name="lblname"><s:property value="lblname"/></label></td>
    
    <td width="12%" align="left">Voucher No. </td>
    <td width="20%">: <label name="lblvoucherno" id="lblvoucherno" ><s:property value="lblvoucherno"/></label></td>
  </tr>
  <tr>
    <td align="left">Description </td>
    <td>: <label id="lbldescription" name="lbldescription" ><s:property value="lbldescription"/></label></td>
    <td align="left">Voucher Date </td>
    <td>: <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
  </tr>
   <tr>
   <td align="left">Amount in words </td>
   <td>: <label id="lblnetamountwords" name="lblnetamountwords"><s:property value="lblnetamountwords"/></label></td>
   <td align="left">Amount </td>
   <td>: <label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label></td>
  </tr>
  <tr>
    <td colspan="4"><!-- <hr noshade size=1 width="100%"> --></td>
  </tr>
  </table><br/>
  </fieldset>
<div id="firstdiv" hidden="true" >
<fieldset>
<legend>Applying</legend>
<table id="applying" style="border-collapse: collapse;" width="100%" >
	<thead>
  	<tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    	<th width="5%" align="center" style="border-collapse: collapse;" ><b>Sl No</b></th>
    	<th width="11%" align="center" style="border-collapse: collapse;"><b>Doc No</b></th>
    	<th width="9%" align="center" style="border-collapse: collapse;"><b>Doc Type</b></th>
    	<th width="11%" align="center" style="border-collapse: collapse;"><b>Date</b></th> 
    	<th width="25%" align="left" style="border-collapse: collapse;"><b>Remarks</b></th> 
    	<th width="13%" align="right" style="border-collapse: collapse;"><b>Amount</b></th>
    	<th width="13%" align="right" style="border-collapse: collapse;"><b>Applying</b></th>
    	<th width="13%" align="right" style="border-collapse: collapse;"><b>Balance</b></th>
  	</tr>
  	</thead>
  	<tbody>
  <tr>
      <td colspan="8"><hr noshade size=1 color="#e1e2df"   width="100%"></td>
  </tr>
    <%int j=0,k=0; %>
    <s:iterator var="stat" value='#request.printapplying' >
   <%k=k+1;j=0;%>
	<tr height="20">   
		<td width="5%" align="center"><%=k%></td>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(j==3){%>
    	<td align="left">
		    <s:property value="#des"/>
    	</td>
     	<%} else if(j>3){%>
  		<td align="right">
		    <s:property value="#des"/>
  			</td>
   		<%} else{ %>
  		<td align="center">
		  <s:property value="#des"/>
  		</td>
  		<% } j++;  %>
 		</s:iterator>
	</tr>
	</s:iterator>
	</tbody> 
</table><br/>
</fieldset>
</div>

<div id="secdiv" hidden="true" > 
<fieldset>
<legend>Accounting</legend>
<table id="accounting" style="border-collapse: collapse;" width="100%">
   <thead>
  	<tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    	<th width="5%" align="center" style="border-collapse: collapse;"><b>Sl No</b></th>
    	<th width="8%" align="center" style="border-collapse: collapse;"><b>Acc. No</b></th>
    	<th width="28%" align="left" style="border-collapse: collapse;"><b>Acc. Head</b></th>
    	<th width="30%" align="left" style="border-collapse: collapse;"><b>Description</b></th>
    	<th width="7%" align="center" style="border-collapse: collapse;"><b>Currency</b></th> 
    	<th width="11%" align="right" style="border-collapse: collapse;"><b>Debit</b></th>
    	<th width="11%" align="right" style="border-collapse: collapse;"><b>Credit</b></th>
   </tr>
  </thead>
  <tbody>
  <tr>
      <td colspan="7"><hr noshade size=1 color="#e1e2df" width="100%"></td>
  </tr>
    <%int i=0,l=0,x=0; %>
    <s:iterator var="stat" value='#request.printingarray' >
   <%l=l+1;i=0;%>
	<tr height="20">   
		<td width="5%" align="center"><%=l%></td>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(i==1 || i==2){%>
    	<td>
		    <s:property value="#des"/>
    	</td>
     	<%} else if(i>3){%>
  		<td align="right">
		    <s:property value="#des"/>
  			</td>
   		<%} else{ %>
  		<td align="center">
		  <s:property value="#des"/>
  		</td>
  		<% } i++;  %>
 		</s:iterator>
	</tr>
	</s:iterator> 
</tbody>	
<tr><td colspan="7">&nbsp;</td></tr>
<tr>
		<td  align="right" colspan="5"><b>Total </b>&nbsp;</td>
        <td width="8%" align="right"><label id="lbldebittotal" name="lbldebittotal"><s:property value="lbldebittotal"/></label></td>
        <td width="7%" align="right"><label id="lblcredittotal" name="lblcredittotal"><s:property value="lblcredittotal"/></label></td>
</tr>
</table>
<br/>
</fieldset>
</div><br/>

<table id="preparedby" width="100%" class="tablereceipt">
<tr>
<td width="60%">
<table width="100%">
  <tr>
    <td width="39%" align="left" height="25"><b>Prepared</b></td>
    <td width="35%" align="center"><b>Verified</b></td>
    <td width="26%" align="center"><b>Approved</b></td>
  </tr>
  <tr>
    <td><b>by</b>&nbsp;<label name="lblpreparedby" id="lblpreparedby" ><s:property value="lblpreparedby"/></label></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><b>on</b>&nbsp;<label name="lblpreparedon" id="lblpreparedon" ><s:property value="lblpreparedon"/></label></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><b>at</b>&nbsp;<label name="lblpreparedat" id="lblpreparedat" ><s:property value="lblpreparedat"/></label></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</td>

<td width="40%" class="tablereceipt">
<table width="100%">
  <tr>
    <td height="25" colspan="4"><b>Received By</b></td>
  </tr>
  <tr>
    <td width="5%"><b>Name</b></td>
    <td colspan="3">:<hr style="border:0;border-bottom: 1px dashed #ccc;" size=1 width="100%"></td>
  </tr>
  <tr>
    <td><b>Date</b></td>
    <td width="48%">:&nbsp;</td>
    <td width="5%"><b>Time</b></td>
    <td width="42%">:&nbsp;</td>
  </tr>
</table>
</td></tr>
</table>

<jsp:include page="../../../common/printFooter.jsp"></jsp:include>
<input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
<input type="hidden" id="secarray" name="secarray" value='<s:property value="secarray"/>'>
<input type="hidden" id="txtheader" name="txtheader" value='<s:property value="txtheader"/>'>
</div>

</form>
</div>
</body>
</html>
