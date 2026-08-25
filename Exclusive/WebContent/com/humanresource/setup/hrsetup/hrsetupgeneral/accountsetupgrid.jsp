<%@page import="com.humanresource.setup.hrsetup.hrsetupgeneral.ClsGeneralDAO"%>
<% ClsGeneralDAO showDAO = new ClsGeneralDAO(); %>    
<% String contextPath=request.getContextPath();%>
<%String docnos = request.getParameter("docno")==null?"0":request.getParameter("docno");%>

<script type="text/javascript">

       var docnoss='<%=docnos%>';
    	   
       if(docnoss>0) {
    		var accountdata='<%=showDAO.searchacsetupreload(docnos)%>';
       } else {
    		var accountdata='<%=showDAO.searchAccountAllowance()%>';   
       }
			 
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'allowanceid', type: 'string'  },
                            {name : 'allowance', type: 'string'  },
                            {name : 'acno', type: 'string'  },
                            {name : 'account', type: 'string'  },
                            {name : 'costtype', type: 'string' },
							{name : 'costgroup', type: 'string' },
							{name : 'costcode', type: 'number' },
							{name : 'grtype', type: 'int'  }
                        ],
                		
                 localdata: accountdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#accountsetup").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                editable: true,
                disabled:true,
                selectionmode: 'singlecell',
                 
                 handlekeyboardnavigation: function (event) {
                    	
                	 	var cell1 = $('#accountsetup').jqxGrid('getselectedcell');
                	 	if (cell1 != undefined && cell1.datafield == 'account') {  
                	
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {  
                         	 document.getElementById("rowindex").value = cell1.rowindex;
                         	 accountSearchContent('accountsDetailsSearch.jsp');
                        	 $('#accountsetup').jqxGrid('render');
                     	}
                     }
                	 	
 	                 var cell2 = $('#accountsetup').jqxGrid('getselectedcell');
 	                 if (cell2 != undefined && cell2.datafield == 'costgroup') {
 	                	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
 	                	var value = $('#accountsetup').jqxGrid('getcellvalue', cell2.rowindex, "grtype");
 	     	            if(value==4 || value==5){
 	                    if (key == 114) {  
 	                    	costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=accountsetup");
 	                    	$('#accountsetup').jqxGrid('render');
 	                      }
 	                    }
 	                 }
 	                    
                     var cell4 = $('#accountsetup').jqxGrid('getselectedcell');
                     if (cell4 != undefined && cell4.datafield == 'costcode') {
 	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
 	                   var value1 = $('#accountsetup').jqxGrid('getcellvalue', cell4.rowindex, "grtype");
 	                   if(value1==4 || value1==5){
 	                   if (key == 114) {   
 	                	   var value=  $('#accountsetup').jqxGrid('getcellvalue', cell4.rowindex, "costtype");
 	                	   costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=accountsetup&costtype="+value);
 	                	   $('#accountsetup').jqxGrid('render');
 	                   }
         	         }
 	               }
                  }, 
                       
                columns: [
                             { text: 'SL No', sortable: false, filterable: false, editable: false,
                               groupable: false, draggable: false, resizable: false,
                               datafield: 'sl', columntype: 'number', width: '10%',
                               cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                               }  
                              },	
                              { text: 'Allowance', datafield: 'allowance', width: '48%' ,editable: false},
                              { text: 'Account', datafield: 'account', width: '15%' ,editable: false},
                              { text: 'Cost Type', datafield: 'costgroup', width: '15%', editable: false },
  							  { text: 'Cost Id', datafield: 'costtype', width: '8%',hidden: true },
  							  { text: 'Cost Code', datafield: 'costcode', width: '12%',editable: false },
    	                      { text: 'Ac docno', datafield: 'acno', width: '20%' ,hidden: true },
    	                      { text: 'master alw doc_no', datafield: 'allowanceid', width: '20%', hidden: true },
    	                      { text: 'Group Type', datafield: 'grtype', hidden: true, width: '10%' },
						]
            });
            
            if ($("#mode").val() == "A" ||$("#mode").val() == "E" ) {
          	     $("#accountsetup").jqxGrid({ disabled: false});
          	}
         
            $('#accountsetup').on('celldoubleclick', function (event) {
           	      var datafield = event.args.datafield;
               	  if(datafield=="account") { 
	               	 var rowindextemp = event.args.rowindex;
               	     document.getElementById("rowindex").value = rowindextemp;  
	               	 accountSearchContent('accountsDetailsSearch.jsp');
               	   } 
               	  
               	if(datafield=="costgroup") { 
             		var rowindextemp = event.args.rowindex;
 		            var value = $('#accountsetup').jqxGrid('getcellvalue', rowindextemp, "grtype");
 		            document.getElementById("rowindex").value = rowindextemp;
 		            if(value==4 || value==5){
 		            $('#accountsetup').jqxGrid('clearselection');
 		            costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=accountsetup");
 	              } 
                } 
             	
               	if(datafield=="costcode") { 
             		var rowindextemp = event.args.rowindex;
 		            var value1 = $('#accountsetup').jqxGrid('getcellvalue', rowindextemp, "grtype");
 		            document.getElementById("rowindex").value = rowindextemp;
 		            if(value1==4 || value1==5){
 		            $('#accountsetup').jqxGrid('clearselection');
 		            var value = $('#accountsetup').jqxGrid('getcellvalue', rowindextemp, "costtype");
 		            costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=accountsetup&costtype="+value);
 	              } 
                }
            });
            
            $("#accountsetup").on('cellvaluechanged', function (event) {
         	   var datafield = event.args.datafield;
         	   var rowindexestemp = event.args.rowindex;
         	   
         		if(datafield=="account") {
         			$('#accountsetup').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
         			$('#accountsetup').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
         			$('#accountsetup').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
      			}
         		
         		if(datafield=="costtype"){
          			$('#accountsetup').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');	
      			}
         	   
            });
          
        });
		
    </script>
    <input type="hidden" id="rowindex">
    <div id="accountsetup"></div>