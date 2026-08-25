
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%@page import="com.dashboard.marketing.quotationdetail.ClsQuotationDetailDAO"%>
<%ClsQuotationDetailDAO DAO= new ClsQuotationDetailDAO();%>
 <%
 int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim());
 String trno=request.getParameter("hidtrno")==null?"0":request.getParameter("hidtrno").trim();
 %>

 <script type="text/javascript">
 
 var servicesite;

 var rowIndex='<%=rowIndex%>';
 
 servicesite='<%=DAO.siteSearch(session,trno)%>';
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

							{name : 'site', type: 'String'  },
							{name : 'refrowno', type: 'String'  },
                          	],
                          	localdata: servicesite,
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
            $("#jqxsitesearch").jqxGrid(
            {
                width: '100%',
                height: 420,
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
					{ text: 'Doc No', datafield: 'refrowno', width: '19%' },
					{ text: 'Site', datafield: 'site', width: '75%' }
					
					 
					
					]
            });
    		            
				           $('#jqxsitesearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	        var rowindex1=event.args.rowindex;
				            	 		$('#qutDetGrid').jqxGrid('setcellvalue', rowIndex, "site",$('#jqxsitesearch').jqxGrid('getcellvalue', rowindex1, "site"));
				               			$('#qutDetGrid').jqxGrid('setcellvalue', rowIndex, "siteid",$('#jqxsitesearch').jqxGrid('getcellvalue', rowindex1, "refrowno"));
				              
				               			 $('#siteinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

                       
    </script>
    <!-- <div style="text-align:right;padding-right:25px;padding-bottom:5px;"><input type="button" name="btnnewarea" id="btnnewarea" value="Add" onclick="addArea()";  class="myButton"></div> -->
    <div id="jqxsitesearch"></div>
    
    </body>
</html>