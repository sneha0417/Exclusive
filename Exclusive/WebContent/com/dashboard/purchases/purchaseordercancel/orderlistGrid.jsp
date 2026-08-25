
 
 <%@page import="com.dashboard.purchase.ClspurchaseReportsDAO"%>
 <% ClspurchaseReportsDAO searchDAO = new ClspurchaseReportsDAO(); 
 
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  
  	String acno = request.getParameter("acno")==null?"NA":request.getParameter("acno").trim();
  	
  	String statusselect = request.getParameter("statusselect")==null?"0":request.getParameter("statusselect").trim();
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
var datas;

 if(temp4!='NA')
{ 
	
	 datas='<%=searchDAO.ordercancellistsearch(barchval,fromdate,todate,statusselect,acno)%>'; 
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
						
						{name : 'btnsave', type: 'string'  },
						{name : 'rowno', type: 'String'  }, 
						
						
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
    
    
   
   
    
    $("#orderlistgrid").jqxGrid(
    {
        width: '98%',
        height: 500,
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
                     { text: 'Doc No',datafield: 'voc_no', width: '4%' },
         			 { text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy'},
         		/* 	 { text: 'Ref No',datafield: 'ref_no', width: '10%' }, */
         			 { text: 'Type',datafield: 'dtype', width: '15%' },
         		     { text: 'Account', datafield: 'account',  width: '5%'  },
                     { text: 'Account Name', datafield: 'acname',  width: '14%'  },
           	         { text: 'Product Id', datafield: 'productid',  width: '11%' }, 
           	         { text: 'Product Name', datafield: 'productname' },
           	   /*       { text: 'Unit', datafield: 'unit',  width: '5%' }, */
           	         { text: 'Total Qty', datafield: 'qty',  width: '5%' ,cellsformat:'d2',cellsalign: 'right',align : 'right'},
           	         { text: 'Out Qty', datafield: 'out_qty',  width: '5%' ,cellsformat:'d2',cellsalign: 'right',align : 'right'},
		           	 { text: 'Balance Qty', datafield: 'balqty',  width: '6%' ,cellsformat:'d2',cellsalign: 'right',align : 'right'},
		           	 { text: ' ', datafield: 'btnsave', width: '6%',columntype: 'button',editable:false, filterable: false},
		           	 { text: 'rowno ', datafield: 'rowno', width: '6%' ,editable:false, filterable: false,hidden:true},
		           	 
		 /*           	 { text: 'Unit Price', datafield: 'amount',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		           	 { text: 'Total', datafield: 'total',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		           	 { text: 'Discount %', datafield: 'disper',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		           	 { text: 'Discount', datafield: 'discount',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		             { text: 'Net Total', datafield: 'nettotal',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						 */	
 
					
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
    $("#orderlistgrid").on('cellclick', function (event) 
    		{
    		 
    		    var datafield = event.args.datafield;
    		    var rowBoundIndex=event.args.rowindex;
    		    
    		    	    
    if(datafield=="btnsave"){
   	 if($('#orderlistgrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Save"){
   		
   		
   		 
   		 //for 
   		  var radocno= $('#orderlistgrid').jqxGrid('getcellvalue',rowBoundIndex, "rowno");
    		 
   		 
   		
		    		          $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		    		        	  
		    	     		       
							       		        	if(r==false)
							       		        	  {
							       		        		return false; 
							       		        	  }
							       		        	else{
							        				 savegriddata(radocno);
							       		        	   }
		    		                      });
   	                      }
						           	 else {
						           		 
						           	
						           	  $('#orderlistgrid').jqxGrid('setcellvalue',rowBoundIndex, "btnsave","Save");
						           	         }
						             }
    });
	          
 }); 

function savegriddata(radocno)
{
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
     			
			var items=x.responseText;
			
			
			 $.messager.alert('Message', '  Record successfully Updated ', function(r){
			     
		     });
			 funreload(event); 
			 
			 
			
			}
		
	}
		
x.open("GET","savedate.jsp?radocno="+radocno,true);

x.send();
		
}

   
 


</script>
<div id="orderlistgrid"></div>