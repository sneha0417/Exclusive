  

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.nisalesnew.deliverynote.ClsDeliveryNoteDAO"%>
<% ClsDeliveryNoteDAO  sDAO = new ClsDeliveryNoteDAO();

String name=request.getParameter("name")==null?"0":request.getParameter("name");%>
 
 
 
   <script type="text/javascript">



            	
        $(document).ready(function () { 	
        	var master='<%=sDAO.searchcode("2") %>'; 
        		 

        	
 
                     
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

            
            
            $("#pcodesearchgrid").jqxGrid(
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
            
            
            
        
            $("#pcodesearchgrid").on('celldoubleclick', function (event) 
            		{
            		
           	 var rowindextemp = event.args.rowindex;
         	 var rowno =  document.getElementById("rowindex").value;
         	 
      
    		  
    		   
    		   $('#prdGridID').jqxGrid('setcellvalue', rowno, "polcodename" ,$('#pcodesearchgrid').jqxGrid('getcellvalue', rowindextemp, "code"));
               $('#prdGridID').jqxGrid('setcellvalue', rowno, "polcode" ,$('#pcodesearchgrid').jqxGrid('getcellvalue', rowindextemp, "doc_no"));
       	
       	             $('#codeWindow').jqxWindow('close'); 
    		   
            	
            	   
            		    
            		});  
            
            
            
            
            
      
   
        });
    </script>
    <div id=pcodesearchgrid></div>
 