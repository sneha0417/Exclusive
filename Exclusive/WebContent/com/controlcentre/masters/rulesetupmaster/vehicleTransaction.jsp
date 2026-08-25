<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

<script type="text/javascript">
		$(document).ready(function () { 
			
			/* Date */
			$("#jqxVehicleTransDate").jqxDateTimeInput({ width: '70%', height: '15px', formatString:"dd.MM.yyyy"});
			
			 /* Grid */
	        <%--  var data1='<%=com.controlcentre.masters.tarifmanagement.tarifmgmt.ClsTarifAction.searchDetails1()%>'; --%>

	         var num = 1; 
	         // prepare the data
	         var source =
	           {
	           datatype: "json",
	           datafields: [
	                       	{name : 'TRANSCODE' , type: 'string' },
	   					    {name : 'DESCRIPTION', type: 'string'  }
	     				   ],
						/* localdata: data1, */
	                
	                pager: function (pagenum, pagesize, oldpagenum) {
	                    // callback called when a page or pagse size is changed.
	                }
	          };
	           
	          var dataAdapter = new $.jqx.dataAdapter(source,
	           		 {
	               		loadError: function (xhr, status, error) {
		                 alert(error);    
		              }
				            
			        });
	            
	            $("#jqxVehicleTransaction").jqxGrid(
	            {
	            	width: '99.5%',
	                height: 330,
	                source: dataAdapter,
	                columnsresize: true,
	                pageable: true,
	                editable: true,
	                altRows: true,
	                showfilterrow: true, 
	                filterable: true, 
	                sortable: true,
	                selectionmode: 'singlerow',
	                pagermode: 'default',
	                
	                //Add row method
	                handlekeyboardnavigation: function (event) {
	                    var cell = $('#jqxVehicleTransaction').jqxGrid('getselectedcell');
	                    if (cell != undefined && cell.datafield == 'DESCRIPTION' && cell.rowindex == num - 1) {
	                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
	                        if (key == 13) {                                                        
	                            var commit = $("#jqxVehicleTransaction").jqxGrid('addrow', null, {});
	                            num++;                           
	                        }
	                    }
	                },
	               
	                columns: [
								{ text: 'Transaction Code', datafield: 'TRANSCODE', width: '15%' },
								{ text: 'Description',  datafield: 'DESCRIPTION', width: '85%'}
	         	              ]
	            });
	            /* Grid Ends*/
	            
});
		function funReset(){
    		$('#frmVehicleTransaction')[0].reset(); 
    	}
    	function funReadOnly(){
    		$('#frmVehicleTransaction input').attr('readonly', true );
    		$('#frmVehicleTransaction textarea').attr('readonly', true );
    		$('#jqxVehicleTransDate').jqxDateTimeInput({ disabled: true});
    	    $("#jqxVehicleTransaction").jqxGrid({ disabled: true});
    	}
    	function funRemoveReadOnly(){
    		$('#frmVehicleTransaction input').attr('readonly', false );
    		$('#frmVehicleTransaction textarea').attr('readonly', false );
    		$('#jqxVehicleTransDate').jqxDateTimeInput({ disabled: false});
    		$("#jqxVehicleTransaction").jqxGrid({ disabled: false});
    		$('#txtvehtransactiondocno').attr('readonly', true);
    	}
    	
    	function funNotify(){	
    		return 1;
     	} 

     	function funChkButton() {
    		/* funReset(); */
    	}

    	function funSearchLoad(){
    		/* changeContent('cpvMainSearch.jsp', $('#window')); */ 
    	}
    		
     	function funFocus(){
    	   	$('#jqxVehicleTransDate').jqxDateTimeInput('focus'); 	    		
     	}
  </script>
</head>
<body onload="funReadOnly();">
<%
	session.setAttribute("FormName", "Vehicle Transaction");
	session.setAttribute("Code", "VTR");
%>
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmVehicleTransaction" action="saveVehicleTransaction">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div class='hidden-scrollbar'>
<fieldset>
<legend>Vehicle Transaction</legend>
<table width="100%">
  <tr>
    <td width="9%" align="right">Date</td>
    <td width="19%"><div id='jqxVehicleTransDate' name='jqxVehicleTransDate' value='<s:property value="jqxVehicleTransDate"/>'></div>
                   <input type="hidden" id="hidjqxVehicleTransDate" name="hidjqxVehicleTransDate" value='<s:property value="hidjqxVehicleTransDate"/>'/></td>
    <td width="15%" align="right">Transaction Code</td>
    <td width="24%"><input type="text" id="txttransactioncode" name="txttransactioncode" value='<s:property value="txttransactioncode"/>'></td>
    <td width="7%" align="right">Doc No</td>
    <td width="26%"><input type="text" id="txtvehtransactiondocno" name="txtvehtransactiondocno" tabindex="-1" value='<s:property value="txtvehtransactiondocno"/>'></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="5"><textarea id="txttransdescription" name="txttransdescription" style="width:51%;resize: none;" value='<s:property value="txttransdescription"/>'></textarea></td>
  </tr>
</table>
<input type="hidden" id="mode" name="mode"/>
<input type="text" name="delete" id="delete" value='<s:property value="delete"/>' hidden="true"/>
</fieldset><br/>
<div id="jqxVehicleTransaction"></div>
</div>
</form>
</div>
</body>
</html>