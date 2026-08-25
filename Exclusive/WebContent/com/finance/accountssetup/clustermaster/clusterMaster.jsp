<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script> 

<script type="text/javascript">
      $(document).ready(function () {
    	  /* Date */
    	  $("#clusterDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  
    	  /* Searching Window */
    	 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
 		 
 		// $('#nationalityWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Nation Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		// $('#nationalityWindow').jqxWindow('close');
 		 
 		 <%-- $('#txtempaccount').dblclick(function(){
			  accountSearchContent(<%=contextPath+"/"%>+"com/humanresource/setup/accountsDetailsSearch.jsp");
		  });
 		 
 		$('#txtempnationality').dblclick(function(){
 			nationalitySearchContent("nationSearchGrid.jsp");
		  }); --%>
 		 
 	//	  getDesignation();getDepartment();getPayrollCategory();getSalesAgent();
      }); 
      
      function accountSearchContent(url) {
		 	$('#accountDetailsWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#accountDetailsWindow').jqxWindow('setContent', data);
			$('#accountDetailsWindow').jqxWindow('bringToFront');
		}); 
		}
      
      function nationalitySearchContent(url) {
		 	$('#nationalityWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#nationalityWindow').jqxWindow('setContent', data);
			$('#nationalityWindow').jqxWindow('bringToFront');
		}); 
		}
      
      function getDesignation() {
    		var x = new XMLHttpRequest();
    		x.onreadystatechange = function() {
    			if (x.readyState == 4 && x.status == 200) {
    				var items = x.responseText;
    				items = items.split('####');
    				var designationItems = items[0].split(",");
    				var designationIdItems = items[1].split(",");
    				var optionsdesignation = '<option value="">--Select--</option>';
    				for (var i = 0; i < designationItems.length; i++) {
    					optionsdesignation += '<option value="' + designationIdItems[i] + '">'
    							+ designationItems[i] + '</option>';
    				}
    				$("select#cmbempdesignation").html(optionsdesignation);
    				if ($('#hidcmbempdesignation').val() != null) {
    					$('#cmbempdesignation').val($('#hidcmbempdesignation').val());
    				}
    			} else {
    			}
    		}
    		x.open("GET", "getDesignation.jsp", true);
    		x.send();
    	}
      
      function getDepartment() {
    		var x = new XMLHttpRequest();
    		x.onreadystatechange = function() {
    			if (x.readyState == 4 && x.status == 200) {
    				var items = x.responseText;
    				items = items.split('####');
    				var departmentItems = items[0].split(",");
    				var departmentIdItems = items[1].split(",");
    				var optionsdepartment = '<option value="">--Select--</option>';
    				for (var i = 0; i < departmentItems.length; i++) {
    					optionsdepartment += '<option value="' + departmentIdItems[i] + '">'
    							+ departmentItems[i] + '</option>';
    				}
    				$("select#cmbempdepartment").html(optionsdepartment);
    				if ($('#hidcmbempdepartment').val() != null) {
    					$('#cmbempdepartment').val($('#hidcmbempdepartment').val());
    				}
    			} else {
    			}
    		}
    		x.open("GET", "getDepartment.jsp", true);
    		x.send();
    	}
      
      function getPayrollCategory() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var payrollcategoryItems = items[0].split(",");
  				var payrollcategoryIdItems = items[1].split(",");
  				var optionspayrollcategory = '<option value="">--Select--</option>';
  				for (var i = 0; i < payrollcategoryItems.length; i++) {
  					optionspayrollcategory += '<option value="' + payrollcategoryIdItems[i] + '">'
  							+ payrollcategoryItems[i] + '</option>';
  				}
  				$("select#cmbpayrollcategory").html(optionspayrollcategory);
  				if ($('#hidcmbpayrollcategory').val() != null) {
  					$('#cmbpayrollcategory').val($('#hidcmbpayrollcategory').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getPayrollCategory.jsp", true);
  		x.send();
  	}
      
      function getSalesAgent() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var salesAgentItems = items[0].split(",");
  				var salesAgentIdItems = items[1].split(",");
  				var optionssalesagent = '<option value="">--Select--</option>';
  				for (var i = 0; i < salesAgentItems.length; i++) {
  					optionssalesagent += '<option value="' + salesAgentIdItems[i] + '">'
  							+ salesAgentItems[i] + '</option>';
  				}
  				$("select#cmbempagentid").html(optionssalesagent);
  				if ($('#hidcmbempagentid').val() != null) {
  					$('#cmbempagentid').val($('#hidcmbempagentid').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getSalesAgent.jsp", true);
  		x.send();
  	}
      
      function getEmpAccount(event){
          var x= event.keyCode;
          if(x==114){
        	  accountSearchContent(<%=contextPath+"/"%>+"com/humanresource/setup/accountsDetailsSearch.jsp");
          }
          else{}
          }
      
      $(function(){
	        $('#frmClusterMaster').validate({
	                rules: {
	                txtclustername:"required",
	                 },
	                 messages: {
	                 txtclustername:" *",
	                 }
	        });});
 	 
	 function funReadOnly(){
			$('#frmClusterMaster input').attr('readonly', true );
			$('#frmClusterMaster select').attr('disabled', true);
			$('#clusterDate').jqxDateTimeInput({disabled: true});
			
			$("#clusterGridID").jqxGrid({ disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
			$('#frmClusterMaster input').attr('readonly', false );
			$('#frmClusterMaster select').attr('disabled', false);
			$('#clusterDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			
			$("#clusterGridID").jqxGrid({ disabled: false});
			
			if ($("#mode").val() == "A") {
					 $('#clusterDate').val(new Date());
					 
					 $("#clusterGridID").jqxGrid('clear'); 
				     $("#clusterGridID").jqxGrid('addrow', null, {});
			}
			
			if ($("#mode").val() == "E") {
				     $("#clusterGridID").jqxGrid('addrow', null, {});
			}
	 }
	 function funNotify(){	
		 /* Validation */
		 
		 
		 
		// document.getElementById("errormsg").innerText="";		 
		 /* Validation Ends*/
		 
		 var rows = $("#clusterGridID").jqxGrid('getrows');
		 var length=0;
			 for(var i=0 ; i < rows.length ; i++){
				var chk=rows[i].doc_no;
				if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
					length=length+1;
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+i)
				    .attr("name", "test"+i)
				    .attr("hidden", "true");
			
					newTextBox.val(rows[i].doc_no);
					newTextBox.appendTo('form');
			 }
			}
 		 $('#gridlength').val(length);
 		 
		return 1;	    	
		} 
	 
	 function funSearchLoad(){
			 changeContent('clmMainSearch.jsp');  
		 }
	 
	 function funFocus(){
	    	$('#clusterDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 function setValues(){
		 
			 if($('#hidclusterDate').val()){
				 $("#clusterDate").jqxDateTimeInput('val', $('#hidclusterDate').val());
			  }
			 
			 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			 
			 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			 funSetlabel();
            
             var indexVal = document.getElementById("docno").value;
			 if(indexVal> 0){
	         	 $("#clusterMasterDiv").load("clusterMasterGrid.jsp?docno="+indexVal+"&mode="+$('#mode').val());
			 }  
		}
	 
	 function funChkButton() {
			/* funReset(); */
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
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmClusterMaster" action="saveClusterMaster" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>   

<div class='hidden-scrollbar'>
<fieldset>
<table width="99%">
  <tr>
    <td width="7%" align="right">Date</td>
    <td width="19%"><div id="clusterDate" name="clusterDate" value='<s:property value="clusterDate"/>'></div>
    <input type="hidden" id="hidclusterDate" name="hidclusterDate" value='<s:property value="hidclusterDate"/>'/></td>
    <td width="4%" align="right">Name</td>
    <td width="30%"><input type="text" id="txtclustername" name="txtclustername" placeholder="Name" style="width:81%;" value='<s:property value="txtclustername"/>'/></td>
    <td width="7%" align="right">Doc No</td>
    <td width="33%"><input type="text" id="docno" name="txtclmmasterdocno" style="width:40%;" tabindex="-1" value='<s:property value="txtclmmasterdocno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="5"><input type="text" id="txtdescription" name="txtdescription" placeholder="Description" style="width:51%;" value='<s:property value="txtdescription"/>'/></td>
  </tr>
</table>
</fieldset><br/>

<div id="clusterMasterDiv"><jsp:include page="clusterMasterGrid.jsp"></jsp:include></div><br/>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
</div>
</form>
<div id="accountDetailsWindow">
	<div></div><div></div>
</div>  
</div>
</body>
</html>
