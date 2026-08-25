<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%@page import="com.dashboard.aviation.fuelstatus.ClsFuelStatusDAO"%>
<%
ClsFuelStatusDAO sd=new ClsFuelStatusDAO();
%>

 <script type="text/javascript">
 
 var clientdata;
 
 
        $(document).ready(function () { 
        	
        
        	clientdata='<%=sd.clientsearch(session)%>';
        
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'cldocno', type: 'String'  },
     						{name : 'client', type: 'String'  },
     						
     						
     						
                          	],
                          	localdata: clientdata,
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
            $("#jqxclsearch").jqxGrid(
            {
                width: '100%',
                height: 390,
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
					{ text: 'Doc No', datafield: 'cldocno', width: '5%',hidden:true },
					{ text: 'Client', datafield: 'client', width: '100%' }
					
					 
					
					]
            });
      
				         
				           $('#jqxclsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	        var rowindex1=event.args.rowindex;
				            	
			               			    document.getElementById("txtclient").value=$('#jqxclsearch').jqxGrid('getcellvalue', rowindex1, "client");
			              	            document.getElementById("clientid").value=$('#jqxclsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
				               			$('#clientsearch1').jqxWindow('close');
				            
				            		 });  	 
				           
        
                  }); 

                            
    </script>
    <div id="jqxclsearch"></div>
    
    </body>
</html>