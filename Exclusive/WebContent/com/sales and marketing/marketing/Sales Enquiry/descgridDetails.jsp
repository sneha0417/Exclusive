  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%-- <%@page import="com.procurement.purchase.purchaseorder.ClspurchaseorderDAO"%>
<% ClspurchaseorderDAO purchaseorderDAO = new ClspurchaseorderDAO(); %> --%> 
<%
String purdoc=request.getParameter("purdoc")==null?"0":request.getParameter("purdoc").trim();

%>
<script type="text/javascript">
var descdata;

var temp='<%=purdoc%>';

if(temp>0)
{
 
	<%-- descdata='<%=purchaseorderDAO.reloadserv(purdoc)%>'; --%>  

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
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
         }
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						
     						{name : 'description', type: 'string'    },
     						{name : 'qty', type: 'int'    },
     						{name : 'unitprice', type: 'number'    },
     						{name : 'total', type: 'number'    },
     						{name : 'discount', type: 'number'    },
     						{name : 'netamt', type: 'number'    },
     						{name : 'nettotal', type: 'number'    },
     					 
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
                handlekeyboardnavigation: function (event) {
                 var rows = $('#descdetailsGrid').jqxGrid('getrows');
                  var rowlength= rows.length;
                    var cell = $('#descdetailsGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'unitprice' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key ==9) {                                                        
                            var commit = $("#descdetailsGrid").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    }
                    },
                
                
                columns: [
                
							   { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
				
							{ text: 'Description', datafield: 'description', width: '36%', },
							{ text: 'Quantity', datafield: 'qty', width: '10%' ,cellsalign: 'left', align:'left'},
							{ text: 'Unit Price', datafield: 'unitprice', width: '10%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2'},
							{ text: 'Total', datafield: 'total', width: '15%' ,editable: false,cellsalign: 'right', align:'right',cellsformat:'d2'},
		    				{ text: 'Discount', datafield: 'discount', width: '10%',cellsalign: 'right', align:'right',cellsformat:'d2' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
							{ text: 'Net Amount', datafield: 'nettotal', width: '15%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false},
						 
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
            	
            	
            	var qty= $('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
            	var unitprice=	$('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");	
            	var total=parseFloat(qty)*parseFloat(unitprice);
           		
    		    $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
    		    
    		   var gtotal= $('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
				  
    	   		var discount=$('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "discount");	
    	        		    
    	        		
    	   		var nettotal=parseFloat(gtotal)-parseFloat(discount);
    	   		if(discount==""||discount==null||discount=="undefiend")
    	   			{
    	   		  $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",total);
    	   			}
    	   		else{
    	   			$('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",nettotal);
    	   		}
    	        		    
    	        		    var summaryData= $("#descdetailsGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
    	                    
    	        		    
    	        	
    	        		    
    	                    document.getElementById("nettotal").value=summaryData.sum;
    	                    
    	                var aa= parseFloat(document.getElementById("netTotaldown").value)+parseFloat(document.getElementById("nettotal").value);
    	                    
    
    	                
    	            	funRoundAmt(aa,"orderValue");
    	                    
    		    
    	            var nettotalval=  $('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal");
           var nuprice=parseFloat(nettotalval)/parseFloat(qty);
                       $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "nuprice",nuprice);
            }

            $("#descdetailsGrid").on('cellvaluechanged', function (event) 
            {
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		     
            		if(datafield=="qty")
            		    {
            
            			valchange(rowBoundIndex);
            		    }
            		if(datafield=="unitprice")
        		    {
            			valchange(rowBoundIndex);
      
            			   var rows = $('#descdetailsGrid').jqxGrid('getrows');
                           var rowlength= rows.length;
                           if(rowBoundIndex == rowlength - 1)
                           	{  
                           $("#descdetailsGrid").jqxGrid('addrow', null, {});
                           	} 
                           	
            			
        		    }
            		if(datafield=="discount")
        		    {
            			valchange(rowBoundIndex);
   				
        		    }
            		 
            		});
            
          
        });
    </script>
<div id="descdetailsGrid"></div>

