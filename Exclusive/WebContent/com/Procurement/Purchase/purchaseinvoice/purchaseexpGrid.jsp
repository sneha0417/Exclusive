<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>

 
<%@page import="com.procurement.purchase.purchaseinvoice.ClspurchaseinvoiceDAO"%>
<% ClspurchaseinvoiceDAO purchaseDAO = new ClspurchaseinvoiceDAO();  

String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");

String masterdoc = request.getParameter("masterdoc")==null?"0":request.getParameter("masterdoc");
 %> 

 
<script type="text/javascript">
		 var expdata;  
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
      
             
            var masterdocno='<%=masterdoc%>';
            
              if(masterdocno!='0')
            	{
            	  expdata='<%=purchaseDAO.expgridreload(masterdoc)%>';     
            	
            	}
            else
            	{
            	expdata;   
            	}
            
             
            		
            
           	
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'desc1', type: 'string' },
							{name : 'account', type: 'string' },
     						{name : 'accountname', type: 'string'    },
     						{name : 'qty2', type: 'number'    },
     						{name : 'unitprice2', type: 'number'    },
     						{name : 'total2', type: 'number'    },
     						{name : 'discount2', type: 'number'    },
     						    
     						{name : 'nettotal2', type: 'number'    },
     					 
     						{name : 'srno', type: 'int'  },
     						
     						{name : 'descsrno', type: 'int'  },            //    descsrno  accountdono
     						{name : 'accountdono', type: 'int'  }
     						
     						
     						 
     						
                        ],
                         localdata: expdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#purchexpgrid").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                editable: true,
                statusbarheight: 21,
                disabled:true,
                showaggregates:true,
                showstatusbar:true,
                selectionmode: 'singlecell',
                handlekeyboardnavigation: function (event) {
                	

               	 var cell1 = $('#purchexpgrid').jqxGrid('getselectedcell');
               	 if (cell1 != undefined && cell1.datafield == 'desc1') {  
               	
                       var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                       if (key == 114) {  
                      
                       	
           
                    		 

            	    	  	 expenceSearchContent('expenceSearch.jsp?rowindex2='+cell1.rowindex);
                   
                  		 
                    	 
                       	
                       	
                       	 $('#purchexpgrid').jqxGrid('render');
                       }
                       }
                	
                   
                       
                       },       
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";  
                              }  
							},   
					
					
								{ text: 'Description', datafield: 'desc1', width: '25%' ,editable: false},
								
								{ text: 'Account', datafield: 'account', width: '10%',editable: false },
								{ text: 'Account Name', datafield: 'accountname', width: '20%',editable: false  },
								
								{ text: 'Quantity', datafield: 'qty2', width: '8%' ,cellsalign: 'left', align:'left',cellsformat:'d2'},
								{ text: 'Unit Price', datafield: 'unitprice2', width: '8%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2'},
								{ text: 'Total', datafield: 'total2', width: '8%' ,editable: false,cellsalign: 'right', align:'right',cellsformat:'d2'},
			    				{ text: 'Discount', datafield: 'discount2', width: '8%',cellsalign: 'right', align:'right',cellsformat:'d2' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
								{ text: 'Net Amount', datafield: 'nettotal2', width: '8%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false},
								{ text: 'accdocno', datafield: 'accountdono', width: '36%',hidden:true  },
								
								{ text: 'descsrno', datafield: 'descsrno', width: '36%' ,hidden:true   },
								{ text: 'srno', datafield: 'srno', width: '9%',hidden:true}
							
						]
            });
            
            
            if( document.getElementById("docno").value>0)
     	   { 
           
            
     	   }
            else
            	{
            	 $("#purchexpgrid").jqxGrid('addrow', null, {});
            	}
              
            
            if(($('#mode').val()=='A')||($('#mode').val()=='E'))
		       {
		  $("#purchexpgrid").jqxGrid({ disabled: false}); 
		        }
     
            
            
            
            
            
            function valchange(rowBoundIndex)
            {
            	
            	
            	var qty= $('#purchexpgrid').jqxGrid('getcellvalue', rowBoundIndex, "qty2");	
            	var unitprice=	$('#purchexpgrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice2");	
            	var total=parseFloat(qty)*parseFloat(unitprice);
           		
    		    $('#purchexpgrid').jqxGrid('setcellvalue', rowBoundIndex, "total2",total);
    		    
    		   var gtotal= $('#purchexpgrid').jqxGrid('getcellvalue', rowBoundIndex, "total2");
				  
    	   		var discount=$('#purchexpgrid').jqxGrid('getcellvalue', rowBoundIndex, "discount2");	
    	        		    
    	        		
    	   		var nettotal=parseFloat(gtotal)-parseFloat(discount);
    	   		if(discount==""||discount==null||discount=="undefiend")
    	   			{
    	   		  $('#purchexpgrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal2",total);
    	   			}
    	   		else{
    	   			$('#purchexpgrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal2",nettotal);
    	   		}
    	        		    
    	        		    var summaryData= $("#purchexpgrid").jqxGrid('getcolumnaggregateddata', 'nettotal2', ['sum'],true);
    	                    
    	        		    
    	        	
    	        		    
    	                    document.getElementById("expencenettotal").value=summaryData.sum.replace(/,/g,'');
    	                    
    	                    
    	                    
        	                
      	                  var ordertotal="0";
      	   	          	  
      	   	         	  var nettotalval="0";
      	   	         	  
      	   	              var ordermainval="0";
      	   	               
      	   	               if(document.getElementById("descgridhid").value!="" && !(document.getElementById("descgridhid").value==null) && !(document.getElementById("descgridhid").value=="undefiend")) 
      	   	            	   {
      	   	       
      	   	          nettotalval=parseFloat(document.getElementById("descgridhid").value);
      	   	            	   }
      	   	               
      	   	               
      	   	               
      	   	            if(document.getElementById("netTotaldown").value!="" && !(document.getElementById("netTotaldown").value==null) && !(document.getElementById("netTotaldown").value=="undefiend")) 
      	            	   {
      	   	          
      	   	             
      	   	             ordermainval=parseFloat(document.getElementById("netTotaldown").value);
      	            	   }
      	               
      	   	               
      	   	               
      	   	               
      	   	              
      	   	              ordertotal=parseFloat(nettotalval)+parseFloat(ordermainval)+parseFloat(document.getElementById("expencenettotal").value);
      	   	            	   
      	                
      	            	funRoundAmt(ordertotal,"orderValue");
    	                    
    	                    
    	                    
    	                    
    	        
    		    
    	   
            }

          $('#purchexpgrid').on('celldoubleclick', function (event) {
                
            	var columnindex1=event.args.columnindex;
            	 var rowindex1 = event.args.rowindex;
            	 var datafield = event.args.datafield;
        
            	 if(datafield=='desc1'){
            		 

    	    	  	 expenceSearchContent('expenceSearch.jsp?rowindex2='+rowindex1);
           
          		  } 
            	 
                 
              
                   
                   });  
            
            
            
            $("#purchexpgrid").on('cellvaluechanged', function (event) 
            {
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		     
            		if(datafield=="qty2")
            		    {
            
            			valchange(rowBoundIndex);
            		    }
            		if(datafield=="unitprice2")
        		    {
            			valchange(rowBoundIndex);
      
            			   var rows = $('#purchexpgrid').jqxGrid('getrows');
                           var rowlength= rows.length;
                           if(rowBoundIndex == rowlength - 1)
                           	{  
                        	     if(($('#mode').val()=='A')||($('#mode').val()=='E'))
                  		       {
                           $("#purchexpgrid").jqxGrid('addrow', null, {});
                  		       }
                           	} 
                           	
            			
        		    }
            		if(datafield=="discount2")
        		    {
            			valchange(rowBoundIndex);
   				
        		    }
            		 
            		});
        });
</script>
<div id="purchexpgrid"></div>
