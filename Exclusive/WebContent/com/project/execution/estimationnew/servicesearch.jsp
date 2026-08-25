
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%@page import="com.project.execution.estimationnew.ClsEstimationDAO"%>
<%ClsEstimationDAO DAO= new ClsEstimationDAO();%>
 <%
 int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); 
 %>

 <script type="text/javascript">
 
 var serviceType;

 var rowIndex='<%=rowIndex%>';
 
   serviceType='<%=DAO.serviceSearch(session)%>';
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

							{name : 'docno', type: 'String'  },
							{name : 'stype', type: 'String'  },
     						
     						
                          	],
                          	localdata: serviceType,
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
            $("#jqxstypesearch").jqxGrid(
            {
                width: '100%',
                height: 420,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Doc No', datafield: 'docno', width: '19%' },
					{ text: 'Service Type', datafield: 'stype', width: '75%' }
					
					 
					
					]
            });
    		            
				           $('#jqxstypesearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				              
		               			
				            	 		$('#materialGrid').jqxGrid('setcellvalue', rowIndex, "sertype",$('#jqxstypesearch').jqxGrid('getcellvalue', rowindex1, "stype"));
				               			$('#materialGrid').jqxGrid('setcellvalue', rowIndex, "stypeid",$('#jqxstypesearch').jqxGrid('getcellvalue', rowindex1, "docno"));
				            var newrowindex=parseInt(rowIndex)+1;
				           
				               			var siteid=$('#materialGrid').jqxGrid('getcellvalue', newrowindex, "sitesrno");
				               			var stypeid=$('#materialGrid').jqxGrid('getcellvalue', newrowindex, "stypeid");
				               			
				               		 

								 var rows = $('#materialGrid').jqxGrid('getrows');
				                     
				                     var rowlength= rows.length;
				                     if(rowIndex == rowlength - 1)
				                     	{  
				                     $("#materialGrid").jqxGrid('addrow', null, {});
				                     	}
				                     if((siteid=="undefined" || typeof(siteid)=="undefined" || siteid==null || siteid=="") &&
					              				(stypeid=="undefined" || typeof(stypeid)=="undefined" || stypeid==null || stypeid=="" ))
				               				{
					               			
				               				$('#materialGrid').jqxGrid('setcellvalue', newrowindex, "sitesrno",$('#materialGrid').jqxGrid('getcellvalue', rowIndex, "sitesrno"));
					               			$('#materialGrid').jqxGrid('setcellvalue', newrowindex, "site",$('#materialGrid').jqxGrid('getcellvalue', rowIndex, "site"));
					               			$('#materialGrid').jqxGrid('setcellvalue', newrowindex, "scopeid",$('#materialGrid').jqxGrid('getcellvalue', rowIndex, "scopeid"));
					               			$('#materialGrid').jqxGrid('setcellvalue', newrowindex, "scope",$('#materialGrid').jqxGrid('getcellvalue', rowIndex, "scope"));
					               			$('#materialGrid').jqxGrid('setcellvalue', newrowindex, "scopeproduct",$('#materialGrid').jqxGrid('getcellvalue', rowIndex, "scopeproduct"));
					               			$('#materialGrid').jqxGrid('setcellvalue', newrowindex, "sertype",$('#jqxstypesearch').jqxGrid('getcellvalue', rowindex1, "stype"));
					               			$('#materialGrid').jqxGrid('setcellvalue', newrowindex, "stypeid",$('#jqxstypesearch').jqxGrid('getcellvalue', rowindex1, "docno"));
					              
				               				}	
					               			
								 $('#servicetypewindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

                       
    </script>
    <!-- <div style="text-align:right;padding-right:25px;padding-bottom:5px;"><input type="button" name="btnnewarea" id="btnnewarea" value="Add" onclick="addArea()";  class="myButton"></div> -->
    <div id="jqxstypesearch"></div>
    
    </body>
</html>