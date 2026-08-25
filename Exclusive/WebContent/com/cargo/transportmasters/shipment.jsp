<%@page import="com.cargo.transportmasters.shipment.ClsShipmentDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="s" uri="/struts-tags"%>
    <% ClsShipmentDAO cd=new ClsShipmentDAO();  %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
 
<script type="text/javascript">
$(document).ready(function () {     
	 $("#shipmentdate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
	 
	   var temp=document.getElementById("docno").value;
	 
	   document.getElementById("formdet").innerText="Shipment (SPT)";
		document.getElementById("formdetail").value="Shipment";
		document.getElementById("formdetailcode").value="SPT";
		window.parent.formCode.value="SPT";
		window.parent.formName.value="Shipment";	
		
		
		var data= '<%=cd.getShipmentGrid()%>';
		
	 var source =
	 {
	     datatype: "json",
	     datafields: [
	               	{name : 'doc_no' , type: 'int' },
	 				{name : 'date', type: 'date'  },
	               	{name : 'shipment', type: 'String'  },
	               	
	      ],
	      localdata: data,
	     
	     
	     pager: function (pagenum, pagesize, oldpagenum) {
	         // callback called when a page or page size is changed.
	     }
	 };

	 var dataAdapter = new $.jqx.dataAdapter(source,
	 		 {
	     		loadError: function (xhr, status, error) {
	              // alert(error);    
	               }
	           }		
	 ); 
	 $("#shipmentgridid").jqxGrid(
	         {
	         	width: '100%',
	         	height:310,
	             source: dataAdapter,
	             showfilterrow: true,
	             filterable: true,
	             selectionmode: 'singlerow',
	             sortable: true,
	             altrows:true,
	             //Add row method
	             columns: [
	 				{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '30%' },
	 				{ text: 'Date',datafield: 'date', filtertype: 'date' , width: '30%', cellsformat:'dd.MM.yyyy' },
	 				{ text: 'Shipment',filtertype: 'textbox', datafield: 'shipment', width: '40%' },
	 			

	               ]
	         });
	 $('#shipmentgridid').on('rowdoubleclick', function (event) {
         var rowindex1=event.args.rowindex;
         
         document.getElementById("docno").value= $('#shipmentgridid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
         $("#shipmentdate").jqxDateTimeInput('val', $("#shipmentgridid").jqxGrid('getcellvalue', rowindex1, "date"));
         document.getElementById("shipmentid").value = $("#shipmentgridid").jqxGrid('getcellvalue', rowindex1, "shipment");
  
         
         $('#window').jqxWindow('hide');
     }); 
   
});

function funFocus(){
	document.getElementById("shipmentid").focus();
}

function funReadOnly() {
	$('#docno').attr('readonly', true);
	$('#shipmentdate').jqxDateTimeInput({ disabled: true}); 
	$('#shipmentid').attr('readonly', true);
	$('#shipmentgridid').attr('readonly', true);
}

function funRemoveReadOnly() {
	$('#shipmentdate').jqxDateTimeInput({ disabled: false}); 
	$('#shipmentid').attr('readonly', false);
	$('#docno').attr('readonly', true);
	$('#shipmentgridid').attr('readonly', false);
}

function setValues() {
	
	
	
	if($('#msg').val()!=''){
		$.messager.alert('Message',$('#msg').val());
	}
}
function funNotify(){
	if(document.getElementById("shipmentid").value==''){
		document.getElementById("errormsg").innerText="Shipment is Mandatory.";
		return 0;
	}
	return 1;
}

function funChkButton() {
	   /* funReset(); */
	  }
function funSearchLoad(){
	
	changeContent('shipmentSearch.jsp'); 
 }
</script>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmshipment" action="saveShipment" method="post" autocomplete="off" >
	<jsp:include page="../../../header.jsp" />
	<br/> 
<fieldset><legend>Shipment</legend>
<table width="100%">

    </table>
    <table>
     <tr>
    <td align="right" width="6%">Date</td>
     <td><div id="shipmentdate" name="shipmentdate" value='<s:property value="shipmentdate"/>'></div></td><td></td>
  <td align="right">Doc No</td>
    <td width="15%";><input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>'></td><td></td>
   
  </tr>
  <tr>
    <td align="right">Shipment</td>
   <td><input type="text" name="shipmentid" id="shipmentid" value='<s:property value="shipmentid"/>'></td>
     <td colspan="2">&nbsp;</td>
    </tr>
    
  </table>
</fieldset>



<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

</form>
</div>
<br/>
	
	<tr><td><div id="shipmentgridid"></div></tr>	
	
	
	</div>
	<div>
	</div>
	 </div> 
</body>
</html>