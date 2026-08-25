  
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%

 
 
 String aa=request.getParameter("aa")==null?"0":request.getParameter("aa");

 
 String reftype=request.getParameter("reftype")==null?"0":request.getParameter("reftype");

 String rowno=request.getParameter("rowno")==null?"0":request.getParameter("rowno");
 String psrno=request.getParameter("psrno")==null?"0":request.getParameter("psrno");

 String locid=request.getParameter("locid")==null?"0":request.getParameter("locid");
 
 

 String mode=request.getParameter("mode")==null?"0":request.getParameter("mode");
 String value=request.getParameter("value")==null?"0":request.getParameter("value");
 System.out.println("==aa=="+aa);
 
%>


 
 
<%@page import="com.sales.Sales.salesInvoice.ClsSalesInvoiceDAO"%>
<%ClsSalesInvoiceDAO DAO= new ClsSalesInvoiceDAO();%> 
 
 
 
 
<script type="text/javascript">



            	
        $(document).ready(function () { 	
        	var Reqmaster;

        	var temps='<%=aa%>';

        	if(temps=='yes')
        		{
        	  Reqmaster= '<%=DAO.searchqty(session,reftype,psrno,locid,aa,mode,value) %>'; 
        		}
        	else
        		{
        		Reqmaster; 
        		}

        	 
 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                                
                             {name : 'qty', type: 'number'},  
     		 				{name : 'stkqty', type: 'number'},
     						{name : 'exp_date', type: 'date'  },
     						{name : 'stockid', type: 'int'   },
     						{name : 'cost_price', type: 'number'  },
     						{name : 'batch_no', type: 'string'  },
     						 
     						{name : 'chk', type: 'bool'  },
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
                height: 320,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                pagermode: 'default',
             
                
          
          

                       
                columns: [      
                            { text: ' ', datafield: 'chk',columntype: 'checkbox',  width: '10%',cellsalign: 'center', align: 'center'},
                            
                          
                            { text: 'Qty', datafield: 'qty', width: '20%' ,cellsformat:'d2' },	
							{ text: 'stkqty', datafield: 'stkqty', width: '25%', hidden: true ,cellsformat:'d2' },
							
							{ text: 'stockid', datafield: 'stockid', width: '10%', editable: false , hidden: true},
							{ text: 'Cost Price', datafield: 'cost_price', width: '25%' , editable: false,cellsalign: 'right', align: 'right',cellsformat:'d2' }	,
							{ text: 'Batch No', datafield: 'batch_no', width: '30%' , editable: false}	,
							 
							{ text: 'Expiry Date', datafield: 'exp_date', width: '15%' ,cellsformat:'dd.MM.yyyy', editable: false},
						
											
							
							
			              ]
               
            });
            
            
            
        
            $("#qtysearchgrid").on('cellvaluechanged', function (event) 
            		{
            		
           	 var rowindextemp = event.args.rowindex;
            	  var df=event.args.datafield;
            	  if(df == "qty")
             		  { 
             		  
            		  var qty=$('#qtysearchgrid').jqxGrid('getcellvalue', rowindextemp, "qty"); 
            		  var stkqty=$('#qtysearchgrid').jqxGrid('getcellvalue', rowindextemp, "stkqty"); 
            		  
            		  
            		  if(parseFloat(qty)>parseFloat(stkqty))
            			  {
            			  
            				 document.getElementById("errormsg").innerText="Quantity should not be greater than available quantity "+stkqty;
            				 
            				 $('#qtysearchgrid').jqxGrid('setcellvalue', rowindextemp, "qty",stkqty); 
            			  return 0;
            			  
            			  }
            		  
             		  }
            	
            	
            	
            	
            	  //document.getElementById("errormsg").innerText="";
            		    
            		});  
            
            
      
   
        });
    </script>
    <div id=qtysearchgrid></div>
 