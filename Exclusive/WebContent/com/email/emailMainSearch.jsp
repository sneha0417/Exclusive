 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<%
 //System.out.println("=dtype==dtype==="+request.getParameter("dtype"));
 int value =Integer.parseInt(request.getParameter("value"));
// System.out.println("=value=value=value"+value);
%>

	<script type="text/javascript">
	
	var value='<%=value%>';
	//alert("value====value===="+value);
	$(document).ready(function () {
		
		 /* $('#dtypeinfowindow').jqxWindow({ width: '20%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		  $('#dtypeinfowindow').jqxWindow('close'); */
	
	}); 

 	function loadSearch() {
 		
 		var name=document.getElementById("txtname").value;
 		var dtype=document.getElementById("txtdtype").value;
 		

 		getdata(name,dtype);
	}
	function getdata(name,dtype){
		/* alert(dtype);
		alert(value); */
		if(value==0){
			$("#refreshdiv").load('addressbook.jsp?name='+name+'&dtype='+dtype);
		}
		if((value==1)||(value==2)){
			
			$("#refreshdiv").load('ccaddressGrid.jsp?name='+name+'&dtype='+dtype+'&value='+value);
		}
		/* if(value==2){
			
			$("#refreshdiv").load('ccaddressGrid.jsp?name='+name+'&dtype='+dtype+'&value='+value);
		} */
		}
	
	function getdtype(event){
	  	
		 var x= event.keyCode;
		    if(x==114){
		  $('#dtypeinfowindow').jqxWindow('open');
		  $('#dtypeinfowindow').jqxWindow('bringToFront'); 
	  // $('#accountWindow').jqxWindow('focus');
	         dtypeSearchContent('dtypesearch.jsp'); 
	      	 }
	else{
		
	}
	}
	function dtypeSearchContent(url) {
		 
		 $.get(url).done(function (data) {
				 
		$('#dtypeinfowindow').jqxWindow('setContent', data);

	             	}); 
	   	} 
		 

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Name</td>
    <td colspan="3"><input type="text" name="txtname" id="txtname" style="width:80%" value='<s:property value="txtname"/>'></td>
    <td width="7%" align="right">Doc Type</td>
    <td colspan="2"><input type="text" name="txtdtype" id="txtdtype" value='<s:property value="txtdtype"/>' readonly="true" placeholder="Press F3 to Search" onkeydown="getdtype(event);"></td>
    <td width="17%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
   <tr>
    <%-- <td align="right">Licence#</td>
    <td width="14%"><input type="text" name="txtlicence" id="txtlicence" value='<s:property value="txtlicence"/>'></td>
    <td width="16%" align="right">Client#</td>
    <td width="14%"><input type="text" name="txtclientid" id="txtclientid" value='<s:property value="txtclientid"/>'></td>
    <td align="right">Nationality</td>
    <td width="14%"><input type="text" id="txtnation" name="txtnation" value='<s:property value="txtnation"/>'></td>
    <td width="12%" align="right">DOB</td>
    <td><div id="txtdob" name="txtdob"  value='<s:property value="txtdob"/>'></div>
        <input type="hidden" name="hidtxtdob" id="hidtxtdob" value='<s:property value="hidtxtdob"/>'></td> --%>
  </tr>
  <tr>
  <% if(value==0){%>
    <td colspan="8"><div id="refreshdiv"><jsp:include  page="addressbook.jsp"></jsp:include></div></td>
    <%} %>
    
    <% if((value==1)||(value==2)){%>
    <td colspan="8"><div id="refreshdiv"><jsp:include  page="ccaddressGrid.jsp"></jsp:include></div></td>
    <%} %>
  </tr>
</table>
<!-- <div id="dtypeinfowindow"><div></div><div></div></div> -->
  </div>
</body>
</html>