 
<style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
     .orangeClass
    {
        background-color: #FFEBC2;
    }
    
</style>
<script type="text/javascript">
    
       var partdata10;
     
      

$(document).ready(function () {
	
	
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
                     
                  
                     
                        {name : 'productid', type: 'String'  },
                        {name : 'productname', type: 'String'  },
                        {name : 'unit', type: 'String'  },
                        {name : 'brand', type: 'String'  },
						{name : 'type', type: 'String'  },
						{name : 'cat', type: 'String'  },
						{name : 'stdprice', type: 'number'  },
						{name : 'fixingprice', type: 'number'  },
						{name : 'fixedcharge', type: 'number'  },
						
						{name : 'department', type: 'String'  },
						{name : 'subcategory', type: 'String'  },
						 
						
						
						],
				    localdata: partdata10,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, data) {
    	
		 if (data.isqty !=0) {
            return "yellowClass";
        }else{
        	return "orangeClass";
        };
    };

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#partSearchgrid2").jqxGrid(
    {
        width: '100%',
        height: 500,
        source: dataAdapter,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
         columnsresize: true,
       selectionmode: 'singlerow',                 
       
       
                                
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '5%' ,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },
                { text: 'Product', datafield: 'productid',  width: '5%'  },
           	   { text: 'Product Name', datafield: 'productname'   }, 
           	   { text: ' Unit', datafield: 'unit',  width: '6%'  }, 
           	   { text: ' Brand', datafield: 'brand',  width: '7%'  }, 
           	   { text: ' Type', datafield: 'type',  width: '10%'  },   
           	   { text: ' Category', datafield: 'cat',  width: '8%'  },
           	   
           	 { text: ' Sub Category', datafield: 'subcategory',  width: '8%'  },
           	 
           	 { text: ' Department', datafield: 'department',  width: '8%'  },
           	 { text: ' Standard cost', datafield: 'stdprice',  width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right'  },
           	 { text: ' Selling price', datafield: 'fixingprice',  width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right'  },
           	 { text: ' Fixed charge', datafield: 'fixedcharge',  width: '8%' ,cellsformat: 'd2',cellsalign:'right',align:'right', hidden:'true' }
           	
           
    ]		 
   
    });

    $("#overlay, #PleaseWait").hide();
});


</script>
<div id="partSearchgrid2"></div>