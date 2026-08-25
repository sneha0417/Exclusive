<script type="text/javascript">
 $(document).ready(function () { 
 var num = 1; 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'branch' , type: 'string' },
     						{name : 'area', type: 'string'  },
     						{name : 'tariff', type: 'string'    }
     						],
                /* url: url, */
                localdata:data3,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                   // alert(error);    
	                    }
		            });
            
            $("#jqxgridtarifdelivery").jqxGrid(
            {
                width: '100%',
                height: 135,
                source: dataAdapter,
                columnsresize: true,
                rowsheight:20,
                pageable: false,
                sortable: true,
                selectionmode: 'default',
                pagermode: 'default',
                editable:true,
               
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#jqxgridtarifdelivery').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'tarriff' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxgridtarifdelivery").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
               
                columns: [
							{ text: 'Branch', datafield: 'branch', width: '20%' },
							{ text: 'Area', datafield: 'area', width: '50%' },
							{ text: 'Tariff', datafield: 'tariff', width: '30%'}
	              ]
            });
            $("#jqxgridtarifdelivery").jqxGrid('addrow', null, {});
                    $('#jqxgridtarifdelivery').on('celldoubleclick', function (event) {
                 	  if(event.args.columnindex ==1)
                 		  {
                 	    var rowindex1 = event.args.rowindex;
                 	    document.getElementById("temprowindex").value = rowindex1;
                 	    deliverySearchContent('deliverySearch.jsp');
                 		  }
                 	  
                     }); 
 });
                     </script>
                     <div id="jqxgridtarifdelivery"></div>