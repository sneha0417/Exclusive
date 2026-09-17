<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<%@page import="com.operations.clientrelations.clientcategory.ClsClientCategoryDAO"%>
<% ClsClientCategoryDAO DAO= new ClsClientCategoryDAO(); %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

.modern-ui form label.error {
    color: red;
    font-weight: bold;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }
</style>

<script type="text/javascript">

	/* Grid */
	 var data= '<%= DAO.category() %>'; 
	 $(document).ready(function () {
		 getAccountGroup();
		 
	     var source =
	     {
	         datatype: "json",
	         datafields: [
						{name : 'doc_no', type: 'int'  },
						{name : 'dtypes', type: 'String'  },
					    {name : 'category', type: 'String'  },
	                    {name : 'cat_name', type: 'String'  },
	                    {name : 'description', type: 'String'  },
	                    { name: 'approved', type: 'bool' },
	                    {name : 'dtype', type: 'String'  },
	                    { name: 'approval', type: 'int' },
	                    {name : 'acc_group', type: 'String'  }
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
	     
	     $("#jqxCategorySearch1").jqxGrid(
	             {
	             	 width: '100%',
	                 height: 375,
	                 source: dataAdapter,
	                 showfilterrow: true,
	                 filterable: true,
	                 selectionmode: 'singlerow',
	                 
	                 columns: [
							  { text: 'Type',columntype: 'textbox', filtertype: 'input', datafield: 'dtypes', width: '10%' },
	 						  { text: 'Category',columntype: 'textbox', filtertype: 'input', datafield: 'category', width: '20%' },
	 						  { text: 'Category Name',columntype: 'textbox', filtertype: 'input', datafield: 'cat_name', width: '30%' },
	 						  { text: 'Account Group',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '30%' },
	 						  { text: 'Approval', datafield: 'approved', columntype: 'checkbox', filterable: false, checked: true, width: '10%',cellsalign: 'center', align: 'center' },
	 						  { text: 'Doc No', datafield: 'doc_no', hidden: true, filterable: false, width: '10%' },
	 						  { text: 'Dtype', datafield: 'dtype', hidden: true, filterable: false, width: '10%' },
	 						  { text: 'Approval', datafield: 'approval', hidden: true, filterable: false, width: '10%' },
	 						  { text: 'Account Group', filterable: false, datafield: 'acc_group', hidden: true, width: '10%' },
	 					
	 	              ]
	             });
	     $('#jqxCategorySearch1').on('rowdoubleclick', function (event) {
	         var rowindex1=event.args.rowindex;
			 getAccountGroup($("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "dtype"));
	         document.getElementById("docno").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "doc_no");
	         document.getElementById("cmbtype").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "dtype");
	         document.getElementById("txtcategory").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "category");
	         document.getElementById("txtcategoryname").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "cat_name");
	         document.getElementById("cmbaccountgroup").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "acc_group");
			 document.getElementById("hidcmbaccountgroup").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "acc_group");
	         document.getElementById("hidchckapproval").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "approval");
	         
	         if($("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "approval")==1){
	 			 document.getElementById("chckapproval").checked = true;
	 		 }
	 		 else if($("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "approval")==0){
	 			document.getElementById("chckapproval").checked = false;
	 		 }
	     }); 
	});
 
    /* Validations */
      $(function(){
	        $('#frmClientCategory').validate({
	                rules: {
	                cmbtype:"required",	
	                txtcategory:"required",
	                txtcategoryname:"required",
	                cmbaccountgroup:"required"
	                },
	                messages: {
	                cmbtype:" *",
	                txtcategory:" *",
	                txtcategoryname:" *",
	                cmbaccountgroup:" *"
	                }
	         });}); 
    
    
      function getAccountGroup(type) {
    		var x = new XMLHttpRequest();
    		x.onreadystatechange = function() {
    			if (x.readyState == 4 && x.status == 200) {
    				var items = x.responseText;
    				items = items.split('####');
    				var groupItems = items[0].split(",");
    				var groupIdItems = items[1].split(",");
    				var optionsgroup = '<option value="">--Select--</option>';
    				for (var i = 0; i < groupItems.length; i++) {
    					optionsgroup += '<option value="' + groupIdItems[i] + '">'
    							+ groupItems[i] + '</option>';
    				}
    				$("select#cmbaccountgroup").html(optionsgroup);
    				if ($('#hidcmbaccountgroup').val() != null) {
    					$('#cmbaccountgroup').val($('#hidcmbaccountgroup').val());
    				}
    			} else {
    			}
    		}
    		x.open("GET", "getAccountGroup.jsp?type="+type, true);
    		x.send();
    	} 
    
      function approval(){
  		 if(document.getElementById("chckapproval").checked){
  			 document.getElementById("hidchckapproval").value = 1;
  		 }
  		 else{
  			 document.getElementById("hidchckapproval").value = 0;
  		 }
  	 }
	
	function funReadOnly() {
		$('#frmClientCategory input').attr('readonly', true);
		$('#frmClientCategory select').attr('disabled', true);
		$('#chckapproval').attr('disabled', true);
	}
	
	function funRemoveReadOnly() {
		$('#frmClientCategory input').attr('readonly', false);
		$('#frmClientCategory select').attr('disabled', false);
		$('#chckapproval').attr('disabled', false);
		
		if ($("#mode").val() == "A") {
			 $('#hidchckapproval').val(0);
			 document.getElementById("chckapproval").checked = false;
		}
	}
	
	function funNotify(){	
		   return 1;
	} 
	 
	function funChkButton() {
		/* funReset(); */
	}
	
	function funSearchLoad(){
	   changeContent('categoryMainSearchGrid.jsp');  
	}
	 
	function funFocus()
	 {
		document.getElementById("cmbtype").focus();
	 }
	
	function setValues(){
		
		document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
		
		 if(document.getElementById("hidchckapproval").value==1){
			 document.getElementById("chckapproval").checked = true;
		 }
		 else if(document.getElementById("hidchckapproval").value==0){
			document.getElementById("chckapproval").checked = false;
		 }
		
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 funSetlabel();
	}
	 
