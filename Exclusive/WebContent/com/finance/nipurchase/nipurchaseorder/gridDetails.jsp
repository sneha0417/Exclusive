<%-- <%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
  <!--   <link rel="stylesheet" href="../../../css/jqx.base.css" type="text/css" />
    <script type="text/javascript" src="../../../js/jquery-1.11.1.min.js"></script>
  -->   <script type="text/javascript" src="../../../js/jqxcore.js"></script>
  <script type="text/javascript" src="../../../js/jqxbuttons.js"></script>
    <script type="text/javascript" src="../../../js/jqxscrollbar.js"></script>
    <script type="text/javascript" src="../../../js/jqxmenu.js"></script>
    <script type="text/javascript" src="../../../js/jqxgrid.js"></script>
    <script type="text/javascript" src="../../../js/jqxgrid.selection.js"></script> 
    <script type="text/javascript" src="../../../js/jqxgrid.columnsresize.js"></script>
    <script type="text/javascript" src="../../../js/jqxgrid.edit.js"></script>
    <script type="text/javascript" src="../../../js/jqxgrid.sort.js"></script> 
    <script type="text/javascript" src="../../../js/jqxgrid.pager.js"></script>
    <script type="text/javascript" src="../../../js/jqxgrid.filter.js"></script>
    <script type="text/javascript" src="../../../js/jqxdata.js"></script> 
<!--     <script type="text/javascript" src="../../../js/demos.js"></script>
  <script type="text/javascript" src="../../../js/globalize.js"></script> -->
   <script type="text/javascript" src="../../../js/jqxpanel.js"></script>
    <script type="text/javascript" src="../../../js/jqxlistbox.js"></script>
     <script type="text/javascript" src="../../../js/jqxdropdownlist.js"></script> --%>
  
    <script type="text/javascript">
        
        $(document).ready(function () { 	
          /* var url = "testdetailstxt.txt"; */
            
            
             var num = 68; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'type', type: 'string'  },
     						{name : 'accno', type: 'number'    },
     						{name : 'accname', type: 'string'    },
     						{name : 'category', type: 'string'    },
     						{name : 'product', type: 'string'    },
     						{name : 'description', type: 'string'    },
     						{name : 'qty', type: 'int'    },
     						{name : 'ordered', type: 'number'    },
     						{name : 'unitprice', type: 'number'    },
     						{name : 'total', type: 'number'    },
     						{name : 'discount%', type: 'number'    },
     						{name : 'discount', type: 'number'    },
     						{name : 'grtotal', type: 'number'    },
     						{name : 'remarks', type: 'string'    }
     						
     						
                 ],
               /*  url: url, */
                
                
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

            
            
            $("#jqxdetailsGrid").jqxGrid(
            {
                width: '95%',
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
                    var cell = $('#jqxdetailsGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'NAME' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxdetailsGrid").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [
                
							{ text: 'Type', datafield: 'type', width: '5%' },
							{ text: 'Account', datafield: 'accno', width: '7%' },
							{ text: 'Account Name', datafield: 'accname', width: '10%' },
							{ text: 'Category', datafield: 'category', width: '5%' },
							{ text: 'Product', datafield: 'product', width: '10%' },
							{ text: 'Description', datafield: 'description', width: '13%' },
							{ text: 'Quantity', datafield: 'qty', width: '5%' },
							{ text: 'Ordered', datafield: 'ordered', width: '5%' },
							{ text: 'Unit Price', datafield: 'unitprice', width: '6%' },
							{ text: 'Total', datafield: 'total', width: '6%' },
							{ text: 'Discount%', datafield: 'discount%', width: '6%' },
							{ text: 'Discount', datafield: 'discount', width: '6%' },
							{ text: 'Gr Total', datafield: 'grtotal', width: '6%' },
							{ text: 'Remarks', datafield: 'remarks', width: '10%' }
							
	              ]
            });
        });
    </script>
    <div id="jqxdetailsGrid"></div>
 
