 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%--  <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
  <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<style>

</style>

	<script type="text/javascript">
	$(document).ready(function () {
	  $("#cntrdates").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function cntrloadSearch() {
 		
 		var cntrdates=document.getElementById("cntrdates").value;
 		 var Cl_namess=document.getElementById("Cl_names").value;
 		var contrval=document.getElementById("contrval").value;
 		var msdocno=document.getElementById("msdocno").value; 
 		var Cl_names = Cl_namess.replace(' ', '%20');
 		var dtype=document.getElementById("cmbcontracttype").value; 
 		var ptype=document.getElementById("ptype").value; 
 		
	getdata(Cl_names,msdocno,contrval,cntrdates,dtype,ptype);
 

	}
 	
	function getdata(Cl_names,msdocno,contrval,cntrdates,dtype,ptype){

		 $("#refreshdivmas").load('contractsubMastersearch.jsp?Cl_names='+Cl_names+'&msdocno='+msdocno+'&contrval='+contrval+'&cntrdate='+cntrdates+'&dtype='+dtype+'&ptype='+ptype);
		
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr>
   <td>                         
   <table>
   <tr>
   <td align="right">Docno</td>
    <td align="left" width="2%"><input type="text" name="msdocno" id="msdocno"  value='<s:property value="msdocno"/>'></td>
    <td align="right" >Name</td>
    <td align="left" width="50%" ><input type="text" name="Cl_names" id="Cl_names"  style="width:96.5%;" value='<s:property value="Cl_names"/>'></td>
    <td align="right" width="20%"  >Contract Value</td>
      <td align="left" width="28%"><input type="text" name="contrval" id="contrval" value='<s:property value="contrval"/>'></td>
      </tr>
        <tr>
        <td>Date </td>
    <td align="left" ><div id="cntrdates" name="cntrdates"  value='<s:property value="cntrdates"/>'></div>
    <td width="4%"  ></td><td>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <input type="button" name="cntrbtnrasearch" id="cntrbtnrasearch" class="myButton" value="Search"  onclick="cntrloadSearch()"></td>
    <tr>
    </table>
    </td>
</tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivmas">
      
   <jsp:include  page="contractsubMastersearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>