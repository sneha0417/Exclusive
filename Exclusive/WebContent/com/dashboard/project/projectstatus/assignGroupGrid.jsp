 <%--  <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.dashboard.project.projectstatus.projectstatusDAO" %>
<%
	projectstatusDAO DAO=new projectstatusDAO();
%>
<%
 String grpname = request.getParameter("grpname")==null?"0":request.getParameter("grpname");
 int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
%> 

 <script type="text/javascript">
 
 var assigngrpdata;
 
 assigngrpdata='<%=DAO.searchAssignGroup(session,id,grpname)%>';
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'doc_no', type: 'String'  },
     						{name : 'grpname', type: 'String'  },
     						 {name : 'description', type: 'String'  }, 
     						
                          	],
                          	localdata: assigngrpdata,
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
            $("#assigngrpgrid").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
               
           
                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '20%' },
					{ text: 'Group Name', datafield: 'grpname', width: '80%' },
					{ text: 'Description', datafield: 'description', width: '60%',hidden:'true' }, 
					]
            });
    
           
          /*   $("#assigngrpgrid").jqxGrid('addrow', null, {}); */
				            
				           $('#assigngrpgrid').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	
				              	 
				                document.getElementById("assigngrpid").value= $('#assigngrpgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
				               document.getElementById("txtassigngroup").value=$('#assigngrpgrid').jqxGrid('getcellvalue', rowindex1, "grpname");
				              
				                $('#assigngrpwindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="assigngrpgrid"></div>
    