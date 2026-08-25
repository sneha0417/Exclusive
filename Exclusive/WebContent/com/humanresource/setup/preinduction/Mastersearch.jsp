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
	  $("#mmdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function qotloadSearch1() {
 		
 		var mmdate=document.getElementById("mmdate").value;
 		 var msdocno=document.getElementById("msdocno").value;
 		var des=document.getElementById("des").value;
 		var gds=document.getElementById("gds").value;
 		 
	getdata1(gds,msdocno,des,mmdate);
 

	}
	function getdata1(gds,msdocno,des,mmdate){
		
 
		 $("#refreshdivmas").load('subMastersearch.jsp?gds='+gds+'&msdocno='+msdocno+'&des='+des+'&mmdate='+mmdate);
		
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%"  >
  <tr>
   <td>                         
   <table width="100%"  >
   <tr>
   <td align="right"  width="8%">Doc No</td>
    <td align="left" width="2%"><input type="text" name="msdocno" id="msdocno"  value='<s:property value="msdocno"/>'></td>
    <td align="right" width="3%" >Designation</td>
    <td align="left" width="40%" ><input type="text" name="des" id="des"  style="width:96.5%;" value='<s:property value="des"/>'></td>
    <td align="right"  width="8%" >Grade</td>
      <td align="left" width="20%"><input type="text" name="gds" id="gds" value='<s:property value="gds"/>'>
      
    
      </td>
      </tr>
        <tr>
        <td align="right">Date </td>
    <td align="left" ><div id="mmdate" name="mmdate"  value='<s:property value="mmdate"/>'></div> </td>
       
  <td colspan="4" align="center">
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