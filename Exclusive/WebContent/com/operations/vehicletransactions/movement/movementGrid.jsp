<script type="text/javascript">
    
       <%--  var data= '<%=com.operations.agreement.rentalagreement.ClsRentalAgreementAction.driverGrid()%>'; --%>
        
        $(document).ready(function () { 	
        	var url = "movement.txt";
             var num = 68; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'RTYPE', type: 'string' },
     						{name : 'BO', type: 'string'  },
     						{name : 'REFNO', type: 'string'  },
     						{name : 'NAME', type: 'string'  },
     						{name : 'STATUS', type: 'string'  },
     						{name : 'TC', type: 'string'  },
     						{name : 'TO', type: 'string'  },
     						{name : 'DTOUT', type: 'string'  },
     						{name : 'TOUT', type: 'string'  },
     						{name : 'KMOUT', type: 'string'  },
     						{name : 'FOUT', type: 'string'  },
     						{name : 'BIN', type: 'string'  },
     						{name : 'DTIN', type: 'string'  },
     						{name : 'TIN', type: 'string'  },
     						{name : 'FIN', type: 'string'  },
     						{name : 'KMIN', type: 'string'  },
     						{name : 'REGNO', type: 'string'  }			
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

            
            
            $("#jqxMovement").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                columnsresize: true,
                pageable: true,
                editable: true,
                altRows: true,
                /* showfilterrow: true, */
                /* filterable: true, */ 
                sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#jqxMovement').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'REGNO' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxMovement").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [							
							{ text: 'Type', datafield: 'RTYPE', width: '7%' },
							{ text: 'BO', datafield: 'BO', width: '5%' },
							{ text: 'Ref No', datafield: 'REFNO', width: '8%' },
							{ text: 'Name', datafield: 'NAME', width: '20%' },
							{ text: 'Status', datafield: 'STATUS', width: '5%' },
							{ text: 'TC', datafield: 'TC', width: '5%' },
							{ text: 'To', datafield: 'TO', width: '7%' },
							{ text: 'Dt Out', datafield: 'DTOUT', width: '10%' },
							{ text: 'T Out', datafield: 'TOUT', width: '7%' },
							{ text: 'KM Out', datafield: 'KMOUT', width: '7%' },
							{ text: 'F Out', datafield: 'FOUT', width: '5%' },
							{ text: 'B In', datafield: 'BIN', width: '5%' },
							{ text: 'Dt In', datafield: 'DTIN', width: '10%' },
							{ text: 'T In', datafield: 'TIN', width: '7%' },
							{ text: 'F In', datafield: 'FIN', width: '5%' },
							{ text: 'KM In', datafield: 'KMIN', width: '7%' },
							{ text: 'Reg No', datafield: 'REGNO', width: '8%' },
	              ]
            });
        });
    </script>
    <div id="jqxMovement"></div>
