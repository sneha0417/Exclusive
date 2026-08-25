<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<% String contextPath=request.getContextPath();%>
   <%@page import="com.dashboard.project.callregisterdetail.ClscallregisterDetailDAO"%>
     <%
     ClscallregisterDetailDAO cmd= new ClscallregisterDetailDAO();
     %>

 <script type="text/javascript">
 
 var usersearch;

 
   usersearch='<%=cmd.userSearch(session)%>';
 
        $(document).ready(function () { 
         
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
     						{name : 'username', type: 'String'  },
     						{name : 'docno', type: 'String'  }
     						
                          	],
                          	localdata: usersearch,
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
            $("#jqxusersearch").jqxGrid(
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
					{ text: 'Name', datafield: 'username', width: '50%' }
					]
            });
    
            $('#jqxusersearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				              	document.getElementById("txtuser").value=$('#jqxusersearch').jqxGrid('getcellvalue', rowindex1, "username");
				              	document.getElementById("userid").value=$('#jqxusersearch').jqxGrid('getcellvalue', rowindex1, "docno");
				              	 $("#callDetailgrid").jqxGrid('clear'); 
				                $('#userinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

       
                       
    </script>
   
    <div id="jqxusersearch"></div>
    
   