
 
 <%@page import="com.dashboard.purchase.ClspurchaseReportsDAO"%>
 <% ClspurchaseReportsDAO searchDAO = new ClspurchaseReportsDAO(); 
 
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  
  	
  	String statusselect = request.getParameter("statusselect")==null?"0":request.getParameter("statusselect").trim();
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
var datas;

 if(temp4!='NA')
{ 
	
	 datas='<%=searchDAO.reqlistsearch(barchval,fromdate,todate,statusselect)%>'; 
	 datass='<%=searchDAO.reqlistsearchex(barchval,fromdate,todate,statusselect)%>'; 
	 
		// alert(enqdata); --%>
} 
else
{ 
	
	datas;
	
	}  

$(document).ready(function () {
    // prepare the data
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
    
    
   
   
    
    $("#requestlist").jqxGrid(
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
                      { text: 'Doc No',datafield: 'voc_no', width: '6%' },
         			 { text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
         			   { text: 'Ref No',datafield: 'refno', width: '14%' },
         			 
           	         { text: 'Product Id', datafield: 'productid',  width: '16%' }, 
           	      { text: 'Product Name', datafield: 'productname',  width: '30%' },
           	      { text: 'Unit', datafield: 'unit',  width: '10%' },
           	      { text: 'Quantity', datafield: 'qty',  width: '10%' ,cellsformat:'d2',cellsalign: 'right',align : 'right'},
           
	    
					
					
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
   
});


</script>
<div id="requestlist"></div>