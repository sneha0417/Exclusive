 
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
	
	    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");


	     
	   
	    $('#adjustmentDetailsWindow').jqxWindow({width: '40%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Stock Adjustment',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#adjustmentDetailsWindow').jqxWindow('close');
	     
		 $('#txtasset').dblclick(function(){
			 adjustmentSearchContent('lprMastersearch.jsp');
		  });
		 
// 		 $('#txtsdocno').dblclick(function(){
// 			 assignmentSearchContent('assignmentSearchGrid.jsp');
// 		  });
		 
// 	    var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
// 	    var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
//         $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
// 	    $('#todate').on('change', function (event) {
			
// 	    var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
//         // out date
        
// 		var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
// 		if(fromdates>todates){
			   
// 	    $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
// 	    return false;
// 		  }   
// 	 });

});
function getAsset(event){
    var x= event.keyCode;
    if(x==114){
    	adjustmentSearchContent('lprMastersearch.jsp');
    }
    else{}
    }

function adjustmentSearchContent(url) {
    $('#adjustmentDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#adjustmentDetailsWindow').jqxWindow('setContent', data);
	$('#adjustmentDetailsWindow').jqxWindow('bringToFront');
}); 
}

function funreload(event){
	 var branchval = document.getElementById("cmbbranch").value;
	 var fromdate = $('#fromdate').val();
	 var todate = $('#todate').val();
	 $("#overlay, #PleaseWait").show();
	 
	 $("#assignmentFollowUpDiv").load("assignmentGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&check=1');
	}

function funExportBtn(){
	 if(parseInt(window.parent.chkexportdata.value)=="1") {
	  	JSONToCSVCon(data, 'StockAdjustment', true);
	 } else {
		 $("#stockAdjustment").jqxGrid('exportdata', 'xls', 'StockAdjustment');
	 }
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
				//alert(itemval);
      if(parseInt(itemval)==1)
      			{
				 	$.messager.alert('Message', '  Record successfully Updated ', function(r){
					     
				     });
				    
				 //	funreload(event);
				 
				 
				  
//     	$("#txtasset").val('');
//     	$("#txtsdocno").val('');
//     	$("#doc_no").val('');
				 	funreload(event);
				 	
					
				}
			else
				{
					$.messager.alert('Message', '  Not Updated ', function(r){
				     
			     });
				}  
		}
		}  
		
	 
	x.open("GET","savedata.jsp?doc_no="+document.getElementById("doc_no").value+"&sdocno="+document.getElementById("txtsdocno").value);
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
<!--  <tr><td colspan="2">&nbsp;</td></tr> -->
<%-- 	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div> --%>
<!--                     </td></tr> -->
                    
                    
<%--                      <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div> --%>
<!--            </td></tr> -->
           
          <tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td align="right"><label class="branch">Product</label></td>
	<td align="left"><input type="text" id="txtasset" name="txtasset" style="width:65%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtasset"/>' onkeydown="getAsset(event);"/></td></tr>
	
<%--        <td align="left"><input type="hidden" id=txtsdocno name="txtsdocno" style="width:60%;height:20px;" readonly="readonly"  value='<s:property value="txtsdocno"/>' onkeydown="getAsset(event);"/></td></tr> --%>
	     
           
           
<!--          <tr><td colspan="2">&nbsp;</td></tr> -->
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
              
             
              
   </table>             
</fieldset>
</td>
<td width="80%">
		<table width="100%">
		<tr>
			 <td><div id="assignmentFollowUpDiv"><jsp:include page="assignmentGrid.jsp"></jsp:include></div></td>
			 
			 </tr>
			
	</table>
	</td>


</tr>
</table>


</div>
<div id="adjustmentDetailsWindow">
	<div></div><div></div>
</div>

</div>
</body>
</html>