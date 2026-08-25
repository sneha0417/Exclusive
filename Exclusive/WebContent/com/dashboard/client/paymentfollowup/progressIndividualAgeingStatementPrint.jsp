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
    border: 1px solid black;
    border-collapse: collapse;
}

.verticalLine {
    border-left: 1px solid black;
}
</style>

<script type="text/javascript">

	function hidedata(){
		
		var first=document.getElementById("firstarray").value;
		var sec=document.getElementById("secarray").value;
		var third=document.getElementById("thirdarray").value;
		var four=document.getElementById("fourtharray").value;
		
		if(parseInt(first)==1){
			   $("#firstdiv").prop("hidden", false);
			}
		else{
			$("#firstdiv").prop("hidden", true);
			}
		
		if(parseInt(sec)==2){
			  $("#secdiv").prop("hidden", false);
		}
		else{
			 $("#secdiv").prop("hidden", true);
			}
		
		if(parseInt(third)==3){
			   $("#thirddiv").prop("hidden", false);
			}
			else{
				$("#thirddiv").prop("hidden", true);
			}
			
		if(parseInt(four)==4){
			   $("#fourthdiv").prop("hidden", false);
			}
			else{
				$("#fourthdiv").prop("hidden", true);
			}
		
		}

</script>

</head>
<body bgcolor="white" style="font-size:10px;" onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmOutstandingsStatement" action="printOutstandingsStatement" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">

<jsp:include page="../../../common/printHeader.jsp"></jsp:include>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<b><font size="2">
<label id="lblaccountname" name="lblaccountname"><s:property value="lblaccountname"/></label>&nbsp;-&nbsp;
<label id="lblaccountaddress" name="lblaccountaddress"><s:property value="lblaccountaddress"/></label>&nbsp;&nbsp;
<label id="lblaccountmobileno" name="lblaccountmobileno"><s:property value="lblaccountmobileno"/></label>
</font></b>

<table width="100%">
  <tr>
    <td width="23%" align="right"><b>Credit Period-Min(Days) :</b>&nbsp;</td>
    <td width="9%" align="left"><label id="lblcreditperiodmin" name="lblcreditperiodmin"><s:property value="lblcreditperiodmin"/></label></td>
    <td width="11%" align="right"><b>Max(Days) :</b>&nbsp;</td>
    <td width="9%" align="left"><label id="lblcreditperiodmax" name="lblcreditperiodmax"><s:property value="lblcreditperiodmax"/></label></td>
    <td width="17%" align="right"><b>Credit Limit :</b>&nbsp;</td>
    <td width="16%" align="left"><label id="lblcreditlimit" name="lblcreditlimit"><s:property value="lblcreditlimit"/></label></td>
    <td width="9%" align="right"><b>Currency</b></td>
    <td width="6%"><label id="lblcurrencycode" name="lblcurrencycode"><s:property value="lblcurrencycode"/></label></td>
  </tr>
</table>

<div id="firstdiv" hidden="true">
<table width="95%" class="tablereceipt" align="center">
  <tr><td colspan="11" height="28" style="background-color: #F6CECE;"><b>&nbsp;Unapplied</b></td></tr>
  
  <tr height="28" style="background-color: #D8D8D8;" class="tablereceipt" align="center">
    <td class="tablereceipt" width="4%" align="center"><b>Sr.No</b></td>
    <td class="tablereceipt" width="10%" align="center"><b>Date</b></td>
    <td class="tablereceipt" width="5%" align="center"><b>Type</b></td>
    <td class="tablereceipt" width="8%" align="center"><b>Doc No.</b></td>
    <td class="tablereceipt" width="8%" align="center"><b>Ref No.</b></td>
    <td class="tablereceipt" width="12%" align="left">&nbsp;<b>Branch</b></td>
    <td class="tablereceipt" width="20%" align="left">&nbsp;<b>Description</b></td>
    <td class="tablereceipt" width="9%" align="right"><b>Amount</b></td>
    <td class="tablereceipt" width="10%" align="right"><b>Applied</b></td>
    <td class="tablereceipt" width="8%" align="right"><b>Balance</b></td>
    <td class="tablereceipt" width="6%" align="center"><b>Age</b></td>
  </tr>
  
  <%int i=0,l=0; %>
  <s:iterator var="stat" value='#request.printunapplyarray' >
  <%l=l+1;i=0;%>
	<tr height="25" class=tablereceipt> 
	    <td class="tablereceipt" width="4%" align="center"><%=l%></td>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">
    	<%i=i+1;%>
    	<% if(i==1){%>
    	<td class=tablereceipt width="7%" align="center">
		    <s:property value="#des"/>
    	</td>
    	<%} else if(i==2){%>
    	<td class=tablereceipt width="3%" align="center">
		    <s:property value="#des"/>
    	</td>
    	
    	<%} else if(i==3){%>
    	<td class=tablereceipt width="3%" align="center">
		    <s:property value="#des"/>
    	</td>
    	
    	<%}else if(i==10){%>
    	<td class=tablereceipt width="1%" align="center">
		    <s:property value="#des"/>
    	</td> 
    	<%}else if(i==5){%>
    	<td class=tablereceipt width="12%" align="left">&nbsp;
		    <s:property value="#des"/>
    	</td>
  	    <%}else if(i==6){%>
    	<td class=tablereceipt width="20%" align="left">&nbsp;
		    <s:property value="#des"/>
    	</td>
    	<%}else if(i==7){%>
    	<td class=tablereceipt width="6%" align="right">
		    <s:property value="#des"/>
    	</td>
    	<%}else if(i==8){%>
    	<td class=tablereceipt width="6%" align="right">
		    <s:property value="#des"/>
    	</td>
    	<%}else if(i==9){%>
    	<td class=tablereceipt width="6%" align="right">
		    <s:property value="#des"/>
    	</td>
   		<%} else{ %>
  		<td class=tablereceipt width="2%" align="center">
		  <s:property value="#des"/>
  		</td>
  		<% } %>
 		</s:iterator>
	</tr>
	</s:iterator>
  <tr height="25">
    <td colspan="7" class="tablereceipt" align="left">&nbsp;<b>Total</b></td>
    <td class="tablereceipt" width="9%" align="right"><label id="lblsumnetamount" name="lblsumnetamount"><s:property value="lblsumnetamount"/></label></td>
    <td class="tablereceipt" width="10%" align="right"><label id="lblsumapplied" name="lblsumapplied"><s:property value="lblsumapplied"/></label></td>
    <td class="tablereceipt" width="8%" align="right"><label id="lblsumbalance" name="lblsumbalance"><s:property value="lblsumbalance"/></label></td>
    <td class="tablereceipt" width="7%" align="center" style="background-color: #A4A4A4;">&nbsp;</td>
  </tr>
