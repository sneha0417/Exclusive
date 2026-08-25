<%String temp=request.getParameter("id"); %>
<script type="text/javascript">
    
       var wilddata ='<%=temp%>';
        alert(wilddata);
        $(document).ready(function () { 	
        	
             var num = 68; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name:'doc_no',type:'int'},
     						{name:'date',type:'date'},
     						{name:'fleet_no',type:'String'}
                 ],               
                 localdata: wilddata,
                //url: url,
                
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

            
            
            $("#wildSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                filtermode:'excel',
                //pageable: true,
                //editable: true,
                altRows: true,
                // showfilterrow: true, 
                 filterable: true, 
                sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#wildSearchGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'fleet_no' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#wildSearchGrid").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [							
							{ text: 'Doc No', datafield: 'doc_no', width: '10%'},
							{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd-MM-yyyy' },
							{ text: 'Fleet No', datafield: 'fleet_no', width: '75%' }
							
	              ]
            });
            $('#wildSearchGrid').on('rowdoubleclick', function (event) {
                 var row2=event.args.rowindex;
                document.getElementById("txtfleetno").value=$('#wildSearchGrid').jqxGrid('getcellvalue', row2, "fleet_no");
                document.getElementById("docno").value=$('#wildSearchGrid').jqxGrid('getcellvalue', row2, "doc_no");
                $("#date").jqxDateTimeInput('val',$("#wildSearchGrid").jqxGrid('getcellvalue', row2, "date"));
                document.getElementById("frmMovement").submit();
				 $('#window').jqxWindow('close');
                });
        });
    </script>
    <div id="wildSearchGrid"></div>
