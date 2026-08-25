
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
  <%@page import="com.dashboard.projectexecution.engineeringconfirmationupdate.ClsEngineeringConfirmationDAO"%>
<%
ClsEngineeringConfirmationDAO DAO=new ClsEngineeringConfirmationDAO();
%>
 <%
 int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); 
 %>

 <script type="text/javascript">
 
 var serviceType;

 var rowIndex='<%=rowIndex%>';
 
   serviceType='<%=DAO.serviceSearch(session)%>';
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

							{name : 'docno', type: 'String'  },
							{name : 'stype', type: 'String'  },
     						
     						
                          	],
                          	localdata: serviceType,
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
            $("#jqxstypesearch").jqxGrid(
            {
                width: '100%',
                height: 420,
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
					{ text: 'Doc No', datafield: 'docno', width: '19%' },
					{ text: 'Service Type', datafield: 'stype', width: '75%' }
					
					 
					
					]
            });
    		            
				           $('#jqxstypesearch').on('rowdoubleclick', function (event) 
				            		{ 
				        		
				              	var rowindex1=event.args.rowindex;
				            	 		$('#materialEstPriceGrid').jqxGrid('setcellvalue', rowIndex, "sertype",$('#jqxstypesearch').jqxGrid('getcellvalue', rowindex1, "stype"));
				               			$('#materialEstPriceGrid').jqxGrid('setcellvalue', rowIndex, "stypeid",$('#jqxstypesearch').jqxGrid('getcellvalue', rowindex1, "docno"));
				              
				               	
				                     $("#materialEstPriceGrid").jqxGrid('addrow', null, {});
				                     
				                $('#servicetypewindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

                       
    </script>
    <!-- <div style="text-align:right;padding-right:25px;padding-bottom:5px;"><input type="button" name="btnnewarea" id="btnnewarea" value="Add" onclick="addArea()";  class="myButton"></div> -->
    <div id="jqxstypesearch"></div>
    
    </body>
</html>