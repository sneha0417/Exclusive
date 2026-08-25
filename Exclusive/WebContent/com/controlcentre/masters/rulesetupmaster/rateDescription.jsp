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
			$("#jqxRateDescDate").jqxDateTimeInput({ width: '50%', height: '15px', formatString:"dd.MM.yyyy"});
			
			 /* Grid */
	        <%--  var data1='<%=com.controlcentre.masters.tarifmanagement.tarifmgmt.ClsTarifAction.searchDetails1()%>'; --%>

	         var num = 1; 
	         // prepare the data
	         var source =
	           {
	           datatype: "json",
	           datafields: [
	                       	{name : 'RENTTYPE' , type: 'string' },
	   					    {name : 'RENTDESCRIPTION', type: 'string'  },
	     				    {name : 'EDITABLE', type: 'string' },
	     				    {name : 'CUSTOMERPREFERENCE', type: 'string' },
	     				    {name : 'ACCOUNTNO', type: 'string' },
	     				    {name : 'ACCOUNTNAME', type: 'string' }
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
	            
	            $("#jqxRateDescription").jqxGrid(
	            {
	            	width: '99.5%',
	                height: 350,
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
	                    var cell = $('#jqxRateDescription').jqxGrid('getselectedcell');
	                    if (cell != undefined && cell.datafield == 'ACCOUNTNAME' && cell.rowindex == num - 1) {
	                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
	                        if (key == 13) {                                                        
	                            var commit = $("#jqxRateDescription").jqxGrid('addrow', null, {});
	                            num++;                           
	                        }
	                    }
	                },
	               
	                columns: [
								{ text: 'Rent Type', datafield: 'RENTTYPE', width: '10%' },
								{ text: 'Rent Description',  datafield: 'RENTDESCRIPTION', width: '30%'},
								{ text: 'Editable', datafield: 'EDITABLE', width: '10%'   },
								{ text: 'Customer Preference', datafield: 'CUSTOMERPREFERENCE', width: '10%' },
								{ text: 'Account No',  datafield: 'ACCOUNTNO', width: '15%'},
								{ text: 'Account Name', datafield: 'ACCOUNTNAME', width: '25%'   },
	         	              ]
	            });
	            /* Grid Ends*/
	            
});
		function funReset(){
    		$('#frmRateDescription')[0].reset(); 
    	}
    	function funReadOnly(){
    		$('#frmRateDescription input').attr('readonly', true );
    		$('#frmRateDescription select').attr('disabled', true);
    		$('#jqxRateDescDate').jqxDateTimeInput({ disabled: true});
    	    $("#jqxRateDescription").jqxGrid({ disabled: true});
    	}
    	function funRemoveReadOnly(){
    		$('#frmRateDescription input').attr('readonly', false );
    		$('#frmRateDescription select').attr('disabled', false);
    		$('#jqxRateDescDate').jqxDateTimeInput({ disabled: false});
    		$("#jqxRateDescription").jqxGrid({ disabled: false});
    		$('#txtratedescdocno').attr('readonly', true);
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
    	   	$('#jqxRateDescDate').jqxDateTimeInput('focus'); 	    		
     	}
  </script>
</head>
<body onload="funReadOnly();">
<%
	session.setAttribute("FormName", "Rate Description");
	session.setAttribute("Code", "RDS");
%>
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmRateDescription" action="saveRateDescription">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div class='hidden-scrollbar'>
<fieldset>
<legend>Rate Description</legend>
<table width="100%">
  <tr>
    <td width="8%" align="right">Date</td>
    <td width="22%"><div id='jqxRateDescDate' name='jqxRateDescDate' value='<s:property value="jqxRateDescDate"/>'></div>
                   <input type="hidden" id="hidjqxRateDescDate" name="hidjqxRateDescDate" value='<s:property value="hidjqxRateDescDate"/>'/></td>
    <td width="8%" align="right">Branch</td>
    <td width="10%"><select id="cmbbranch" name="cmbbranch" value='<s:property value="cmbbranch"/>'>
                   <option>--Select--</option></select>
                   <input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/></td>
    <td width="40%"><input type="text" id="txtbranchname" name="txtbranchname" style="width:60%" value='<s:property value="txtbranchname"/>'></td>
    <td width="6%" align="right">Doc No</td>
    <td width="13%"><input type="text" id="txtratedescdocno" name="txtratedescdocno" tabindex="-1" value='<s:property value="txtratedescdocno"/>'></td>
  </tr>
</table>
<input type="hidden" id="mode" name="mode"/>
<input type="text" name="delete" id="delete" value='<s:property value="delete"/>' hidden="true"/>
</fieldset><br/>
<div id="jqxRateDescription"></div>
</div>
</form>
</div>
</body>
</html>