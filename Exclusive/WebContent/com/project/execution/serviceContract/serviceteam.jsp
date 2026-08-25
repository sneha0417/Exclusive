 
 

<%@page import="com.project.execution.serviceContract.ClsServiceContractDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsServiceContractDAO DAO= new ClsServiceContractDAO(); %>
 <%int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); %>

 <script type="text/javascript">
 
 var serviceteamdata;

 var rowIndex='<%=rowIndex%>';
 

 
 serviceteamdata='<%=DAO.serviceteamSearch(session)%>';
 
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'docno', type: 'String'  },
     						{name : 'team', type: 'String'  },
     						
     						
     						
                          	],
                          	localdata: serviceteamdata,
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
            $("#jqxsteamsearch").jqxGrid(
            {
                width: '100%',
                height: 420,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Doc No', datafield: 'docno', width: '21%' },
					{ text: 'Service Team', datafield: 'team', width: '72%' }
					
					 
					
					]
            });
    
            //$("#jqxsteamsearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxsteamsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 
				            	  
				               			$('#siteGrid').jqxGrid('setcellvalue', rowIndex, "serviceteam",$('#jqxsteamsearch').jqxGrid('getcellvalue', rowindex1, "team"));
				               			$('#siteGrid').jqxGrid('setcellvalue', rowIndex, "steamid",$('#jqxsteamsearch').jqxGrid('getcellvalue', rowindex1, "docno"));
				               			$("#siteGrid").jqxGrid('addrow', null, {});
				              
				                $('#serviceteamwindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

                       
    </script>
    <div style="text-align:right;padding-right:25px;padding-bottom:5px;"><input type="button" name="btnnewarea" id="btnnewarea" value="Add" onclick="addArea()";  class="myButton"></div>
    <div id="jqxsteamsearch"></div>
    
    </body>
</html>