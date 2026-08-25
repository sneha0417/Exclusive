 
 

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 
<%@page import="com.controlcentre.masters.client.ClsClientDAO"%>
<%ClsClientDAO ClsClientDAO= new ClsClientDAO();%>

 <script type="text/javascript">
 
 var radata;
<%--  if('NA' != '<%=item%>')  {
	 radata = '<%=item%>';
 } 
  --%>
  var value = '<%=request.getParameter("getarea")%>';
  var rowIndex = '<%=request.getParameter("rowBoundIndex")%>';
  radata='<%=ClsClientDAO.countrySearch(session)%>';
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'cdocno', type: 'string'  },
     						{name : 'country_name', type: 'String'  }
     						
     						
                          	],
                          	localdata: radata,
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
            $("#jqxcountrysearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					
					{ text: 'Country', datafield: 'country_name', width: '90%' }
					
					
					 
					
					]
            });
    
            //$("#jqxcountrysearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxcountrysearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	
				                	
						      
						                document.getElementById("countryid").value=$('#jqxcountrysearch').jqxGrid('getcellvalue', rowindex1, "cdocno");
						               document.getElementById("txtcountry").value=$('#jqxcountrysearch').jqxGrid('getcellvalue', rowindex1, "country_name");
				            	  
				              
				                $('#countryinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxcountrysearch"></div>
    
    </body>
</html>