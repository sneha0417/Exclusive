
<%@page import="com.project.execution.jobContract.ClsJobContractDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
 <%
 ClsJobContractDAO DAO= new ClsJobContractDAO();
 int clientid =request.getParameter("clientdocno")==null?0:Integer.parseInt(request.getParameter("clientdocno").trim());
 int rowindex =request.getParameter("rowindex")==null?0:Integer.parseInt(request.getParameter("rowindex").trim());
 int type =request.getParameter("type")==null?0:Integer.parseInt(request.getParameter("type").trim());
%>

 <script type="text/javascript">
 
 var cadata;

  var value = '<%=clientid%>';
  var rowindex = '<%=rowindex%>';
  var type = '<%=type%>';

  cadata='<%=DAO.contactpersonSearch(session,clientid) %>';
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
							{name : 'cprowno', type: 'String'  },
     						{name : 'cperson', type: 'String'  },
     						{name : 'tel', type: 'String'  },
     						{name : 'area', type: 'String'  }
     						
     						
     						
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
            $("#jqxcpsearch").jqxGrid(
            {
                width: '100%',
                height: 400,
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
					{ text: 'DocNo', datafield: 'cprowno', width: '35%' },
					{ text: 'ContactPerson', datafield: 'cperson', width: '35%' },
					{ text: 'Tele', datafield: 'tel', width: '25%' },
					{ text: 'Area', datafield: 'area', width: '30%',hidden:true }
					
					
					 
					
					]
            });
    
            //$("#jqxcpsearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxcpsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex2=event.args.rowindex;
				            	  var temp="";
				            	  temp=temp+$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex2, "tele");
				                temp=temp+","+$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex2, "area");
				               
				                
				                if(type==2){
				                	
				                	$('#siteGrid').jqxGrid('setcellvalue', rowindex, "contmob",$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex2, "tel"));
				                	$('#siteGrid').jqxGrid('setcellvalue', rowindex, "contper",$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex2, "cperson"));
			               			$('#siteGrid').jqxGrid('setcellvalue', rowindex, "contid",$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex2, "cprowno"));
				                	
				                }
				                if(type==1){
				                	document.getElementById("txtcontact").value=$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex2, "cperson");
						            document.getElementById("cpersonid").value=$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex2, "cprowno");
				            	   
				                }
				                
						      
				                $('#cpinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxcpsearch"></div>
    
    </body>
</html>