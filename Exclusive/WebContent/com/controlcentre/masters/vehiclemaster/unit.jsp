 <%@page import="com.controlcentre.masters.vehiclemaster.unit.ClsUnitAction" %>
<% ClsUnitAction cua =new ClsUnitAction();%>

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
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
var data= '<%=cua.searchDetails() %>';
$(document).ready(function () { 	

	document.getElementById("formdet").innerText="Unit(UOM)";
	document.getElementById("formdetail").value="Unit";
	document.getElementById("formdetailcode").value="UOM";
	window.parent.formCode.value="UOM";
	window.parent.formName.value="Unit";
    
    var num = 0; 
    var source =
    {
        datatype: "json",
        datafields: [
                  	    {name : 'DOC_NO' , type: 'number' },
						{name : 'unit', type: 'String'  },
						{name : 'unit_desc', type:  'String'}
                  	
         ],
         localdata: data,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
            }		
    );
  
    $("#jqxUnitSearch1").jqxGrid(
            {
            	width: '70%',
                height: 337,
                source: dataAdapter,
                showfilterrow: true,
                filterable: true,
                selectionmode: 'multiplecellsextended',
                //pagermode: 'default',
                sortable: true,
                //pageable: true,
                altrows:true,
                //Add row method
                columns: [
					{ text: 'Doc No',filtertype: 'number', datafield: 'DOC_NO', width: '30%' },
					{ text: 'Unit',columntype: 'textbox', filtertype: 'input', datafield: 'unit', width: '30%' },
					{ text: 'Description',columntype: 'textbox', filtertype: 'input', datafield: 'unit_desc',width: '40%'}
	              ]
            });
    $('#jqxUnitSearch1').on('rowdoubleclick', function (event) 
    		{ 
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxUnitSearch1').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
                document.getElementById("unit").value = $("#jqxUnitSearch1").jqxGrid('getcellvalue', rowindex1, "unit");
                document.getElementById("unitdesc").value = $("#jqxUnitSearch1").jqxGrid('getcellvalue', rowindex1, "unit_desc");
    		 });
});

function funSearchLoad(){
		changeContent('unitSearch.jsp', $('#window')); 
	 }
	function funReadOnly() {
		$('#frmUnit input').attr('readonly', true);
		/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmUnit input').attr('readonly', false);
		//$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
	}
	 function setValues(){	
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }

			}
		    function funFocus()
		    {
		    	document.getElementById("unit").focus();
		    		
		    }
		    $(function(){
		        $('#frmUnit').validate({
		                 rules: {
		                 unit:{
		                	 required:true,
		                	 maxlength:3
		                 }, 
		                unitdesc:{
		                	maxlength:25
		                	}
		                
		                 },
		                 messages: {
		                  unit:{
		                	  required:" *",
		                	  maxlength:"max 3 chars"
		                  },
		                  unitdesc:{
		                	  maxlength:"max 25 chars"
		                  }
		                 }
		        });});
		     function funNotify(){
		    	 
		    		return 1;
			} 
		     function funExcelBtn(){
		   	  $("#jqxUnitSearch1").jqxGrid('exportdata', 'xls', 'Unit');
		   }
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmUnit" action="saveActionUnit"  autocomplete="off">

<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset>
<legend>Unit Details</legend>
				<table width="100%">
					<tr>
						<td width="9%" align="right">Unit</td>
						<td width="45%" align="left"><input type="text" name="unit"
							value='<s:property value="unit"/>' id="unit" ></td>
						<td width="4%" align="right">Doc No</td>
						<td width="42%" align="left"><input type="text" name="docno"
							value='<s:property value="docno"/>' id="docno"
							readonly="readonly" tabindex="-1"></td>
					</tr>
					<tr>
						<td align="right">Description</td>
						<td align="left"><input type="text" name="unitdesc"
							 value='<s:property value="unitdesc"/>'
							id="unitdesc"></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</fieldset>
			<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="text" name="deleted"  hidden="hidden" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="mode" hidden="hidden" name="mode"/>
</form>
<br/>
<div id="jqxUnitSearch1"></div>
<%-- <div id="window">
	<div id="windowHeader" class="windowHead">
		<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search</span>
	</div>
	<div id="windowContent" class="windowCont" style="overflow: hidden;">
		<jsp:include page="unitSearch.jsp"></jsp:include>
	</div></div> --%>
	
</div>
</body>
</html>