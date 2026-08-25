<%@page import="com.controlcentre.masters.vehiclemaster.project.ClsProjectDAO" %>
<%ClsProjectDAO cpd=new ClsProjectDAO(); %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">

$(document).ready(function () {
	 $("#projectDate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	
	 $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#clientDetailsWindow').jqxWindow('close');
	 
	 $("#btnExcel").click(function() {
			$("#jqxProjectSearch1").jqxGrid('exportdata', 'xls', 'Project');
		});
	 
	    document.getElementById("formdet").innerText="Project(PRJ)";
		document.getElementById("formdetail").value="Project";
		document.getElementById("formdetailcode").value="PRJ";
	 	window.parent.formCode.value="PRJ";
			window.parent.formName.value="Project";
	 var data= '<%=cpd.projectDetailsLoading() %>';
	           
	 var source =
	            {
	                datatype: "json",
	                datafields: [
	                          	{name : 'doc_no' , type: 'number' },
	                          	{name : 'date', type: 'date'  },
	                          	{name : 'refname', type: 'String'  },
	                          	{name : 'project_name', type: 'String'  }
	                 ],
	               localdata: data,
	                
	                pager: function (pagenum, pagesize, oldpagenum) {
	                    // callback called when a page or page size is changed.
	                }
	            };
	            var dataAdapter = new $.jqx.dataAdapter(source,
	            		 {
	                		loadError: function (xhr, status, error) {
		                    }
			            }		
	            );
	    
	            $("#jqxProjectSearch1").jqxGrid(
	                    {
	                    	width: 850,
	                        source: dataAdapter,
	                        showfilterrow: true,
	                        filterable: true,
	                        selectionmode: 'multiplecellsextended',
	                        //Add row method
	                        columns: [
	        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
	        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
	        					{ text: 'Client Name',columntype: 'textbox', filtertype: 'input', datafield: 'refname', width: '30%' },
	        					{ text: 'Project Name',columntype: 'textbox', filtertype: 'input', datafield: 'project_name', width: '40%' }
	        	              ]
	                    });
	            $('#jqxProjectSearch1').on('rowdoubleclick', function (event) {
	                var rowindex1=event.args.rowindex;
	                document.getElementById("docno").value= $('#jqxProjectSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
	                document.getElementById("txtprojectname").value = $("#jqxProjectSearch1").jqxGrid('getcellvalue', rowindex1, "project_name");
	                $("#projectDate").jqxDateTimeInput('val', $("#jqxProjectSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
	                document.getElementById("txtclientname").value = $("#jqxProjectSearch1").jqxGrid('getcellvalue', rowindex1, "refname");
	            }); 
	            
	            
	            
	            $('#txtclientname').dblclick(function(){
	            	clientSearchContent('clientDetailsGrid.jsp');
	       		});
          });

function clientSearchContent(url) {
    $('#clientDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#clientDetailsWindow').jqxWindow('setContent', data);
	$('#clientDetailsWindow').jqxWindow('bringToFront');
}); 
}

function funReadOnly(){
	$('#frmProject input').attr('readonly', true );
	$('#projectDate').jqxDateTimeInput({disabled: true});
}

function funRemoveReadOnly(){
	$('#frmProject input').attr('readonly', false );
	$('#projectDate').jqxDateTimeInput({disabled: false});
	$('#txtclientname').prop('readonly', true);
	$('#docno').prop('readonly', true);
}

function setValues(){	
   
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }

}

function funFocus(){
	$('#projectDate').jqxDateTimeInput('focus'); 
}
   
    /* Validations */
	   $(function(){
	        $('#frmProject').validate({
	                rules: {
	                txtclientname:"required",
	                txtprojectname:"required"
	                 },
	                 messages: {
	                 txtclientname:" *",
	                 txtprojectname:" *"
	                 }
	        });});
     
function funNotify(){
   return 1;
} 

function funSearchLoad(){
    changeContent('projectSearch.jsp');
}
     
function getClient(event){
  var x= event.keyCode;
  if(x==114){
	  clientSearchContent('clientDetailsGrid.jsp');
  }
  else{
   }
}
function funExcelBtn(){
	  $("#jqxProjectSearch1").jqxGrid('exportdata', 'xls', 'Project');
}
</script>
</head>
<body onload="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmProject" action="saveActionProject" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>  
<fieldset><legend>Project Details</legend>
<table width="100%">
<tr>
  <td align="right">Date</td>
  <td><div id="projectDate" name="projectDate" value='<s:property value="projectDate"/>'></div>
    <input type="hidden" id="hidprojectDate" name="hidprojectDate" value='<s:property value="hidprojectDate"/>'/></td>
  <td align="right">Doc No</td>
  <td><input type="text" id="docno" name="txtprojectdocno" style="width:25%;" value='<s:property value="txtprojectdocno"/>' tabindex="-1"/></td>
</tr>
<tr>
  <td width="9%" align="right">Client</td>
  <td width="31%"><input type="text" name="txtclientname" id="txtclientname" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txtclientname"/>' onkeydown="getClient(event);">
  <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/></td>
  <td width="12%" align="right">Project Name</td>
  <td width="48%"><input type="text" name="txtprojectname"  id="txtprojectname"  style="width:70%;" value='<s:property value="txtprojectname"/>'></td>
</tr>
</table>
<br/>
</fieldset><br/>
<div id="jqxProjectSearch1"></div> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</form>
<div id="clientDetailsWindow">
	<div></div><div></div>
</div>
</div>
</body>
</html>