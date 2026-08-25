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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {

	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	$("#dat").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#dat").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$('#vndwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
    $('#vndwindow').jqxWindow('close');
    $('#enqwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
    $('#enqwindow').jqxWindow('close');
    $('#staWindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: '  Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
    $('#staWindow').jqxWindow('close');
    $('#asgmtdiv select').attr('disabled',true);
    $('#asgmtdiv input').attr('disabled',true);
    
    $("#assignmentto").dblclick(function(){
    	var asgmnttype = $("#cmbasgmnttype").val();
    	if(asgmnttype=="1"){
			vendorSearchContent("vendorSearch.jsp");
		}
		else{
			staffSearchContent("staffSearch.jsp");
		}
    });
  
    $('#equipment').dblclick(function(){
	  	
    	equipmentSearchContent('equipSearch.jsp'); 
    });
  });
	
	
	
     
	
function searchAsgmnt(event){
	var x= event.keyCode;
	var asgmnttype = $("#cmbasgmnttype").val();
	if(x==114){
		if(asgmnttype=="1"){
			vendorSearchContent("vendorSearch.jsp");
		}
		else{
			staffSearchContent("staffSearch.jsp");
		}
	}
}
function searchEquipment(event){
 	var x= event.keyCode;
 	if(x==114){
  
	 	equipmentSearchContent('equipSearch.jsp');    
	 	}
 
 else{
	 }
 } 
function equipmentSearchContent(url) {
 		$('#enqwindow').jqxWindow('open');
    $.get(url).done(function (data) {
    $('#enqwindow').jqxWindow('setContent', data);
	$('#enqwindow').jqxWindow('bringToFront');
	}); 
} 
function vendorSearchContent(url) {
 	$('#vndwindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#vndwindow').jqxWindow('setContent', data);
	$('#vndwindow').jqxWindow('bringToFront');
}); 
}
function staffSearchContent(url) {
 	$('#staWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#staWindow').jqxWindow('setContent', data);
	$('#staWindow').jqxWindow('bringToFront');
}); 
}

function funreload(){
	$("#overlay, #PleaseWait").show();
	
	 
	 var barchval = document.getElementById("cmbbranch").value;
	   var id=1;
		
   	$("#asgmntgrid").load("assignmentGrid.jsp?&barchval="+barchval+"&id="+id);
}

