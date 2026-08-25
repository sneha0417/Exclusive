<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%@page import="com.dashboard.aviation.invoicedetails.ClsinvoiceDetailsDAO"%>
<%
ClsinvoiceDetailsDAO sd=new ClsinvoiceDetailsDAO();
%>

 <script type="text/javascript">
 
 var pdata;
 
 
        $(document).ready(function () { 
        	
        
        	pdata='<%=sd.portsearch(session)%>';
        
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'doc_no', type: 'String'  },
     						{name : 'port', type: 'String'  },
     						
     						
     						
                          	],
                          	localdata: pdata,
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
            $("#jqxportsearch").jqxGrid(
            {
                width: '100%',
                height: 390,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                filterable: true,
                showfilterrow: true,
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Doc No', datafield: 'doc_no', width: '5%',hidden:true },
					{ text: 'Port', datafield: 'port', width: '100%' }
					
					 
					
					]
            });
      
				    
				           $('#jqxportsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				              	document.getElementById("txtport").value=$('#jqxportsearch').jqxGrid('getcellvalue', rowindex1, "port");
		              	        document.getElementById("portid").value=$('#jqxportsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
		                        
				                $('#portsearch').jqxWindow('close');
				               
				            
				            		 });	 
				           
        
                  }); 

                            
    </script>
    <div id="jqxportsearch"></div>
    
    </body>
</html>