</table><br/>
</div>

<div id="secdiv" hidden="true" > 
<table width="95%" class="tablereceipt" align="center">
  <tr><td colspan="11" height="28" style="background-color: #F6CECE;"><b>&nbsp;Outstandings</b></td></tr>
  
  <tr height="28" style="background-color: #D8D8D8;" class="tablereceipt" align="center">
    <td class="tablereceipt" width="4%" align="center"><b>Sr.No</b></td>
    <td class="tablereceipt" width="10%" align="center"><b>Date</b></td>
    <td class="tablereceipt" width="5%" align="center"><b>Type</b></td>
    <td class="tablereceipt" width="8%" align="center"><b>Doc No.</b></td>
    <td class="tablereceipt" width="8%" align="center"><b>Ref No.</b></td>
    <td class="tablereceipt" width="12%" align="left">&nbsp;<b>Branch</b></td>
    <td class="tablereceipt" width="20%" align="left">&nbsp;<b>Description</b></td>
    <td class="tablereceipt" width="9%" align="right"><b>Amount</b></td>
    <td class="tablereceipt" width="10%" align="right"><b>Applied</b></td>
    <td class="tablereceipt" width="8%" align="right"><b>Balance</b></td>
    <td class="tablereceipt" width="6%" align="center"><b>Age</b></td>
  </tr>
  
  <%int j=0,k=0; %>
  <s:iterator var="stat" value='#request.printoutstandingsarray' >
  <%j=0;k=k+1;%>
	<tr height="25" class=tablereceipt>   
	    <td class="tablereceipt" width="4%" align="center"><%=k%></td>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">
    	<%j=j+1;%>
    	<% if(j==1){%>
    	<td class=tablereceipt width="7%" align="center">
		    <s:property value="#des"/>
    	</td>
        <%} else if(j==2){%>
    	<td class=tablereceipt width="5%" align="center">
		    <s:property value="#des"/>
    	</td>
    	
    	<%} else if(j==3){%>
    	<td class=tablereceipt width="3%" align="center">
		    <s:property value="#des"/>
    	</td> 
       	<%}else if(j==10){%>
    	<td class=tablereceipt width="1%" align="center">
		    <s:property value="#des"/>
    	</td>
     	<%}else if(j==5){%>
    	<td class=tablereceipt width="12%" align="left">&nbsp;
		    <s:property value="#des"/>
    	</td>
    	<%}else if(j==6){%>
    	<td class=tablereceipt width="20%" align="left">&nbsp;
		    <s:property value="#des"/>
    	</td>
    	<%}else if(j==7){%>
    	<td class=tablereceipt width="6%" align="right">
		    <s:property value="#des"/>
    	</td>
    	<%}else if(j==8){%>
    	<td class=tablereceipt width="6%" align="right">
		    <s:property value="#des"/>
    	</td>
    	<%}else if(j==9){%>
    	<td class=tablereceipt width="6%" align="right">
		    <s:property value="#des"/>
    	</td>
   		<%} else{ %>
  		<td class=tablereceipt  width="2%" align="center">
		  <s:property value="#des"/>
  		</td>
  		<% } %>
 		</s:iterator>
	</tr>
	</s:iterator>
  <tr height="25">
    <td colspan="7" class="tablereceipt" align="left">&nbsp;<b>Total</b></td>
    <td class="tablereceipt" width="9%" align="right"><label id="lblsumoutnetamount" name="lblsumoutnetamount"><s:property value="lblsumoutnetamount"/></label></td>
    <td class="tablereceipt" width="10%" align="right"><label id="lblsumoutapplied" name="lblsumoutapplied"><s:property value="lblsumoutapplied"/></label></td>
    <td class="tablereceipt" width="8%" align="right"><label id="lblsumoutbalance" name="lblsumoutbalance"><s:property value="lblsumoutbalance"/></label></td>
    <td class="tablereceipt" width="7%" align="center" style="background-color: #A4A4A4;">&nbsp;</td>
  </tr>
