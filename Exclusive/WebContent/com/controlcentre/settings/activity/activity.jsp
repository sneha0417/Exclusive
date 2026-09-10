<%@page import="com.controlcentre.settings.activity.ClsActivityDAO"%>
<%ClsActivityDAO DAO= new ClsActivityDAO();%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
	$(document).ready(function () {   
        /* Formatted jqxDateTimeInput height to match modern UI 24px */
	    $("#date_acti").jqxDateTimeInput({ width: '120px', height: 24, formatString : "dd.MM.yyyy", theme: 'energyblue'});
        
        /* force internal alignment AFTER render */
        setTimeout(function () {
            $("#date_acti").find("input").css({
                "margin-top": "0px",
                "line-height": "24px",
                "font-size": "12px", 
                "font-family": "Arial, sans-serif", 
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $("#date_acti").find(".jqx-action-button").css({
                "top": "0px",
                "height": "24px"
            });
        }, 0);

	   var data= '<%=DAO.searchDetails() %>'; 
       var num = 0; 
       var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
                          	{name : 'date', type: 'String' },
      						{name : 'ay_name', type: 'String'  } ,
                            {name : 'ay_code', type: 'String'  }  
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
    
            $("#jqxactivitySearch1").jqxGrid(
                    {
                    	width: '100%',
                    	height: 300,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'multiplecellsextended',
                        columns: [
        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%' },
        					{ text: 'Activity',columntype: 'textbox', filtertype: 'input', datafield: 'ay_name', width: '40%' },
        					{ text: 'Activity Code',columntype: 'textbox', filtertype: 'input', datafield: 'ay_code', width: '30%' } 
        	              ]
                    });
            $('#jqxactivitySearch1').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxactivitySearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("activity").value = $("#jqxactivitySearch1").jqxGrid('getcellvalue', rowindex1, "ay_name");
                document.getElementById("activity_code").value = $("#jqxactivitySearch1").jqxGrid('getcellvalue', rowindex1, "ay_code");
                $("#date_acti").jqxDateTimeInput('val', $("#jqxactivitySearch1").jqxGrid('getcellvalue', rowindex1, "date"));
            }); 
        });

       function funSearchLoad(){
		changeContent('activitySearch.jsp', $('#window')); 
	 } 
	
	function funReadOnly() {
		$('#frmActivity input').attr('readonly', true);
		$('#date_acti').jqxDateTimeInput({
			readonly : true
		});
		setValues();
	}

	function funRemoveReadOnly() {
		$('#frmActivity input').attr('readonly', false);
		$('#date_acti').jqxDateTimeInput({
			readonly : false
		});
		$('#docno').attr('readonly', true);
		if(document.getElementById("mode").value=='A'){
			$('#jqxactivitySearch1').jqxGrid({ disabled: true});
		}
	}

	function setValues() {
		if($('#datehidden').val()){
			$("#date_acti").jqxDateTimeInput('val', $('#datehidden').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
	
	 $(function(){
	        $('#frmActivity').validate({
	                 rules: {
	                 	 region: {
	                 	 required:true,
	                 	 maxlength:40
	                 }
	                 },
	                 messages: {
	                 	 region: {
	                 	  required:" *",
	                 	  maxlength:"max 40 only"
	                  } 
	                 }
	        });});

	     function funNotify(){
	    		return 1;
		} 
	     function funFocus(){
	    	 $('#date_acti').jqxDateTimeInput('focus');
	     }
</script>  
</head>

<body onLoad="funReadOnly();setValues();" >
<form id="frmActivity" action="saveActivity" method="get" autocomplete="off">
    <script>
        window.parent.formName.value="ACTIVITY";
        window.parent.formCode.value="ACT"; 
    </script>
    <jsp:include page="../../../../header.jsp" />

    <div class="modern-ui hidden-scrollbar">
        
        <div class="middle-panel">
            <span class="middle-panel-title">Activity Details</span>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Date</label>
                <div style="width: 120px;">
                    <div id="date_acti" name="date_acti"></div>
                </div>
                
                <label class="lbl-right" style="width:80px; margin-left: 15px;">Activity</label>
                <input type="text" name="activity" id="activity" style="flex:1; max-width: 350px;" value='<s:property value="activity"/>' >

                <label class="lbl-right" style="width:100px; margin-left: 15px;">Activity Code</label>
                <input type="text" name="activity_code" id="activity_code" style="width: 150px;" value='<s:property value="activity_code"/>'>
                
                <label class="lbl-right" style="width:80px; margin-left: auto;">Doc No.</label>
                <input type="text" name="docno" id="docno" style="width: 120px;" value='<s:property value="docno"/>' readonly="true" tabindex="-1">
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Activity List</span>
            <div id="jqxactivitySearch1" class="grid-container" style="border:none;"></div>  
        </div>

        <!-- Hidden Fields Container -->
        <div style="display:none;">
            <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/>
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        </div>

    </div>

</form>
</body>
</html>