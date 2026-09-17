<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<%@page import="com.humanresource.setup.hrsetup.designation.ClsDesignationDAO"%>
<% ClsDesignationDAO showDAO = new ClsDesignationDAO(); %>   

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
    overflow: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }
</style>

<script type="text/javascript">

	$(document).ready(function () {   
	    document.getElementById("formdet").innerText="Designation(DES)";
		document.getElementById("formdetail").value="Designation";
		document.getElementById("formdetailcode").value="DES";
		window.parent.formCode.value="DES";
		window.parent.formName.value="Designation";

        /* Formatted jqxDateTimeInput height to match modern UI 24px */
		$("#desigdate").jqxDateTimeInput({ width: '120px', height: 24 ,formatString : "dd.MM.yyyy", theme: 'energyblue' });
        
        /* force internal alignment AFTER render */
        setTimeout(function () {
            $("#desigdate").find("input").css({
                "margin-top": "0px",
                "line-height": "24px",
                "font-size": "12px", 
                "font-family": "Arial, sans-serif", 
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $("#desigdate").find(".jqx-action-button").css({
                "top": "0px",
                "height": "24px"
            });
        }, 0);
	   
		var desigdata='<%=showDAO.searchDesignation()%>';

		var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
      						{name : 'designation', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'remarks', type: 'String'  }
                 ],
               localdata: desigdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
		
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#designationgrid").jqxGrid(
                    {
                    	width: "100%",
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
        					{ text: 'Designation',columntype: 'textbox', filtertype: 'input', datafield: 'designation', width: '38%' },
        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
        	              ]
                    });
            
           $('#designationgrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                document.getElementById("docno").value= $('#designationgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("designation").value = $("#designationgrid").jqxGrid('getcellvalue', rowindex1, "designation");
                $("#desigdate").jqxDateTimeInput('val', $("#designationgrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#designationgrid").jqxGrid('getcellvalue', rowindex1, "remarks");
              
            });   
        });

	function funSearchLoad(){
		 changeContent('designationsearch.jsp'); 
	 }
 
	function funReadOnly() {
		$('#frmdesignation input').attr('readonly', true);
		$('#desigdate').jqxDateTimeInput({ disabled: true});
	}

	function funRemoveReadOnly() {
		$('#frmdesignation input').attr('readonly', false);
		$('#desigdate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			 $('#desigdate').val(new Date());
		   }
	}
 
	function setValues() {
		
		if($('#datehidden').val()){
			$("#desigdate").jqxDateTimeInput('val', $('#datehidden').val());
		}
		
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		}
	}
	
    function funNotify(){
        if(document.getElementById("designation").value=="") {
            document.getElementById("errormsg").innerText=" Enter Designation";
            document.getElementById("designation").focus();
            return 0;
        }
        return 1;
    } 

    function funFocus(){
        $('#desigdate').jqxDateTimeInput('focus');
    }
	  
</script>  
</head>
<body onLoad="setValues();" >

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmdesignation" action="saveDesignation" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

    <div class="modern-ui hidden-scrollbar">
        
        <div class="middle-panel">
            <span class="middle-panel-title">Designation Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Date</label>
                <div style="width: 120px;">
                    <div id="desigdate" name="desigdate" value='<s:property value="desigdate"/>'></div>
                </div>
                
                <label class="lbl-right" style="width:80px; margin-left: 15px;">Designation</label>
                <input type="text" name="designation" id="designation" style="flex:1; max-width:350px;" placeholder="Designation" value='<s:property value="designation"/>'>
                
                <label class="lbl-right" style="width:80px; margin-left: auto;">Doc No</label>
                <input type="text" name="docno" id="docno" style="width:120px;" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1">
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Remarks</label>
                <input type="text" name="remarks" id="remarks" style="flex:1;" placeholder="Remarks" value='<s:property value="remarks"/>' >
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Designation Grid</span>
            <div id="designationgrid" class="grid-container" style="border:none;"></div>
        </div>

        <!-- Hidden Fields -->
        <div style="display:none;">
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
            <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
            <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
        </div>

    </div>
</form>

</div>
</body>
</html>