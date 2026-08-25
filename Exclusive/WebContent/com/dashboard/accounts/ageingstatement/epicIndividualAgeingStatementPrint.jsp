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
    <td width="94%" align="right"><b>Currency</b></td>
    <td width="6%"><label id="lblcurrencycode" name="lblcurrencycode"><s:property value="lblcurrencycode"/></label></td>
  </tr>
</table>

<div id="firstdiv" hidden="true">
<table id="unapplied" width="95%" class="tablereceipt" align="center">
<thead>
  <tr><th colspan="11" height="28" style="background-color: #F6CECE;"><b>Unapplied</b></th></tr>
  
  <tr height="28" style="background-color: #D8D8D8;" class="tablereceipt" align="center">
    <th class="tablereceipt" width="4%" align="center">Sr.No</th>
    <th class="tablereceipt" width="10%" align="center">Date</th>
    <th class="tablereceipt" width="5%" align="center">Type</th>
    <th class="tablereceipt" width="8%" align="center">Doc No.</th>
    <th class="tablereceipt" width="8%" align="center">Ref No.</th>
    <th class="tablereceipt" width="12%" align="left">Branch</th>
    <th class="tablereceipt" width="20%" align="left">Description</th>
    <th class="tablereceipt" width="9%" align="right">Amount</th>
    <th class="tablereceipt" width="10%" align="right">Applied</th>
    <th class="tablereceipt" width="8%" align="right">Balance</th>
    <th class="tablereceipt" width="6%" align="center">Age</th>
  </tr>
</thead>
<tbody>
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
    	<td class=tablereceipt width="12%" align="left">
		    <s:property value="#des"/>
    	</td>
  	    <%}else if(i==6){%>
    	<td class=tablereceipt width="20%" align="left">
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
	</tbody>
  <tr height="25">
    <td colspan="7" class="tablereceipt" align="left">Total</td>
    <td class="tablereceipt" width="9%" align="right"><label id="lblsumnetamount" name="lblsumnetamount"><s:property value="lblsumnetamount"/></label></td>
    <td class="tablereceipt" width="10%" align="right"><label id="lblsumapplied" name="lblsumapplied"><s:property value="lblsumapplied"/></label></td>
    <td class="tablereceipt" width="8%" align="right"><label id="lblsumbalance" name="lblsumbalance"><s:property value="lblsumbalance"/></label></td>
    <td class="tablereceipt" width="7%" align="center" style="background-color: #A4A4A4;">&nbsp;</td>
  </tr>
</table><br/>
</div>

<div id="secdiv" hidden="true" > 
<table id="outstandings" width="95%" class="tablereceipt" align="center">
<thead>
  <tr><th colspan="11" height="28" style="background-color: #F6CECE;"><b>Outstandings</b></th></tr>
  
  <tr height="28" style="background-color: #D8D8D8;" class="tablereceipt" align="center">
    <th class="tablereceipt" width="4%" align="center">Sr.No</th>
    <th class="tablereceipt" width="10%" align="center">Date</th>
    <th class="tablereceipt" width="5%" align="center">Type</th>
    <th class="tablereceipt" width="8%" align="center">Doc No.</th>
    <th class="tablereceipt" width="8%" align="center">Ref No.</th>
    <th class="tablereceipt" width="12%" align="left">Branch</th>
    <th class="tablereceipt" width="20%" align="left">Description</th>
    <th class="tablereceipt" width="9%" align="right">Amount</th>
    <th class="tablereceipt" width="10%" align="right">Applied</th>
    <th class="tablereceipt" width="8%" align="right">Balance</th>
    <th class="tablereceipt" width="6%" align="center">Age</th>
  </tr>
  </thead>
  <tbody>
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
    	<td class=tablereceipt width="3%" align="center">
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
    	<td class=tablereceipt width="12%" align="left">
		    <s:property value="#des"/>
    	</td>
    	<%}else if(j==6){%>
    	<td class=tablereceipt width="20%" align="left">
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
	</tbody>
  <tr height="25">
    <td colspan="7" class="tablereceipt" align="left">Total</td>
    <td class="tablereceipt" width="9%" align="right"><label id="lblsumoutnetamount" name="lblsumoutnetamount"><s:property value="lblsumoutnetamount"/></label></td>
    <td class="tablereceipt" width="10%" align="right"><label id="lblsumoutapplied" name="lblsumoutapplied"><s:property value="lblsumoutapplied"/></label></td>
    <td class="tablereceipt" width="8%" align="right"><label id="lblsumoutbalance" name="lblsumoutbalance"><s:property value="lblsumoutbalance"/></label></td>
    <td class="tablereceipt" width="7%" align="center" style="background-color: #A4A4A4;">&nbsp;</td>
  </tr>
</table><br/>
</div>

<div id="thirddiv" hidden="true"> 
<table width="95%" class="tablereceipt" style="page-break-inside: avoid;" align="center">
  <tr>
    <td colspan="7" class="tablereceipt" height="28" style="background-color: #F6CECE;"><b>Ageing Summary</b></td>
  </tr>
  <tr height="25">
    <td width="5%" class="tablereceipt">&nbsp;</td>
    <td class="tablereceipt" width="15%" align="right">Total</td>
    <td class="tablereceipt" width="15%" align="right">0-30</td>
    <td class="tablereceipt" width="18%" align="right">31-60</td>
    <td class="tablereceipt" width="18%" align="right">61-90</td>
    <td class="tablereceipt" width="15%" align="right">91-120</td>
    <td class="tablereceipt" width="14%" align="right">&ge;121&nbsp;days</td>
  </tr>
  <tr height="25" style="background-color: #CEECF5;">
    <td class="tablereceipt" align="left">Net</td>
    
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
</div>
</form>
</div>
</body>
</html>