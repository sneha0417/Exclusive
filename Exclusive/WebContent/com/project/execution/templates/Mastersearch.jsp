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
	  //$("#surdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function loadSearch() {
 		
 		
 		var Cl_projects=document.getElementById("Cl_project").value;
 		var Cl_section=document.getElementById("Cl_section").value;
 		var msdocno=document.getElementById("msdocno").value; 
 		var Cl_project = Cl_projects.replace(' ','%20');
 		var Cl_activity=document.getElementById("Cl_activity").value; 
 		
	getdata1(Cl_project,msdocno,Cl_section,Cl_activity);
 

	}
	function getdata1(Cl_project,msdocno,Cl_section,Cl_activity){
		
		var id=1;
		
		 $("#refreshdivmas").load('subMastersearch.jsp?Cl_project='+Cl_project+'&msdocno='+msdocno+'&Cl_section='+Cl_section+'&Cl_activity='+Cl_activity+'&id='+id);
		
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
    <td align="right" >Project</td>
    <td align="left" width="40%" ><input type="text" name="Cl_project" id="Cl_project"  style="width:85%;" value='<s:property value="Cl_project"/>'></td>
    <td align="right" >Section</td>
      <td align="left" width="58%"><input type="text" name="Cl_section" id="Cl_section"  style="width:100%;" value='<s:property value="Cl_section"/>'></td>
      </tr>
        <tr>
        <td>Activity </td>
    <td align="left"  width="30%"><input type="text" name="Cl_activity" id="Cl_activity"  style="width:100%;" value='<s:property value="Cl_activity"/>'></div>
    <td width="4%"  ></td><td >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearch()"></td>
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