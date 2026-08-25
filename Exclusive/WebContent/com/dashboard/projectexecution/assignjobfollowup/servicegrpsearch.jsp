<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.assignjobfollowup.AssignJobFollowupDAO" %>
<% String contextPath=request.getContextPath();%>
 <%AssignJobFollowupDAO DAO= new AssignJobFollowupDAO();
 System.out.println("===request=assignfrm===="+request.getParameter("id").trim());
 int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").trim());
 %>

 <script type="text/javascript">
 
 var assignfrm;
 
 
        $(document).ready(function () { 
        	
        	var id='<%=id%>';
        	assignfrm='<%=DAO.assignfrm(session)%>';
        
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'doc_no', type: 'String'  },
     						{name : 'grpcode', type: 'String'  },
     						
     						
     						
                          	],
                          	localdata: assignfrm,
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
            $("#jqxgrpsearch").jqxGrid(
            {
                width: '100%',
                height: 390,
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
					{ text: 'Doc No', datafield: 'doc_no', width: '21%' },
					{ text: 'Assign Group', datafield: 'grpcode', width: '75%' }
					
					 
					
					]
            });
      
				            
				           $('#jqxgrpsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	
				              	if(id==1){
			               			document.getElementById("txtsergroup").value=$('#jqxgrpsearch').jqxGrid('getcellvalue', rowindex1, "grpcode");
			              	        document.getElementById("sergroupid").value=$('#jqxgrpsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
			              	    }
				              	if(id==2){
				               			document.getElementById("txtgroup").value=$('#jqxgrpsearch').jqxGrid('getcellvalue', rowindex1, "grpcode");
				              	        document.getElementById("groupid").value=$('#jqxgrpsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				              	}		
				              
				                $('#grpinfowindow').jqxWindow('close');
				               
				            
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
    <div id="jqxgrpsearch"></div>
    
    </body>
</html>