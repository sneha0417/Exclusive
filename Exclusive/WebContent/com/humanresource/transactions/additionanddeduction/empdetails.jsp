<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.humanresource.transactions.additionanddeduction.ClsAdditionandDeductionDAO" %>
<% String contextPath=request.getContextPath();%>
<% ClsAdditionandDeductionDAO DAO=new ClsAdditionandDeductionDAO();
   String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim(); %>
	
<script type="text/javascript">
	var descdata;
	var temp='<%=docno%>';
 
	if(temp>0) {
		descdata='<%=DAO.reloadgridSearch(docno)%>';  
	} else {   
		descdata;
	} 
        
	$(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						
     						{name : 'empname', type: 'string' },
     						{name : 'empid', type: 'string' },
     						{name : 'atype', type: 'string' }, 
     						{name : 'account', type: 'string' },
     						{name : 'accountname', type: 'string' },
     						{name : 'costtype', type: 'string' },
							{name : 'costgroup', type: 'string' },
							{name : 'costcode', type: 'number' },
     						{name : 'addition', type: 'number' },
     						{name : 'deduction', type: 'number' },
     						{name : 'remarks', type: 'string' },
     						{name : 'srno', type: 'int'  },
     						{name : 'empdoc', type: 'string' },
     						{name : 'acno', type: 'int'  },
     						{name : 'grtype', type: 'int'  }
                 ],
                 localdata: descdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            var list = ['HR', 'GL'];
            
            $("#descdetailsGrid").jqxGrid(
            {
                width: '98%',
                height: 300,
                source: dataAdapter,
                showaggregates:true,
                editable: true,
                disabled:true,
                selectionmode: 'singlecell',
                pagermode: 'default',
                
                handlekeyboardnavigation: function (event) {
                   	
               	 	var cell1 = $('#descdetailsGrid').jqxGrid('getselectedcell');
               	 	if (cell1 != undefined && cell1.datafield == 'empid') {  
               	
                       var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                       if (key == 114) {  
                        	 document.getElementById("rowindex").value = cell1.rowindex;
                        	 empSearchContent('employeeDetailsSearch.jsp');
                       	     $('#descdetailsGrid').jqxGrid('render');
                    	}
                    }
               	 	
	               	 var cell2 = $('#descdetailsGrid').jqxGrid('getselectedcell');
	                 if (cell2 != undefined && cell2.datafield == 'account') {
	                     var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
	                     if (key == 114) {   
	                     	var value = $('#descdetailsGrid').jqxGrid('getcellvalue', cell2.rowindex, "atype");
	                     	if(typeof(value) == "undefined" || typeof(value) == "NaN" || value == "") {
	    			    		document.getElementById("errormsg").innerText="Choose a Type & Search Account.";
	    			    		return 0;
	    			    	}
	                  	    document.getElementById("errormsg").innerText="";
	                     	accountSearchContent('accountsDetailsSearch.jsp?atype='+value);
	                     }
	                 }
	                 
	                 var cell3 = $('#descdetailsGrid').jqxGrid('getselectedcell');
	                 if (cell3 != undefined && cell3.datafield == 'costgroup') {
	                	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
	                	var value = $('#descdetailsGrid').jqxGrid('getcellvalue', cell3.rowindex, "grtype");
	                	var value1 = $('#descdetailsGrid').jqxGrid('getcelltext', cell3.rowindex, "atype");
	     	            if((value==4 || value==5) && value1=='GL'){
	                    if (key == 114) {  
	                    	costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=descdetailsGrid");
	                    	 $('#descdetailsGrid').jqxGrid('render');
	                      }
	                    }
	                 }
	                    
                    var cell4 = $('#descdetailsGrid').jqxGrid('getselectedcell');
                    if (cell4 != undefined && cell4.datafield == 'costcode') {
	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
	                   var value2 = $('#descdetailsGrid').jqxGrid('getcellvalue', cell4.rowindex, "grtype");
	                   var value3 = $('#descdetailsGrid').jqxGrid('getcelltext', cell4.rowindex, "atype");
	                   if((value2==4 || value2==5) && value3=='GL'){
	                   if (key == 114) {   
	                	   var value=  $('#descdetailsGrid').jqxGrid('getcellvalue', cell4.rowindex, "costtype");
	                	   costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=descdetailsGrid&costtype="+value);
	                	   $('#descdetailsGrid').jqxGrid('render');
	                   }
        	         }
	               }
                 }, 
 
                columns: [
                
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) { 
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>"; 
                              }   
                            },
							{ text: 'Emp. ID', datafield: 'empid', width: '7%',editable: false },
							{ text: 'Emp. Name', datafield: 'empname', width: '17%' ,cellsalign: 'left', align:'left',editable: false},
							{ text: 'Type', datafield: 'atype', width: '4%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }
                            },
                            { text: 'Account', datafield: 'account',  editable: false,  width: '7%' },	
							{ text: 'Account Name', datafield: 'accountname', editable: false, width: '17%' },	
                            { text: 'Cost Type', datafield: 'costgroup', width: '7%', editable: false },
							{ text: 'Cost Id', datafield: 'costtype', width: '8%',hidden: true },
							{ text: 'Cost Code', datafield: 'costcode', width: '5%',editable: false },
							{ text: 'Addition', datafield: 'addition', width: '8%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2'},
							{ text: 'Deduction', datafield: 'deduction', width: '8%' ,cellsalign: 'right', align:'right',cellsformat:'d2'},
		    				{ text: 'Remarks', datafield: 'remarks', width: '15%'  },
		    				{ text: 'Emp docno', datafield: 'empdoc', width: '12%',hidden: true },
							{ text: 'srno', datafield: 'srno', width: '9%',hidden: true },
		    				{ text: 'Emp acno', datafield: 'acno', width: '12%',hidden: true },
		    				{ text: 'Group Type', datafield: 'grtype', hidden: true, width: '10%' },
							
	              ]
            });

            if(temp==0) {
            	$("#descdetailsGrid").jqxGrid('addrow', null, {});
        	}
           
           if($("#mode").val() != "view") {
        	   $("#descdetailsGrid").jqxGrid({ disabled: false});
           }

           if($("#mode").val() == "E") {
        	    $("#descdetailsGrid").jqxGrid('addrow', null, {});  
        	   
           }
           
           $('#descdetailsGrid').on('celldoubleclick', function (event) {
           		  var columnindex1=event.args.columnindex;
             	  if(columnindex1 == 1) { 
             	 	var rowindextemp = event.args.rowindex;
             	    document.getElementById("rowindex").value = rowindextemp;  
             	  	$('#descdetailsGrid').jqxGrid('clearselection');
             	 	empSearchContent('employeeDetailsSearch.jsp');
                  } 
             	  
             	 if(columnindex1 == 4) { 
              	 	var rowindextemp = event.args.rowindex;
              	    document.getElementById("rowindex").value = rowindextemp;  
              	  	$('#descdetailsGrid').jqxGrid('clearselection');
              	    var value = $('#descdetailsGrid').jqxGrid('getcellvalue', rowindextemp, "atype");
              	  	if(typeof(value) == "undefined" || typeof(value) == "NaN" || value == "") {
			    		document.getElementById("errormsg").innerText="Choose a Type & Search Account.";
			    		return 0;
			    	}
              	    document.getElementById("errormsg").innerText="";
              	    accountSearchContent('accountsDetailsSearch.jsp?atype='+value);
                 } 
             	 
             	if(columnindex1 == 6) { 
             		var rowindextemp = event.args.rowindex;
 		            var value = $('#descdetailsGrid').jqxGrid('getcellvalue', rowindextemp, "grtype");
 		            var value1 = $('#descdetailsGrid').jqxGrid('getcellvalue', rowindextemp, "atype");
 		            document.getElementById("rowindex").value = rowindextemp;
 		            if((value==4 || value==5) && value1=='GL'){
 		            $('#descdetailsGrid').jqxGrid('clearselection');
 		            costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=descdetailsGrid");
 	              } 
                } 
             	
             	if(columnindex1 == 8) { 
             		var rowindextemp = event.args.rowindex;
 		            var value1 = $('#descdetailsGrid').jqxGrid('getcellvalue', rowindextemp, "grtype");
 		            var value2 = $('#descdetailsGrid').jqxGrid('getcellvalue', rowindextemp, "atype");
 		            document.getElementById("rowindex").value = rowindextemp;
 		            if((value1==4 || value1==5) && value2=='GL'){
 		            $('#descdetailsGrid').jqxGrid('clearselection');
 		            var value = $('#descdetailsGrid').jqxGrid('getcellvalue', rowindextemp, "costtype");
 		            costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=descdetailsGrid&costtype="+value);
 	              } 
                } 
           }); 
           
           $("#descdetailsGrid").on('cellvaluechanged', function (event) {
        	   var datafield = event.args.datafield;
        	   var rowindexestemp = event.args.rowindex;
        	   
        		if(datafield=="atype") {
        			$('#descdetailsGrid').jqxGrid('setcellvalue', rowindexestemp, "acno" ,'');	
        			$('#descdetailsGrid').jqxGrid('setcellvalue', rowindexestemp, "account" ,'');
        			$('#descdetailsGrid').jqxGrid('setcellvalue', rowindexestemp, "accountname" ,'');
        			$('#descdetailsGrid').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
        			$('#descdetailsGrid').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
        			$('#descdetailsGrid').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
        			$('#descdetailsGrid').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
     			}
        		
        		if(datafield=="costtype"){
         			$('#descdetailsGrid').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');	
     			}
        	   
           });
           
           
}); 
 
</script>
<div id="descdetailsGrid"></div>
<input type=hidden id="rowindex">