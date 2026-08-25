<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%@page
	import="com.dashboard.projectexecution.assignmentfollowup.ClsAssignmentFollowupDAO"%>
<%
ClsAssignmentFollowupDAO sd=new ClsAssignmentFollowupDAO();
%>
<% 
 int assgnid=request.getParameter("assgnid")==null||request.getParameter("assgnid")==""?0:Integer.parseInt(request.getParameter("assgnid").trim());
 int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").trim());
 %>

 <script type="text/javascript">
 
 var assignteam;
 
 var assgnid='<%=assgnid%>';
   assignteam='<%=sd.assignteam(assgnid)%>';
        $(document).ready(function () { 
        	var id='<%=id%>';
        	
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
				              	
				              	if(id==1){
					              	
					              	document.getElementById("txtsergrpemp").value=$('#jqxgrptosearch').jqxGrid('getcellvalue', rowindex1, "name");
					              	document.getElementById("grpsermemberid").value=$('#jqxgrptosearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
					              	document.getElementById("grpserempid").value=$('#jqxgrptosearch').jqxGrid('getcellvalue', rowindex1, "empid");
					              	}
				              	
				              	if(id==2){
				              	
				              	document.getElementById("txtgrpmember").value=$('#jqxgrptosearch').jqxGrid('getcellvalue', rowindex1, "name");
				              	document.getElementById("grpmemberid").value=$('#jqxgrptosearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				              	document.getElementById("grpempid").value=$('#jqxgrptosearch').jqxGrid('getcellvalue', rowindex1, "empid");
				              	}		
				              
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