<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#jqxIpglDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		$("#btnEdit").attr('disabled', true );
		 $("#btnPrint").attr('disabled', true );
		 $("#btnExcel").attr('disabled', true );
		 $("#btnDelete").attr('disabled', true );
		 $("#btnCancel").attr('disabled', true );
		 $("#btnSearch").attr('disabled', true );
		 $("#btnClose").attr('disabled', true );
		 
    });
	
	
	   function  funReadOnly(){
	    
   		$('#frmGuideLine input').attr('disabled', true );
   		$('#frmGuideLine textarea').attr('disabled', true );
   		$('#frmGuideLine select').attr('disabled', true);
   		$('#jqxgthree').jqxGrid({ disabled: true});
   		$('#jqxgDesc').jqxGrid({ disabled: true});
   		$('#jqxgtwo').jqxGrid({ disabled: true});
   		$('#jqxMenuGrid').jqxGrid({ disabled: true});
   		 $('#mode').attr('disabled', false);
   		 $('#formdetailcode').attr('disabled', false);

   		 
   		
   	}
     
     function funSearchLoad(){
   		changeContent('masterSearch.jsp', $('#window'));
   	}
     
     function funRemoveReadOnly(){
   	  
    	 $('#frmGuideLine input').attr('disabled', false );
    		$('#frmGuideLine textarea').attr('disabled', false );
    		$('#frmGuideLine select').attr('disabled', false);
    		$('#jqxgthree').jqxGrid({ disabled: false});
    		$('#jqxgDesc').jqxGrid({ disabled: false});
    		$('#jqxgtwo').jqxGrid({ disabled: false});
    		$('#jqxMenuGrid').jqxGrid({ disabled: false});
		$('#descGrid').load("descGrid.jsp?doctype=0");
            $('#gtwoGrid').load("gtwoGrid.jsp?doctype=0");
            $('#gthreeGrid').load("gthreeGrid.jsp?doctype=0");
     }
	
	
	function funUpdate(){
	      if(document.getElementById("btnUpdate").value=="Update")
	       {
	         document.getElementById("btnUpdate").value="Save";
	         return 0;
	       }
	      else if(document.getElementById("btnUpdate").value=="Save"){
	    	    $('#btnSave').mousedown();
	           }
	  }
	

	function funFocus(){
		 document.getElementById("txtrefno").focus();  
		
	 }
	
	function funAdd(){
		
		var jobtype=document.getElementById("txtjobtype").value;
		var jobstatus=document.getElementById("txtjobstatus").value;
		var statusid=document.getElementById("jobstatusid").value;
		var description=document.getElementById("txtdescription").value;
		var mandatory=document.getElementById("chckmandatory").value;
		var date=document.getElementById("jqxIpglDate").value;
		
		if(jobstatus==""){
			document.getElementById("errormsg").innerText="Select a job Status";
			return 0;
		}
		
		if(description==""){
			document.getElementById("errormsg").innerText="Enter Description For selected for process";
			return 0;
		}
		
		//alert(date);
		  var x = new XMLHttpRequest();
		  x.onreadystatechange = function() {
		   if (x.readyState == 4 && x.status == 200) {
		    var item=x.responseText.trim();
		    
		    if(item>0)
	    	{
	    	//document.getElementById("errormsg").innerText="Added Successfully";
	    	//alert("Added Successfully");
	    	$.messager.alert('Message',"Added Successfully");
	    	$('#descGrid').load("descGrid.jsp?statusid="+document.getElementById("jobstatusid").value+"&jobtype="+document.getElementById("txtjobtype").value);
	    	//document.getElementById("txtjobtype").value="";
			//document.getElementById("txtjobstatus").value="";
			//document.getElementById("jobstatusid").value="";
			document.getElementById("txtdescription").value="";
			document.getElementById("errormsg").innerText="";
			$('#chckmandatory').attr('checked', false);
			
 			return  true;
	    	}
	    
	    else
		 {
		//document.getElementById("codeval").value="";
		//document.getElementById("errormsg").innerText="Failed";
		//alert("Failed");
		$.messager.alert('Message',"Failed");
		return  false;
		 }
		    
		    /* if(item!='undefine'){
		     $("#btnApproval").show();
		    }
		    else{
		     $("#btnApproval").hide();
		    } */
		   } else {
		   }
		  }
		  x.open("GET","guidlineinsert.jsp?jobtype="+jobtype+"&jobstatus="+jobstatus+"&statusid="+statusid+"&description="+description+"&mandatory="+mandatory+"&date="+date, true);
		  x.send();  
		 }
	
