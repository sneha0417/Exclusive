<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.assignjobfollowup.AssignJobFollowupDAO" %>
<% String contextPath=request.getContextPath();%>
 <%AssignJobFollowupDAO DAO= new AssignJobFollowupDAO();%>
 

 <script type="text/javascript">
 
 var assignmode;

 
   assignmode='<%=DAO.assignmode(session)%>';
 
        $(document).ready(function () { 
         
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
     						{name : 'assign', type: 'String'  },
     						{name : 'docno', type: 'String'  }
     						
                          	],
                          	localdata: assignmode,
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
            $("#jqxassignsearch").jqxGrid(
            {
                width: '100%',
                height: 390,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '10%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'DocNo', datafield: 'docno', width: '40%'},
					{ text: 'Assign Method', datafield: 'assign', width: '50%' }
					]
            });
    
            $('#jqxassignsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				              	document.getElementById("txtassign").value=$('#jqxassignsearch').jqxGrid('getcellvalue', rowindex1, "assign");
				              	document.getElementById("assignid").value=$('#jqxassignsearch').jqxGrid('getcellvalue', rowindex1, "docno");
				             
				                $('#assigninfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

       <%--  function addArea(){
        	
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
        	
        	window.open("<%=contextPath%>/com/controlcentre/settings/ServiceSettings/serviceSettings.jsp?formname="+formname+"&formcode="+formcode+"&lblname="+lblname+"&lbldrp="+lbldrp+"","Service Settings","menubar=0,resizable=1,width=1000,height=580 ,top=100, left=260");
      
        } --%>
        
                       
    </script>
    <!-- <div style="text-align:right;padding-right:25px;padding-bottom:5px;"><input type="button" name="btnnewarea" id="btnnewarea" value="Add" onclick="addArea()";  class="myButton"></div> -->
    <div id="jqxassignsearch"></div>
    
   