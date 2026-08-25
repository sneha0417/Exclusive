 <%--  <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
   <%@page import="com.dashboard.project.callregisterdetail.ClscallregisterDetailDAO"%>
     <%
     ClscallregisterDetailDAO cmd= new ClscallregisterDetailDAO();
     %>


 <script type="text/javascript">
 
 var cldata;

 cldata='<%=cmd.searchcomplaint(session)%>' ;
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'groupname', type: 'String'  },
     						{name : 'doc_no', type: 'String'  }
     						
                          	],
                          	localdata: cldata,
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
            $("#Jqxcomplaintearch").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
               
           
                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '10%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'DocNo', datafield: 'doc_no', width: '40%'},
					{ text: 'Complaint', datafield: 'groupname', width: '50%' }
					
					
					
					]
            });
    
           
          /*   $("#Jqxcomplaintearch").jqxGrid('addrow', null, {}); */
				            
				           $('#Jqxcomplaintearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	
				              document.getElementById("complid").value= $('#Jqxcomplaintearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				               document.getElementById("txtcomplaint").value=$('#Jqxcomplaintearch').jqxGrid('getcellvalue', rowindex1, "groupname");
				             
				               $("#callDetailgrid").jqxGrid('clear'); 
				   			
				                $('#complaintsearch').jqxWindow('close');
				               
				                
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="Jqxcomplaintearch"></div>
    