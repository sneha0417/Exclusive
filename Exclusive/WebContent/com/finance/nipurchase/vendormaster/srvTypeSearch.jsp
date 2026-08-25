 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
	<script type="text/javascript">
	
		$(document).ready(function(){
			var gridrowindex='<%=request.getParameter("gridrowindex")%>';
		
		});
			function funUpdate(){
			
				var gridrowindex='<%=request.getParameter("gridrowindex")%>';
				var rows=$('#servTypeGrid').jqxGrid('selectedrowindexes'); 
				for(var i=0;i<rows.length;i++){
					if(i==0){
						
						$('#jqxService').jqxGrid('setcellvalue',gridrowindex,'servid',$('#servTypeGrid').jqxGrid('getcellvalue',rows[i],'servid'));
						
						$('#jqxService').jqxGrid('setcellvalue',gridrowindex,'servicetype',$('#servTypeGrid').jqxGrid('getcellvalue',rows[i],'service_type'));
						
					}
					else{   
						gridrowindex++;
						$('#jqxService').jqxGrid('addrow',null,{});
						$('#jqxService').jqxGrid('setcellvalue',gridrowindex,'servid',$('#servTypeGrid').jqxGrid('getcellvalue',rows[i],'servid'));
						
						$('#jqxService').jqxGrid('setcellvalue',gridrowindex,'servicetype',$('#servTypeGrid').jqxGrid('getcellvalue',rows[i],'service_type'));
						
					}
					
				}
				
				$('#jqxService').jqxGrid('addrow',null,{});
				$('#srvtypserchwindow').jqxWindow('close');
			}
			
	 function loadSearch() {
               var gridarray=new Array();      
				var rows=$('#jqxService').jqxGrid('getrows'); 
				for(var i=0;i<rows.length;i++){
				var cpersion= $.trim(rows[i].servid);
				   
					if(cpersion.trim()!="" && typeof(cpersion)!="undefined" && typeof(cpersion)!="NaN" )
						{
					 gridarray.push(rows[i].servid);   
					 }
				}
 		getdata(gridarray);
	}
	function getdata(gridarray){
			//alert("gridarray====="+gridarray);    
		    $("#refsearch").load('serviceTypeSearchGrid.jsp?check='+encodeURIComponent(gridarray)+'&id=1');    
		}
		
	</script>
</head>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  
  <tr>
  <td>

  </td>
  <tr>
  
    <td width="24%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refsearch"> 
   <jsp:include  page="serviceTypeSearchGrid.jsp"></jsp:include> 
   </div>
    </td>
  </tr>
</table>
  </div>
  <table width="100%">
  <tr>
  <td width="100%" align="center">
<button class="myButton" type="button" id="btnAdd" name="btnAdd" onclick="funUpdate();">OK</button>

  </td>
  </tr>
  </table>
</body>
</html>