<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
 <%@page import="com.realestate.propertyrelated.propertyrelatedmaster.ClsPropertyRelatedMasterDAO"%>
<%ClsPropertyRelatedMasterDAO DAO= new ClsPropertyRelatedMasterDAO();%> 

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

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

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

var data= '<%=DAO.searchunitm() %>';
$(document).ready(function () { 	
	 $('#btnSearch').attr('disabled', true);
	
	  $('#unitwindow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Unit Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	  $('#unitwindow').jqxWindow('close');
	  
	  /* Formatted jqxDateTimeInput heights to match modern UI 24px */
	  $("#udate").jqxDateTimeInput({width : '120px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue'});
	  
	  /* force internal alignment AFTER render */
      setTimeout(function () {
          $("#udate").find("input").css({
              "margin-top": "0px",
              "line-height": "24px",
              "font-size": "12px", 
              "font-family": "Arial, sans-serif", 
              "padding": "0 6px", 
              "box-sizing":"border-box"
          });
          $("#udate").find(".jqx-action-button").css({
              "top": "0px",
              "height": "24px"
          });
      }, 0);
	  
	  document.getElementById("formdet").innerText="Unit Type(UNT)";
	  document.getElementById("formdetail").value="Unit Type";
	  document.getElementById("formdetailcode").value="UNT";
	  window.parent.formCode.value="UNT";
	  window.parent.formName.value="Unit Type";
 
       var source =
    {
        datatype: "json",
        datafields: [
                  	    {name : 'doc_no' , type: 'number' },
						{name : 'unittype', type: 'String'  },
						{name : 'prtypeid', type:  'String'},
						{name : 'prtype', type:  'String'},
						{name : 'date', type:  'date'},
						
                  	
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
            	width: '100%',
                height: 337,
                source: dataAdapter,
                showfilterrow: true,
                filterable: true,
                selectionmode: 'singlerow',
         
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					 { text: 'Date', datafield: 'date', width: '10%', cellsformat: 'dd.MM.yyyy'  },
						{ text: 'Property type' , datafield: 'prtype',width: '40%'},
					{ text: 'Unit Type'  ,datafield: 'unittype', width: '40%' },
					{ text: 'prtypeid' , datafield: 'prtypeid',width: '30%',hidden:true }
			
					
		
					
	              ]
            });
    $('#jqxUnitSearch1').on('rowdoubleclick', function (event) 
    		{ 
            	var rowindex1=event.args.rowindex;
                
             	if ($("#mode").val() != "A") 
             		
             		{
                document.getElementById("docno").value= $('#jqxUnitSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("unit").value = $("#jqxUnitSearch1").jqxGrid('getcellvalue', rowindex1, "unittype");
                document.getElementById("prtypeid").value = $("#jqxUnitSearch1").jqxGrid('getcellvalue', rowindex1, "prtypeid");
                document.getElementById("prtype").value = $("#jqxUnitSearch1").jqxGrid('getcellvalue', rowindex1, "prtype");
                
                
                
                $("#udate").jqxDateTimeInput('val', $("#jqxUnitSearch1").jqxGrid('getcellvalue', rowindex1, "date")); 
             		}
    		 });
    
    
	 $('#prtype').dblclick(function(){
		  $('#unitwindow').jqxWindow('open');
			  unitsearchContent('searchptype.jsp');
			  });
});

function getunit(event){
	 var x= event.keyCode;
	 if(x==114){
	  		$('#unitwindow').jqxWindow('open');
	  	  unitsearchContent('searchptype.jsp');	 
          
	 } else{}
}
       	 
function unitsearchContent(url) {
     	 $.get(url).done(function (data) {
		 $('#unitwindow').jqxWindow('setContent', data);
     	 }); 
}

function funSearchLoad(){
		 
	 }
	function funReadOnly() {
		$('#frmUnit input').attr('readonly', true)

		
		  $('#udate').jqxDateTimeInput({ disabled: true}); 
	}
	function funRemoveReadOnly() {
		$('#frmUnit input').attr('readonly', false);
		 $('#udate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		$('#prtype').attr('readonly', true);
		
	}
	 function setValues(){	
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
			if($('#hidudate').val()){
				$("#udate").jqxDateTimeInput('val', $('#hidudate').val());
			}
			}
		    function funFocus()
		    {
		    	 
		    		
		    }
 
		     function funNotify(){
				 var prtype = document.getElementById("prtype").value;
				 var unit = document.getElementById("unit").value; // changed from .name to .value 
				

if(prtype=="")
	{
	 document.getElementById("errormsg").innerText="Property typeis required ";
	    
     return 0;
	}
				

if(unit=="")
	{
	 document.getElementById("errormsg").innerText="Unit Type is required ";
	    
     return 0;
	}
		    		return 1;
			} 
		    
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmUnit" action="saveunitt"  autocomplete="off">
<jsp:include page="../../../../header.jsp" />

<div class='modern-ui hidden-scrollbar'>

    <div class="middle-panel">
        <span class="middle-panel-title">Unit Type Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="udate" name="udate" value='<s:property value="udate"/>'></div>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left: auto;">Doc No</label>
            <input type="text" name="docno" style="width:120px;" value='<s:property value="docno"/>' id="docno" readonly="readonly" tabindex="-1">
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Property Type</label>
            <div class="input-search-container" style="flex:1; max-width:250px;">
                <input type="text" name="prtype" value='<s:property value="prtype"/>' onkeypress="getunit(event);" readonly="readonly" id="prtype" placeholder="Press F3"> 
                <svg class="magnifier-icon" onclick="$('#unitwindow').jqxWindow('open'); unitsearchContent('searchptype.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Unit Type</label>
            <input type="text" name="unit" style="flex:1; max-width:300px;" value='<s:property value="unit"/>' id="unit" >
        </div>
    </div>

    <!-- Hidden Fields Container -->
    <div style="display:none;">
        <input type="hidden" id="hidudate" name="hidudate"  value='<s:property value="hidudate"/>'/>
        <input type="hidden" id="prtypeid" name="prtypeid"  value='<s:property value="prtypeid"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="mode" name="mode"/>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Unit Types Grid</span>
        <div id="jqxUnitSearch1" class="grid-container" style="border:none;"></div>
    </div>
    
</div>

</form>

<div id="unitwindow"><div></div></div>

</div>
</body>
</html>