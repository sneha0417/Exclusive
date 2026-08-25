  <script type="text/javascript">
    
       <%--  var data= '<%=com.operations.agreement.rentalagreement.ClsRentalAgreementAction.driverGrid()%>'; --%>
        
        $(document).ready(function () { 	
        	var url; /* = "maintenance.txt"; */
             var num = 68; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'MAINTENANCE', type: 'string'  },
     						{name : 'type', type: 'string' }
                 ],               
                /* localdata: data, */
                url: url,
                
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
            var list = ['Maintenance', 'Damage'];
            
            
            $("#jqxMaintenances").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
                editable: true,
                altRows: true,
                /* showfilterrow: true, */
                /* filterable: true, */ 
                //sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#jqxMaintenances').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'MAINTENANCE' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxMaintenances").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [
                            { text: 'Type', datafield: 'type', width: '15%',columntype:'dropdownlist',
 								createeditor: function (row, column, editor) {
 		                            editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
 								}
 							},							
							{ text: 'Maintenance Details', datafield: 'MAINTENANCE', width: '85%' }
							
	              ]
            });
            $('#jqxMaintenances').on('celldoubleclick', function (event) {
               document.getElementById("temprow").value=event.args.rowindex;
               var row1=event.args.rowindex; 
              var value= $('#jqxMaintenances').jqxGrid('getcellvalue', row1, "type");
               if(event.args.columnindex == 1){
            	   if((value=="undefined") ||(value==null)){
            		   document.getElementById("maintenancewarning").style.display="block";
            	   }
            	   else{
            		   document.getElementById("maintenancewarning").style.display="none";
            		   $('#maintenancewindow').jqxWindow('open');
                  		$('#maintenancewindow').jqxWindow('focus');
                   	   maintenanceSearchContent('maintenanceSearch.jsp?id="'+value+'"', $('#maintenancewindow'));
            	   }
            	
               }
               else{
            	   
               }
               });
            $("#jqxMaintenances").jqxGrid("addrow", null, {});

        });
    </script>
    <div id="jqxMaintenances"></div>
<input type="hidden" name="temprow" id="temprow">