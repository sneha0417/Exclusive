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
<style type="text/css">
 
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

.bicon {
    background-color: #ECF8E0;
	width: 1em;
	height: 1em;
	border: none;
}

</style>

<script type="text/javascript">


$(document).ready(function () {   
	
	    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	    $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	    $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	    $("#pdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	    
	    var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	    var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
	    $('#pdate').jqxDateTimeInput('getDate');
        $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	    $('#todate').on('change', function (event) {
			
	    var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
        // out date
        
		var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		if(fromdates>todates){
			   
	    $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
	    return false;
		  }   
	 });

});

function funreload(event){
	 disable();
	 document.getElementById('cmbprocess').value="";
	 document.getElementById('txtdescription').value="";
     $('#pdate').val(new Date());
	 var branchval = document.getElementById("cmbbranch").value;
	 var fromdate = $('#fromdate').val();
	 var todate = $('#todate').val();
	 var id=1;
	 $("#overlay, #PleaseWait").show();
	 $("#listdiv").load("orderlistGrid.jsp?id="+id+"&fromdate="+fromdate+"&todate="+todate);
	}
function disable(){
    document.getElementById("txtdescription").value="";
    document.getElementById("txtdelnoteno").value="";
    document.getElementById("txtqty").value="";
	 $('#cmbprocess').attr("disabled",true);
	 $('#txtdescription').attr("disabled",true);
	 $('#pdate').jqxDateTimeInput({disabled: true});
	 $('#btnupdate').attr("disabled",true);
	 $('#txtdelnoteno').attr("disabled",true);
	 $('#txtqty').attr("disabled",true);
	}
function disable2(){
	var process=document.getElementById("cmbprocess").value;
	if(process==1){
		 $('#txtdelnoteno').attr("disabled",false);
		 $('#txtqty').attr("disabled",false);
		 $('#pdate').jqxDateTimeInput({disabled: false});
		 $('#btnupdate').attr("disabled",false);
		 $('#txtdescription').attr("disabled",true);
	}else if(process==2){
	 $('#txtdelnoteno').attr("disabled",true);
     $('#txtqty').attr("disabled",true);
     $('#txtdescription').attr("disabled",false);
	 $('#pdate').jqxDateTimeInput({disabled: false});
	 $('#btnupdate').attr("disabled",false);
	}
	
}
 function update(){ 
	var delnoteno=document.getElementById("txtdelnoteno").value;
	var row_no=document.getElementById("hiddocno").value;
	var doc_no=document.getElementById("hiddocno1").value;
    var qty=document.getElementById("txtqty").value;
    var desc=document.getElementById("txtdescription").value;
	var process=document.getElementById("cmbprocess").value;
	var pdate=$('#pdate').val();
    var rowindex=document.getElementById("hidrowindex").value;
	if($('#rowindex').val()== "")
		{
	    	$.messager.alert('Message',"select a document");
		
		return 0;
		}
	
    if($('#process').val()== "")
	{
    	$.messager.alert('Message',"select Process");
	
	return 0;
	}
	    
	      var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var items= x.responseText;
				 	 items=items.split('###');
				 	 var res=items[0];
				 	 
				 	if(parseInt(res)>0){
					     $.messager.alert('Message',"Updated Successfully");
			             document.getElementById("txtdescription").value="";
			             document.getElementById("cmbprocess").value="";
			             funreload(event);
			   		}
				 	else{
				 		$.messager.alert('Message',"Not Updated");
				 	}
					}
			       else
				  {}
		     }
		      x.open("GET","saveNote.jsp?process="+process+"&desc="+desc.replace(/ /g, "%20")+"&delnoteno="+delnoteno.replace(/ /g, "%20")+"&qty="+qty.replace(/ /g, "%20")+"&pdate="+pdate+"&row_no="+row_no+"&doc_no="+doc_no,true);
		     x.send();
	   }
 
 function funExportBtn(){
	  JSONToCSVCon(exceldata,'Fuel Delivery Followup',true);
 }
 
</script>

</head>
<body onload="getBranch();disable();">
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
             <td  align="right" ><label class="branch">From</label></td>
             <td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
           </tr>
           <tr>
             <td  align="right" ><label class="branch">To</label></td>
             <td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
           </tr>
           <tr><td colspan="2">&nbsp;</td></tr>
	       <tr>
             <td align="right"><label class="branch">Process</label></td>
             <td colspan="4"><select id="cmbprocess" name="cmbprocess" onchange="disable2();" style="width: 73%;height:20px;" value='<s:property value="cmbprocess"/>'>
             <option value="">------select------</option><option value="1">Delivery</option><option value="2">Cancelation</option></select>
             <input type="hidden" id="hidcmbprocess" name="hidcmbprocess" value='<s:property value="hidcmbprocess"/>'/>
           </tr>
	       <tr>
	         <td  align="right" ><label class="branch">Date</label></td>
	         <td align="left"><div id='pdate' name='pdate' value='<s:property value="pdate"/>'></div> </td>
           </tr>  
	       <tr>
             <td align="right"><label class="branch">Description</label></td>
             <td colspan="4"><input type="text" id="txtdescription" name="txtdescription" style="width: 73%;height:20px;" value='<s:property value="txtdescription"/>'/></td>
           </tr>
            <tr>
             <td align="right"><label class="branch">Delivery Note No.</label></td>
             <td colspan="4"><input type="text" id="txtdelnoteno" name="txtdelnoteno" style="width: 73%;height:20px;" value='<s:property value="txtdelnoteno"/>'/></td>
           </tr>
            <tr>
             <td align="right"><label class="branch">Quantity</label></td>
             <td colspan="4"><input type="text" id="txtqty" name="txtqty" style="width: 73%;height:20px;" value='<s:property value="txtqty"/>'/></td>
           </tr>
           <tr>
           <td>
           <input type="hidden" id="hiddocno1" name="hiddocno1" value='<s:property value="hiddocno1"/>'/>
            <input type="hidden" id="hiddocno" name="hiddocno" value='<s:property value="hiddocno"/>'/>
            <input type="hidden" id="hidrowindex" name="hidrowindex" value='<s:property value="hidrowindex"/>'/>
            </td>
            </tr>
              
             <tr><td colspan="2">&nbsp;</td></tr>
	       <tr>
	         <td colspan="2" align="center"><input type="button" id="btnupdate" name="btnupdate" class="myButton" value="Update" style="width: 80px;" onclick="update();"/></td>
	       </tr>  
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
			 <td><div id="listdiv"><jsp:include page="orderlistGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
	</td>
</tr>
</table>
</div>
</div>
</body>
</html>