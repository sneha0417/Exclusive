
 
 <%@page import="com.dashboard.purchases.purchaseorderfollowup.ClsPurchaseorderFollowupDAO"%>
 <% ClsPurchaseorderFollowupDAO searchDAO = new ClsPurchaseorderFollowupDAO(); 
 
    String docno = request.getParameter("docno")==null?"NA":request.getParameter("docno").trim();
 
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=docno%>';
var datas11;

 if(temp4!='NA')
{ 
	 
	 datas11ex='<%=searchDAO.orderlistsubsearchEx(docno)%>'; 
	 datas11='<%=searchDAO.orderlistsubsearch(docno)%>'; 
	 
	 
	 
		 
} 
else
{ 
	
	datas11;
	
	}  

$(document).ready(function () {
	  var rendererstring1=function (aggregates){
         	var value=aggregates['sum1'];
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
         }    
      
   var rendererstring=function (aggregates){
   	var value=aggregates['sum'];
 	 if(typeof(value) == "undefined"){
         value=0.00;
        }
 	
   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
   }
      
    var source =
    {
        datatype: "json",
        datafields: [   
                     
 
                     
					 
						{name : 'qty', type: 'number'  },
						
						{name : 'productid', type: 'String'  },
						{name : 'productname', type: 'String'  },
						{name : 'unit', type: 'String'  },
					 
						{name : 'brandname', type: 'String'  },
				 
						{name : 'out_qty', type: 'number'  },
						
				 
						{name : 'amount', type: 'number'  },
						
						{name : 'total', type: 'number'  },
						
						{name : 'disper', type: 'number'  },
						{name : 'discount', type: 'number'  },
						{name : 'nettotal', type: 'number'  },
						
						{name : 'psrno', type: 'number'  },
						
						

						{name : 'taxper', type: 'number'  },
						{name : 'taxamount', type: 'number'  },
						{name : 'totalamount', type: 'number'  },
				  
			 
						
						],
				    localdata: datas11,
        
        
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
    
    
   
   
    
    $("#ordersubgrid").jqxGrid(
    {
        width: '100%',
        height: 230,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        
        showaggregates:true,
        showstatusbar:true,
        
        statusbarheight: 21,
        columnsresize: true,
        
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
          
                  
           	         { text: 'Product Id', datafield: 'productid',  width: '13%' }, 
           	         { text: 'Product Name', datafield: 'productname'  },
           	      	 { text: 'Brand Name', datafield: 'brandname',  width: '10%' },
           	         { text: 'Unit', datafield: 'unit',  width: '5%' },
           	         { text: 'Qty', datafield: 'qty',  width: '5%' ,cellsformat:'d2'},
           	         { text: 'Out Qty', datafield: 'out_qty',  width: '5%' ,cellsformat:'d2'},
		           	 { text: 'Unit Price', datafield: 'amount',  width: '6%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
		           	 { text: 'Total', datafield: 'total',  width: '6%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		           	 { text: 'Discount %', datafield: 'disper',  width: '6%' ,cellsformat:'d2',cellsalign: 'right', align:'right'},
		           	 { text: 'Discount', datafield: 'discount',  width: '6%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		             { text: 'Net Total', datafield: 'nettotal',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		             { text: 'Taxper', datafield: 'taxper',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		             { text: 'Tax Amount', datafield: 'taxamount',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		             { text: 'Total Amount', datafield: 'totalamount',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		         	
		             {text: 'psrno', datafield: 'psrno', width: '10%',hidden:true},
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
   
});


</script>
<div id="ordersubgrid"></div>