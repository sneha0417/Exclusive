 <%@page import="com.dashboard.purchase.ClspurchaseReportsnewDAO"%>
 <% ClspurchaseReportsnewDAO searchDAO = new ClspurchaseReportsnewDAO(); 
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String acno = request.getParameter("acno")==null?"NA":request.getParameter("acno").trim();
  	String statusselect = request.getParameter("statusselect")==null?"0":request.getParameter("statusselect").trim();
  	System.out.println("==fromdate=="+fromdate);
 %> 
       
   <style type="text/css">
  .advanceClass
  {
      color: #FF0000;
  }
  .yellowClass
        {
       background-color: #ffc0cb; 
        
        }
</style>
 
<script type="text/javascript">  
 var temp4='<%=barchval%>';
var datasa;

 if(temp4!='NA')
{ 
	 
	 datassa='<%=searchDAO.summpurchaseExcel(barchval,fromdate,todate,statusselect,acno)%>'; 
	 datasa='<%=searchDAO.summpurchase(barchval,fromdate,todate,statusselect,acno)%>'; 
		// alert(enqdata); --%>
} 
else
{ 
	
	datasa;
	
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
						{name : 'clstatus', type: 'Int'  }, 
						{name : 'taxper', type: 'number'  }, 
						{name : 'taxamount', type: 'number'  }, 
						{name : 'nettotaltax', type: 'number'  }, 
						{name : 'balamount', type:'number'},
						{name : 'cancelamt', type:'number'},  
						{name : 'taxamount', type:'number'},
						{name : 'totalamount', type:'number'},  
						{name : 'butview', type:'String'},  
						
						{name : 'loc', type:'String'},
						{name : 'ptotal', type: 'number'  },
						{name : 'billtype', type:'String'},
						{name : 'invno', type:'String'},
						{name : 'invdate', type:'date'},
						{name : 'distotal', type:'number'},
						{name : 'purexp', type:'number'},
						{name : 'service', type:'number'},
						{name : 'igst', type:'number'},
						{name : 'sgst', type:'number'},
						{name : 'cgst', type:'number'},
						{name : 'brhid', type:'number'},
						{name : 'tr_no', type:'number'},
						],
				    localdata: datasa,
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname =  function (row, column, value, data) {


   	  var ss= $('#sumorderlistgrid').jqxGrid('getcellvalue', row, "clstatus");
   		          if(parseInt(ss)>0)
   		  		{
   		  		
   		  		return "yellowClass";
   		  	
   		  		}
   	    
   	    	/* return "greyClass";
   	    	
   		        var element = $(defaultHtml);
   		        element.css({ 'background-color': '#F3F297', 'width': '100%', 'height': '100%', 'margin': '0px' });
   		        return element[0].outerHTML;
   	*/

   		}

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#sumorderlistgrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        showfilterrow: true,
        filterable: true,
        sortable:true,
        columnsresize:true,
        showaggregates:true,
        showstatusbar:true,
        
        statusbarheight: 21,
        
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,cellclassname: cellclassname,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
          
                   /// doc_no, voc_no, date, type, expdeldt, qty, brand, model, color  
                     { text: 'Doc No',datafield: 'voc_no', width: '6%' ,cellclassname: cellclassname},
         			 { text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
         			 { text: 'Account No', datafield: 'account',  width: '10%' ,cellclassname: cellclassname },
         			 { text: 'Account Name', datafield: 'acname'   ,cellclassname: cellclassname, width: '20%' },
         			 { text: '',  datafield: 'butview',columntype: 'button', width: '5%' },
         			 { text: 'Loctaion', datafield: 'loc',  width: '10%',cellclassname: cellclassname },
         			 { text: 'Bill Type', datafield: 'billtype',  width: '7%',cellclassname: cellclassname },
         			 { text: 'Ref Type',datafield: 'dtype', width: '10%',cellclassname: cellclassname },
         			 { text: 'Ref No',datafield: 'refno', width: '8%',cellclassname: cellclassname },
         			 { text: 'Inv No', datafield: 'invno',  width: '7%',cellclassname: cellclassname },
					 { text: 'Inv Date', datafield: 'invdate',  width: '6%',cellclassname: cellclassname,cellsformat:'dd.MM.yyyy' },
					 { text: 'Product Total', datafield: 'ptotal',  width: '7%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right'},
					 { text: 'Discount Total', datafield: 'distotal',  width: '7%',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname ,cellsformat: 'd2',cellsalign:'right',align:'right'},
					 {text:'Tax Amount' , datafield:'taxamount',hidden:false ,width: '8%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					 { text: 'Net Total', datafield: 'nettotaltax',  width: '7%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
					 { text: 'Services', datafield: 'service' ,cellsformat:'d2',cellclassname: cellclassname ,  width: '10%',cellsalign: 'right', align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring},
					 { text: 'Purchase Expense', datafield: 'purexp' ,cellclassname: cellclassname ,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellsformat: 'd2',cellsalign:'right',align:'right'},
					 { text: 'SGST', datafield: 'sgst'   ,cellclassname: cellclassname ,  width: '6%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true },
					 { text: 'CGST', datafield: 'cgst'   ,cellclassname: cellclassname ,  width: '6%',cellsformat: 'd2',cellsalign:'right',align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
					 { text: 'IGST', datafield: 'igst'   ,cellclassname: cellclassname,  width: '6%',cellsformat: 'd2',cellsalign:'right',align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
					 {text:'Total Amount' , datafield:'totalamount',  width: '7%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					 
					 
                /*   { text: 'Product Id', datafield: 'productid',  width: '13%',cellclassname: cellclassname }, 
           	         { text: 'Product Name', datafield: 'productname',  width: '25%',cellclassname: cellclassname },
           	         { text: 'Unit', datafield: 'unit',  width: '5%' ,cellclassname: cellclassname},
           	         { text: 'Total Qty', datafield: 'qty',  width: '6%' ,cellsformat:'d2',cellclassname: cellclassname},
           	         { text: 'Out Qty', datafield: 'out_qty',  width: '6%' ,cellsformat:'d2',cellclassname: cellclassname},
		           	 { text: 'Balance Qty', datafield: 'balqty',  width: '6%' ,cellsformat:'d2',cellclassname: cellclassname},
		           	 { text: 'Unit Price', datafield: 'amount',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
		           	{ text: 'Total', datafield: 'total',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
		           	 { text: 'Discount %', datafield: 'disper',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
		           	 { text: 'Discount', datafield: 'discount',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
		            */ 
		            
		           
		          
		            
		            
		            
		            {text:'brhid' , datafield:'brhid',  width: '7%',cellsformat:'d2',cellsalign: 'right', align:'right',hidden:true },
		            
		            {text:'tr_no' , datafield:'tr_no',  width: '7%',cellsformat:'d2',cellsalign: 'right', align:'right',hidden:true },
					
		            /*  {text:'Bal Amount' , datafield:'balamount',  width: '12%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{text:'Cancel Amount' , datafield:'cancelamt',  width: '12%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
		   */
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    $("#sumorderlistgrid").on('cellclick', function (event) 
    		{
    	 var rowindextemp = event.args.rowindex;
    	 
   
    	  var datafield = event.args.datafield;
   	   
    	  
    
    	   if(datafield=="butview")
    		   {
    	 		
    		   cmbbranch.value=$('#sumorderlistgrid').jqxGrid('getcellvalue', "brhid");
    		   
    		   funPurchase($('#sumorderlistgrid').jqxGrid('getcellvalue', rowindextemp, "doc_no"));
    		   
     
    		   }
    	 
    	
    		});
   
});


</script>
<div id="sumorderlistgrid"></div>
