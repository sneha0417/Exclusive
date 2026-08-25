
 
 <%@page import="com.dashboard.audit.purchaseinvoiceaudit.ClsPurchaseInvoiceAuditDAO"%>
 <% ClsPurchaseInvoiceAuditDAO searchDAO = new ClsPurchaseInvoiceAuditDAO(); 
 
    String doc_no = request.getParameter("doc_no")==null?"0":request.getParameter("doc_no").trim();
 System.out.println("doc_no="+doc_no);
 %> 
       
 
<script type="text/javascript">
 
var datas;

 if(temp4!='NA')
{ 
	
	 datas='<%=searchDAO.purchaseInvoiceAuditDetailGrid(doc_no)%>'; 
		// alert(enqdata); --%>
} 
else
{ 
	
	datas;
	
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
						{name : 'location', type: 'String'  },
						{name : 'brand', type: 'String'  },
						
						  
				 
			 
						
						],
				    localdata: datas,
        
        
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
    
    
   
   
    
    $("#detailpurchaselist").jqxGrid(
    {
        width: '98%',
        height: 200,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        
        showaggregates:true,
        showstatusbar:true,
        
        statusbarheight: 21,
        
        selectionmode: 'singlerow',
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
                     { text: 'Doc No',datafield: 'voc_no', width: '5%',hidden:true },
         			 { text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy',hidden:true},
         			 { text: 'Ref No',datafield: 'ref_no', width: '10%',hidden:true },
         			 { text: 'Type',datafield: 'dtype', width: '9%' ,hidden:true},
         		     { text: 'Account', datafield: 'account',  width: '5%' ,hidden:true },
                     { text: 'Account Name', datafield: 'acname',  width: '12%' ,hidden:true },
           	         { text: 'Product Id', datafield: 'productid',  width: '13%' }, 
           	         { text: 'Product Name', datafield: 'productname',  width: '25%' },
           	      	 { text: 'Location', datafield: 'location',  width: '25%',hidden:true },
           	         { text: 'Brand', datafield: 'brand',  width: '25%',hidden:true },
           	         { text: 'Unit', datafield: 'unit',  width: '5%' },
           	         { text: 'Qty', datafield: 'qty',  width: '6%' ,cellsformat:'d2'},
           	         { text: 'Out Qty', datafield: 'out_qty',  width: '6%' ,cellsformat:'d2',hidden:true },
		           	 { text: 'Balance Qty', datafield: 'balqty',  width: '6%',hidden:true  ,cellsformat:'d2',aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
		           	 { text: 'Unit Price', datafield: 'amount',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		           	 { text: 'Total', datafield: 'total',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		           	 { text: 'Discount %', datafield: 'disper',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		           	 { text: 'Discount', datafield: 'discount',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		             { text: 'Net Total', datafield: 'nettotal',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							
 
					
					]
   
    });
    $("#overlay, #PleaseWait").hide();
   
   
    
   
});


</script>
<div id="detailpurchaselist"></div>