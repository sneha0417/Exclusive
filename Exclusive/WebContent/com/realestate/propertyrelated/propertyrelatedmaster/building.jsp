<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
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
	$(document).ready(function () {   
	    $("#date").jqxDateTimeInput({ width: '120px', height: 24 ,formatString : "dd.MM.yyyy", theme: 'energyblue' });
	    
	    /* force internal alignment AFTER render */
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
	    
		$('#date').on('change', function (event) {
			  
 		    var maindate = $('#date').jqxDateTimeInput('getDate');
 		 	 if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
 		    funDateInPeriodchk(maindate);
 		 	 }
 		   });
	    $('#btnSearch').attr('disabled', true);
  	  $('#areainfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	  $('#areainfowindow').jqxWindow('close');
	    document.getElementById("formdet").innerText="Building(RLB)";
		document.getElementById("formdetail").value="Building";
		document.getElementById("formdetailcode").value="RLB";
		window.parent.formCode.value="RLB";
		window.parent.formName.value="Building";
 		var datab = '<%=DAO.Load(session)%>';
 
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
      						{name : 'name', type: 'String'  },
      						{name : 'plno', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                        	{name : 'areadocno', type: 'String'  },
      						{name : 'area', type: 'String'  },
      						{name : 'city_name', type: 'String'  },
      						{name : 'country_name', type: 'String'  },
      						{name : 'region_name', type: 'String'  }
                          	
       
                          	
                 ],
               localdata: datab,
                //url: "/searchDetails",
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
    
            $("#jqxb1").jqxGrid(
                    {
                    	width: '100%',
                       height: 275,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        //Add row method
                        columns: [
        					{ text: 'Docno', datafield: 'doc_no', width: '8%' },
        					{ text: 'Date' , datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
        					{ text: 'Name' , datafield: 'name' },
        					{ text: 'Plot Number' , datafield: 'plno', width: '25%' },
        					{ text: 'AREA', datafield: 'area', width: '20%' },
        					{ text: 'State', datafield: 'city_name', width: '25%',hidden:true  },
        					{ text: 'Country', datafield: 'country_name', width: '25%' ,hidden:true },
        					{ text: 'Region', datafield: 'region_name', width: '20%',hidden:true }
        					
        	              ]
                    });
            $('#jqxb1').on('rowdoubleclick', function (event) {
             var rowindex1=event.args.rowindex;
             
            //  docno plotnumber txtarea txtareadet txtareaid
             	if ($("#mode").val() != "A") 
             		
             		{
                document.getElementById("docno").value= $('#jqxb1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("plotnumber").value = $("#jqxb1").jqxGrid('getcellvalue', rowindex1, "plno");
                document.getElementById("name").value = $("#jqxb1").jqxGrid('getcellvalue', rowindex1, "name");
                
       
                
          	  var temp="";
        	  temp=temp+$('#jqxb1').jqxGrid('getcellvalue', rowindex1, "country_name");
            temp=temp+","+$('#jqxb1').jqxGrid('getcellvalue', rowindex1, "region_name");
           
      
            
            	
	            	document.getElementById("txtareadet").value=temp; 
	                document.getElementById("txtareaid").value=$('#jqxb1').jqxGrid('getcellvalue', rowindex1, "areadocno");
	               document.getElementById("txtarea").value=$('#jqxb1').jqxGrid('getcellvalue', rowindex1, "area");
        	   
          
	               $('#contactgriddiv').load("contactgrid.jsp?docno="+$('#jqxb1').jqxGrid('getcellvalue', rowindex1, "doc_no")) ;
                
                
                $("#date").jqxDateTimeInput('val', $("#jqxb1").jqxGrid('getcellvalue', rowindex1, "date")); 
            }
                
            }); 
            
      	  
      	  $('#txtarea').dblclick(function(){
      		  $('#areainfowindow').jqxWindow('open');
  			  areaSearchContent('area.jsp?getarea=0');
  			  });
        });
    function getareas(event){
     	 var x= event.keyCode;
     	 if(x==114){
     	 		$('#areainfowindow').jqxWindow('open');
               areaSearchContent('area.jsp?getarea=0');  	 
               
     	 } else{}
     }
             	 
	 function areaSearchContent(url) {
	      	 $.get(url).done(function (data) {
	 		 $('#areainfowindow').jqxWindow('setContent', data);
	      	 }); 
	 }
	function funSearchLoad(){
		//changeContent('brandSearch.jsp', $('#window')); 
	 }
	/* function funReset() {
		$(this).closest('form').find("input[type=text]").val("");
		//$('#frmB').trigger("reset");
		//document.getElementById("frmB").reset();
		//document.getElementById("docno").value="";
		//document.getElementById("brand").value="";
	} */
	function funReadOnly() {
		$('#frmB input').attr('readonly', true);
	 
		$('#date').jqxDateTimeInput({ disabled: true});
		
		
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmB input').attr('readonly', false);
		$('#date').jqxDateTimeInput({ disabled: false});
		if($('#mode').val()=="A")
			{
			$('#date').val(new Date());

			 $("#contactgrids").jqxGrid('clear');
			    $("#contactgrids").jqxGrid('addrow', null, {});
			}
 		if ($("#mode").val() == "A" || $("#mode").val() == "E") {
			$("#contactgrids").jqxGrid({ disabled: false});
		}
		
		$('#txtarea').attr('readonly', true);
		$('#docno').attr('readonly', true);
	}
 
	function setValues() {
		 
		if($('#datehidden').val()){
			$("#date").jqxDateTimeInput('val', $('#datehidden').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 
		 var indexVal2 = document.getElementById("docno").value;

		 if(indexVal2>0)
			 {
			 $('#contactgriddiv').load("contactgrid.jsp?docno="+indexVal2) ;
			 }
		 
	}
	
	 
	 function funDateInPeriodchk(value){
 
		    var currentDate = new Date(new Date());
		 
		     if(value>currentDate){
		     document.getElementById("errormsg").innerText="Future Date, Transaction Restricted. ";
		    
		     return 0;
		    } 
		    
		    document.getElementById("errormsg").innerText="";
		   
		     return 1;
		 }

	 function funNotify(){
		 
			var maindate = $('#date').jqxDateTimeInput('getDate');
			   var validdate=funDateInPeriodchk(maindate);
			   
			  
			   
			   if(validdate==0){
			   return 0; 
			   }
			   
				 var plotnumber = document.getElementById("plotnumber").value;
				 var name = document.getElementById("docno").name;
				 

if(name=="")
	{
	 document.getElementById("errormsg").innerText="Name is required ";
	    
     return 0;
	}
				 

if(plotnumber=="")
	{
	 document.getElementById("errormsg").innerText="Plot Number	 is required ";
	    
     return 0;
	}
		
			   
			   
			   var rows = $("#contactgrids").jqxGrid('getrows');
			   
			   
		 
			    $('#gridlength').val(rows.length);
			    
			   for(var i=0 ; i < rows.length ; i++){ 
			 	  
			 	 
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "TEMP"+i)
			       .attr("name", "TEMP"+i)
			       .attr("hidden", "true");
			  
			   newTextBox.val(rows[i].name+"::"+rows[i].mob+"::"+rows[i].remarks+"::");
			   newTextBox.appendTo('form');
			   }
				$('#date').jqxDateTimeInput({ disabled: false});
	    		return 1;
		} 
	     function funFocus(){
	    	 
	     }
	  
</script>  
 
</head>
<body onLoad="setValues();" >

<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmB" action="saveB1"  autocomplete="off">
        <jsp:include page="../../../../header.jsp" />

        <div class="modern-ui hidden-scrollbar">
            <!-- General Info Panel -->
            <div class="middle-panel">
                <span class="middle-panel-title">General Info</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Date</label>
                    <div style="width: 125px;">
                        <div id="date" name="date"></div>  
                    </div>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Name</label>
                    <input type="text" name="name" id="name" style="flex:1; max-width:300px;" readonly value='<s:property value="name"/>' >
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
                    <input type="text" name="docno" id="docno" style="width:120px;" value='<s:property value="docno"/>' readonly tabindex="-1">
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Plot Number</label>
                    <input type="text" id="plotnumber" name="plotnumber" style="width:150px;" value='<s:property value="plotnumber"/>'/>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Area</label>
                    <div class="input-search-container" style="flex:1; max-width: 250px;">
                        <input type="text" id="txtarea" name="txtarea" readonly placeholder="Press F3" value='<s:property value="txtarea"/>' onKeyDown="getareas(event);"/> 
                        <svg class="magnifier-icon" onclick="$('#areainfowindow').jqxWindow('open'); areaSearchContent('area.jsp?getarea=0');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    
                    <input type="text" id="txtareadet" name="txtareadet" readonly style="flex:1;" value='<s:property value="txtareadet"/>'/>
                    <input type="hidden" id="txtareaid" name="txtareaid" value='<s:property value="txtareaid"/>'/>
                </div>
            </div>

            <!-- Contact Grid Panel -->
            <div class="middle-panel">
                <span class="middle-panel-title">Contacts</span>
                <div id="contactgriddiv" class="grid-container" style="border:none;">
                    <jsp:include page="contactgrid.jsp"></jsp:include>
                </div>
            </div>

            <!-- Main Building Grid Panel -->
            <div class="middle-panel">
                <span class="middle-panel-title">Building</span>
                <div id="jqxb1" class="grid-container" style="border:none;"></div>  
            </div>

            <!-- Hidden Fields Container -->
            <div style="display:none;">
                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' /> 
                <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
                <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>' />
                <input type="hidden" id="gridlength" name="gridlength" value='<s:property value="gridlength"/>' />
            </div>
            
        </div>
    </form>
    
    <div id="areainfowindow"><div></div></div>
   
</div>
</body>
</html>