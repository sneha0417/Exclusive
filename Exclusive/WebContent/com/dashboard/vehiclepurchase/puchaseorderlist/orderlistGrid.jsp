 <%@page import="com.dashboard.vehiclepurchase.purchaselist.ClsPurchaseListDAO" %>
<%ClsPurchaseListDAO cpd=new ClsPurchaseListDAO(); %>
 
 
 <%
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  
  	
  	String statusselect = request.getParameter("statusselect")==null?"0":request.getParameter("statusselect").trim();
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
var enqdatas;

 if(temp4!='NA')
{ 
	
	 enqdatas='<%=cpd.orderlistsearch(barchval,fromdate,todate,statusselect)%>'; 
		// alert(enqdata); --%>
} 
else
{ 
	
	enqdatas;
	
	}  

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
//doc_no, voc_no, date, type, expdeldt, qty, brand, model, color  
                        {name : 'voc_no', type: 'String'  },
						{name : 'date', type: 'date'  },
						{name : 'type', type: 'String'  },
						{name : 'expdeldt', type: 'date'  },
						{name : 'qty', type: 'String'  },
						{name : 'brand', type: 'String'},
						{name : 'model', type: 'String'},
						{name : 'color', type: 'String'  },
						{name : 'spec', type: 'String'  },
						{name : 'description', type: 'String'  },
						{name : 'account', type: 'String'  },
						{name : 'price', type: 'String'  },
						{name : 'total', type: 'String'  },
						{name : 'odqty', type: 'String'  },
						{name : 'pqty', type: 'String'  },
						{name : 'remqty', type: 'String'  },
			 
						  
						
						//voc_no, doc_no, date, type, expdeldt, description, account, qty, price, total, brand, model, color	
						
						],
				    localdata: enqdatas,
        
        
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
    
    
   
   
    
    $("#orderlist").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
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
                      { text: 'Doc No',datafield: 'voc_no', width: '5%' },
         			 { text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy'},
           	         { text: 'Type', datafield: 'type',  width: '5%' }, 

				     { text: 'Exp.Delivery', datafield: 'expdeldt', width: '7%',cellsformat:'dd.MM.yyyy'},
				     
					 { text: 'Account', datafield: 'account', width: '6%' },
				     
					 { text: 'Account Name', datafield: 'description', width: '15%' },
					 
					 { text: 'Order Qty', datafield: 'odqty', width: '7%' },
					 { text: 'Purchased Qty', datafield: 'pqty', width: '7%' },
					 { text: 'Remaining Qty', datafield: 'remqty', width: '7%' },


					 
					 { text: 'Price', datafield: 'price', width: '7%' },
					 { text: 'Total', datafield: 'total', width: '7%' },
				
					 { text: 'Brand', datafield: 'brand', width: '14%'},
					 { text: 'Model', datafield: 'model', width: '15%'},
					 { text: 'Color', datafield: 'color', width: '8%'},
					
					
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
   
});


</script>
<div id="orderlist"></div>