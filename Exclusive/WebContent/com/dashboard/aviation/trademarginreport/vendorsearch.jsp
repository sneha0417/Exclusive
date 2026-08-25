<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%@page import="com.dashboard.aviation.trademarginreport.ClsTradeMarginReportDAO"%>
<%
ClsTradeMarginReportDAO sd=new ClsTradeMarginReportDAO();
%>

 <script type="text/javascript">
 
 var vdata;
 
 
        $(document).ready(function () { 
        	
        
        vdata='<%=sd.vendorsearch(session)%>';
        
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'cldocno', type: 'String'  },
     						{name : 'vendor', type: 'String'  },
     						
     						
     						
                          	],
                          	localdata: vdata,
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
            $("#jqxvendorsearch").jqxGrid(
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
					{ text: 'vendor', datafield: 'vendor', width: '100%' }
					
					 
					
					]
            });
      
				    
				           $('#jqxvendorsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				              	document.getElementById("txtvendor").value=$('#jqxvendorsearch').jqxGrid('getcellvalue', rowindex1, "vendor");
		              	        document.getElementById("vendorid").value=$('#jqxvendorsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
		                        
				                $('#vendorsearch').jqxWindow('close');
				               
				            
				            		 });	 
				           
        
                  }); 

                            
    </script>
    <div id="jqxvendorsearch"></div>
    
    </body>
</html>