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
.formfont {
	font: 10px Tahoma;
	color: #404040;
	background: #E0ECF8;
	overflow:hidden;
}
</style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

	<script type="text/javascript">
	$(document).ready(function () {
	 $("#dr_DOB").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 
	 
	 $( "#btnok_client" ).click(function() {
  	   
        	var rows = $("#jqxclientsearch").jqxGrid('selectedrowindexes');
        if(rows!=""){
     	 	if(document.getElementById("searchdetails").value==""){
	           		document.getElementById("searchdetails").value="Client";	
	           		document.getElementById("client").value="Client";
	           	}
	           	else{
	           		document.getElementById("searchdetails").value+="\n\nClient";
	           		document.getElementById("client").value+="\nClient";
	           	}
        }
       
        	
        	document.getElementById("hidclient").value="";
        	
        	for(var i=0;i<rows.length;i++){
        		var dummy=$('#jqxclientsearch').jqxGrid('getcellvalue',rows[i],'refname');
        		var docno=$('#jqxclientsearch').jqxGrid('getcellvalue',rows[i],'cldocno');
        		document.getElementById("searchdetails").value+="\n"+dummy;
        		document.getElementById("client").value+="\n"+dummy;
        		if(i==0){
        			document.getElementById("hidclient").value=docno;
        		}
        		else{
        			document.getElementById("hidclient").value+=","+docno;
        		}
        	}
        	$('#clientsearchwindow').jqxWindow('close');
	});


$( "#btncancel_client" ).click(function() {
		$('#clientsearchwindow').jqxWindow('close');
	});
	
	
	}); 

 	function loadSearch() {
 		
 		var clname=document.getElementById("Cl_name").value;
 		var mob=document.getElementById("Cl_mob").value;
 		var lcno=document.getElementById("dr_Licence").value;
 		var passno=document.getElementById("dr_Passport").value;
 		var nation=document.getElementById("dr_Nation").value;
 		var dob=document.getElementById("dr_DOB").value;
		var branch=document.getElementById("cmbbranch").value;
		getdata(clname,mob,lcno,passno,nation,dob,branch);

	}	
	function getdata(clname,mob,lcno,passno,nation,dob,branch){
		
		 $("#refreshdiv").load('clientinfo.jsp?clname='+clname+'&mob='+mob+'&lcno='+lcno+'&passno='+passno+'&nation='+nation+'&dob='+dob+'&branch='+branch);
	
		}

	</script>
<body bgcolor="#E0ECF8">
<div id="search">
<table width="100%">
  <tr>
    <td width="7%" align="right"><label class="formfont">Name</label></td>
    <td colspan="5" align="left"><input type="text" name="Cl_name" id="Cl_name"  style="width:100%;height:17px;" value='<s:property value="Cl_name"/>'></td>
    <td width="6%" align="center">&nbsp;</td>
    <td width="14%" align="center"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onClick="loadSearch();"></td>
    <td width="12%" colspan="2" align="center">&nbsp;</td>
    </tr>
  <tr>
    <td align="right"><label class="formfont">License#</label></td>
    <td width="12%" align="left"><input type="text" name="dr_Licence" id="dr_Licence" value='<s:property value="dr_Licence"/>' style="height:17px;"></td>
    <td width="8%" align="right"><label class="formfont">Passport#</label></td>
    <td width="17%" align="left"><input type="text" name="dr_Passport" id="dr_Passport" value='<s:property value="dr_Passport"/>' style="height:17px;"></td>
    <td width="8%" align="right"><label class="formfont">Nationality</label></td>
    <td width="14%" align="left"><input type="text" id="dr_Nation" name="dr_Nation" value='<s:property value="dr_Nation"/>' style="height:17px;"></td>
    <td align="center">&nbsp;</td>
    <td align="center"><button type="button" id="btnok_client" name="btnok" class="myButton">&nbsp;&nbsp;&nbsp;OK&nbsp;&nbsp;&nbsp;</button></td>
    <td width="12%" colspan="2" align="center"></td>
    <input type="hidden" name="hiddr_DOB" id="hiddr_DOB" value='<s:property value="hiddr_DOB"/>'>
    </tr>
  <tr>
    <td align="right"><span class="formfont">Mob</span></td>
    <td align="left"><input type="text" name="Cl_mob" id="Cl_mob" value='<s:property value="Cl_mob"/>' style="height:17px;"></td>
    <td align="right"><span class="formfont">DOB</span></td>
    <td align="left"><div id="dr_DOB" name="dr_DOB"  value='<s:property value="dr_DOB"/>'></div></td>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center"><button type="button" id="btncancel_client" name="btncancel" class="myButton" >Cancel</button></td>
    <td colspan="2" align="center"></td>
  </tr>
  <tr>
    <td colspan="8">  <div id="refreshdiv">
      
   <jsp:include  page="clientinfo.jsp"></jsp:include> 
   
   </div></td>
    </tr>
</table>

  </div>
</body>
</html>