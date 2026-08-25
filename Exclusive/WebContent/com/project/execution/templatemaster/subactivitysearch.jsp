<%@page import="com.project.execution.estimationnew.ClsEstimationDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%

String activity=request.getParameter("activity")==null?"":request.getParameter("activity");
String section=request.getParameter("section")==null?"":request.getParameter("section");
String project=request.getParameter("project")==null?"":request.getParameter("project");
String activid=request.getParameter("activid")==null?"0":request.getParameter("activid");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
ClsEstimationDAO DAO= new ClsEstimationDAO();
%>
 
 
<script type="text/javascript">

var actimaster;

   actimaster= '<%=DAO.searchActivity(session,project,section,activity,activid,id) %>';
	
     	
        $(document).ready(function () { 	
 
            var source =
            {
                datatype: "json",
                datafields: [
                                
                            {name : 'tr_no', type: 'int'},  
     		 				{name : 'doc_no', type: 'int'},
     						{name : 'project', type: 'string'  },
     						{name : 'projectid', type: 'string'   },
     						{name : 'section', type: 'string'  },
     						{name : 'sectionid', type: 'string'   },
     						{name : 'activity', type: 'string'  },
     						{name : 'activityid', type: 'string'   },
     						
                 ],
                 localdata: actimaster,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#activitySearch").jqxGrid(
            {
                width: '100%',
                height: 320,
                source: dataAdapter,
                editable: true,
                //selectionmode: 'singlecell',
                selectionmode: 'checkbox',
                pagermode: 'default',
             
       
                columns: [      
                            //{ text: ' ', datafield: 'chk',columntype: 'checkbox', editable: true,   width: '10%',cellsalign: 'center', align: 'center'},
                            { text: 'Activity', datafield: 'activity', width: '35%'},
                            { text: 'Project', datafield: 'project', width: '30%'},
                            { text: 'Projectid', datafield: 'projectid', width: '10%',hidden:true},
    						{ text: 'Section', datafield: 'section', width: '30%'},
    						{ text: 'sectionid', datafield: 'sectionid', width: '10%',hidden:true},
    						{ text: 'tr_no', datafield: 'tr_no', width: '10%',hidden:true}
							
			              ]
               
            });
            
            
            
        
            $("#activitySearch").on('cellvaluechanged', function (event) 
            		{
            		    
            	  document.getElementById("errormsg").innerText="";
            		    
            		});  
            
            
      
   
        });
    </script>
    <div id=activitySearch></div>
 