function funUpdate(){
		
		var jobstatus=document.getElementById("txtjobstatus").value;
		var statusid=document.getElementById("jobstatusid").value;
		var srno=document.getElementById("is_pglinesrno").value;
		var description=document.getElementById("txtdescription").value;
		var mandatory=document.getElementById("chckmandatory").value;
		
		if(jobstatus==""){
			document.getElementById("errormsg").innerText="Select a job Status";
			return 0;
		}
		
		if(description==""){
			document.getElementById("errormsg").innerText="Enter Description For selected for process";
			return 0;
		}
		//alert("description==="+description);
		  var x = new XMLHttpRequest();
		  x.onreadystatechange = function() {
		   if (x.readyState == 4 && x.status == 200) {
		    var item=x.responseText.trim();
		    
		    if(item>0)
	    	{
	    	//document.getElementById("errormsg").innerText="updated Successfully";
	    	//alert("Updated Successfully");
	    	$.messager.alert('Message',"Updated Successfully");
	    	$('#descGrid').load("descGrid.jsp?statusid="+document.getElementById("jobstatusid").value+"&jobtype="+document.getElementById("txtjobtype").value);
			document.getElementById("jobstatusid").value="";
			document.getElementById("txtdescription").value="";
			document.getElementById("errormsg").innerText="";
			$('#chckmandatory').attr('checked', false);
 			return  true;
	    	}
	    
	    else
		 {
		//document.getElementById("codeval").value="";
		//document.getElementById("errormsg").innerText="Failed";
		$.messager.alert('Message',"Failed");
		//alert("Failed");
		return  false;
		 }
		    
		    /* if(item!='undefine'){
		     $("#btnApproval").show();
		    }
		    else{
		     $("#btnApproval").hide();
		    } */
		   } else {
		   }
		  }
		  x.open("GET","guidlineupdate.jsp?statusid="+statusid+"&description='"+description+"'&srno="+srno+"&mandatory="+mandatory, true);
		  x.send();  
		 }


function funDelete(){
	
	var jobstatus=document.getElementById("txtjobstatus").value;
	var statusid=document.getElementById("jobstatusid").value;
	var srno=document.getElementById("is_pglinesrno").value;
	var description=document.getElementById("txtdescription").value;
	
	if(jobstatus==""){
		document.getElementById("errormsg").innerText="Select a job Status";
		return 0;
	}
	
	if(description==""){
		document.getElementById("errormsg").innerText="Select a description to delete";
		return 0;
	}
	
	//alert("srno======="+srno);
	  var x = new XMLHttpRequest();
	  x.onreadystatechange = function() {
	   if (x.readyState == 4 && x.status == 200) {
	    var item=x.responseText.trim();
	    
	    if(item>0)
    	{
    	//document.getElementById("errormsg").innerText="Deleted Successfully";
    	
    	//alert("Deleted Successfully");
    	$.messager.alert('Message',"Deleted Successfully");
    	$('#descGrid').load("descGrid.jsp?statusid="+document.getElementById("jobstatusid").value+"&jobtype="+document.getElementById("txtjobtype").value);
		document.getElementById("jobstatusid").value="";
		document.getElementById("txtdescription").value="";
		document.getElementById("errormsg").innerText="";
		$('#chckmandatory').attr('checked', false);
			return  true;
    	}
    
    else
	 {
	//document.getElementById("codeval").value="";
	//document.getElementById("errormsg").innerText="Failed";
	//alert("Failed");
	$.messager.alert('Message',"Failed");
	return  false;
	 }
	    
	    /* if(item!='undefine'){
	     $("#btnApproval").show();
	    }
	    else{
	     $("#btnApproval").hide();
	    } */
	   } else {
	   }
	  }
	  x.open("GET","guidlinedelete.jsp?statusid="+statusid+"&srno="+srno, true);
	  x.send();  
	 }
	 
function funNotify(){	
	 

	/* if(acgroup=="")
	{
	document.getElementById("errormsg").innerText=" Select Account Group";
	return 0;
	} */
	
	
	
	 var rows = $("#jqxgDesc").jqxGrid('getrows');
	   
	    var len=0;
	   for(var i=0;i<rows.length;i++){
		   
	    var description= $.trim(rows[i].description);
	   
		if(description.trim()!="" && typeof(description)!="undefined" && typeof(description)!="NaN" )
			{
			
			
			newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "test"+len)
		       .attr("name", "test"+len)
		       .attr("hidden", "true");
		    
			   
			
	   newTextBox.val(rows[i].description);
	   
	   newTextBox.appendTo('form'); 
	   
	   len=len+1;
			 }
	   
	   }
	   $('#descgridlen').val(len);
	   
	   var rows = $("#jqxgtwo").jqxGrid('getrows');
	   
	    var len=0;
	   for(var i=0;i<rows.length;i++){
		   
	    var fieldname= $.trim(rows[i].fieldname);
	   
		if(fieldname.trim()!="" && typeof(fieldname)!="undefined" && typeof(fieldname)!="NaN" )
			{
			
			
			newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "test2"+len)
		       .attr("name", "test2"+len)
		       .attr("hidden", "true");
		    
			   
			
	   newTextBox.val(rows[i].fieldname+" :: "+rows[i].description+"");
	   
	   newTextBox.appendTo('form'); 
	   
	   len=len+1;
			 }
	   
	   }
	   $('#fieldgridlen').val(len);
	   
	   var rows = $("#jqxgthree").jqxGrid('getrows');
	   
	    var len=0;
	   for(var i=0;i<rows.length;i++){
		   
	    var notes= $.trim(rows[i].notes);
	   
		if(notes.trim()!="" && typeof(notes)!="undefined" && typeof(notes)!="NaN" )
			{
			
			
			newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "test3"+len)
		       .attr("name", "test3"+len)
		       .attr("hidden", "true");
		    
			   
			
	   newTextBox.val(rows[i].notes);
	   
	   newTextBox.appendTo('form'); 
	   
	   len=len+1;
			 }
	   
	   }
	   $('#notegridlen').val(len);
	   
	   
	   
	   return 1;
	
}

