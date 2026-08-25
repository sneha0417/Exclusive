  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.procurement.purchase.purchaseorder.ClspurchaseorderDAO"%>
<% ClspurchaseorderDAO purchaseorderDAO = new ClspurchaseorderDAO(); %> 

<%
String purdoc=request.getParameter("purdoc")==null?"0":request.getParameter("purdoc").trim();

%>
<script type="text/javascript">
var descdata1;

var temp='<%=purdoc%>';

if(temp>0)
{
 
	<%-- descdata1='<%=purchaseorderDAO.maingridreload(purdoc)%>'; --%>  

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
     						{name : 'qty', type: 'int'    },
     						{name : 'unitprice', type: 'number'    },
     						{name : 'total', type: 'number'    },
     						{name : 'discount', type: 'number'    },
     					
     						{name : 'nettotal', type: 'number'    },
     						{name : 'prodoc', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
     						
     						
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
                height: 297,
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
                 var rows = $('#serviecGrid').jqxGrid('getrows');
                  var rowlength= rows.length;
                    var cell = $('#serviecGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'unitprice' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key ==9) {                                                        
                            var commit = $("#serviecGrid").jqxGrid('addrow', null, {});
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
				
							{ text: 'Product', datafield: 'productid', width: '10%',  editable: false }, 
							{ text: 'Product Name', datafield: 'productname', width: '26%' , editable: false }, 
							{ text: 'Unit', datafield: 'unit', width: '10%' },
							{ text: 'Quantity', datafield: 'qty', width: '10%' ,cellsalign: 'left', align:'left'},
							{ text: 'Unit Price', datafield: 'unitprice', width: '10%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2' },
							{ text: 'Total', datafield: 'total', width: '10%' ,editable: false,cellsalign: 'right', align:'right',cellsformat:'d2' },
		    				{ text: 'Discount', datafield: 'discount', width: '10%',cellsalign: 'right', align:'right',cellsformat:'d2' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
							{ text: 'Net Amount', datafield: 'nettotal', width: '10%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false},
							{text: 'prodoc', datafield: 'prodoc', width: '10%' ,hidden:true},
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',hidden:true  },
							{text: 'psrno', datafield: 'psrno', width: '10%',hidden:true },
						 
							 
							
							
				 
						
							
	              ]
            });
           if(temp==0)
        	   {
            $("#serviecGrid").jqxGrid('addrow', null, {});
         
 
         
        	   }
           
           
           if(($('#mode').val()=='A')||($('#mode').val()=='E'))
   		       {
   		  $("#serviecGrid").jqxGrid({ disabled: false}); 
   		        }
           
           
     

           $('#serviecGrid').on('celldoubleclick', function (event) {
           	var columnindex1=event.args.columnindex;

             	  if(columnindex1 == 1)
             		  { 
                      
             	 var rowindextemp = event.args.rowindex;
             	    document.getElementById("rowindex").value = rowindextemp;  
             	  $('#serviecGrid').jqxGrid('clearselection');
             	 productSearchContent('productSearch.jsp');
             	
             		  } 
             	  
             	 
             	
             	  
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
   	                    var summaryData1= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
   	        		    var summaryData= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
   	        		  
   	                    document.getElementById("productTotal").value=summaryData1.sum.replace(/,/g,'');
   	               document.getElementById("netTotaldown").value=summaryData.sum.replace(/,/g,'');
   	         
   	               
   	         	  if(document.getElementById('chkdiscount').checked) {
   	         		 var summaryData3= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'discount', ['sum'],true);
   	         	   document.getElementById("descountVal").value=summaryData3.sum.replace(/,/g,'');
   	         	  }
   	               
   	               if(document.getElementById("nettotal").value!="" ||document.getElementById("nettotal").value==null || document.getElementById("nettotal").value=="undefiend") 
   	            	   {
   	               
   	            var aa=parseFloat(document.getElementById("netTotaldown").value)+parseFloat(document.getElementById("nettotal").value);
   	            	   }
   	               else
   	            	   {
   	            	  var aa=document.getElementById("netTotaldown").value;
   	            	   }
        
                
            	funRoundAmt(aa,"orderValue");
   	               
   	               
   	            var nettotalval=  $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal");
          var nuprice=parseFloat(nettotalval)/parseFloat(qty);
                      $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "nuprice",nuprice);
           }

           $("#serviecGrid").on('cellvaluechanged', function (event) 
           {
           	var datafield = event.args.datafield;
       		
   		    var rowBoundIndex = event.args.rowindex;
   		     
           		if(datafield=="qty")
           		    {
           
           			valchange(rowBoundIndex);
           		    }
           		if(datafield=="unitprice")
       		    {
           	  	  /* if(document.getElementById('chkdiscount').checked) {
                		 
             			 
             		 
           	  	  } */
           			valchange(rowBoundIndex);
     
           			
           			
       		    }
           	  if(document.getElementById('chkdiscount').checked) {
           		 
           		
           	  }else{
		           		if(datafield=="discount")
		       		    {
		           			valchange(rowBoundIndex);
		  				
		       		    }
           		}
           		 
           		});
            
          
        });
    </script>
<div id="serviecGrid"></div>
<input type="hidden" id="rowindex">
