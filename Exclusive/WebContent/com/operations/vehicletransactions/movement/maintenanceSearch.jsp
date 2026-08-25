  <%@page import="com.operations.vehicletransactions.movement.ClsMovementDAO"%>
<%String value=request.getParameter("id");
  System.out.println("ID:"+value);
  ClsMovementDAO movdao=new ClsMovementDAO();
  %>
  <script type="text/javascript">
    
       var datasearch= '<%=movdao.maintenanceSearch(value)%>';
      // alert(datasearch); 
       $(document).ready(function () { 	
        	
        	
             var num = 68; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'name', type: 'string'  },
     						{name : 'doc_no', type: 'int' }
                 ],               
                /* localdata: data, */
               localdata:datasearch,
                
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
            //var list = ['M', 'D'];
            
            
            $("#maintenanceSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
               // editable: true,
                altRows: true,
                showfilterrow: true,
               filterable: true, 
                //sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#maintenanceSearch').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'name' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#maintenanceSearch").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
              
                
                
                columns: [
                            { text:'Doc No',datafield:'doc_no',width:'10%'},
							{ text: 'Name', datafield: 'name', width: '90%' }
							
	              ]
            });
            $('#maintenanceSearch').on('rowdoubleclick', function (event) {
                var row2=event.args.rowindex;
                var value5=$('#maintenanceSearch').jqxGrid('getcellvalue', row2, "name");
                var row3=document.getElementById("temprow").value;
                $("#jqxMaintenances").jqxGrid('setcellvalue', row3, "MAINTENANCE", value5);
                $('#maintenancewindow').jqxWindow('close');
                $("#jqxMaintenances").jqxGrid("addrow", null, {});
                });
            $("#maintenanceSearch").jqxGrid("addrow", null, {});

        });
    </script>
    <div id="maintenanceSearch"></div>