function setValues() {
	  var doctype=document.getElementById("txtdoctype").value;
	  
	  if(doctype!="")
		  {
	 
  var indexVal1 = document.getElementById("txtdoctype").value;
  
  var rdoc_type=indexVal1.replace(/ /g, "%20");
 
  $('#descGrid').load("descGrid.jsp?doctype="+rdoc_type);
  $('#gtwoGrid').load("gtwoGrid.jsp?doctype="+rdoc_type);
  $('#gthreeGrid').load("gthreeGrid.jsp?doctype="+rdoc_type);
 
		  }
	 
	  
	   // main
		 if($('#hidjqxIpglDate').val()){
			$("#jqxIpglDate").jqxDateTimeInput('val', $('#hidjqxIpglDate').val());
		} 
		

	   if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		   
		  }
	   
	/*document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")"; */
	
}


	
</script>
<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmGuideLine" action="guideline" autocomplete="off">

<%-- <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> --%>

<jsp:include page="../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<fieldset>
<table width="100%">
  <tr>
    <td width="7%" align="right">Date</td>
    <td width="12%"><div id="jqxIpglDate" name="jqxIpglDate" value='<s:property value="jqxIpglDate"/>'></div>
    <input type="hidden" id="hidjqxIpglDate" name="hidjqxIpglDate" value='<s:property value="hidjqxIpglDate"/>'/></td>
    <td width="24%" align="right"></td>
    <td width="10%"><input type="text" id="txtrefno" name="txtrefno" style="width:100%;" value='<s:property value="txtrefno"/>'/></td>
    <td width="34%" colspan="2" align="right"></td>
    <td width="16%"><input type="hidden" id="docno" name="docno" readonly="true" style="width:50%;" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Menu Details</td>
    <td><input type="text" id="txtdoctype" name="txtdoctype" readonly="true"  style="width:70%;" value='<s:property value="txtdoctype"/>'/></td>
    <td><input type="text" id="txtmenuname" name="txtmenuname" readonly="true" style="width:75%;" value='<s:property value="txtmenuname"/>' tabindex="-1"/></td>
    <%-- <input type="hidden" id="jobstatusid" name="jobstatusid"  value='<s:property value="jobstatusid"/>'/>
    <input type="hidden" id="is_pglinesrno" name="is_pglinesrno"  value='<s:property value="is_pglinesrno"/>'/> --%>
    <%-- <td align="right">Description</td>
    <td colspan="3"><input type="text" id="txtdescription" name="txtdescription" style="width:84%;" value='<s:property value="txtdescription"/>'/></td> --%>
  </tr>
  <%-- <tr>
    <td colspan="4">&nbsp;</td>
    <td align="center"><input type="checkbox" id="chckmandatory" name="chckmandatory" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)">&nbsp;Flag
                                 <input type="hidden" id="hidchckmandatory" name="hidchckmandatory" value='<s:property value="hidchckmandatory"/>'/></td>
    <td align="right"><button class="myButton" type="button" id="btnAdd" name="btnAdd" onclick="funAdd();">Add</button></td>
    <td align="left" colspan="2"><input type="button" name="btnUpdate" id="btnUpdate" class="myButton" value="Update" onclick="funUpdate();">
    <input type="button" name="btnDelete" id="btnDelete" class="myButton" value="delete" onclick="funDelete();"></td>
  </tr> --%>
  <input type="hidden" id="descgridlen" name="descgridlen"  value='<s:property value="descgridlen"/>'/>
  <input type="hidden" id="fieldgridlen" name="fieldgridlen"  value='<s:property value="fieldgridlen"/>'/>
  <input type="hidden" id="notegridlen" name="notegridlen"  value='<s:property value="notegridlen"/>'/>
<input type="hidden" id="txtmenuid" name="txtmenuid"  value='<s:property value="txtmenuid"/>'/>
 <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
 <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</table>
</fieldset>
<fieldset>
<legend>Status</legend>
<table width="100%">
<tr>
<td width="30%">
  <div id="menuGrid"><jsp:include page="menuGrid.jsp"></jsp:include></div>
</td>
<td width="70%">
<table width="100%">
<tr>
<td ><div id="descGrid"><jsp:include page="descGrid.jsp"></jsp:include></div></td></tr>
<tr><td><div id="gtwoGrid"><jsp:include page="gtwoGrid.jsp"></jsp:include></div></td>
<tr><td><div id="gthreeGrid"><jsp:include page="gthreeGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</td></tr>
<tr>
 <td colspan="3">
  
</td> 
</tr>
</table>
</fieldset>

</div>
</form>
	
</div>
</body>
</html>
