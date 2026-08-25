 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>   
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>

	<script type="text/javascript">
	$(document).ready(function () {
	  $("#sdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function qotloadSearch1() {
 		
 		var sdate=document.getElementById("sdate").value;
 		 var tobranch=document.getElementById("tobranch").value;
 		var tolocation=document.getElementById("tolocation").value;
 		var msdocno=document.getElementById("msdocno").value; 
 		var reftype=document.getElementById("reftype").value; 
 		
 		
	getdata1(tobranch,msdocno,tolocation,sdate,reftype);
 

	}
	function getdata1(tobranch,msdocno,tolocation,sdate,reftype){
		

		
		 $("#refreshdivmas").load('subMastersearch.jsp?tobranch='+tobranch+'&msdocno='+msdocno+'&tolocation='+tolocation+'&sdate='+sdate+'&reftype='+reftype);
		
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr>
   <td>                         
   <table width="100%">
   <tr>
   <td width="7%" align="right">Docno</td>
    <td align="left" width="21%"><input type="text" name="msdocno" id="msdocno"  value='<s:property value="msdocno"/>'></td>
    <td align="right" >To Branch</td>
    <td align="left" width="18%" ><input type="text" name="tobranch" id="tobranch"  style="width:100%;" value='<s:property value="tobranch"/>'></td>
    <td width="15%" align="right" >To Location</td>
      <td align="left" width="23%"><input type="text" name="tolocation" id="tolocation" value='<s:property value="tolocation"/>'></td>
      </tr>
        <tr>
        <td  align="center"> Type</td>
    <td><select id="reftype" name="reftype" value='<s:property value="reftype"/>'>
     <option value="">----select------</option>
      <option value="IBT">Branch Trasfer(IBT)</option>
      <option value="ILT">Location Transfer(ILT)</option></select></td>
        <td align="right">Date </td>
    <td align="left" ><div id="sdate" name="sdate"  value='<s:property value="sdate"/>'></div>
   
    <td width="16%" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="button" name="qotbtnrasearch" id="qotbtnrasearch" class="myButton" value="Search"  onclick="qotloadSearch1()"></td>
    <tr>
    </table>
    </td>
</tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivmas">
      
   <jsp:include  page="subMastersearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>