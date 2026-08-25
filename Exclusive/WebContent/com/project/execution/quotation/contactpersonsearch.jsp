 
 

<%@page import="com.project.execution.quotation.ClsQuotationDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 <%
 ClsQuotationDAO DAO= new ClsQuotationDAO();
 int clientid =request.getParameter("clientdocno")==null?0:Integer.parseInt(request.getParameter("clientdocno").trim());
 
%>

 <script type="text/javascript">
 
 var cadata;
 var value = '<%=clientid%>';
  cadata='<%=DAO.contactpersonSearch(session,clientid) %>';
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
							{name : 'cprowno', type: 'String'  },
     						{name : 'cperson', type: 'String'  },
     						{name : 'contactdet', type: 'String'  },
     						
     						
     						
     						
                          	],
                          	localdata: cadata,
                          //	 url: url1,
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxcpsearch").jqxGrid(
            {
                width: '100%',
                height: 400,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'DocNo', datafield: 'cprowno', width: '10%' },
					{ text: 'ContactPerson', datafield: 'cperson', width: '35%' },
					{ text: 'Details', datafield: 'contactdet', width: '50%' },
					
					]
            });
    
      	            
				           $('#jqxcpsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex2=event.args.rowindex;
				            	  var temp="";
				            		
						        document.getElementById("txtcontact").value=$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex2, "cperson");
						        document.getElementById("cpersonid").value=$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex2, "cprowno");
						        document.getElementById("txtcontactdetails").value=$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex2, "contactdet");
				            	   
				              $('#cpinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxcpsearch"></div>
    
    </body>
</html>