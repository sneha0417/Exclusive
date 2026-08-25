<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		
		 
    });
	
	
	   function  funReadOnly(){
		  $("#jqxgDesc").jqxGrid('disabled',true);
   		$('#frmsurveytype input').attr('disabled', true );
   		$('#frmsurveytype textarea').attr('disabled', true );
   		$('#frmsurveytype select').attr('disabled', true);
   		$('#jqxgDesc').jqxGrid({ disabled: true});
   		 $('#mode').attr('disabled', false);
   		 $('#formdetailcode').attr('disabled', false);

   		 
   		
   	}
     
     function funSearchLoad(){
   		changeContent('masterSearch.jsp', $('#window'));
   	}
     
     function funRemoveReadOnly(){
   	  
    	 $('#frmsurveytype input').attr('disabled', false );
    	 $('#frmsurveytype input').attr('readonly', false );
    		$('#frmsurveytype textarea').attr('disabled', false );
    		$('#frmsurveytype select').attr('disabled', false);
    		$('#jqxgDesc').jqxGrid({ disabled: false});
    		
    		if($("#mode").val()=="A"){
    			
   			 $('#date').jqxDateTimeInput('setDate', new Date());
    		}
    		
          }
		

	function funFocus(){
		 document.getElementById("txtname").focus();  
		
	 }
	
 
function funNotify(){	
	 
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
	   
	   return 1;
	
}

function setValues() {
	 	  
	var docno=$('#docno').val();
	if(docno>0){
		
		
		$('#descGrid').load("descGrid.jsp?docno="+docno);
		
			 if($('#hiddate').val()){
				$("#date").jqxDateTimeInput('val', $('#hiddate').val());
			} 
			
		   if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			   
			  }
		
	}
	
	   	
}

function funSearchLoad(){
	changeContent('masterSearch.jsp', $('#window'));
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
<form id="frmsurveytype" action="saveServicetype" autocomplete="off">


<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<fieldset>
<table width="100%">
  <tr>
    <td width="7%" align="right">Date</td>
    <td width="12%"><div id="date" name="date" value='<s:property value="date"/>'></div>
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/></td>
    <td width="24%" align="right">Doc No</td>
    <td width="10%"><input type="text" id="docno" name="docno" style="width:100%;" value='<s:property value="docno"/>'/></td>
    <td width="34%" colspan="2" align="right"></td>
    
  </tr>
  <tr>
    <td align="right">Name</td>
    <td><input type="text" id="txtname" name="txtname" readonly  style="width:70%;" value='<s:property value="txtname"/>'/></td>
    <td align="right">Description</td>
    <td><input type="text" id="txtdesc" name="txtdesc" readonly style="width:100%;" value='<s:property value="txtdesc"/>' /></td>
    <td>
      <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
      <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
      <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
      <input type="hidden" id="descgridlen" name="descgridlen"  value='<s:property value="descgridlen"/>'/>
      </td>
</table>
</fieldset>
<fieldset>
<legend>Details</legend>
<table width="100%">
<tr>
<td width="100%">
<table width="100%">
<tr>
<td ><div id="descGrid"><jsp:include page="descGrid.jsp"></jsp:include></div></td></tr>

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
