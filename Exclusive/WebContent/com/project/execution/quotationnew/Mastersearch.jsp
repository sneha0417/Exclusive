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
	  $("#surdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function qotloadSearch1() {
 		
 		 var surdate=document.getElementById("surdate").value;
 		 var Cl_namess=document.getElementById("Cl_names").value;
 		 var sereftype=document.getElementById("sereftype").value;
 		 var msdocno=document.getElementById("msdocno").value; 
 	     var Cl_names = Cl_namess.replace(' ','%20');
 		 var cntrtype=document.getElementById("cntrtype").value;
	     var Cl_site1=document.getElementById("cl_site").value;
 		 var Cl_area1=document.getElementById("cl_area").value;
 		 var Cl_amount=document.getElementById("cl_amount").value;
 		 var Cl_site = Cl_site1.replace(' ','%20');
 		 var Cl_area = Cl_area1.replace(' ','%20');
 		 var refno=document.getElementById("refno").value;
 		
	getdata1(Cl_names,msdocno,surdate,cntrtype,sereftype,Cl_site,Cl_area,Cl_amount,refno);
 

	}
	function getdata1(Cl_names,msdocno,surdate,cntrtype,sereftype,Cl_site,Cl_area,Cl_amount,refno){
		
		var id=1;
		
		 $("#refreshdivmas").load('subMastersearch.jsp?Cl_names='+Cl_names+'&msdocno='+msdocno+'&sereftype='+sereftype+'&surdate='+surdate+'&cntrtype='+cntrtype+'&Cl_site='+Cl_site+'&Cl_area='+Cl_area+'&Cl_amount='+Cl_amount+'&refno='+refno+'&id='+id);
		
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
    <td align="right" >Client</td>
    <td align="left" width="50%" ><input type="text" name="Cl_names" id="Cl_names"  style="width:96.5%;" value='<s:property value="Cl_names"/>'></td>
    <td align="right" >Ref.Type</td>
      <td align="left" width="28%"><select id="sereftype" name="sereftype"  style="width:100%;"  value='<s:property value="sereftype"/>'>
      <option value=""></option>
      <option value="DIR">DIR</option>
      <option value="ENQ">ENQ</option>
      </select></td>
      </tr>
       <tr>
        <td width="8%">Contract Type</td>
    <td align="left" width="5%"><select id="cntrtype" name="cntrtype"  style="width:100%;"  value='<s:property value="cntrtype"/>'>
    <option value=""></option>
      <option value="AMC">AMC</option>
      <option value="SJOB">SJOB</option>
      </select></td>
    <td width="10%" align="right">Date</td><td width="4%"><div id="surdate" name="surdate"  value='<s:property value="surdate"/>'></div></td>
   <td align="right" >Site</td>
      <td align="left" width="50%"><input type="text" name="cl_site" id="cl_site"  value='<s:property value="cl_site"/>'></td>
    </tr>
    
     <tr>
        <td width="8%">Area</td>
    <td align="left" width="5%"><input type="text" name="cl_area" id="cl_area"  value='<s:property value="cl_area"/>'></td>
    <td width="10%" align="right">Amount</td>
    <td width="4%"><input type="text" name="cl_amount" id="cl_amount"  value='<s:property value="cl_amount"/>'></div></td>
    <td align="right">Ref.No.</td>
    <td align="left" width="2%"><input type="text" name="refno" id="refno"  value='<s:property value="refno"/>'></td>
  
   <td><input type="button" name="qotbtnrasearch" id="qotbtnrasearch" class="myButton" value="Search"  onclick="qotloadSearch1()"></td>
    </tr>
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