<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<title>GatewayERP(i)</title>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.settings.enquirysource.ClsEnquirySourceDAO"%>
<%ClsEnquirySourceDAO DAO= new ClsEnquirySourceDAO();%>

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
				
		$(document).ready(function() {
		    /* Formatted jqxDateTimeInput height to match modern UI 24px */
			$("#date").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
			
			/* Force internal alignment AFTER render */
            setTimeout(function () {
                $("#date").find("input").css({
                    "margin-top": "0px",
                    "line-height": "24px",
                    "font-size": "12px", 
                    "font-family": "Arial, sans-serif", 
                    "padding": "0 6px", 
                    "box-sizing":"border-box"
                });
                $("#date").find(".jqx-action-button").css({
                    "top": "0px",
                    "height": "24px"
                });
            }, 0);
		
			var datas='<%=DAO.descLoad(session) %>';
              
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
                          	{name : 'date', type: 'date'  },
                          	{name : 'name', type: 'String'  },
                          	{name : 'mobile', type: 'String'  },
                         	{name : 'email', type: 'String'  },
                         	{name : 'address', type: 'String'  },
                         	{name : 'description', type: 'String'  }
                          	
                 ],
                localdata: datas,
                
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
    
            $("#enquiryServiceGridID").jqxGrid(
                    {
                    	width: "100%",
                    	height:375,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
        					{ text: 'Name',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '15%' },
        					{ text: 'Mobile',columntype: 'textbox', filtertype: 'input', datafield: 'mobile', width: '10%' },
        					{ text: 'Email',columntype: 'textbox', filtertype: 'input', datafield: 'email', width: '15%' },
        					{ text: 'Address',columntype: 'textbox', filtertype: 'input', datafield: 'address', width: '20%' },
        					{ text: 'Description',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '20%' },
        	              ]
                    });
            
         $('#enquiryServiceGridID').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                document.getElementById("docno").value= $('#enquiryServiceGridID').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                $("#date").jqxDateTimeInput('val', $("#enquiryServiceGridID").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("txtname").value = $("#enquiryServiceGridID").jqxGrid('getcellvalue', rowindex1, "name");
                document.getElementById("txtmobile").value = $("#enquiryServiceGridID").jqxGrid('getcellvalue', rowindex1, "mobile");
                document.getElementById("txtemail").value = $("#enquiryServiceGridID").jqxGrid('getcellvalue', rowindex1, "email");
                document.getElementById("txtaddress").value = $("#enquiryServiceGridID").jqxGrid('getcellvalue', rowindex1, "address");
                document.getElementById("txtdescription").value = $("#enquiryServiceGridID").jqxGrid('getcellvalue', rowindex1, "description");
                
            });
		
		});
		
		function funReadOnly(){
			$('#frmEnquirysource input').attr('readonly', true );
			$('#date').jqxDateTimeInput({disabled: true});
		}
		
		function funRemoveReadOnly(){
			$('#frmEnquirysource input').attr('readonly', false );
			$('#date').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			
			if ($("#mode").val() == "A") {
				$('#date').val(new Date());
			}
		}
		
		function funSearchLoad(){
			  /*changeContent('cpsMainSearch.jsp');*/   
		 }
			
		function funChkButton() {
				/* funReset(); */
		}
		 
		function funFocus(){
			$('#date').jqxDateTimeInput('focus'); 	    		
		}
		
		function funNotify(){	
 			 return 1;
		} 
		  
		  function setValues(){
			  
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
<form id="frmEnquirysource" action="saveEnquirysource" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class="modern-ui hidden-scrollbar">

    <!-- General Info Section -->
    <div class="middle-panel">
        <span class="middle-panel-title">General Info</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 120px;">
                <div id='date' name='date' value='<s:property value="date"/>'></div>
                <input type="hidden" id="hidendate" name="hidendate" value='<s:property value="hidendate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
            <input type="text" id="docno" name="docno" style="width:120px;" value='<s:property value="docno"/>' tabindex="-1" readonly/>
        </div>
    </div>

    <!-- Details Section -->
    <!-- Mimicking original fieldset style by setting a soft background -->
    <div class="middle-panel" style="background-color: #fcfaff;">
        <span class="middle-panel-title">Source Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Name</label>
            <input type="text" id="txtname" name="txtname" style="flex:1; max-width:300px;" value='<s:property value="txtname"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Mobile</label>
            <input type="text" id="txtmobile" name="txtmobile" style="width:150px;" value='<s:property value="txtmobile"/>'/>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Email</label>
            <input type="text" id="txtemail" name="txtemail" style="flex:1; max-width:300px;" value='<s:property value="txtemail"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Address</label>
            <input type="text" id="txtaddress" name="txtaddress" style="flex:1;" value='<s:property value="txtaddress"/>'/>
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Description</label>
            <input type="text" id="txtdescription" name="txtdescription" style="flex:1;" value='<s:property value="txtdescription"/>'/>
        </div>
    </div>

    <!-- Grid Section -->
    <div class="middle-panel">
        <span class="middle-panel-title">Enquiry Sources Grid</span>
        <div id="enquiryServiceGridID" class="grid-container" style="border:none;"></div>
    </div>

    <!-- Hidden Fields -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
    </div>

</div>

</form>
</div>
</body>
</html>