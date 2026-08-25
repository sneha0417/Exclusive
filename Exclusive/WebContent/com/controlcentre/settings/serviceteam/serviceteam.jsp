<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">
	
	$(document).ready(function() {
  	  $("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" }); 
  	
  	  $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  	  $('#employeeDetailsWindow').jqxWindow('close');
  	  
  	  $('#userDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Team-User Link Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	  $('#userDetailsWindow').jqxWindow('close');
	  
	  $('#txtteamuserlinkname').dblclick(function(){
		  $('#userDetailsWindow').jqxWindow('open');
     	  userSearchContent('userDetailsSearch.jsp?id=0');
	});
  	  
	});
	
	function employeeSearchContent(url) {
	 	$('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsWindow').jqxWindow('setContent', data);
		$('#employeeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function userSearchContent(url) {
	 	$('#userDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#userDetailsWindow').jqxWindow('setContent', data);
		$('#userDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getTeamUserLink(event){
        var x= event.keyCode;
        if(x==114){
        	 $('#userDetailsWindow').jqxWindow('open');
        	 userSearchContent('userDetailsSearch.jsp?id=0');
        }
        else{}
        }
	
	function getTeamUserLink(rownindex){
		$('#userDetailsWindow').jqxWindow('open');
   	    userSearchContent('userDetailsSearch.jsp?id=1&rownindex='+rownindex); 
	}
	
	function getemployee(rownindex){
   	  $('#employeeDetailsWindow').jqxWindow('open');
   	  employeeSearchContent('employeeDetailsSearch.jsp?rownindex='+rownindex); 
    }
	
	function funReadOnly() {
		 $('#frmServiceteam input').attr('readonly', true);
		 $('#frmServiceteam input').attr('disabled', true);
		 $('#date').jqxDateTimeInput({ disabled: true});
		 $('#docno').attr('disabled', false);
		 $("#serviceteamGrid").jqxGrid('disabled',true);
	}
	function funRemoveReadOnly() {
		$('#frmServiceteam input').attr('readonly', false);
		$('#frmServiceteam input').attr('disabled', false);
		$('#docno').attr('readonly', true);
		$('#txtteamuserlinkname').attr('readonly', true);
		
		 $('#date').jqxDateTimeInput({ disabled: false}); 
		 $("#serviceteamGrid").jqxGrid('disabled',false);
		 if ($("#mode").val() == "A") {
			 $('#date').val(new Date());
		     $("#serviceteamGrid").jqxGrid('clear');
		     $("#serviceteamGrid").jqxGrid('addrow', null, {});
		   }
		 if($('#mode').val()=='E'){
         	
         	$("#serviceteamGrid").jqxGrid('addrow', null, {});
         }   
		 
	}
	
	function setValues() {
		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		funSetlabel();
		
		if(document.getElementById("ismultiemp").value==1)
    	{
			document.getElementById("ismemp").checked=true;
    		
    	}
		if(document.getElementById("ismultiemp").value==0)
    	{
			document.getElementById("ismemp").checked=false;
    		
    	}
		
		var docVal1 = document.getElementById("docno").value;
	  	
      	if(docVal1>0)
      		{
     	  
         $("#searviceteamdiv").load("serviceteamGrid.jsp?docno="+docVal1);
      		}
      	
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
	}

	 function funFocus()
	    {
	    	document.getElementById("txtgpcode").focus();
	    		
	    }
	    /* $(function(){
	        $('#frmVehicle').validate({
	                 rules: {
	                cmbauthority:"required"
	                 
	                 }, 
	        messages:{
	        	cmbauthority:" *"
	        }
	                 //alert("here");
	        });
	        }); */
	        
	     function funNotify(){
	        	
	        	if(document.getElementById("ismemp").checked==true)
            	{
            		document.getElementById("ismultiemp").value=1;
            	}
	        	if(document.getElementById("ismemp").checked==false)
            	{
            		document.getElementById("ismultiemp").value=0;
            	}
	        	
	        	var rows = $("#serviceteamGrid").jqxGrid('getrows');
	 		    $('#serteamgridlen').val(rows.length);
	 		  
	 		   for(var i=0 ; i < rows.length ; i++){
	 		
	 		    newTextBox = $(document.createElement("input"))
	 		       .attr("type", "dil")
	 		       .attr("id", "test"+i)
	 		       .attr("name", "test"+i)
	 		       .attr("hidden", "true"); 
	 		 
	 		    newTextBox.val(rows[i].empid+"::"+rows[i].teamuserlinkid+" :: ");
	 		    newTextBox.appendTo('form');
	 		    
	 		   }
	        	
	    		return 1;
	     }
	        
	  function fungridchange(){
		  $("#serviceteamGrid").jqxGrid('addrow', null, {});
	  }
	  
	  function funSearchLoad(){
			changeContent('masterSearch.jsp', $('#window'));
	  }

</script>
 </head>
<body onLoad="setValues();"> 
<div id="mainBG" class="homeContent" data-type="background"> 
<form id="frmServiceteam" action="saveServiceteam" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>

<table width="100%">
  <tr>
    <td width="7%" align="right">Date</td>
    <td colspan="2"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
    <td colspan="2" align="right">Doc No</td>
    <td width="40%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>'></td>
  </tr>
  <tr>
    <td align="right"><input type="checkbox" name="ismemp" id="ismemp" onchange="fungridchange()"></td>
    <td width="18%" align="left"><label for="chkmultipleemp">Multiple Employees</label> </td>
    <td width="9%" align="right">Team-User Link</td>
    <td width="17%"><input type="text" name="txtteamuserlinkname" id="txtteamuserlinkname" placeholder="Press F3 To Search"   onKeyDown="getTeamUserLink(event);" value='<s:property value="txtteamuserlinkname"/>'>
    <input type="hidden" name="txtteamuserlinkid" id="txtteamuserlinkid" value='<s:property value="txtteamuserlinkid"/>'></td>
    <td width="9%" align="right">Group Code</td>
    <td><input type="text" name="txtgpcode" id="txtgpcode" value='<s:property value="txtgpcode"/>'></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="5"><input type="text" id="txtdesc" name="txtdesc"  style="width:40%;" value='<s:property value="txtdesc"/>'></td>
  </tr>
  <tr>
    <td colspan="6"><div id="searviceteamdiv"><jsp:include page="serviceteamGrid.jsp"></jsp:include></div></td>
  </tr>
  <tr>
  	<td colspan="6"><input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
      <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
      <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
      <input type="hidden" id="ismultiemp" name="ismultiemp"  value='<s:property value="ismultiemp"/>'/>
      <input type="hidden" id="serteamgridlen" name="serteamgridlen"  value='<s:property value="serteamgridlen"/>'/></td>
  </tr>
</table>

<div id="employeeDetailsWindow">
   <div></div>
</div>
<div id="userDetailsWindow">
   <div></div>
</div>

</form>
</div>
</body>
</html>