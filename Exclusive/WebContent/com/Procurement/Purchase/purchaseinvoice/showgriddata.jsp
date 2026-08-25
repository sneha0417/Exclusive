     <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.procurement.purchase.purchaseinvoice.ClspurchaseinvoiceDAO"%>
<% ClspurchaseinvoiceDAO purchaseDAO = new ClspurchaseinvoiceDAO(); %>   
 
  <%
String purdoc=request.getParameter("purdoc")==null?"0":request.getParameter("purdoc").trim();




String from=request.getParameter("from")==null?"0":request.getParameter("from").trim();

String reftype=request.getParameter("reftype")==null?"NA":request.getParameter("reftype").trim();

String reqmasterdocno=request.getParameter("reqmasterdocno")==null?"0":request.getParameter("reqmasterdocno").trim();





%>  
  <style type="text/css">
 
  .yellowClass
        {
        
       
       background-color: #f0e68c; 
        
        }
</style>


<script type="text/javascript">
var loaddata;
 
  var temp='<%=purdoc%>';
  
  var temp1='<%=reftype%>';
  if(temp>0)
{
 
	loaddata='<%=purchaseDAO.calutationshowdata(purdoc,reftype,reqmasterdocno)%>';  

}

else
 
{  
	loaddata;

  } 


        $(document).ready(function () { 	
        	
        /* 	 if(temp1=="DIR")
           	{
        	chkfoc();
           	} */
/*        	  var rendererstring2=function (aggregates){
             	var value=aggregates['sum2'];
             	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "  Total" + '</div>';
             }    
          
  
        
        	  var rendererstring1=function (aggregates){
               	var value=aggregates['sum1'];
               	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
               }    
            
         var rendererstring=function (aggregates){
         	var value=aggregates['sum'];
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
         }
             
     	 
      */
         
 
         
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [     
     						
                      		{name : 'productid', type: 'string'    },
                    		{name : 'productname', type: 'string'    },
                    		{name : 'unit', type: 'String'    },
     						{name : 'qty', type: 'number'    },
     						{name : 'unitprice', type: 'number'    },
     						{name : 'total', type: 'number'    },
     						{name : 'discount', type: 'number'    },       
     					
     						{name : 'nettotal', type: 'number'    },
     						{name : 'prodoc', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
     						
     						{name : 'qutval', type: 'number'    },
     						{name : 'saveqty', type: 'number'    },
     						
     						{name : 'discper', type: 'number'    },
     						
     						{name : 'checktype', type: 'number'    },   //no use
     						{name : 'pqty', type: 'number'    },
     						
     				     	{name : 'proid', type: 'string'    },
                    		{name : 'proname', type: 'string'    },
                    		{name : 'specid', type: 'string'  },
                    		
                    		 {name : 'foc', type: 'number'    },  
                    		{name : 'stockid', type: 'number'  },
                 
                    		  {name : 'cost_price', type: 'number'  },
                    		  
                    		  {name : 'netcost_price', type: 'number'  },
                    		  {name : 'sr_no', type: 'Int'    },
                    		  
                    		  
                    		  
                    		
                    		  
                 ],
              
                 localdata: loaddata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            
            var cellclassname = function (row, column, value, data) {
        		
                    return "yellowClass";
                
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#showdata").jqxGrid(
            {
                width: '99.5%',
                height: 297,
                source: dataAdapter,
               // showaggregates:true,
              //  showstatusbar:true,
                editable: false,
                 
                statusbarheight: 21,
                selectionmode: 'singlecell',
                pagermode: 'default',
                
              
                columns: [
                
							   { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sr_no' ,width: '3%',cellclassname: cellclassname},
				
                        	{ text: 'Product', datafield: 'productid',  width: '8%',cellclassname: cellclassname},
							{ text: 'Product Name', datafield: 'productname',  cellclassname: cellclassname }, 
							{ text: 'Unit', datafield: 'unit', width: '6%',cellclassname: cellclassname },
							
				 
							  
							  { text: 'oldqty', datafield: 'oldqty', width: '5%' ,cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2',hidden:true},
							  
							{ text: 'Quantity', datafield: 'qty',cellsalign: 'left', width: '5%' ,align:'left',cellclassname: cellclassname,cellsformat:'d2'},
							
							
					 
							{ text: 'FOC', datafield: 'foc', width: '5%' ,cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2',hidden:true},
				 
							{ text: 'Unit Price', datafield: 'unitprice', width: '9%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2',cellclassname: cellclassname },
							{ text: 'Total', datafield: 'total', width: '9%' ,editable: false,cellsalign: 'right', align:'right',cellsformat:'d2' ,cellclassname: cellclassname},
							{text: 'Discount %', datafield: 'discper', width: '7%' ,  cellsformat:'d2',cellsalign: 'right', align:'right',cellclassname: cellclassname},
							{ text: 'Discount', datafield: 'discount', width: '8%',cellsalign: 'right', align:'right',cellsformat:'d2' ,cellclassname: cellclassname},
							{ text: 'Net Amount', datafield: 'nettotal', width: '9%',cellsformat:'d2',cellsalign: 'right', align:'right',editable: false,cellclassname: cellclassname},
							{ text: 'Net Cost Price', datafield: 'netcost_price', width: '8%',cellsformat:'d2',cellsalign: 'right', align:'right',editable: false,cellclassname: cellclassname},
							{ text: 'Cost Price/Unit', datafield: 'cost_price', width: '8%',cellsformat:'d2',cellsalign: 'right', align:'right',editable: false,cellclassname: cellclassname},
			
							{text: 'prodoc', datafield: 'prodoc', width: '10%' ,hidden:true},
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',hidden:true  },
							{text: 'psrno', datafield: 'psrno', width: '10%',hidden:true },
							
							{text: 'stockid', datafield: 'stockid', width: '10%' ,hidden:true },
							
							
							{text: 'qutval', datafield: 'qutval', width: '10%' ,cellsformat:'d2' ,hidden:true  },
							{ text: 'pqty', datafield: 'pqty', width: '9%',cellsformat:'d2'  ,hidden:true  },
							{text: 'saveqty', datafield: 'saveqty', width: '10%' ,cellsformat:'d2' ,hidden:true  },
						 
							{text: 'pid', datafield: 'proid', width: '10%' ,hidden:true  }, 
  							{text: 'pname', datafield: 'proname', width: '10%'  ,hidden:true}, 
							
							 
							{text: 'checktype', datafield: 'checktype', width: '10%'  ,hidden:true},    
							{text: 'specid', datafield: 'specid', width: '10%' ,hidden:true  },
							
				 
						
							
	              ]
            });
            
          
            
          
        });
        
        
      
    </script>
<div id="showdata"></div>
 