</table><br/>
</div>

<div id="thirddiv" hidden="true" > 
<table width="95%" class="tablereceipt" align="center">
  <tr>
    <td colspan="7" class="tablereceipt" height="28" style="background-color: #F6CECE;"><b>&nbsp;Ageing Summary</b></td>
  </tr>
  <tr height="25">
    <td width="5%" class="tablereceipt">&nbsp;</td>
    <td class="tablereceipt" width="15%" align="right"><b>Total</b></td>
    <td class="tablereceipt" width="15%" align="right"><b>0-30</b></td>
    <td class="tablereceipt" width="18%" align="right"><b>31-60</b></td>
    <td class="tablereceipt" width="18%" align="right"><b>61-90</b></td>
    <td class="tablereceipt" width="15%" align="right"><b>91-120</b></td>
    <td class="tablereceipt" width="14%" align="right"><b>&gt;=121&nbsp;days</b></td>
  </tr>
  <tr height="25" style="background-color: #CEECF5;">
    <td class="tablereceipt" align="left">&nbsp;<b>Net</b></td>
    
    <s:iterator var="stat" value='#request.printingarray' >
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
  		<td class=tablereceipt align="right">
		    <s:property value="#des"/>
		    </td>
 		</s:iterator>
 	</s:iterator>
	</tr>
</table><br/>
</div>

<div id="fourthdiv" hidden="true">
<table id="security" width="95%" class=tablereceipt align="center">
  <tr><td colspan="7" class="tablereceipt" height="28" style="background-color: #F6CECE;"><b>&nbsp;Security</b></td></tr>
  <tr height="25" style="background-color: #D8D8D8;" class="tablereceipt" align="center">
    <td colspan="6" align="center" class=tablereceipt><b>Account Informations</b></td>
    <td align="center" class=tablereceipt><b>Value in AED</b></td>
  </tr>
  <tr>
    <td width="10%" height="20" align="center" class=tablereceipt><b>Date</b></td>
    <td width="7%" align="center" class=tablereceipt><b>Type</b></td>
    <td width="10%" align="center" class=tablereceipt><b>Doc No</b></td>
	<td width="14%" align="left" class=tablereceipt><b>&nbsp;Branch</b></td>
	<td width="14%" align="center" class=tablereceipt><b>Agreement</b></td>
    <td width="29%" align="left" class=tablereceipt><b>&nbsp;Description</b></td>
	<td width="11%"  align="right" class=tablereceipt><b>Amount</b></td>
  </tr>
    <s:iterator var="stat" value='#request.printsecurityamountarray' >
	<tr height="25" class=tablereceipt>   
		<%int m=0; %>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(m==3 || m==5){%>
    	<td class=tablereceipt align="left">&nbsp;
		    <s:property value="#des"/>
    	</td>
     	<%} else if(m>5){%>
  		<td class=tablereceipt align="right">
		    <s:property value="#des"/>
  			</td>
   		<%} else{ %>
  		<td class=tablereceipt align="center">
		  <s:property value="#des"/>
  		</td>
  		<% } m++;  %>
 		</s:iterator>
	</tr>
	</s:iterator>
	</tbody>
</table><br/>

<table width="100%">
<tr>
		<td width="88%" align="right"><b>Security Amount :</b>&nbsp;</td>
        <td width="12%" align="left"><label id="lblnetsecurityamount" name="lblnetsecurityamount"><s:property value="lblnetsecurityamount"/></label></td>
</tr>
</table><br/>
</div>

<table width="100%">
<tr>
		<td width="88%" align="right"><b>Net Total :</b>&nbsp;</td>
        <td width="12%" align="left"><label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label></td>
</tr>
</table><br/>

<jsp:include page="../../../common/printFooter.jsp"></jsp:include>
<br/><br/>

<input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
<input type="hidden" id="secarray" name="secarray" value='<s:property value="secarray"/>'>
<input type="hidden" id="thirdarray" name="thirdarray" value='<s:property value="thirdarray"/>'>  
<input type="hidden" id="fourtharray" name="fourtharray" value='<s:property value="fourtharray"/>'>
</div>
</form>
</div>
</body>
</html>