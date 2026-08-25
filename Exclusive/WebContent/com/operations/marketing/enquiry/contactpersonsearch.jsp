
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.operations.marketing.enquiry.ClsEnquiryDAO"%>  
<%
ClsEnquiryDAO DAO= new ClsEnquiryDAO();
 
 int clientid =request.getParameter("clientdocno")==null?0:Integer.parseInt(request.getParameter("clientdocno").trim());
 
%>

 <script type="text/javascript">
 
 var cadata;

  var value = '<%=clientid%>';
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
     						{name : 'mob', type: 'String'  },
     						{name : 'email', type: 'String'  },
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
                width: '99.5%',
                height: 350,
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
					{ text: 'DocNo', datafield: 'cprowno', width: '15%' },
					{ text: 'ContactPerson', datafield: 'cperson', width: '50%' },
					{ text: 'Tele', datafield: 'tel', width: '30%',hidden:true  },
					{ text: 'Mob', datafield: 'mob', width: '30%' },
					{ text: 'E-mail', datafield: 'email', width: '30%',hidden:true  },
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
				               
				                
				               
						            	
						      document.getElementById("txtcontact").value=$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex2, "cperson");
						      document.getElementById("cpersonid").value=$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex2, "cprowno");
						      document.getElementById("txtmobile").value=$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex2, "mob");
						      document.getElementById("txtemail").value=$('#jqxcpsearch').jqxGrid('getcellvalue', rowindex2, "email");
				            	   
				              
				               
				               
				               
				              
				                $('#cpinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxcpsearch"></div>
    
    </body>
</html>