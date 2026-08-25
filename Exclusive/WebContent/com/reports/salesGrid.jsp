 
 
<script type="text/javascript">
 var temp4= "";
var datas1;
 if(temp4!='NA')
{ 
	 datas1;
} 
else
{ 
	datas1;
	}  

$(document).ready(function () {
	  var rendererstring1=function (aggregates){
         	var value=aggregates['sum1'];
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
         }    
      
   var rendererstring=function (aggregates){
   	var value=aggregates['sum'];
   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
   }
      
    var source =
    {
        datatype: "json",
        datafields: [   
                     
 
                        {name : 'voc_no', type: 'int'  },
                        {name : 'doc_no', type: 'int'  },
						{name : 'date', type: 'date'  },
						{name : 'qty', type: 'number'  },
						
						{name : 'productid', type: 'String'  },
						{name : 'productname', type: 'String'  },
						{name : 'unit', type: 'String'  },
						{name : 'refno', type: 'String'  },
						{name : 'dtype', type: 'String'  },
						{name : 'out_qty', type: 'number'  },
						{name : 'balqty', type: 'number'  },
						{name : 'amount', type: 'number'  },
						{name : 'total', type: 'number'  },
						
						
						{name : 'disper', type: 'number'  },
						{name : 'discount', type: 'number'  },
						{name : 'nettotal', type: 'number'  },
						{name : 'account', type: 'String'  },      
						{name : 'acname', type: 'String'  }, 
						
						{name : 'paymode', type: 'String'  }, 
						{name : 'out_amount', type: 'number'  },
						{name : 'bal', type: 'number'  },
						{name : 'category', type: 'String'  }, 
						{name : 'salesman', type: 'String'  }, 
						{name : 'salesperson', type: 'String'  }, 
						{name : 'per_mob', type: 'String'  }, 

						{name : 'taxamount', type: 'number'  },
						{name : 'totalamount', type: 'number'  },
						{name : 'butview', type: 'String'  }, 
						],
				    localdata: datas1,
        
        
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
    
    $("#invlist").jqxGrid(
    {
        width: '98%',
        height: 550,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 21,
        selectionmode: 'checkbox',        
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
          
                   /// doc_no, voc_no, date, type, expdeldt, qty, brand, model, color  
                 { text: 'Doc No',datafield: 'voc_no', width: '5%' },
                 { text: 'Docno',datafield: 'doc_no', width: '5%', hidden:true },
       			 { text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy'},
       			
    			 { text: 'Type',datafield: 'dtype', width: '10%' },
       			 { text: 'Mode Of   Payment',datafield: 'paymode', width: '10%' },
       		     { text: 'Account', datafield: 'account',  width: '10%'  },
                 { text: 'Account Name', datafield: 'acname'   },
                 { text: 'MOB', datafield: 'per_mob', width: '10%' ,  aggregates: ['sum1'],aggregatesrenderer:rendererstring1  },
	           	 { text: 'Net Total', datafield: 'nettotal',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
	             { text: 'Tax Amount', datafield: 'taxamount',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
	             { text: 'Total Amount', datafield: 'totalamount',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		           	 
		         { text: 'Category', datafield: 'category',  width:'12%'  },
			     { text: 'Salesman', datafield: 'salesman',  width: '12%'  },
			     { text: 'Sales Person', datafield: 'salesperson',  width: '12%'  },
					
					]
   
    });
    
    
    $("#invlist").jqxGrid('addrow', null, {});

    $("#overlay, #PleaseWait").hide();
   
});


</script>
<div id="invlist"></div>