</script>
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmClientCategory" action="saveClientCategory" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class="modern-ui hidden-scrollbar">

    <!-- Category Master Form Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title">Category Master</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Type</label>
            <select id="cmbtype" name="cmbtype" style="width:120px;" onchange="getAccountGroup($('#cmbtype').val());" value='<s:property value="cmbtype"/>'>
                <option value="">--Select--</option>
                <option value="CRM">CLIENT</option>
                <option value="VND">VENDOR</option>
            </select>
            <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left: 15px;">Category</label>
            <input type="text" id="txtcategory" name="txtcategory" style="width:150px;" value='<s:property value="txtcategory"/>'>
            
            <label class="lbl-right" style="width:100px; margin-left: 15px;">Category Name</label>
            <input type="text" id="txtcategoryname" name="txtcategoryname" style="flex:1; max-width:350px;" value='<s:property value="txtcategoryname"/>'>
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Account Group</label>
            <select id="cmbaccountgroup" name="cmbaccountgroup" style="width:250px;" value='<s:property value="cmbaccountgroup"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbaccountgroup" name="hidcmbaccountgroup" value='<s:property value="hidcmbaccountgroup"/>'/>
            
            <label style="display:flex; align-items:center; gap:4px; font-weight:bold; font-size:12px; cursor:pointer; margin-left:15px; margin-bottom:0;">
                <input type="checkbox" id="chckapproval" name="chckapproval" onchange="approval();" onclick="$(this).attr('value', this.checked ? 1 : 0)" style="margin:0; width:auto; height:auto!important;">
                Approval
            </label>
            <input type="hidden" id="hidchckapproval" name="hidchckapproval" value='<s:property value="hidchckapproval"/>'/>
        </div>
    </div>

    <!-- Category List Grid Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title">Category List</span>
        <div id="jqxCategorySearch1" class="grid-container" style="border:none;"></div>
    </div>

    <!-- Hidden Fields Container -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" id="docno" name="hidtxtclientcategorydocno" value='<s:property value="hidtxtclientcategorydocno"/>'/>
    </div>

</div>

</form>
</div>
</body>
</html>