<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.serviceScheduler.ServiceSchedulerDAO" %>
<% String contextPath=request.getContextPath();%>
 <%ServiceSchedulerDAO DAO= new ServiceSchedulerDAO();%>
 

 <script type="text/javascript">
 
 var assignmode;

 
   assignmode='<%=DAO.assignmode(session)%>';
 
        $(document).ready(function () { 
         
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
     						{name : 'assign', type: 'String'  },
     						{name : 'docno', type: 'String'  }
     						
                          	],
                          	localdata: assignmode,
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
            $("#jqxassignsearch").jqxGrid(
            {
                width: '100%',
                height: 390,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '10%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'DocNo', datafield: 'docno', width: '40%'},
					{ text: 'Assign Method', datafield: 'assign', width: '50%' }
					]
            });
    
            $('#jqxassignsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				              	document.getElementById("txtassign").value=$('#jqxassignsearch').jqxGrid('getcellvalue', rowindex1, "assign");
				              	document.getElementById("assignid").value=$('#jqxassignsearch').jqxGrid('getcellvalue', rowindex1, "docno");
				             
				                $('#assigninfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

       
                       
    </script>
   
    <div id="jqxassignsearch"></div>
    
   