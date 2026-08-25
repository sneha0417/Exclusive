 
 

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.dashboard.marketing.enquiryfollowup.enquiryFollowupDAO"%>
 
<%enquiryFollowupDAO DAO=new enquiryFollowupDAO(); %>
 <script type="text/javascript">
 
 var radata;
<%--  if('NA' != '<%=item%>')  {
	 radata = '<%=item%>';
 } 
  --%>
  <%-- var value = '<%=request.getParameter("getarea")%>';
  var rowIndex = '<%=request.getParameter("rowBoundIndex")%>'; --%>
 radata='<%=DAO.areaSearch(session)%>';
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'areadocno', type: 'String'  },
     						{name : 'area', type: 'String'  },
     						{name : 'city_name', type: 'String'  },
     						{name : 'country_name', type: 'String'  },
     						{name : 'region_name', type: 'String'  }
     						
     						
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
            $("#jqxarea").jqxGrid(
            {
                width: '100%',
                height: 330,
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
					{ text: 'AREA', datafield: 'area', width: '24%' },
					{ text: 'State', datafield: 'city_name', width: '25%' },
					{ text: 'Country', datafield: 'country_name', width: '25%' },
					{ text: 'Region', datafield: 'region_name', width: '19%' },
					
					 
					
					]
            });
    
            //$("#jqxarea").jqxGrid('addrow', null, {});
      
				            
            $('#jqxarea').on('rowdoubleclick', function (event) {
                
                var rowindex2 = event.args.rowindex;
                document.getElementById("areaid").value=$('#jqxarea').jqxGrid('getcellvalue', rowindex2, "areadocno");
                document.getElementById("txtarea").value=$('#jqxarea').jqxGrid('getcellvalue', rowindex2, "area");
           //     document.getElementById("cldocno").value=$('#salmsearch').jqxGrid('getcellvalue', rowindex2, "cldocno");
               
                
                $('#areawindow').jqxWindow('close');
            }); 
                  }); 
				       
                       
    </script>
    <div id="jqxarea"></div>
    
    </body>
</html>