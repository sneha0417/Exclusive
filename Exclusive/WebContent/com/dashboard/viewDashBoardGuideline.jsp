<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>

<style type="text/css">

.heading {
    font: 14px Myriad Pro;
    font-weight: bold;
    margin-top: 0px;
	line-height: 20px;
	background-color: #fff;
	color: #BE694A;
	height: 20px;
	width: 100%;
}

.subHeading{
    font: 12px Myriad Pro;
    font-weight: bold;
    margin-top: 0px;
	line-height: 20px;
	background-color: #fff; 
	color: #D84E72;
	height: 20px;
	width: 100%;
}

tr.work:nth-child(even) {background: #fff }
tr.work:nth-child(odd) {background: #e0ecf8}

</style>

<body style="background-color:white;">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmGuideline" action="viewGuideline" method="post" autocomplete="off" target="_blank">

<span class="heading"><label id="lblformname" name="lblformname"><s:property value="lblformname"/></label>&nbsp;-&nbsp;<label id="lblformcode" name="lblformcode"><s:property value="lblformcode"/></label></span>
<span style="float: right;color: #008ED4;"><label  id="lblrefno" name="lblrefno"><s:property value="lblrefno"/></label></span>
<label><hr  size=1 color="black"></label>

<span class="subHeading">Guidelines</span><br/>

  <%int i=0; %>
    <s:iterator var="stat" value='#request.guidelinesarray' >
	<ul>  
    	<li style="font-family: Tahoma;">
		    <s:property value="#stat"/>
    	</li>
    	
  		</ul>
 		</s:iterator>

<span class="subHeading">How does it work</span><br/><br/>

<table width="95%" align="center" style="border-collapse: collapse;">
  <tr height="25px" style="border-collapse: collapse;background-color: #E6E6E8;color: rgb(102, 51, 255);font-family: Myriad Pro;">
    <td width="6%"  align="center"><b>Sr No.</b></td>
    <td width="18%" align="left"><b>Field Name</b></td>
    <td width="76%" align="left"><b>Description</b></td>
  </tr>
  <%int j=0; %>
    <s:iterator var="stat" value='#request.howitworkarray' >
    <%j=j+1;%>
	<tr height="20px" class="work" style="border-collapse: collapse;">  
	    <td width="6%" align="center"><%=j%></td> 
		<s:iterator status="arr" value="#stat.split('::')" var="des">
    	<td width="18%" style="font: 10px;" align="left">
		    <s:property value="#des"/>
    	</td>
    	</s:iterator>
  		</tr>
 		</s:iterator>
</table>

<h3 style="background-color: #E6E6E8; color: #D84E72; font-family: Myriad Pro;">&nbsp;Note :</h3>
<%int k=0; %>
    <s:iterator var="stat" value='#request.notesarray' >
	<ul>  
    	<li style="font-family: Tahoma;">
		    <s:property value="#stat"/>
    	</li>
    	
  		</ul>
 		</s:iterator><br/>

</form>
</div>
</body>
</html>
