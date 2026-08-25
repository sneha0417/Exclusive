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
			$("#jqxVehicleStatusDate").jqxDateTimeInput({ width: '70%', height: '15px', formatString:"dd.MM.yyyy"});
			
			 /* Grid */
	        <%--  var data1='<%=com.controlcentre.masters.tarifmanagement.tarifmgmt.ClsTarifAction.searchDetails1()%>'; --%>

	         var num = 1; 
	         // prepare the data
	         var source =
	           {
	           datatype: "json",
	           datafields: [
	                       	{name : 'STATUS' , type: 'string' },
	   					    {name : 'STATUSDESCRIPTION', type: 'string'  },
	     				    {name : 'DISPLAY', type: 'string' }
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
	            
	            $("#jqxVehicleStatus").jqxGrid(
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
	                    var cell = $('#jqxVehicleStatus').jqxGrid('getselectedcell');
	                    if (cell != undefined && cell.datafield == 'DISPLAY' && cell.rowindex == num - 1) {
	                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
	                        if (key == 13) {                                                        
	                            var commit = $("#jqxVehicleStatus").jqxGrid('addrow', null, {});
	                            num++;                           
	                        }
	                    }
	                },
	               
	                columns: [
								{ text: 'Status', datafield: 'STATUS', width: '30%' },
								{ text: 'Status Description',  datafield: 'STATUSDESCRIPTION', width: '50%'},
								{ text: 'Display', datafield: 'DISPLAY', width: '20%'   },
	         	              ]
	            });
	            /* Grid Ends*/
	            
});
		function funReset(){
    		$('#frmVehicleStatus')[0].reset(); 
    	}
    	function funReadOnly(){
    		$('#frmVehicleStatus input').attr('readonly', true );
    		$('#frmVehicleStatus select').attr('disabled', true);
    		$('#frmVehicleStatus textarea').attr('readonly', true );
    		$('#jqxVehicleStatusDate').jqxDateTimeInput({ disabled: true});
    	    $("#jqxVehicleStatus").jqxGrid({ disabled: true});
    	}
    	function funRemoveReadOnly(){
    		$('#frmVehicleStatus input').attr('readonly', false );
    		$('#frmVehicleStatus select').attr('disabled', false);
    		$('#frmVehicleStatus textarea').attr('readonly', false );
    		$('#jqxVehicleStatusDate').jqxDateTimeInput({ disabled: false});
    		$("#jqxVehicleStatus").jqxGrid({ disabled: false});
    		$('#txtvehstatusdocno').attr('readonly', true);
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
    	   	$('#jqxVehicleStatusDate').jqxDateTimeInput('focus'); 	    		
     	}
  </script>
</head>
<body onload="funReadOnly();">
<%
	session.setAttribute("FormName", "Vehicle Status");
	session.setAttribute("Code", "VST");
%>
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmVehicleStatus" action="saveVehicleStatus">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div class='hidden-scrollbar'>
<fieldset>
<legend>Vehicle Status</legend>
<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="16%"><div id='jqxVehicleStatusDate' name='jqxVehicleStatusDate' value='<s:property value="jqxVehicleStatusDate"/>'></div>
                   <input type="hidden" id="hidjqxVehicleStatusDate" name="hidjqxVehicleStatusDate" value='<s:property value="hidjqxVehicleStatusDate"/>'/></td>
    <td width="15%">&nbsp;</td>
    <td width="36%">&nbsp;</td>
    <td width="10%" align="right">Doc No</td>
    <td width="17%"><input type="text" id="txtvehstatusdocno" name="txtvehstatusdocno" tabindex="-1" value='<s:property value="txtvehstatusdocno"/>'></td>
  </tr>
  <tr>
    <td align="right">Status</td>
    <td><input type="text" id="txtstatus" name="txtstatus" value='<s:property value="txtstatus"/>'></td>
    <td align="right">Status Description</td>
    <td><textarea id="txtstatusdescription" name="txtstatusdescription" style="width:70%;resize: none;" value='<s:property value="txtstatusdescription"/>'></textarea></td>
    <td align="right">Display</td>
    <td><select id="cmbdisplay" name="cmbdisplay" value='<s:property value="cmbdisplay"/>'>
                   <option>--Select--</option></select>
                   <input type="hidden" id="hidcmbdisplay" name="hidcmbdisplay" value='<s:property value="hidcmbdisplay"/>'/></td>
  </tr>
</table>
<input type="hidden" id="mode" name="mode"/>
<input type="text" name="delete" id="delete" value='<s:property value="delete"/>' hidden="true"/>
</fieldset><br/>
<div id="jqxVehicleStatus"></div>
</div>
</form>
</div>
</body>
</html>