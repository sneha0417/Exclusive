 
<%@page import="com.controlcentre.masters.relatedmaster.hoteltype.ClsHotelDAO"%>
<%
ClsHotelDAO cd=new ClsHotelDAO();
%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 <%
  int rowindex =request.getParameter("rowindex")==null?0:Integer.parseInt(request.getParameter("rowindex").trim());
 String type =request.getParameter("tax")==null?"0":request.getParameter("tax");

%>

 <script type="text/javascript">
 
 var cadata;

  
  cadata='<%=cd.vendorSearch(session) %>';
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
							{name : 'vendorid', type: 'String'  },
     						{name : 'vendor', type: 'String'  },
     						{name : 'tax', type: 'String'  },
     						{name : 'tinno', type: 'String'  },
     						{name : 'invno', type: 'String'  },
     						{name : 'invdate', type: 'String'  },
     						
     						
     						
     						
     						
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
            $("#jqxvendorSearch").jqxGrid(
            {
                width: '99%',
                height: 400,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            	showfilterrow:true,
            	filterable:true,
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'DocNo', datafield: 'vendorid', width: '16%' },
					{ text: 'Vendor Name', datafield: 'vendor', width: '78%' },
					{ text: 'tax', datafield: 'tax', width: '78%', hidden:true },
					{ text: 'tinno', datafield: 'tinno', width: '78%',hidden:true },
					{ text: 'invno', datafield: 'invno', width: '78%', hidden:true },
					{ text: 'invdate', datafield: 'invdate',width: '78%', hidden:true },
				
					
					]
            });
    
         		            
				           $('#jqxvendorSearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 
				           document.getElementById("vendor").value = $("#jqxvendorSearch").jqxGrid('getcellvalue', rowindex1, "vendor");
     		               document.getElementById("vendid").value = $("#jqxvendorSearch").jqxGrid('getcellvalue', rowindex1, "vendorid");
				                
				                $('#vendorinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxvendorSearch"></div>
    
    </body>
</html>