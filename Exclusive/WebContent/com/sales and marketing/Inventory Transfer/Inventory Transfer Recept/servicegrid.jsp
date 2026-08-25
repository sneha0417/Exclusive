  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%@page import="com.sales.Sales.salesInvoice.ClsSalesInvoiceDAO"%>
<%ClsSalesInvoiceDAO DAO= new ClsSalesInvoiceDAO();%>
<%
String rdoc=request.getParameter("rdoc")==null?"0":request.getParameter("rdoc").trim();

%>
<script type="text/javascript">
var servicedata;



var rdoc='<%=rdoc%>';
 if(rdoc>0)
{
 
	 servicedata='<%=DAO.reloadserviceGrid(rdoc)%>';  
 
 
}

else
 
{   
	
	 
	servicedata;

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
     						{name : 'qty', type: 'int'    },
     						{name : 'price', type: 'number'    },
     						{name : 'total', type: 'number'    },
     						{name : 'discount', type: 'number'    },
     						{name : 'netamt', type: 'number'    },
     						{name : 'nettotal', type: 'number'    },
     						{name : 'account', type: 'string'    },
     						{name : 'acno', type: 'number'    },
     						{name : 'srno', type: 'int'  }
     						
     						
                 ],
              
                 localdata: servicedata,
                
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

            
            
            $("#jqxserviceGrid").jqxGrid(
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
                 var rows = $('#jqxserviceGrid').jqxGrid('getrows');
                  var rowlength= rows.length;
                    var cell = $('#jqxserviceGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'price' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key ==9) {                                                        
                            var commit = $("#jqxserviceGrid").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    }
                    },
                
                
                columns: [
                
							   { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
				
							{ text: 'Description', datafield: 'description', width: '25%' },
							{ text: 'Account', datafield: 'account', width: '15%',editable:false },
							{ text: 'ACNo', datafield: 'acno', width: '15%',hidden:true },
							{ text: 'Quantity', datafield: 'qty', width: '10%' ,cellsalign: 'left', align:'left'},
							{ text: 'Unit Price', datafield: 'price', width: '10%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2'},
							{ text: 'Total', datafield: 'total', width: '10%' ,editable: false,cellsalign: 'right', align:'right',cellsformat:'d2'},
		    				{ text: 'Discount', datafield: 'discount', width: '10%',cellsalign: 'right', align:'right',cellsformat:'d2' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
							{ text: 'Net Amount', datafield: 'nettotal', width: '15%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false},
						 
							{ text: 'srno', datafield: 'srno', width: '9%',hidden:true}
						
							
	              ]
            });
           if(rdoc==0)
        	   {
            $("#jqxserviceGrid").jqxGrid('addrow', null, {});
 
          
        	   }
           
           
           if(($('#mode').val()=='A')||($('#mode').val()=='E'))
   		       {
   		  $("#jqxserviceGrid").jqxGrid({ disabled: false}); 
   		        }
           
           
           
            function valchange(rowBoundIndex)
            {
            	
            	
            	var qty= $('#jqxserviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
            	var price=	$('#jqxserviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "price");	
            	var total=parseFloat(qty)*parseFloat(price);
           		
    		    $('#jqxserviceGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
    		    
    		   var gtotal= $('#jqxserviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
				  
    	   		var discount=$('#jqxserviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "discount");	
    	        		    
    	        		
    	   		var nettotal=parseFloat(gtotal)-parseFloat(discount);
    	   		if(discount==""||discount==null||discount=="undefiend")
    	   			{
    	   		  $('#jqxserviceGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",total);
    	   			}
    	   		else{
    	   			$('#jqxserviceGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",nettotal);
    	   		}
    	        		    
    	        		    var summaryData= $("#jqxserviceGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
    	                    
    	        		    
    	        	
    	        		    
    	                    document.getElementById("nettotal").value=summaryData.sum.replace(/,/g,'');
    	                    
    	                var aa= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
    	                    
    
    	                
    	            	funRoundAmt(aa,"orderValue");
    	                    
    		    
    	            var nettotalval=  $('#jqxserviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal");
           var nuprice=parseFloat(nettotalval)/parseFloat(qty);
                       $('#jqxserviceGrid').jqxGrid('setcellvalue', rowBoundIndex, "nuprice",nuprice);
            }

            $("#jqxserviceGrid").on('cellvaluechanged', function (event) 
            {
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		     
            		if(datafield=="qty")
            		    {
            
            			valchange(rowBoundIndex);
            		    }
            		if(datafield=="price")
        		    {
            			valchange(rowBoundIndex);
      
            			   var rows = $('#jqxserviceGrid').jqxGrid('getrows');
                           var rowlength= rows.length;
                           if(rowBoundIndex == rowlength - 1)
                           	{  
                           $("#jqxserviceGrid").jqxGrid('addrow', null, {});
                           	} 
                           	
            			
        		    }
            		if(datafield=="discount")
        		    {
            			valchange(rowBoundIndex);
   				
        		    }
            		 
            		});
            
            
            $('#jqxserviceGrid').on('celldoubleclick', function (event) {

            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
        	  
            	if(datafield=="account")
         	   { 
            		accountSearchContent('accountSearchGrid.jsp?rowno='+rowBoundIndex);
         	   }
                  });

            
            
            if($('#mode').val()!="view"){
            	$("#jqxserviceGrid").jqxGrid('disabled', false);
            }
          
        });
    </script>
<div id="jqxserviceGrid"></div>

