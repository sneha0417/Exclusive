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
var enqdata;

 if(temp4!='NA')
{ 
	
	 enqdata='<%=cpd.reqlistsearch(barchval,fromdate,todate,statusselect)%>'; 
		// alert(enqdata); --%>
} 
else
{ 
	
	enqdata;
	
	}  

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
//doc_no, voc_no, date, type, expdeldt, qty, brand, model, color   	orderqty purqty remqty
                        {name : 'voc_no', type: 'String'  },
						{name : 'date', type: 'date'  },
						{name : 'type', type: 'String'  },
						{name : 'expdeldt', type: 'date'  },
						{name : 'qty', type: 'String'  },
						{name : 'brand', type: 'String'},
						{name : 'model', type: 'String'},
						{name : 'color', type: 'String'  },
						{name : 'spec', type: 'String'  },
						
						{name : 'orderqty', type: 'String'  },
					 
						{name : 'remqty', type: 'String'  },
						
						
						{name : 'puqty', type: 'String'  },
					 
						{name : 'rempuqty', type: 'number'  },
						    
						],
				    localdata: enqdata,
        
        
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
    
    
   
   
    
    $("#reqlistgrid").jqxGrid(
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
         			 { text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy'},
           	         { text: 'Type', datafield: 'type',  width: '4%' }, 
		
			
				     { text: 'Exp.Delivery', datafield: 'expdeldt', width: '8%',cellsformat:'dd.MM.yyyy'},
					 { text: 'Qty', datafield: 'qty', width: '4%' },
					 { text: 'Order Qty', datafield: 'orderqty', width: '5%' },
					
					 { text: 'Bal-Order Qty', datafield: 'remqty', width: '7%' },
					 
					 
			
					 { text: 'Purchase Qty', datafield: 'puqty', width: '9%' },    
				
					 { text: 'Bal-Purchase Qty', datafield: 'rempuqty', width: '9%' },
				
					 { text: 'Brand', datafield: 'brand', width: '11%'},
					 { text: 'Model', datafield: 'model', width: '12%'},
					 { text: 'Color', datafield: 'color', width: '8%'},
					{ text: 'Specification', datafield: 'specification', width: '22%' },	
					
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
   
});


</script>
<div id="reqlistgrid"></div>