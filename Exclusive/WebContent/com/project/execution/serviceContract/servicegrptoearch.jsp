 
 

<%@page import="com.project.execution.serviceContract.ClsServiceContractDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsServiceContractDAO DAO= new ClsServiceContractDAO(); %>
 <%
 int rowIndex=request.getParameter("rowIndex")==null?0:Integer.parseInt(request.getParameter("rowIndex").trim()); 
 int assgnid=request.getParameter("assgnid")==null?0:Integer.parseInt(request.getParameter("assgnid").trim());
 %>

 <script type="text/javascript">
 
 var assignteam;

 var rowIndex='<%=rowIndex%>';
 var assgnid='<%=assgnid%>';
 
   assignteam='<%=DAO.assignteam(session,assgnid)%>';
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'empid', type: 'String'  },
     						{name : 'doc_no', type: 'String'  },
     						{name : 'grpcode', type: 'String'  },
     						{name : 'name', type: 'String'  },
     						
     						
                          	],
                          	localdata: assignteam,
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
            $("#jqxgrptosearch").jqxGrid(
            {
                width: '95%',
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
					{ text: 'Assign Team', datafield: 'name', width: '50%' },
					{ text: 'Assign Group', datafield: 'grpcode', width: '45%' },
					{ text: 'doc_no', datafield: 'doc_no', width: '45%',hidden:true },
					{ text: 'empid', datafield: 'empid', width: '45%',hidden:true },
					
					 
					
					]
            });
    
            //$("#jqxgrptosearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxgrptosearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 		$('#servscGrid').jqxGrid('setcellvalue', rowIndex, "assignto",$('#jqxgrptosearch').jqxGrid('getcellvalue', rowindex1, "name"));
				               			$('#servscGrid').jqxGrid('setcellvalue', rowIndex, "assigntoid",$('#jqxgrptosearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
				               			$('#servscGrid').jqxGrid('setcellvalue', rowIndex, "assignempid",$('#jqxgrptosearch').jqxGrid('getcellvalue', rowindex1, "empid"));
				               			$("#servscGrid").jqxGrid('addrow', null, {});
				              
				                $('#teaminfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

        function addArea(){
        	
        	var formname='Service Settings';
        	var formcode='SERS';
        	var lblname='Service Area Settings';
        	var lbldrp='area';
        	var detName='Service Settings';
        	
        	 var url=document.URL;
		     var reurl=url.split("com");
		     var path1='com/controlcentre/settings/ServiceSettings/serviceSettings.jsp';
        	var path= path1+"?formname="+formname+"&formcode="+formcode+"&lblname="+lblname+"&lbldrp="+lbldrp+"&mode=A";
			  
			   top.addTab( detName,reurl[0]+""+path);
        	
        	<%-- window.open("<%=contextPath%>/com/controlcentre/settings/ServiceSettings/serviceSettings.jsp?formname="+formname+"&formcode="+formcode+"&lblname="+lblname+"&lbldrp="+lbldrp+"","Service Settings","menubar=0,resizable=1,width=1000,height=580 ,top=100, left=260"); --%>
      
        }
        
                       
    </script>
    <!-- <div style="text-align:right;padding-right:25px;padding-bottom:5px;"><input type="button" name="btnnewarea" id="btnnewarea" value="Add" onclick="addArea()";  class="myButton"></div> -->
    <div id="jqxgrptosearch"></div>
    
    </body>
</html>