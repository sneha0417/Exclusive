  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.dashboard.purchases.purchasevendorquote.ClspurchasevendorquoteDAO"%>
 <% ClspurchasevendorquoteDAO searchDAO = new ClspurchasevendorquoteDAO(); 
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim();



 
System.out.println("=====docno====="+docno);

 


%>
  <style type="text/css">
  .advanceClass
  {
      
     background-color: #ffdead;     
      	
  }
  .yellowClass
        {
        
       
       background-color: #ffc0cb; 
        
        }
</style>


<script type="text/javascript">
var descdata1;
 
var temp='<%=docno%>';
 
  if(temp>0)
{

	descdata1='<%=searchDAO.mainsearch(docno)%>';  
 
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
        	if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
     	   {
     		value=0.0;
     	   }
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
         }
             
     	 
             
           
         var cellclassname =  function (row, column, value, data) {

 
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
                    		
                    		 {name : 'docno', type: 'int'  }, 
                    		 {name : 'branchids', type: 'int'  }, 
                    		 
                    		 {name : 'fdate', type: 'date'  },
                    		 {name : 'refrowno', type: 'int'  }, 
                    		 
     						
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

            
            
            $("#serviecGrid").jqxGrid(
            {
                width: '99.5%',
                height: 450,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
               
                statusbarheight: 21,
               
                editmode: 'selectedcell',
                selectionmode: 'singlecell',
                pagermode: 'default',
                
                //Add row method
 
 
                
                columns: [
                
							   { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
                        
                        	{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '10%',cellclassname: cellclassname, editable: false,
                          	  
                         
                            	
                            	
  							    createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							     
  							         editor.html('<input type="text" id="part_no" name="part_no" style="width:100%;height:99%;"   />' ); 
  							   
  							        
  							    },  
  							 
                           
  							 
							}, 
							{ text: 'Product Name', datafield: 'productname',  cellclassname: cellclassname ,columntype: 'custom', editable: false,
								

  								
  								createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							       
  							         editor.html('<input type="text" id="productname" name="productname" style="width:100%;height:99%;"   />' ); 
  							     
  							        
  							    },  
							
							}, 
							{ text: 'Unit', datafield: 'unit', width: '5%',cellclassname: cellclassname ,editable: false },
							
						
							{ text: 'Quantity', datafield: 'qty', width: '6%' ,cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2', editable: false },
							{ text: 'Unit Price', datafield: 'unitprice', width: '10%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2',cellclassname: cellclassname },
							{ text: 'Total', datafield: 'total', width: '10%' ,editable: false,cellsalign: 'right', align:'right',cellsformat:'d2' ,cellclassname: cellclassname},
							{text: 'Discount %', datafield: 'discper', width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',cellclassname: cellclassname},
							{ text: 'Discount', datafield: 'discount', width: '8%',cellsalign: 'right', align:'right',cellsformat:'d2' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname},
							{ text: 'Net Amount', datafield: 'nettotal', width: '10%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname},
							
							{ text: 'Follow up Date', datafield: 'fdate', width: '8%',cellsformat:'dd.MM.yyyy' },
							
							{text: 'prodoc', datafield: 'prodoc', width: '10%' ,hidden:true},
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',hidden:true  },
							{text: 'psrno', datafield: 'psrno', width: '10%',hidden:true },
							{text: 'qutval', datafield: 'qutval', width: '10%' ,cellsformat:'d2' ,hidden:true  },
							{ text: 'pqty', datafield: 'pqty', width: '9%',cellsformat:'d2'  ,hidden:true  },
							{text: 'saveqty', datafield: 'saveqty', width: '10%' ,cellsformat:'d2'  ,hidden:true },
						 
							{text: 'pid', datafield: 'proid', width: '10%' ,hidden:true  }, 
  							{text: 'pname', datafield: 'proname', width: '10%'  ,hidden:true}, 
							
							 
							{text: 'checktype', datafield: 'checktype', width: '10%'  ,hidden:true},    
							{text: 'specid', datafield: 'specid', width: '10%' ,hidden:true  },
							
							{text: 'docno', datafield: 'docno', width: '10%'   ,hidden:true   },
							
							{text: 'refrowno', datafield: 'refrowno', width: '10%'   ,hidden:true   },
							
							
	              ]
            
            
            
            });
       
        	  $("#overlay, #PleaseWait").hide();
        	    $('#serviecGrid').on('cellclick', function (event) 
        	    		{ 
        	    	
        	   	 $('#date').jqxDateTimeInput({ disabled: false});
        	  	
        		 $('#cmbinfo').attr("disabled",false);
        		 $('#remarks').attr("readonly",false);
        		 $('#Update').attr("disabled",false);
        		 $('#FixedDiv').attr("disabled",false);
        			document.getElementById("cmbinfo").value="";
        			document.getElementById("remarks").value="";
        			 $('#date').val(new Date());
        		 
        			  var rowindex1=event.args.rowindex;
       			 
       			  
       			  document.getElementById("docno").value=$('#serviecGrid').jqxGrid('getcelltext', rowindex1, "docno");
       			  document.getElementById("branchids").value=$('#serviecGrid').jqxGrid('getcelltext', rowindex1, "branchids");
       			  document.getElementById("refrowno").value=$('#serviecGrid').jqxGrid('getcelltext', rowindex1, "refrowno");
       			  
       			

       		       $("#detaildiv").load("detailgrid.jsp?rdoc="+$('#serviecGrid').jqxGrid('getcellvalue', rowindex1, "docno")+"&refrowno="+$('#serviecGrid').jqxGrid('getcellvalue', rowindex1, "refrowno"));
       		    
        		 
        	    	
        	    		});
        	    
                function valchange(rowBoundIndex)
                {
                	
      
                	var qty= $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
                	var unitprice=	$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");	
                	var total=parseFloat(qty)*parseFloat(unitprice);
               		
        		    $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
        		    
        		   var gtotal= $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
     				  
        	   		var discount=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "discount");	
        	   		
        	   			
        	        		    
        	        		
        	   		var nettotal=parseFloat(gtotal)-parseFloat(discount);
        	   		if(discount==""||discount==null||discount=="undefiend")
        	   			{
        	   		  $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",total);
        	   			}
        	   		else{
        	   			$('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",nettotal);
        	   		}
        	                    
               
        	               
        	               
        
                }

                $("#serviecGrid").on('cellvaluechanged', function (event) 
                {
                	var datafield = event.args.datafield;
            		
        		    var rowBoundIndex = event.args.rowindex;
        		    
        		    
        	    
        	    
        	    
        	    if(datafield=="unitprice")
       		    {
           	   
   			
           	  	  
           			valchange(rowBoundIndex);
     
           			
           			
       		    }
           
		           		if(datafield=="discount")
		       		    {
		           			
		           		var	 totals=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
		           		
		           		var discounts=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "discount");
		           			
		           		var	discper=(100/parseFloat(totals))*parseFloat(discounts);
		           		
		
		           			
		           			$('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "discper",discper);
		           			valchange(rowBoundIndex);
		  				
		       		    }
		           		
		           		
		           		
		           		if(datafield="discper")
		           			
		           			{
		           			
		           			
		            	           			
		           			var	 totals=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
				           		
				           		var discper=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "discper");
				           	var	discounts=(parseFloat(totals)*parseFloat(discper))/100;
		           			 
		           		$('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "discount",discounts);
		           			 
		           			 
		           		 
           	               	}
           		 
           		});
           
        	    
        	    
        });
 
        
 
	
  
    </script>
    <div id="serviecGrid"></div>
<!--      <div id='jqxWidget'>
   <div id="serviecGrid"></div>
    <div id="popupWindow">
 
 <div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div> -->
    
<!-- <div id="serviecGrid"></div> -->
<input type="hidden" id="rowindex">
   <input type="hidden" id="datas1"/>  

   <input type="hidden" id="datas"/>     <!--   FOR DOUBLE CLICK -->
