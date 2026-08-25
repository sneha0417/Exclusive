

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%

 
 

 String mode=request.getParameter("mode")==null?"0":request.getParameter("mode");
 String psrno=request.getParameter("psrno")==null?"0":request.getParameter("psrno");
 String oldqty=request.getParameter("oldqty")==null?"0":request.getParameter("oldqty");
 String unitdocno=request.getParameter("unitdocno")==null?"0":request.getParameter("unitdocno");
 String locationid=request.getParameter("locationid")==null?"0":request.getParameter("locationid");
 
 String date=request.getParameter("date")==null?"0":request.getParameter("date");
 
 
%>



<%@page import="com.sales.InventoryTransfer.goodsissuenote.ClsGoodsissuenoteDAO"%>
<% ClsGoodsissuenoteDAO searchDAO = new ClsGoodsissuenoteDAO(); %> 

<script type="text/javascript">



            	
        $(document).ready(function () { 	
        	var Reqmaster='<%=searchDAO.searchunit(mode,psrno,session,oldqty,unitdocno,locationid,date) %>'; 
        		 

        	
 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                                
                             {name : 'unit', type: 'string'},  
     		 				{name : 'fr', type: 'number'},
     				 
     						{name : 'doc_no', type: 'int'   },
     						
     						{name : 'balqty', type: 'number'},
     						{name : 'outqty', type: 'number'},
     						{name : 'totqty', type: 'number'},
     						
     						{name : 'oldqty', type: 'number'},
     						
     						 
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
							{ text: 'fr', datafield: 'fr', width: '25%' ,hidden:true  },
							
							{ text: 'doc_no', datafield: 'doc_no', width: '10%' , hidden: true},
 
								
							{ text: 'balqty', datafield: 'balqty', width: '25%', hidden: true   },
							{ text: 'outqty', datafield: 'outqty', width: '25%' , hidden: true  },
							{ text: 'totqty', datafield: 'totqty', width: '25%' , hidden: true  },
							{ text: 'oldqty', datafield: 'oldqty', width: '25%'  , hidden: true },
							
							
						
							
							
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
	                
	                
	         /*         var fr= $('#qtysearchgrid').jqxGrid('getcellvalue', rowindextemp, "fr");
	                var oldqty= $('#jqxDeliveryNote').jqxGrid('getcellvalue', rowno, "oldqty");
	                var totqty= $('#jqxDeliveryNote').jqxGrid('getcellvalue', rowno, "totqty");
	                var outqty= $('#jqxDeliveryNote').jqxGrid('getcellvalue', rowno, "outqty");
	                var balqty= $('#jqxDeliveryNote').jqxGrid('getcellvalue', rowno, "balqty");
	                 */
	     /*            alert("oldqty="+oldqty);
	                alert("totqty="+totqty);
	                alert("outqty="+outqty);
	                alert("balqty="+balqty);
	                alert("fr="+fr);
	                 */
	           /*      if(!(parseFloat(fr)>0))
                	{
	                	fr=1;	
                	}
	                
	                if(parseFloat(oldqty)>0)
	                	{
	                	  $('#jqxDeliveryNote').jqxGrid('setcellvalue', rowno, "oldqty" ,parseFloat(oldqty)/parseFloat(fr));
	                	}
	                if(parseFloat(totqty)>0)
                	{
	                	 $('#jqxDeliveryNote').jqxGrid('setcellvalue', rowno, "totqty" ,parseFloat(totqty)/parseFloat(fr));
                	}
	                if(parseFloat(outqty)>0)
                	{
	                	 $('#jqxDeliveryNote').jqxGrid('setcellvalue', rowno, "outqty" ,parseFloat(outqty)/parseFloat(fr));
                	}
	                if(parseFloat(balqty)>0)
                	{
	                	 $('#jqxDeliveryNote').jqxGrid('setcellvalue', rowno, "balqty" ,parseFloat(balqty)/parseFloat(fr));
                	} */
                	
                	
                	 $('#serviecGrid').jqxGrid('setcellvalue', rowno, "qutval" , $('#qtysearchgrid').jqxGrid('getcellvalue', rowindextemp, "balqty"));
                	
                	
                	
                	 $('#serviecGrid').jqxGrid('setcellvalue', rowno, "oldqty" ,$('#qtysearchgrid').jqxGrid('getcellvalue', rowindextemp, "oldqty"));
                	
                	
	             /*    $('#jqxDeliveryNote').jqxGrid('setcellvalue', rowno, "balqty" ,$('#qtysearchgrid').jqxGrid('getcellvalue', rowindextemp, "balqty"));
	                $('#jqxDeliveryNote').jqxGrid('setcellvalue', rowno, "outqty" ,$('#qtysearchgrid').jqxGrid('getcellvalue', rowindextemp, "outqty"));
	                $('#jqxDeliveryNote').jqxGrid('setcellvalue', rowno, "totqty" ,$('#qtysearchgrid').jqxGrid('getcellvalue', rowindextemp, "totqty"));
	                $('#jqxDeliveryNote').jqxGrid('setcellvalue', rowno, "oldqty" ,$('#qtysearchgrid').jqxGrid('getcellvalue', rowindextemp, "oldqty"));
	                
  */
            	
            	             $('#qtyWindow').jqxWindow('close'); 
            	
            	  //document.getElementById("errormsg").innerText="";
            		    
            		});  
            
            
            
            
            
      
   
        });
    </script>
    <div id=qtysearchgrid></div>
 