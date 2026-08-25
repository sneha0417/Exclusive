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
	
			 /* Grid */
	        <%--  var data1='<%=com.controlcentre.masters.tarifmanagement.tarifmgmt.ClsTarifAction.searchDetails1()%>'; --%>

	         var num = 1; 
	         // prepare the data
	         var source =
	           {
	           datatype: "json",
	           datafields: [
	                       	{name : 'METHODNAME' , type: 'string' },
	   					    {name : 'METHOD', type: 'string'  },
	     				    {name : 'DESCRIPTION', type: 'string' }
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
	            
	            $("#jqxMethodSettings").jqxGrid(
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
	                    var cell = $('#jqxMethodSettings').jqxGrid('getselectedcell');
	                    if (cell != undefined && cell.datafield == 'DESCRIPTION' && cell.rowindex == num - 1) {
	                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
	                        if (key == 13) {                                                        
	                            var commit = $("#jqxMethodSettings").jqxGrid('addrow', null, {});
	                            num++;                           
	                        }
	                    }
	                },
	               
	                columns: [
								{ text: 'Method Name', datafield: 'METHODNAME', width: '40%' },
								{ text: 'Method',  datafield: 'METHOD', width: '20%'},
								{ text: 'Description', datafield: 'DESCRIPTION', width: '40%'   },
	         	              ]
	            });
	            /* Grid Ends*/
	            
});
		function funReset(){
    		$('#frmMethodSettings')[0].reset(); 
    	}
    	function funReadOnly(){
    		$('#frmMethodSettings input').attr('readonly', true );
    		$('#frmMethodSettings select').attr('disabled', true);
    	    $("#jqxMethodSettings").jqxGrid({ disabled: true});
    	}
    	function funRemoveReadOnly(){
    		$('#frmMethodSettings input').attr('readonly', false );
    		$('#frmMethodSettings select').attr('disabled', false);
    		$("#jqxMethodSettings").jqxGrid({ disabled: false});
    		$('#txtmethodsettingdocno').attr('readonly', true);
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
    	   	document.getElementById("txtmethodname").focus(); 	    		
     	}
  </script>
</head>
<body onload="funReadOnly();">
<%
	session.setAttribute("FormName", "Settings Master");
	session.setAttribute("Code", "MET");
%>
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmMethodSettings" action="saveMethodSettings">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div class='hidden-scrollbar'>
<fieldset>
<legend>Method Settings</legend>
<table width="100%">
  <tr>
    <td width="11%" align="right">Method Name</td>
    <td width="15%"><input type="text" id="txtmethodname" name="txtmethodname" value='<s:property value="txtmethodname"/>'/></td>
    <td width="15%" align="right">Method</td>
    <td width="9%"><select id="cmbmethod" name="cmbmethod" value='<s:property value="cmbmethod"/>'>
                   <option>--Select--</option></select>
                   <input type="hidden" id="hidcmbmethod" name="hidcmbmethod" value='<s:property value="hidcmbmethod"/>'/></td>
    <td width="27%"><input type="text" id="txtmethoddesc" name="txtmethoddesc" value='<s:property value="txtmethoddesc"/>'></td>
    <td width="9%" align="right">Doc No</td>
    <td width="14%"><input type="text" id="txtmethodsettingdocno" name="txtmethodsettingdocno" tabindex="-1" value='<s:property value="txtmethodsettingdocno"/>'></td>
  </tr>
</table>
<input type="hidden" id="mode" name="mode"/>
<input type="text" name="delete" id="delete" value='<s:property value="delete"/>' hidden="true"/>
</fieldset><br/>
<div id="jqxMethodSettings"></div>
</div>
</form>
</div>
</body>
</html>