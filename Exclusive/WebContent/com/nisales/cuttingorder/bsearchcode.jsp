

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
  <%@page import="com.nisales.cuttingorder.ClsCuttingOrderDAO"%>
<% ClsCuttingOrderDAO  ClsCuttingOrderDAO = new ClsCuttingOrderDAO();

String name=request.getParameter("name")==null?"0":request.getParameter("name");%>
 
 
 
   <script type="text/javascript">



            	
        $(document).ready(function () { 	
        	var master='<%=ClsCuttingOrderDAO.searchcode("1") %>'; 
        		 

        	
 
                     
            // prepare the data
            var source =
            {
                datatype: "json",   
                datafields: [
                                
                             {name : 'code', type: 'string'},  
     		 				 
     				 
     						{name : 'doc_no', type: 'int'   },
     						 
                 ],
                 localdata: master,
                
                
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

            
            
            $("#bcodesearchgrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                editable: false,
                selectionmode: 'singlecell',
                pagermode: 'default',
             
                
          
          

                       
                columns: [      
                           
                            
                          
                            { text: 'Code', datafield: 'code', width: '100%'   },	
						 
							
							{ text: 'doc_no', datafield: 'doc_no', width: '10%' , hidden: true},
 
											
							
							
			              ]
               
            });
            
            
            
        
            $("#bcodesearchgrid").on('celldoubleclick', function (event) 
            		{
            		
           	 var rowindextemp = event.args.rowindex;
         	 var rowno =  document.getElementById("rowindex").value;
         	 
     
        
    		   $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowno, "bevcodename" ,$('#bcodesearchgrid').jqxGrid('getcellvalue', rowindextemp, "code"));
               $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowno, "bevcode" ,$('#bcodesearchgrid').jqxGrid('getcellvalue', rowindextemp, "doc_no"));
       	
       	             $('#codeWindow').jqxWindow('close'); 
    		   
         	 
 
               
            	
            	   
            		    
            		});  
            
            
            
            
            
      
   
        });
    </script>
    <div id=bcodesearchgrid></div>
 