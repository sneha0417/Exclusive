 
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


	     
	    $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	    $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	    
	    $('#assignmentDetailsWindow').jqxWindow({width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Assignment Followup',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#assignmentDetailsWindow').jqxWindow('close');
	     
		 $('#statusDetailsWindow').jqxWindow({width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Substatus',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#statusDetailsWindow').jqxWindow('close');
	     
		 $('#txtasset').dblclick(function(){
			 assignmentSearchContent('assignmentSearchGrid.jsp');
		  });
		 $('#txtstatus').dblclick(function(){
			 var txtsdocno = document.getElementById("txtsdocno").value;
			
			 statusSearchContent("substatusSearchGrid.jsp?txtsdocno="+txtsdocno);
		  });
		 $('#txtsdocno').dblclick(function(){
			 assignmentSearchContent('assignmentSearchGrid.jsp');
		  });
		 
	    var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	    var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
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
function getStatus(event){
    var x= event.keyCode;
    var txtsdocno = document.getElementById("txtsdocno").value;
	 
    if(x==114){
    	
    	statusSearchContent("substatusSearchGrid.jsp?txtsdocno="+txtsdocno);
   
    }
    else{}
    }
    
function statusSearchContent(url) {
    $('#statusDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#statusDetailsWindow').jqxWindow('setContent', data);
	$('#statusDetailsWindow').jqxWindow('bringToFront');
}); 
}
    
function getAsset(event){
    var x= event.keyCode;
    if(x==114){
    	assetSearchContent('assignmentSearchGrid.jsp');
    }
    else{}
    }

function assignmentSearchContent(url) {
    $('#assignmentDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#assignmentDetailsWindow').jqxWindow('setContent', data);
	$('#assignmentDetailsWindow').jqxWindow('bringToFront');
}); 
}

function funreload(event){
	 var branchval = document.getElementById("cmbbranch").value;
	 var txtsdocno = document.getElementById("txtsdocno").value;
	 var fromdate = $('#fromdate').val();
	 var todate = $('#todate').val();
	 $("#overlay, #PleaseWait").show();
	 	
	 $("#assignmentFollowUpDiv").load("assignmentGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&check=1');
	}

function funExportBtn(){
	 if(parseInt(window.parent.chkexportdata.value)=="1") {
	  	JSONToCSVCon(data, 'AssignmentFollowup', true);
	 } else {
		 $("#assignmentFollowup").jqxGrid('exportdata', 'xls', 'AssignmentFollowup');
	 }
}
function funupdates()
{
	

	var docno=$("#txtsdocno").val();
	if(docno==''){
  		 $.messager.alert('Message','Choose a Status','warning');
 		 return 0;
  	 }
	docno=0;
	
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
		 				 listss.push($("#jqxAssignmentgrid").jqxGrid('getcellvalue',selectedrows[i],'doc_no') 
		 						 +"::"+$("#jqxAssignmentgrid").jqxGrid('getcellvalue',selectedrows[i],'brhid')+"::"+$("#jqxAssignmentgrid").jqxGrid('getcellvalue',selectedrows[i],'adocno')); 
		 					  }
				var status=$("#txtasset").val();
				var brhid=$('#hidbrhid').val();
				saveData(docno,status,brhid,listss);
			}
	});
	  }


 function saveData(docno,status,brhid,listss){
	 
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200) 
				{
				 var items= x.responseText;
				 	var itemval=items.trim();
				 if(parseInt(itemval)>0)  
	    	{ 
		    $.messager.alert('Message', '  Record Successfully Saved ','info');
		    funreload();
		    $("#txtasset").val('');
		    	$("#txtsdocno").val('');
		    	$("#txtstdocno").val('');
		    	$("#txtstatus").val('');
		    	$("#doc_no").val('');
		    	//funreload(event);
		    	disable();
		    	
	    }
	    else
	    {
	    	$.messager.alert('Message', '  Not Saved  ','warning');
	    }
 		}
		}  
		
	x.open("GET","savedata.jsp?doc_no="+docno+"&status="+txtasset+"&sdocno="+document.getElementById("txtsdocno").value+"&subsdocno="+document.getElementById("txtstdocno").value+"&branchids="+brhid+"&listss="+listss,true);    
		 
	//x.open("GET","savedata.jsp?doc_no="+document.getElementById("doc_no").value+"&sdocno="+document.getElementById("txtsdocno").value);
		x.send();
	}

 function disable(){
	 $('#txtasset').attr("disabled",true);
	 $('#txtstatus').attr("disabled",true);
	 $('#txtsdocno').attr("disabled",true);
	 $('#txtstdocno').attr("disabled",true);
	 $('#update').attr("disabled",true);
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
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
           </td></tr>
           
          <tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td align="right"><label class="branch">Status</label></td>
	<td align="left"><input type="text" id="txtasset" name="txtasset" style="width:65%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtasset"/>' onkeydown="getAsset(event);"/></td></tr>

       <td align="left"><input type="hidden" id=txtsdocno name="txtsdocno" style="width:60%;height:20px;" readonly="readonly"  value='<s:property value="txtsdocno"/>' onkeydown="getAsset(event);"/></td>
	     
      	<tr><td align="right"><label class="branch">Substatus</label></td> 
	<td align="left"><input type="text" id="txtstatus" name="txtstatus" style="width:65%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtstatus"/>' onkeydown="getStatus(event);"/></td></tr>
	<td align="left"><input type="hidden" id=txtstdocno name="txtstdocno" style="width:60%;height:20px;" readonly="readonly"  value='<s:property value="txtstdocno"/>' onkeydown="getAsset(event);"/></td>
	     
	 </tr>   
           
<!--          <tr><td colspan="2">&nbsp;</td></tr> -->
	 <tr>
	 <td colspan="2" align="center">
     <input type="button" class="myButton" name="Update" id="update"  value="Update" onclick="funupdates()">
     </td></tr>
    
       
	<tr>
	<input type="text" name="doc_no" id="doc_no" hidden="true" value='<s:property value="doc_no"/>' >
	<input type="text" name="hidbrhid" id="hidbrhid" hidden="true" value='<s:property value="hidbrhid"/>' >
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
<div id="assignmentDetailsWindow">
	<div></div><div></div>
</div>
<div id="statusDetailsWindow">
	<div></div><div></div>
</div>
</div>
</body>
</html>