function funUpdate(){
	
	var docno=$("#hiddocno").val();
// 	if(docno==''){
// 		 $.messager.alert('Message','Choose a document','warning');
// 		 return 0;
// 	 }
// 	else{
	
	var selectedrows=$("#jqxAssignmentgrid").jqxGrid('selectedrowindexes');
		 		selectedrows = selectedrows.sort(function(a,b){return a - b});  
	if(selectedrows.length==0)
		{
		 $.messager.alert('Message','Choose a document','warning');
		 return 0;
		}
	 
		$.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
		     if (r){
		    	 var listss = new Array();
		    	 
		     	
		 		var selectedrows=$("#jqxAssignmentgrid").jqxGrid('selectedrowindexes');
		 		selectedrows = selectedrows.sort(function(a,b){return a - b});  
		 			  for(var i=0 ; i < selectedrows.length ; i++){
		 				 listss.push($("#jqxAssignmentgrid").jqxGrid('getcellvalue',selectedrows[i],'doc_no')+"::"
		 						 +$("#jqxAssignmentgrid").jqxGrid('getcellvalue',selectedrows[i],'brhid')+"::"
		 						 +$("#jqxAssignmentgrid").jqxGrid('getcellvalue',selectedrows[i],'jobtrno')+"::"
		 						 +$("#jqxAssignmentgrid").jqxGrid('getcellvalue',selectedrows[i],'typeid'));   
		 					  }
		 			  		    	 
				var agtype=$("#cmbasgmnttype").val();
				var agto=$("#hidassignmentid").val();
				var equipment=$("#equipment").val();
				var trackid=$("#trackid").val();
				var remarks=$("#remarks").val();
				var compldate=$('#dat').jqxDateTimeInput('val');
				var brhid=$('#hidbrhid').val();
				saveData(docno,agtype,agto,equipment,trackid,compldate,remarks,brhid,listss);
			}
	});
	
}
function saveData(docno,agtype,agto,equipment,trackid,compldate,remarks,brhid,listss){
	var x=new XMLHttpRequest();
	  x.onreadystatechange=function(){
	  if (x.readyState==4 && x.status==200){
	         
	    var items=x.responseText.trim();
 	    
	    if(parseInt(items)>0)  
	    { 
		    $.messager.alert('Message', '  Record Successfully Saved ','info');
		    funreload();
		    $('#asgmtdiv select').attr('disabled',true);
		    $('#asgmtdiv input').attr('disabled',true);
		    funcleardata();
	    }
	    else
	    {
	    	$.messager.alert('Message', '  Not Saved  ','warning');
	    }
	   }
	 }
	 x.open("GET","savedata.jsp?docno="+docno+"&agtype="+agtype+"&agto="+agto+"&equipment="+equipment+"&trackid="+trackid+"&expdate="+compldate+"&remarks="+remarks+"&branchids="+brhid+"&listss="+listss,true);    
	 x.send();
}
function funcleardata()
{
	$("#cmbasgmnttype").val("1");$("#assignmentto").val("");$("#equipment").val("");
	$("#remarks").val("");$("#dat").val("");$("#trackid").val("");
}
function funClear(){
	$("#assignmentto").val("");
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
    
	<table width="100%"><tr><td>
<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	</table></td></tr>	
	<tr><td>
	<div id="asgmtdiv">
<table width="100%">
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr>
    <td width="30%" align="right"><label class="branch">Assignment Type</label></td>
    <td width="70%" align="left"><select id="cmbasgmnttype" name="cmbasgmnttype" onchange="funClear();" value='<s:property value="cmbasgmnttype"/>'>
    <option value="1">Vendor</option>
    <option value="2">Own</option>
    </select></td>
    </tr>
    <tr>
      <td align="right"><label class="branch">Assignment To</label></td>
            <td align="left">
            	<input type="text" name="assignmentto" id="assignmentto" readonly="readonly" value='<s:property value="assignmentto"/>' style="height: 20px;" placeholder="Press F3 to search" onkeydown="searchAsgmnt(event);">
            	<input type="text" name="hidassignmentid" id="hidassignmentid" hidden="true" value='<s:property value="hidassignmentid"/>' >
            </td></tr>
         <tr>
        <td align="right"><label class="branch">Reg No </label></td>
        <td align="left">
        <input type="text" id="equipment" name="equipment"   value='<s:property value="equipment"/>' style="height: 20px;" placeholder="Press F3 to search" onkeydown="searchEquipment(event);"/>        
        <input type="text" name="hidequipmentid" id="hidequipmentid" hidden="true" value='<s:property value="hidequipmentid"/>' >
        </td></tr>
         <tr><td align="right"><label class="branch">Trailer No </label></td>
        <td align="left"><input type="text" id="trackid" name="trackid"   value='<s:property value="trackid"/>' style="height: 20px;" >  </td>        
      
         </tr>
	  <tr><td  align="right" ><label class="branch">Completion Date</label></td><td align="left"><div id='dat' name='dat' value='<s:property value="dat"/>'></div>
                    </td></tr>
         
         <tr>
        <td align="right"><label class="branch">Remarks</label></td><td align="left"><input type="text" id="remarks" name="remarks" style="height: 20px;" /></td>        
        </tr>
      
        
	


 <tr><td colspan="2">&nbsp;</td></tr>  

 <tr><td colspan="2" align="center"><input type="button" class="myButton" name="update" id="update"  value="update" onclick="funUpdate()"></td></tr>
<tr><td colspan="2">&nbsp;</td></tr> 
<tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
  <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
	</table></div>
	</td></tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="asgmntgrid"><jsp:include page="assignmentGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</td>
</tr>
</table>
<input type="text" name="hiddocno" id="hiddocno" hidden="true" value='<s:property value="hiddocno"/>' >
<input type="text" name="hidbrhid" id="hidbrhid" hidden="true" value='<s:property value="hidbrhid"/>' >
<div id="vndwindow">
   <div ></div>
</div>
<div id="enqwindow">
   <div ></div>
</div>
<div id="staWindow">
   <div ></div>
</div>
</div>
</div>
</body>
</html>