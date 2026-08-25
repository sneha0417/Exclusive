<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%@page import="com.controlcentre.settings.productsettings.productmaster.ClsProductMasterDAO"%>
<%ClsProductMasterDAO DAO= new ClsProductMasterDAO(); %>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
      $(document).ready(function () {  
    	  $('#btnSearch').attr('disabled', true);
    	  $("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  
    	  getBrand();
    	    document.getElementById("formdet").innerText="Model(MOD)";
			document.getElementById("formdetail").value="Model";
			document.getElementById("formdetailcode").value="MOD";
			window.parent.formCode.value="MOD";
			window.parent.formName.value="Model";
          var data= '<%=DAO.modellist(session) %>';
              
              var num = 0; 
              var source =
              {
                  datatype: "json",
                  datafields: [
                            	{name : 'doc_no' , type: 'int' },
       						{name : 'model', type: 'String'  },
                            	{name : 'date', type: 'date'  },
                            	{name : 'brand',type:'String'},
                            	{name : 'brandid',type:'String'}
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
      


              $("#jqxModelSearch1").jqxGrid(
                      {
                      	width: '70%',
                          height: 350,
                          source: dataAdapter,
                          showfilterrow: true,
                          filterable: true,
                          selectionmode: 'multiplecellsextended',
                        //  pagermode: 'default',
                          sortable: true,
                          //pageable: true,
                          altrows:true,
                          //Add row method
                          columns: [
          					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '20%' },
          					{ text: 'Brand ID',columntype: 'textbox', filtertype: 'input', datafield: 'brandid', width: '30%' },
          					{ text: 'Model',columntype: 'textbox', filtertype: 'input', datafield: 'model', width: '30%' },
          					{ text: 'Date',columntype: 'textbox',filtertype: 'input',datafield:'date',width: '20%',cellsformat:'dd.MM.yyyy'},
          					{ text: 'Brand',columntype: 'textbox', filtertype: 'input', datafield: 'brand', width: '30%' },

          	              ]
                      });

              $('#jqxModelSearch1').on('rowdoubleclick', function (event) 
              		{
  		            	var rowindex1=event.args.rowindex;
  		                document.getElementById("docno").value= $('#jqxModelSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
  		                document.getElementById("model").value = $("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "model");
  		              $('#frmModel select').attr('disabled', false);
  		    		$('#date').jqxDateTimeInput({disabled: false});
  		                $("#date").jqxDateTimeInput('val',$("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
  		               // $('#brandid').val($("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "brandid")) ;
  		                $('#brand').val($("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "brandid")) ;
  		              $('#frmModel select').attr('disabled', true);
  		    		$('#date').jqxDateTimeInput({disabled: true});
              		 }); 
              $("#jqxModelSearch1").jqxGrid('hidecolumn', 'brandid'); 
              //$("#jqxModelSearch").jqxGrid('hidecolumn', 'brandid'); 

          });
    
      function funSearchLoad(){
			changeContent('modelSearch.jsp', $('#window')); 
		 }

	function funReadOnly() {
		$('#frmModel input').attr('readonly', true);
		$('#frmModel select').attr('disabled', true);
		$('#date').jqxDateTimeInput({disabled: true});
		/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
		
	}
	function funRemoveReadOnly() {
		$('#frmModel input').attr('readonly', false);
		$('#frmModel select').attr('disabled', false);
		$('#date').jqxDateTimeInput({disabled: false});
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
					/* document.getElementById("brandid").value=brandidItems[i]; */
				}
				
				
				$("select#brand").html(optionsbrand);
				$('#brand').val($('#brandid').val());
				} else {
			}
		}
		x.open("GET", "getBrand.jsp", true);
		x.send();
	}
	
	function funFocus(){
		document.getElementById("brand").focus();
	}
	 $(function(){
	        $('#frmModel').validate({
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
	        });});
	     function funNotify(){
	    	
	    		return 1;
		} 
	     
	function setValues() {
		//$('#brand').val($('#brandid').val());
if ($('#brandid').val() != null) {
	//alert("ghcj");
			$('#brand').val($('#brandid').val());
}
if($('#msg').val()!=""){
	   $.messager.alert('Message',$('#msg').val());
	  }
	}
</script>
</head>
<body onLoad="setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmModel" action="savepmmAction"  autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset><legend>Model Details</legend>
<table width="100%">
<tr>
  <td width="14%"><div align="right">Date</div></td>
  <td width="12%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
  <td width="23%"><div align="right">Doc No</div></td>
  <td width="51%"><input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly="readonly"  tabindex="-1"></td>
</tr>
<tr><td><div align="right">Brand</div></td>
<td> 
<!-- <option value="">--Select--</option> -->
 <select name="brand" id="brand" style="width:100%;"  ></select></td>
 <td><div align="right">Model</div></td><td><input type="text" name="model"  id="model" value='<s:property value="model"/>'></td></tr>
<input type="hidden" id="brandid" name="brandid" value='<s:property value="brandid"/>'>

<td><input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' /> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' /></td>

</table> 
</fieldset>    
</form>
<br/>
<div id="jqxModelSearch1"></div>
<%-- <div id="window">
	<div id="windowHeader" class="windowHead">
		<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search</span>
	</div>
	<div id="windowContent" class="windowCont" style="overflow: hidden;">
		<jsp:include page="modelSearch.jsp"></jsp:include>
	</div></div> --%>
	
</div>
</body>
</html>