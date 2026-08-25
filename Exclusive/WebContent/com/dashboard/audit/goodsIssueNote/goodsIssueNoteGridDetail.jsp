  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.audit.goodsIssueNote.ClsGoodsIssueNoteDAO"%>
<% ClsGoodsIssueNoteDAO searchDAO = new ClsGoodsIssueNoteDAO(); %> 



<%
String doc_no = request.getParameter("doc_no")==null?"0":request.getParameter("doc_no").trim();
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
var descdata1;
var temp2='<%=doc_no%>';

 


  if(temp2>0)
{
 
	descdata1='<%=searchDAO.goodsIssueDetailGrid(doc_no) %>'; 
	 
}

else
 
{   
	descdata1;

 } 


        $(document).ready(function () { 
        	
       	  var rendererstring2=function (aggregates){
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
             
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [  
     						
                      		{name : 'productid', type: 'string'    },
                    		{name : 'productname', type: 'string'    },
                    		{name : 'unit', type: 'String'    },
     						{name : 'qty', type: 'number'    },
     						/* {name : 'unitprice', type: 'number'    },  
     						{name : 'total', type: 'number'    },
     						{name : 'discount', type: 'number'    },
     					
     						{name : 'nettotal', type: 'number'    }, */
     						{name : 'prodoc', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
     						
     					  	{name : 'qutval', type: 'number' },
     						{name : 'saveqty', type: 'number'},  
     						
     						{name : 'checktype', type: 'number' },
     				        {name : 'pqty', type: 'number'    },  
     						
     				     	{name : 'proid', type: 'string'    },
                    		{name : 'proname', type: 'string'    },
                    		{name : 'specid', type: 'string'  },     
                    		
                    		 {name : 'foc', type: 'number'    },  
                    		 
                    		 {name : 'unitprice', type: 'string'    },   
                    		 
                    		 {name : 'refrowno', type: 'int'    },  
                    		 
                    		 {name : 'discount', type: 'number'    },  
                    		 
                    		 {name : 'disper', type: 'number'    },  
                    		 {name : 'brandname', type: 'string'    },    
                     
                    		
                    		
                 ],
              
                 localdata: descdata1,
                
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

            
            
            $("#goodsIssueNoteGrd").jqxGrid(
            {
                width: '99.5%',
                height: 250,
                source: dataAdapter,
               // showaggregates:true,
               //   showstatusbar:true,
                editable: true,
               
                statusbarheight: 21,
                selectionmode: 'singlecell',
                pagermode: 'default',
                
                //Add row method
         //Add row method
                columns: [
                
							   { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
				
                        	{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '20%'}, 
							{ text: 'Product Name', datafield: 'productname'  ,columntype: 'custom'	},
							{ text: 'Brand Name', datafield: 'brandname', width: '15%', editable:false },
							{ text: 'Unit', datafield: 'unit', width: '6%', editable:false},
							{ text: 'Quantity', datafield: 'qty',  cellsalign: 'left', align:'left',cellsformat:'d2'},
							{ text: 'FOC', datafield: 'foc', width: '10%' ,cellsalign: 'left', align:'left',ellsformat:'d2',hidden:true},
							{ text: 'Unit Price', datafield: 'unitprice', width: '10%'   ,hidden:true },
							{ text: 'discount', datafield: 'discount', width: '10%'   ,hidden:true },
							{ text: 'disper', datafield: 'disper', width: '10%'   ,hidden:true },
							{ text: 'prodoc', datafield: 'prodoc', width: '10%' ,hidden:true  },
							{ text: 'unitdocno', datafield: 'unitdocno', width: '10%' ,hidden:true  },
							{ text: 'psrno', datafield: 'psrno', width: '10%',hidden:true  },
							{ text: 'refrowno', datafield: 'refrowno', width: '10%',hidden:true   },
							{ text: 'Cost price', datafield: 'cost_price', width: '10%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,hidden:true },
							{ text: 'Net Cost price', datafield: 'savecost_price', width: '10%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer: rendererstring ,editable: false,hidden:true },
					  	    { text: 'qutval', datafield: 'qutval', width: '10%' ,cellsformat:'d2'   ,hidden:true  },
							{ text: 'pqty', datafield: 'pqty', width: '9%',cellsformat:'d2' ,hidden:true    },
							{text: 'saveqty', datafield: 'saveqty', width: '10%' ,cellsformat:'d2'  ,hidden:true   }, 
							{text: 'pid', datafield: 'proid', width: '10%' ,hidden:true  }, 
  							{text: 'pname', datafield: 'proname', width: '10%'  ,hidden:true}, 
							{text: 'checktype', datafield: 'checktype', width: '10%'  ,hidden:true},    
							{text: 'specid', datafield: 'specid', width: '10%',hidden:true   },
	              ]
            });
		  
        });     	 
        	 
        
        
    </script>
<div id="goodsIssueNoteGrd"></div>