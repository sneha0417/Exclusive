<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $('#update').attr("disabled",true);
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	});

	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 $("#overlay, #PleaseWait").show();
		 
		 $("#propertyStatusChangeDiv").load("propertyStatusChangeGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&check=1');
		}

	function funExportBtn(){
		 
		  	JSONToCSVCon(data, 'PropertyStatusChange', true);
		 
	 }
	
	function funupdates()
	{
		
		$.messager.confirm('Message', 'Do you want to save changes?', function(r){
		 	  
		     
		   	if(r==false)
		   	  {
		   		
		   	  }
		   	else
		   		{
		
		   	 save();
		  
		   		
		   		} 
		    });
		
		  }
	
	
	
	
	 function save(){
		 
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200) 
					{
					 var items= x.responseText;
					 	var itemval=items.trim();
					 
	      if(parseInt(itemval)==1)
	      	{
					 	$.messager.alert('Message', '  Record successfully Updated ', function(r){
						     
					     });
					    
					 //	funreload(event);
					 
					 	   $('#update').attr("disabled",true);
					 	$("#propertyStatusChangeGridID").jqxGrid('clear'); 
					 	funreload(event);
					 	
						
					}
				else
					{
					$.messager.alert('Message', '  Not Updated ', function(r){
					     
				     });
					}  
			}
			}  
			
		 
		x.open("GET","savedata.jsp?doc_no="+document.getElementById("doc_no").value);
			x.send();
		}

	 
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr>
	 <td align="right"><label class="branch">Period</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr> 
	 <tr><td colspan="1">&nbsp;&nbsp;&nbsp;</td></tr>
	 <tr>
	 <td colspan="2" align="center">
     <input type="button" class="myButton" name="Update" id="update"  value="Update" onclick="funupdates()">
     </td></tr>
	<tr>
	<input type="hidden" id="doc_no" name="doc_no" value='<s:property value="doc_no"/>' />
	 </tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>	
 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="propertyStatusChangeDiv"><jsp:include page="propertyStatusChangeGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
</div>
</body>
</html>