<%@page import="com.project.execution.serviceReport.ClsServiceReportDAO"%>
<% ClsServiceReportDAO DAO = new ClsServiceReportDAO(); %> 
<% String contractno = request.getParameter("contractno")==null?"0":request.getParameter("contractno"); 
   String docNo = request.getParameter("trno")==null?"0":request.getParameter("trno");
   String mode = request.getParameter("mode")==null?"0":request.getParameter("mode");
   String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
   String serdocno = request.getParameter("serdocno")==null?"0":request.getParameter("serdocno");
 %>  
   
<script type="text/javascript">

	    var data;
	    
        $(document).ready(function () { 
        	
        	var temp='<%=docNo%>';
        	var temp1='<%=mode%>';
        	
        	<%--  if(temp>0 && temp1=='E'){ 
        		 alert("===inside one");
        		data= '<%=DAO.serviceActivityGridEditReLoading(docNo,contractno) %>'; 
        	
          	} else --%> 
        	if(temp>0){  
          	
        		data= '<%=DAO.serviceActivityGridReLoading(docNo) %>';     
          	} else {
          		
          		data= '<%=DAO.serviceActivityGridLoading(contractno,dtype,serdocno) %>';
          	}
        	
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							
     						{name : 'stype', type: 'string' },
     						{name : 'sertypeid', type: 'int' },
     						{name : 'item', type: 'string'   },
     						{name : 'numbers', type: 'number'  },
     						{name : 'activity', type: 'string'  },
     						{name : 'activityid', type: 'int' },
     						{name : 'description', type: 'string'  }
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
			            
		            } );

            
            
            $("#activityDetailsGridID").jqxGrid(
            {
            	width: '99%',
                height: 150,
                source: dataAdapter,
                columnsresize: true,
                editable: true,
                sortable: true,
                rowsheight:25,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
				handlekeyboardnavigation: function (event) {
                	
                    //Search Pop-Up
                    var cell1 = $('#activityDetailsGridID').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'activity') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	activitySearchContent('activitySearch.jsp');
                          }
                    }
                    var cell2 = $('#activityDetailsGridID').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'stype') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	serviceSearchContent('ServiceTypeSearch.jsp'); 
                          }
                    }
                },
                
                columns: [
						  { text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Service Type', datafield: 'stype', editable: false,width: '18%' },
							{ text: 'Service Id', datafield: 'sertypeid', hidden: true, width: '10%' },
							{ text: 'Item', datafield: 'item', editable: false, width: '20%' },	
							{ text: 'Nos', datafield: 'numbers', width: '8%' },	
							{ text: 'Activity', datafield: 'activity', editable: false, width: '23%' },
							{ text: 'Activity Id', datafield: 'activityid', hidden: true, width: '10%' },
							{ text: 'Description', datafield: 'description', width: '26%' },
						 ]
            });
            $("#activityDetailsGridID").jqxGrid('addrow', null, {});
            if(temp>0){
            	$("#activityDetailsGridID").jqxGrid('disabled', true);
            }
            
            if(temp>0 && temp1=='E'){  
            	$("#activityDetailsGridID").jqxGrid('disabled', false);
            }
            
            $('#activityDetailsGridID').on('celldoubleclick', function (event) {
          	  	if(event.args.columnindex == 5) {
          			var rowindextemp = event.args.rowindex;
          			document.getElementById("rowindex").value = rowindextemp;
          			activitySearchContent('activitySearch.jsp');
                 } 
          	  if(event.args.columnindex == 1) {
        			var rowindextemp = event.args.rowindex;
        			document.getElementById("rowindex").value = rowindextemp;
        			serviceSearchContent('ServiceTypeSearch.jsp');
               } 
          	  	
          	  	
          	  
             });
            
            
        });

</script>

<div id="activityDetailsGridID"></div>
<input type="hidden" id="rowindex"/> 