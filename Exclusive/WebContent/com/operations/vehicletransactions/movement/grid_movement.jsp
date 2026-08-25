<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
    <link rel="stylesheet" href="../../../../css/jqx.base.css" type="text/css" />
    <script type="text/javascript" src="../../../../js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../../../../js/jqxcore.js"></script>
    <script type="text/javascript" src="../../../../js/jqxbuttons.js"></script>
    <script type="text/javascript" src="../../../../js/jqxscrollbar.js"></script>
    <script type="text/javascript" src="../../../../js/jqxmenu.js"></script>
    <script type="text/javascript" src="../../../../js/jqxgrid.js"></script>
    <script type="text/javascript" src="../../../../js/jqxgrid.selection.js"></script> 
    <script type="text/javascript" src="../../../../js/jqxgrid.columnsresize.js"></script>
    <script type="text/javascript" src="../../../../js/jqxgrid.edit.js"></script>
    <script type="text/javascript" src="../../../../js/jqxgrid.sort.js"></script> 
    <script type="text/javascript" src="../../../../js/jqxgrid.pager.js"></script>
    <script type="text/javascript" src="../../../../js/jqxgrid.filter.js"></script>
    <script type="text/javascript" src="../../../../js/jqxdata.js"></script> 
    <script type="text/javascript" src="../../../../js/demos.js"></script>
    <script type="text/javascript" src="../../../../js/globalize.js"></script>
    <script type="text/javascript" src="../../../../js/jqxpanel.js"></script>
    <script type="text/javascript" src="../../../../js/jqxlistbox.js"></script>
     <script type="text/javascript" src="../../../../js/jqxdropdownlist.js"></script>
  
    <script type="text/javascript">
        $(document).ready(function () {
            var url = "movementtxt.txt";
            
            
             var num = 1; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'srno' , type: 'int' },
     						{name : 'maintenance', type: 'string'  },
     						{name : 'type', type: 'string'    }
     						
     						
     						
                 ],
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

            
            
            $("#jqxgridmove").jqxGrid(
            {
                width: '100%',
                height: 155,
                source: dataAdapter,
                columnsresize: true,
                pageable: true,
                editable: true,
                sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#jqxgridmove').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'type' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxgridmove").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                columns: [
							{ text: 'Sr No', datafield: 'srno', width: '12%' },
							{ text: 'Maintenance Details', datafield: 'maintenance', width: '65%' },
							{ text: 'Type', datafield: 'type', width: '23%' }
													
	              ]
            });
        });
    </script>
    <div id="jqxgridmove"></div>
 
