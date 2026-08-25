

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%

 
 

 String mode=request.getParameter("mode")==null?"0":request.getParameter("mode");
 String psrno=request.getParameter("psrno")==null?"0":request.getParameter("psrno");
 
 
%>


<%@page import="com.procurement.purchase.purchaseinvoice.ClspurchaseinvoiceDAO"%>
<% ClspurchaseinvoiceDAO purchaseDAO = new ClspurchaseinvoiceDAO();  %>
 
 
 
<script type="text/javascript">



            	
        $(document).ready(function () { 	
        	var Reqmaster='<%=purchaseDAO.searchunit(mode,psrno) %>'; 
        		 

        	
 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                                
                             {name : 'unit', type: 'string'},  
     		 				{name : 'fr', type: 'number'},
     				 
     						{name : 'doc_no', type: 'int'   },
     						 
                 ],
                 localdata: Reqmaster,
                
                
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

            
            
            $("#qtysearchgrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                editable: false,
                selectionmode: 'singlecell',
                pagermode: 'default',
             
                
          
          

                       
                columns: [      
                           
                            
                          
                            { text: 'Unit', datafield: 'unit', width: '100%'   },	
							{ text: 'fr', datafield: 'fr', width: '25%'  , hidden: true},
							
							{ text: 'doc_no', datafield: 'doc_no', width: '10%' , hidden: true},
 
											
							
							
			              ]
               
            });
            
            
            
        
            $("#qtysearchgrid").on('celldoubleclick', function (event) 
            		{
            		
           	 var rowindextemp = event.args.rowindex;
         	 var rowno =  document.getElementById("rowindex").value;
         	 
         	 
         	var prodocs='<%=psrno%>';
         	var rows = $("#serviecGrid").jqxGrid('getrows');
    	    var aa=0;
    	    for(var i=0;i<rows.length;i++){
    	 
    	    	
    	    	 
    		   if(parseInt(rows[i].prodoc)==parseInt(prodocs))
    			   {
    			   
    			   var munit=$('#qtysearchgrid').jqxGrid('getcellvalue', rowindextemp, "doc_no");
    				 if((parseInt(document.getElementById("multimethod").value)==1))
        				{	
	        			   if(parseInt(rows[i].unitdocno)==parseInt(munit))
	        			   {
	        				   aa=1;
	            			   break;
	        			   }
        				}
    				 else
    					 {
    			   
    			   aa=1;
    			   break;
    					 }
    			   }
    		   else{
    			   
    			   aa=0;
    		       } 

    	 
    	   
    	                         }
    	   
    	   
    	   
    	   if(parseInt(aa)==1)
    		   {
    		   
    			document.getElementById("errormsg").innerText="You have already select this product";
    		   
    		   return 0;
    		   
    		   }
    	   else
    		   {
    		   document.getElementById("errormsg").innerText="";
    		   }
    	   
         	 
         	 
    	   $('#serviecGrid').jqxGrid('setcellvalue', rowno, "qty" ,'');
    	   
    	   
         	 
 
                 $('#serviecGrid').jqxGrid('setcellvalue', rowno, "unit" ,$('#qtysearchgrid').jqxGrid('getcellvalue', rowindextemp, "unit"));
	                $('#serviecGrid').jqxGrid('setcellvalue', rowno, "unitdocno" ,$('#qtysearchgrid').jqxGrid('getcellvalue', rowindextemp, "doc_no"));
            	
            	             $('#qtyWindow').jqxWindow('close'); 
            	
            	  //document.getElementById("errormsg").innerText="";
            		    
            		});  
            
            
            
            
            
      
   
        });
    </script>
    <div id=qtysearchgrid></div>
 