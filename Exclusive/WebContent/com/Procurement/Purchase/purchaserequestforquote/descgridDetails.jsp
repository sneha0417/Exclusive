  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%@page import="com.procurement.purchase.purchaserequestforquote.ClspurchaserequestforquoteDAO"%>
<% ClspurchaserequestforquoteDAO  purchaserequestforquoteDAO = new ClspurchaserequestforquoteDAO(); %> 
<%
String purdoc=request.getParameter("purdoc")==null?"0":request.getParameter("purdoc").trim();


 


%>
<script type="text/javascript">
var descdata;



var temp='<%=purdoc%>';
 if(temp>0)
{
 
	descdata='<%=purchaserequestforquoteDAO.reloadserv(purdoc)%>';  
 
 
}

else
 
{   
	
	 
	descdata;

 } 


        $(document).ready(function () { 	
        
        	  var rendererstring1=function (aggregates){
               	var value=aggregates['sum1'];
               	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
               }    
            
         var rendererstring=function (aggregates){
        	 
        	 
        	 
         	var value=aggregates['sum'];
         	
         	 if(typeof(value) == "undefined"){
                 value=0.00;
                }
         	
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
         }
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						
     						{name : 'description', type: 'string'    },
     						{name : 'qty1', type: 'number'    },
     						{name : 'unitprice1', type: 'number'    },
     						{name : 'total1', type: 'number'    },
     						{name : 'discount1', type: 'number'    },
     						 
     						{name : 'nettotal1', type: 'number'    },
     					 
     						{name : 'srno', type: 'int'  }
     						
     						
                 ],
              
                 localdata: descdata,
                
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

            
            
            $("#descdetailsGrid").jqxGrid(
            {
                width: '100%',
                height: 147,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                disabled:true,
                statusbarheight: 21,
                selectionmode: 'singlecell',
                pagermode: 'default',
                
                //Add row method
         //Add row method
  
                
                
                columns: [
                
							   { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
				
							{ text: 'Description', datafield: 'description', width: '36%', },
							{ text: 'Quantity', datafield: 'qty1', width: '10%' ,cellsalign: 'left', align:'left',cellsformat:'d2'},
							{ text: 'Unit Price', datafield: 'unitprice1', width: '10%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2'},
							{ text: 'Total', datafield: 'total1', width: '15%' ,editable: false,cellsalign: 'right', align:'right',cellsformat:'d2'},
		    				{ text: 'Discount', datafield: 'discount1', width: '10%',cellsalign: 'right', align:'right',cellsformat:'d2' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
							{ text: 'Net Amount', datafield: 'nettotal1', width: '15%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false},
						 
							{ text: 'srno', datafield: 'srno', width: '9%',hidden:true}
						
							
	              ]
            });
           if(temp==0)
        	   {
            $("#descdetailsGrid").jqxGrid('addrow', null, {});
 
          
        	   }
           
           
           if(($('#mode').val()=='A')||($('#mode').val()=='E'))
   		       {
   		  $("#descdetailsGrid").jqxGrid({ disabled: false}); 
   		
   		  
   		        }
           
           
           
            function valchange(rowBoundIndex)
            {
            	
            	
            	var qty= $('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty1");	
            	var unitprice=	$('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice1");	
            	var total=parseFloat(qty)*parseFloat(unitprice);
           		
    		    $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "total1",total);
    		    
    		   var gtotal= $('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "total1");
				  
    	   		var discount=$('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "discount1");	
    	        		    
    	        		
    	   		var nettotal=parseFloat(gtotal)-parseFloat(discount);
    	   		if(discount==""||discount==null||discount=="undefiend")
    	   			{
    	   		  $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal1",total);
    	   			}
    	   		else{
    	   			$('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal1",nettotal);
    	   		}
    	        		    
    	        		    var summaryData= $("#descdetailsGrid").jqxGrid('getcolumnaggregateddata', 'nettotal1', ['sum'],true);
    	                    
    	        		    
    	        	
    	        		    
    	                    document.getElementById("nettotal").value=summaryData.sum.replace(/,/g,'');
    	                    
    	                    
    	                    
    	                    
    	                    
    	                    
    	  	                
      	                  var ordertotal="0";
      	   	          	  
      	   	         	  var maintotalval="0";
      	   	         	  
      	   	             
      	   	               
      	   	               if(document.getElementById("netTotaldown").value!="" && !(document.getElementById("netTotaldown").value==null) && !(document.getElementById("netTotaldown").value=="undefiend")) 
      	   	            	   {
      	   	            	   
      	   	  
      	   	            maintotalval=parseFloat(document.getElementById("netTotaldown").value);
      	   	            	   }
      	   	               
      	   	               
      	   	        
      	   	               
      	   	               
      	   	               
      	   	              
      	   	              ordertotal=parseFloat(maintotalval)+parseFloat(document.getElementById("nettotal").value);
      	   	            	   
      	                
      	            	funRoundAmt(ordertotal,"orderValue");
      	                
    	                    
    		    
    	      
            }

            $("#descdetailsGrid").on('cellvaluechanged', function (event) 
            {
            	
            	 
              	 var rowBoundIndex = event.args.rowindex;
            	 var rows = $('#descdetailsGrid').jqxGrid('getrows');
                 var rowlength= rows.length;
    
                 
                 if(rowBoundIndex == rowlength-1)
                 	{  
                 $("#descdetailsGrid").jqxGrid('addrow', null, {});
                 	} 
            	
            	var datafield = event.args.datafield;
        		
    		   
    		     
            		if(datafield=="qty1")
            		    {
            
            			valchange(rowBoundIndex);
            		    }
            		if(datafield=="unitprice1")
        		    {
            			
            	
            			valchange(rowBoundIndex);
          	
            			
        		    }
            		if(datafield=="discount1")
        		    {
            			valchange(rowBoundIndex);
   				
        		    }
            		 
            		});
            
          
        });
    </script>
<div id="descdetailsGrid"></div>

