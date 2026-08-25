<%@page import="com.controlcentre.masters.vehiclemaster.modelnew.*" %>
<%ClsModelNewDAO dao=new ClsModelNewDAO(); %>
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
	$(document).ready(function () {          
    	$("#modeldate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  
    	document.getElementById("formdet").innerText="Model(MOD)";
		document.getElementById("formdetail").value="Model";
		document.getElementById("formdetailcode").value="MOD";
		window.parent.formCode.value="MOD";
		window.parent.formName.value="Model";
        
        var data= '<%=dao.list()%>';
        var source =
        {
        	datatype: "json",
            datafields: [
            	{name : 'doc_no' , type: 'int' },
       			{name : 'vtype', type: 'String'  },
                {name : 'date', type: 'date'  },
                {name : 'brand_name',type:'String'},
                {name : 'brandid',type:'String'},
                {name : 'vehtype',type:'string'},
                {name : 'seat',type:'number'},
                {name : 'door',type:'number'},
                {name : 'luggage',type:'number'},
                {name : 'passengers',type:'number'},
                {name : 'ac',type:'number'},
                {name : 'vehtypedocno',type:'number'},
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
  		});

        $("#jqxModelSearch1").jqxGrid(
        {
        	width: '100%',
            height: 350,
            source: dataAdapter,
            showfilterrow: true,
            filterable: true,
            selectionmode: 'singlerow',
            sortable: true,
            altrows:true,
            columns: [
          		{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
          		{ text: 'Brand ID',columntype: 'textbox', filtertype: 'input', datafield: 'brandid', width: '30%' },
          		{ text: 'Model',columntype: 'textbox', filtertype: 'input', datafield: 'vtype', width: '30%' },
          		{ text: 'Date',columntype: 'textbox',filtertype: 'input',datafield:'date',width: '10%',cellsformat:'dd.MM.yyyy'},
          		{ text: 'Brand',columntype: 'textbox', filtertype: 'input', datafield: 'brand_name', width: '30%' },
				{ text: 'Vehicle Type',columntype: 'textbox', filtertype: 'input', datafield: 'vehtype', width: '20%' },
				{ text: 'Vehicle Type Doc No',columntype: 'textbox', filtertype: 'input', datafield: 'vehtypedocno', width: '20%',hidden:true },
				{ text: 'Seats',columntype: 'textbox', filtertype: 'input', datafield: 'seat', width: '20%',hidden:true },
				{ text: 'Doors',columntype: 'textbox', filtertype: 'input', datafield: 'door', width: '20%',hidden:true },
				{ text: 'Luggages',columntype: 'textbox', filtertype: 'input', datafield: 'luggage', width: '20%',hidden:true },
				{ text: 'Passengers',columntype: 'textbox', filtertype: 'input', datafield: 'passengers', width: '20%',hidden:true },
				{ text: 'AC',columntype: 'textbox', filtertype: 'input', datafield: 'ac', width: '20%',hidden:true }
          	]
        });

        $('#jqxModelSearch1').on('rowdoubleclick', function (event) 
       	{
  			var rowindex1=event.args.rowindex;
  		    document.getElementById("docno").value= $('#jqxModelSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
  		    document.getElementById("model").value = $("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "vtype");
  		    $('#frmModelNew select').attr('disabled', false);
  		    $('#modeldate').jqxDateTimeInput({disabled: false});
  		    $("#modeldate").jqxDateTimeInput('val',$("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
  		    $('#brand').val($("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "brandid")) ;
  		    $('#cmbvehtype').val($("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "vehtypedocno")) ;
  		    $('#frmModelNew select').attr('disabled', true);
  		    $('#modeldate').jqxDateTimeInput({disabled: true});
			document.getElementById("cmbseat").value = $("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "seat");
			document.getElementById("cmbdoor").value = $("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "door");
			document.getElementById("cmbluggage").value = $("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "luggage");
			document.getElementById("cmbpassengers").value = $("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "passengers");
			document.getElementById("cmbac").value = $("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "ac");
        }); 
        
        $("#jqxModelSearch1").jqxGrid('hidecolumn', 'brandid'); 
        //$("#jqxModelSearch").jqxGrid('hidecolumn', 'brandid'); 
    });
    
    function funSearchLoad(){
		changeContent('modelnewSearch.jsp', $('#window')); 
	}

	function funReadOnly() {
		$('#frmModelNew input').attr('readonly', true);
		$('#frmModelNew select').attr('disabled', true);
		$('#modeldate').jqxDateTimeInput({disabled: true});
		/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}

	function funRemoveReadOnly() {
		$('#frmModelNew input').attr('readonly', false);
		$('#frmModelNew select').attr('disabled', false);
		$('#modeldate').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true);
	}

	function getBrand() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('***');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
				}
				$("select#brand").html(optionsbrand);
				$('#brand').val($('#brandid').val());
				} else {
			}
		}
		x.open("GET", "getBrand.jsp", true);
		x.send();
	}
	
	function getVehicleType() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText.trim();
				items = JSON.parse(items);
				var htmldata = '<option value="">--Select--</option>';
				$.each(items.vehtypearray, function( key, value ) {
					htmldata+='<option value="'+value.docno+'">'+value.name+'</option>';
				});
				$("select#cmbvehtype").html($.parseHTML(htmldata));
				$('#cmbvehtype').val($('#hidcmbvehtype').val());
				} else {
			}
		}
		x.open("GET", "getVehicleType.jsp", true);
		x.send();
	}
	function funFocus(){
		document.getElementById("brand").focus();
	}
	$(function(){
		$('#frmModelNew').validate({
	    	rules: {
	        	brand:{
	            	required:true
	            },
	            model:{
	            	required:true,
	                maxlength:20
	            }
	        },
	        messages: {
	        	brand:{
	            	required:" *"
	            },
	            model:{
	            	required:" *",
	                maxlength:"max 20 chars"
	            }
	        }
	   });
	});
	 
	function funNotify(){
		return 1;
	} 
	     
	function setValues() {
		if($('#brandid').val() != null) {
			$('#brand').val($('#brandid').val());
		}
		if($('#hidcmbvehtype').val()!=null && $('#hidcmbvehtype').val()!='') {
			$('#cmbvehtype').val($('#hidcmbvehtype').val());
		}
		if($('#hidcmbdoor').val()!=null && $('#hidcmbdoor').val()!='') {
			$('#cmbdoor').val($('#hidcmbdoor').val());
		}
		if($('#hidcmbseat').val()!=null && $('#hidcmbseat').val()!='') {
			$('#cmbseat').val($('#hidcmbseat').val());
		}
		if($('#hidcmbluggage').val()!=null && $('#hidcmbluggage').val()!='') {
			$('#cmbluggage').val($('#hidcmbluggage').val());
		}
		if($('#hidcmbpassengers').val()!=null && $('#hidcmbpassengers').val()!='') {
			$('#cmbpassengers').val($('#hidcmbpassengers').val());
		}
		if($('#hidcmbac').val()!=null && $('#hidcmbac').val()!='') {
			$('#cmbac').val($('#hidcmbac').val());
		}
		if($('#msg').val()!=""){
	   		$.messager.alert('Message',$('#msg').val());
	  	}
	}
	
	function funExcelBtn(){
		$("#jqxModelSearch1").jqxGrid('exportdata', 'xls', 'Model');
	}
</script>
</head>
<body onLoad="getBrand();setValues();getVehicleType();">
<div id="mainBG" class="homeContent" data-type="background">
	<form id="frmModelNew" action="saveActionModelNew"  autocomplete="off">
		<jsp:include page="../../../../header.jsp" /><br/> 
		<fieldset><legend>Model Details</legend>
			<input type="text" id="brandid" name="brandid" value='<s:property value="brandid"/>' hidden="true">
			<table width="100%">
				<tr>
  					<td width="14%"><div align="right">Date</div></td>
  					<td width="12%"><div id="modeldate" name="modeldate" value='<s:property value="modeldate"/>'></div></td>
  					<td width="23%"><div align="right">Doc No</div></td>
  					<td width="51%"><input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly="readonly"  tabindex="-1"></td>
				</tr>
				<tr>
					<td><div align="right">Brand</div></td>
					<td>
						<select name="brand" id="brand" style="width:100%;">
							<option value="">--Select--</option>
						</select>
					</td>
					<td><div align="right">Model</div></td>
					<td><input type="text" name="model" id="model" value='<s:property value="model"/>'></td>
				</tr>
				<tr>
					<td align="right">Vehicle Type</td>
					<td><select name="cmbvehtype" id="cmbvehtype" style="width:100%;"><option value="">--Select--</option></select></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="4">
						<table style="width:100%;border:1px solid #000;">
							<tr>
								<td align="right">Doors</td>
								<td>
									<select name="cmbdoor" id="cmbdoor" style="width:80%;">
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
									</select>
								</td>
								<td align="right">Seats</td>
								<td>
									<select name="cmbseat" id="cmbseat" style="width:80%;">
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="6">7</option>
										<option value="6">8</option>
									</select>
								</td>
								<td align="right">Luggages</td>
								<td>
									<select name="cmbluggage" id="cmbluggage" style="width:80%;">
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="6">7</option>
										<option value="6">8</option>
									</select>
								</td>
								<td align="right">Passengers</td>
								<td>
									<select name="cmbpassengers" id="cmbpassengers" style="width:80%;">
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
									</select>
								</td>
								<td align="right">AC</td>
								<td>
									<select name="cmbac" id="cmbac" style="width:80%;">
										<option value="1">Yes</option>
										<option value="0">No</option>
									</select>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table> 
		</fieldset>
		
		<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
		<input type="hidden" id="hidcmbvehtype" name="hidcmbvehtype"  value='<s:property value="hidcmbvehtype"/>'/>
		<input type="hidden" id="hidcmbdoor" name="hidcmbdoor"  value='<s:property value="hidcmbdoor"/>'/>
		<input type="hidden" id="hidcmbseat" name="hidcmbseat"  value='<s:property value="hidcmbseat"/>'/>
		<input type="hidden" id="hidcmbluggage" name="hidcmbluggage"  value='<s:property value="hidcmbluggage"/>'/>
		<input type="hidden" id="hidcmbpassengers" name="hidcmbpassengers"  value='<s:property value="hidcmbpassengers"/>'/>
		<input type="hidden" id="hidcmbac" name="hidcmbac"  value='<s:property value="hidcmbac"/>'/>
		<input type="hidden" id="mode" name="mode"/>
		<input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>    
	</form>
	<br/>
	<div id="jqxModelSearch1"></div>
</div>
</body>
</html>