
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%@page import="com.project.execution.templatemaster.ClsTemplateDAO"%>
<%ClsTemplateDAO DAO= new ClsTemplateDAO();%>
 <%
 int rowIndexx=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); 
 %>

 <script type="text/javascript">
 
 var serviceType;

 var rowIndexx='<%=rowIndexx%>';
 
   serviceType='<%=DAO.scopeSearch(session)%>';
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

							{name : 'doc_no', type: 'String'  },
							{name : 'sname', type: 'String'  },
     						
     						
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
            $("#jqxscopesearch").jqxGrid(
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
					{ text: 'Doc No', datafield: 'doc_no', width: '19%' },
					{ text: 'Scope', datafield: 'sname', width: '75%' }
					
					 
					
					]
            });
    		            
				           $('#jqxscopesearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				              
		               			
				            	 		$('#materialGrid').jqxGrid('setcellvalue', rowIndexx, "scope",$('#jqxscopesearch').jqxGrid('getcellvalue', rowindex1, "sname"));
				               			$('#materialGrid').jqxGrid('setcellvalue', rowIndexx, "scopeid",$('#jqxscopesearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
				         /*   var newrowindexx=parseInt(rowIndex)+1;
				           
				           		
				               			var scopeid=$('#materialGrid').jqxGrid('getcellvalue', newrowindexx, "scopeid");
				               			
				               		 

								 var rows = $('#materialGrid').jqxGrid('getrows');
				                     
				                     var rowlength= rows.length;
				                     if(rowIndexx == rowlength - 1)
				                     	{  
				                     $("#materialGrid").jqxGrid('addrow', null, {});
				                     	}
				                     

				               				$('#materialGrid').jqxGrid('setcellvalue', newrowindexx, "stypeid",$('#jqxscopesearch').jqxGrid('getcellvalue', rowindex1, "docno"));
					              
 */				  
					               			
								 $('#scopetypewindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

                       
    </script>
    <!-- <div style="text-align:right;padding-right:25px;padding-bottom:5px;"><input type="button" name="btnnewarea" id="btnnewarea" value="Add" onclick="addArea()";  class="myButton"></div> -->
    <div id="jqxscopesearch"></div>
    
    </body>
</html>