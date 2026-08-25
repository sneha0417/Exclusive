
 
 <%@page import="com.dashboard.purchases.purchaserequestfollowup.ClsPurchaseRequestFollowupDAO"%>
 <% ClsPurchaseRequestFollowupDAO searchDAO = new ClsPurchaseRequestFollowupDAO(); 
 
    String docno = request.getParameter("docno")==null?"NA":request.getParameter("docno").trim();
    
    
 
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=docno%>';
var datas11;

 if(temp4!='NA')
{ 
	 
   datas11ex='<%=searchDAO.listsubsearchex(docno)%>';  
	 datas11='<%=searchDAO.listsubsearch(docno)%>'; 
	 
	 
	 
		 
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
  
        columnsresize: true,
        
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:true,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                   		 },	
           	         { text: 'Product Id', datafield: 'productid',  width: '15%', editable: false }, 
           	         { text: 'Product Name', datafield: 'productname' , editable: false },
           	      	 { text: 'Brand Name', datafield: 'brandname',  width: '12%' , editable: false}, 
           	         { text: 'Unit', datafield: 'unit',  width: '8%', editable: false},
           	         { text: 'Qty', datafield: 'qty',  width: '10%' ,cellsformat:'d2', editable: false},
           	         { text: 'Out Qty', datafield: 'out_qty',  width: '10%' ,cellsformat:'d2',hidden:true},
		          
		         	 
		         	
		         	 
		         	 
		         	 
		         	 
		        
		         	 
		         	 
					]
   
    });
    
    $('#ordersubgrid').on('cellvaluechanged', function (event) {
       	var datafield = event.args.datafield;
       	
       	var rowBoundIndex = event.args.rowindex;
       	
  		if(datafield=="discount")
		    {
   		 
   			
   		var	 totals=$('#ordersubgrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
   		
   		var discounts=$('#ordersubgrid').jqxGrid('getcellvalue', rowBoundIndex, "discount");
   			
   		var	discper=(100/parseFloat(totals))*parseFloat(discounts);
   	     $('#ordersubgrid').jqxGrid('setcellvalue', rowBoundIndex, "disper",discper);
   			valchange(rowBoundIndex);
			
		    }
   		
   		
   		
			if(datafield=="disper")
			 {
			   			
			   			var	 totals=$('#ordersubgrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
			           		
			           		var discper=$('#ordersubgrid').jqxGrid('getcellvalue', rowBoundIndex, "disper");
			           	var	discounts=(parseFloat(totals)*parseFloat(discper))/100;
			   			 
			   		 $('#ordersubgrid').jqxGrid('setcellvalue', rowBoundIndex, "discount",discounts);
			   			 
			 }	 
   			 
   			
			if(datafield=="amount")
		    {	 
   			 
        valchange(rowBoundIndex);
		    }
    });	
    	
    	
    function valchange(rowBoundIndex)
    {
    	

    	var qty= $('#ordersubgrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
    	var unitprice=	$('#ordersubgrid').jqxGrid('getcellvalue', rowBoundIndex, "amount");	
    	var total=parseFloat(qty)*parseFloat(unitprice);
   		
	    $('#ordersubgrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
	    
	   var gtotal= $('#ordersubgrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
			  
   		var discount=$('#ordersubgrid').jqxGrid('getcellvalue', rowBoundIndex, "discount");	
   		
   			
 
   		
   	var	 totals=$('#ordersubgrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
   	
    		
    		var discper=$('#ordersubgrid').jqxGrid('getcellvalue', rowBoundIndex, "disper");
    
	 
	if(discper==""||discper==null||discper=="undefiend")
		{
	  $('#ordersubgrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",total);
		}
	else{
		
		var	discounts=(parseFloat(totals)*parseFloat(discper))/100;
		 
  		 $('#ordersubgrid').jqxGrid('setcellvalue', rowBoundIndex, "discount",discounts);
  	   		
    	var nettotal=parseFloat(gtotal)-parseFloat(discounts);
		
		
		$('#ordersubgrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",nettotal);
	}
	 
	 
   		
   		}
   		
   		
   		
 
  
    
    $("#overlay, #PleaseWait").hide();
    
   
});


</script>
<div id="ordersubgrid"></div>