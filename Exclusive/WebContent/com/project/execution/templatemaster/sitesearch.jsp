
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%@page import="com.project.execution.estimationnew.ClsEstimationDAO"%>
<%ClsEstimationDAO DAO= new ClsEstimationDAO();%>
 <%
 int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); 
 int loadid =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").trim()); 
 String reftrno=request.getParameter("reftrno")==null?"0":request.getParameter("reftrno").trim();
 String reftype = request.getParameter("reftype")==null?"0":request.getParameter("reftype");
 
 %>

 <script type="text/javascript">
 
 var site;

 var rowIndex='<%=rowIndex%>';
 
   <%-- site='<%=DAO.sitegridSearch(reftrno,loadid,reftype)%>' ; --%>
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

							{name : 'site', type: 'String'  },
							{name : 'sitesrno', type: 'String'  },
     						
     						
                          	],
                          	localdata: site,
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
                height: 380,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					
					{ text: 'Sr No.', datafield: 'sitesrno', width: '25%' },
					{ text: 'Site', datafield: 'site', width: '75%' }
					
					 
					
					]
            });
    		            
				           $('#jqxsitesearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 		$('#materialGrid').jqxGrid('setcellvalue', rowIndex, "sitesrno",$('#jqxsitesearch').jqxGrid('getcellvalue', rowindex1, "sitesrno"));
				               			$('#materialGrid').jqxGrid('setcellvalue', rowIndex, "site",$('#jqxsitesearch').jqxGrid('getcellvalue', rowindex1, "site"));
				              
				               

								 var rows = $('#materialGrid').jqxGrid('getrows');
				                     
				                     var rowlength= rows.length;
				                     if(rowIndex == rowlength - 1)
				                     	{  
				                     $("#materialGrid").jqxGrid('addrow', null, {});
				                     	}
				               		
								 $('#sitewindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

                       
    </script>
    <!-- <div style="text-align:right;padding-right:25px;padding-bottom:5px;"><input type="button" name="btnnewarea" id="btnnewarea" value="Add" onclick="addArea()";  class="myButton"></div> -->
    <div id="jqxsitesearch"></div>
    
    </body>
</html>