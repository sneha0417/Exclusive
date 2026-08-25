  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%@page import="com.procurement.purchase.purchaseinvoice.ClspurchaseinvoiceDAO"%>
<% ClspurchaseinvoiceDAO purchaseDAO = new ClspurchaseinvoiceDAO(); %> 
<%
String purdoc=request.getParameter("purdoc")==null?"0":request.getParameter("purdoc").trim();
String reqdoc=request.getParameter("reqdoc")==null?"0":request.getParameter("reqdoc").trim();
String load=request.getParameter("load")==null?"0":request.getParameter("load").trim();


 


%>
<script type="text/javascript">
var descdata;

 

var temp='<%=purdoc%>';
var temp1='<%=load%>';

 
 if(temp>0)
{
 
	descdata='<%=purchaseDAO.reloadserv(purdoc)%>';  
 
 
}
 else if(temp1>0)
 {
  
 	descdata='<%=purchaseDAO.reloadservs(reqdoc)%>';  

  
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
     					 
     						{name : 'srno', type: 'int'  },
     						{name : 'srvtaxper', type: 'number'    },
     						{name : 'srvtaxamount', type: 'number'    }
     						
     						
                 ],
              
                 localdata: descdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                },
                deleterow: function (rowid, commit) {
                    
                    commit(true);
                }                       
                };
           
                
                $("#descdetailsGrid").on("bindingcomplete", function (event) { 
        			
        			
                   
           
                  
                	
                 	/*  var rows = $("#descdetailsGrid").jqxGrid('getrows');   
     
    	             	  for(var i=0;i<rows.length;i++){
    	             	   		var netotal=$('#descdetailsGrid').jqxGrid('getcellvalue', i, "nettotal1"); 
    	                		
    	                		  var taxper= $('#descdetailsGrid').jqxGrid('getcellvalue', i, "srvtaxper"); 
    	                		  if(parseFloat(taxper)>0)
    	                			  {
    	                		  var taxempamount=parseFloat(netotal)*(parseFloat(taxper)/100);
    	                		  
    	                		  var order= document.getElementById("orderValue").value;
//    	                		  alert(order);
    	                		  var orderchng=parseFloat(order)+parseFloat(taxempamount);
    	                		  
    	                		  funRoundAmt(orderchng,"orderValue");
    	                		  
    	                		  $('#descdetailsGrid').jqxGrid('setcellvalue', i, "srvtaxamount",taxempamount);
    	                		  
    	                		  var taxtotalamount=parseFloat(netotal)+parseFloat(taxempamount);
    	                		  
    	                		  $('#descdetailsGrid').jqxGrid('setcellvalue', i, "nettotal1",taxtotalamount);
    	                			  }
    	                		  else
    	                			  {
    	                			  $('#descdetailsGrid').jqxGrid('setcellvalue', i, "nettotal1",netotal);
    	                			  }
    	                		 
    	             	  }
                                        
                       var order=        
                       funRoundAmt(order,"orderValue");   */
         
        			
        			
        		}); 
   
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
				
							{ text: 'Description', datafield: 'description' },
							{ text: 'Quantity', datafield: 'qty1', width: '7%' ,cellsalign: 'left', align:'left',cellsformat:'d2'},
							{ text: 'Unit Price', datafield: 'unitprice1', width: '7%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2'},
							{ text: 'Total', datafield: 'total1', width: '7%' ,editable: false,cellsalign: 'right', align:'right',cellsformat:'d2'},
		    				{ text: 'Discount', datafield: 'discount1', width: '7%',cellsalign: 'right', align:'right',cellsformat:'d2' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
		    				{ text: 'Tax %', datafield: 'srvtaxper', width: '7%',cellsalign: 'right', align:'right',cellsformat:'d2'  },
							{ text: 'Tax Amount', datafield: 'srvtaxamount',editable:false , width: '7%',cellsalign: 'right', align:'right',cellsformat:'d2' ,aggregates: ['sum'],aggregatesrenderer:rendererstring},
		    				{ text: 'Net Amount', datafield: 'nettotal1', width: '9%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false},
						 
							{ text: 'srno', datafield: 'srno', width: '9%',hidden:true}
						
							
	              ]
            });
           if(temp==0)
        	   {
            $("#descdetailsGrid").jqxGrid('addrow', null, {});
 
          
        	   }
           
           
        
       	 $('#descdetailsGrid').on('celldoubleclick', function (event) {
    		  var rowindex = event.args.rowindex;
    		  
    		 var columnindex1=event.args.datafield;
    		
    		   
             if(($('#mode').val()=='A')||($('#mode').val()=='E'))
     		       {
      	  if(columnindex1 == "sl")
      		  {
    	     var rowid = $("#descdetailsGrid").jqxGrid('getrowid', rowindex);
            $("#descdetailsGrid").jqxGrid('deleterow', rowid);
            var summaryData= $("#descdetailsGrid").jqxGrid('getcolumnaggregateddata', 'nettotal1', ['sum'],true);
            
		    
        	
		    
            document.getElementById("descgridhid").value=summaryData.sum.replace(/,/g,'');
            var summarytaxData= $("#descdetailsGrid").jqxGrid('getcolumnaggregateddata', 'srvtaxamount', ['sum'],true);
            var desctax=summarytaxData.sum.replace(/,/g,'');
            funRoundAmt(desctax,"descgridtax");
        
        
        
        
          var ordertotal="0";
          	  
         	  var maintotalval="0";
         	  
              var exptotalval="0";
               
               if(document.getElementById("netTotaldown").value!="" && !(document.getElementById("netTotaldown").value==null) && !(document.getElementById("netTotaldown").value=="undefiend")) 
            	   {
            	   
  
            maintotalval=parseFloat(document.getElementById("netTotaldown").value);
            	   }
               
               
               
            if(document.getElementById("expencenettotal").value!="" && !(document.getElementById("expencenettotal").value==null) && !(document.getElementById("expencenettotal").value=="undefiend")) 
    	   {

             
          exptotalval=parseFloat(document.getElementById("expencenettotal").value);
    	   }
       
               
               
               
              
              ordertotal=parseFloat(maintotalval)+parseFloat(exptotalval)+parseFloat(document.getElementById("descgridhid").value);
            	   
        
    	funRoundAmt(ordertotal,"orderValue");
            
      		  }
     		       }
      	 
   		 
   	 }); 

           
           
           if(temp1>0)
        	   {
        	    var summaryData= $("#descdetailsGrid").jqxGrid('getcolumnaggregateddata', 'nettotal1', ['sum'],true);
                
    		    
	        	
    		    
                document.getElementById("descgridhid").value=summaryData.sum.replace(/,/g,'');
                
            
            
            
            
              var ordertotal="0";
	          	  
	         	  var maintotalval="0";
	         	  
	              var exptotalval="0";
	               
	               if(document.getElementById("netTotaldown").value!="" && !(document.getElementById("netTotaldown").value==null) && !(document.getElementById("netTotaldown").value=="undefiend")) 
	            	   {
	            	   
	  
	            maintotalval=parseFloat(document.getElementById("netTotaldown").value);
	            	   }
	               
	               
	               
	            if(document.getElementById("expencenettotal").value!="" && !(document.getElementById("expencenettotal").value==null) && !(document.getElementById("expencenettotal").value=="undefiend")) 
        	   {

	             
	          exptotalval=parseFloat(document.getElementById("expencenettotal").value);
        	   }
           
	               
	               
	               
	              
	              ordertotal=parseFloat(maintotalval)+parseFloat(exptotalval)+parseFloat(document.getElementById("descgridhid").value);
	            	   
            
        	funRoundAmt(ordertotal,"orderValue");
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
    	        		    
                var nettot=$('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal1");
    	   		
    	   	    var taxper =$('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "srvtaxper"); 
    	   		
    	   		
    	   		if(parseFloat(taxper)>=0)
    	   			{
    	   			
    	   			var taxamount=parseFloat(nettot)*parseFloat(taxper)/100;
    	   			
    	   			nettotal=parseFloat(taxamount)+parseFloat(nettot);
    	   			
    	   			$('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "srvtaxamount",taxamount);
    	   			
    	   			$('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal1",nettotal);
    	   			
    	   			 
    	   			
    	   			
    	   			}
    	        		    
    	        		    /* var summaryData= $("#descdetailsGrid").jqxGrid('getcolumnaggregateddata', 'nettotal1', ['sum'],true);
    	                    
    	        		    
    	        	
    	        		    
    	                    document.getElementById("nettotal").value=summaryData.sum.replace(/,/g,'');
    	                     */
    	                
    	                 var total= $("#descdetailsGrid").jqxGrid('getcolumnaggregateddata', 'nettotal1', ['sum'],true);
    	               // alert(total.sum.replace(/,/g,''));
    	                 var summarytaxData= $("#descdetailsGrid").jqxGrid('getcolumnaggregateddata', 'srvtaxamount', ['sum'],true); 
    	                //alert(summarytaxData.sum.replace(/,/g,''));
    	                 
    	                 var summaryData=parseFloat(total.sum.replace(/,/g,'')).toFixed(2)-parseFloat(summarytaxData.sum.replace(/,/g,'')).toFixed(2);
    	                //alert(summaryData);
    	                 document.getElementById("descgridhid").value=total.sum.replace(/,/g,''); 
    	                 var desctax=summarytaxData.sum.replace(/,/g,'');
    	                 funRoundAmt(desctax,"descgridtax");
    	                 document.getElementById("nettotal").value=summaryData; 
    	                    
    	                
    	                
    	                
    	                
    	                  var ordertotal="0";
    	   	          	  
    	   	         	  var maintotalval="0";
    	   	         	  
    	   	              var exptotalval="0";
    	   	               
    	   	               if(document.getElementById("netTotaldown").value!="" && !(document.getElementById("netTotaldown").value==null) && !(document.getElementById("netTotaldown").value=="undefiend")) 
    	   	            	   {
    	   	            	   
    	   	  
    	   	            maintotalval=parseFloat(document.getElementById("netTotaldown").value);
    	   	            	   }
    	   	               
    	   	               
    	   	               
    	   	            if(document.getElementById("expencenettotal").value!="" && !(document.getElementById("expencenettotal").value==null) && !(document.getElementById("expencenettotal").value=="undefiend")) 
    	            	   {
    	    
    	   	             
    	   	          exptotalval=parseFloat(document.getElementById("expencenettotal").value);
    	            	   }
    	               
    	   	               
    	   	               
    	   	               
    	   	              
    	   	              ordertotal=parseFloat(maintotalval)+parseFloat(exptotalval)+parseFloat(document.getElementById("descgridhid").value);
    	   	            	   
    	                
    	            	funRoundAmt(ordertotal,"orderValue");
    	                
    	                
 /*    	            ordertotal=parseFloat(ordertotal)+document.getElementById("nettotal").value;
    	                
    	                    
    
    	                
    	            	funRoundAmt(aa,"orderValue"); */
    	                    
    		    
 
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
        		
    		  //  var rowBoundIndex = event.args.rowindex;
    		     
            		if(datafield=="qty1")
            		    {
                                                  
            			valchange(rowBoundIndex);
            		    }
            		if(datafield=="unitprice1")
        		    {
            			valchange(rowBoundIndex);
      
            			/*    var rows = $('#descdetailsGrid').jqxGrid('getrows');
                           var rowlength= rows.length;
                           if(rowBoundIndex == rowlength - 1)
                           	{  
                           $("#descdetailsGrid").jqxGrid('addrow', null, {});
                           	} 
                           	 */
            			
        		    }
            		if(datafield=="discount1")
        		    {
            			valchange(rowBoundIndex);
   				
        		    }
            		if(datafield=="srvtaxper")
        		    {
            			valchange(rowBoundIndex);
   				
        		    }
            		});
            
          
        });
    </script>
<div id="descdetailsGrid"></div>

