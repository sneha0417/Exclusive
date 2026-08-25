<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
<%@page import="com.sales.InventoryTransfer.materialrequest.ClsMaterialrequestDAO"%>
<% ClsMaterialrequestDAO searchDAO = new ClsMaterialrequestDAO(); %> 

 
 <%

String typedocno=request.getParameter("docno")==null?"0":request.getParameter("docno");
 String docnoss=request.getParameter("docnoss")==null?"0":request.getParameter("docnoss");
 String refnames=request.getParameter("refnames")==null?"0":request.getParameter("refnames");
 
 String search=request.getParameter("search")==null?"0":request.getParameter("search");
 

%>
 
 

 
 
<script type="text/javascript">



            	
        $(document).ready(function () { 	
        	var costunit;

        	var temps='<%=search%>';

        	if(temps=="yes")
        		{
        		costunit='<%=searchDAO.costunitsearch(session,"4",docnoss,refnames,search) %>'; 
        		temps="";
        		}
        	else
        		{
        		costunit; 
        		}


 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'tr_no', type: 'int'},   
                             {name : 'doc_no', type: 'int'},  
     		 				{name : 'customer', type: 'string'},
     						 
     			 
     						{name : 'prjname', type: 'string'   },
     						
     						{name : 'cldocno', type: 'string'   },
     						{name : 'site', type: 'string'   },
     						{name : 'siteid', type: 'string'   },
     					 
     				 
     						
     						
     						
     											
                 ],
                 localdata: costunit,
                
                
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

            
            
            $("#costunitsearch").jqxGrid(
            {
                width: '100%',
                height: 320,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
             
                
          
          

                       
                columns: [      
                         
							{ text: 'DocNo', datafield: 'doc_no', width: '10%', editable: false },	
							{ text: 'Client', datafield: 'customer', width: '50%' , editable: false},
							{ text: 'Ref Type', datafield: 'prjname', width: '40%', editable: false },
							
				
							{ text: 'cldocno', datafield: 'cldocno', width: '40%', editable: false ,hidden:true },
							{ text: 'site', datafield: 'site', width: '40%', editable: false ,hidden:true   },
							{ text: 'siteid', datafield: 'siteid', width: '40%', editable: false ,hidden:true  },
		 
							
							{ text: 'tr_no', datafield: 'tr_no', width: '40%', editable: false,hidden:true  },	
							
							
							
			              ]
            
            
            });
            
            
            $('#costunitsearch').on('rowdoubleclick', function (event) {
         	   
         	   var rowindex1 = event.args.rowindex;      
                 document.getElementById("jobno").value=$('#costunitsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
             	 
             	 document.getElementById("costtr_no").value=$('#costunitsearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
             	
             	 
                 $('#DetailsWindow').jqxWindow('close'); 
             });  
            
               
         
            
            
        
        
      
   
        });
    </script>
    <div id=costunitsearch></div>
 