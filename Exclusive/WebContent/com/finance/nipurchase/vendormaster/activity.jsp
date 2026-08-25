 
 

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.finance.nipurchase.vendormaster.ClsVendorDetailsDAO"%> 
 
<% ClsVendorDetailsDAO DAO=new ClsVendorDetailsDAO(); %>
 <script type="text/javascript">
 
 var radata;
<%--  if('NA' != '<%=item%>')  {
	 radata = '<%=item%>';
 } 
  --%>
  var rowIndex = '<%=request.getParameter("rowBoundIndex")%>';
  radata='<%=DAO.activitySearch(session)%>';
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'adocno', type: 'string'  },
     						{name : 'ay_name', type: 'String'  }
     						
     						
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
            $("#jqxactivitysearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '6%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					
					{ text: 'activity', datafield: 'ay_name', width: '94%' }
					
					
					 
					
					]
            });
    
            //$("#jqxactivitysearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxactivitysearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	
				                	
						      
				              	$('#cpDetailsGrid').jqxGrid('setcellvalue', rowIndex, "activity",$('#jqxactivitysearch').jqxGrid('getcellvalue', rowindex1, "ay_name"));
		               			$('#cpDetailsGrid').jqxGrid('setcellvalue', rowIndex, "activity_id",$('#jqxactivitysearch').jqxGrid('getcellvalue', rowindex1, "adocno"));
				              
				               
				           $("#cpDetailsGrid").jqxGrid("addrow", null, {});
				              
				                $('#activityinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxactivitysearch"></div>
    
    </body>
</html>