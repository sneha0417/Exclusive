<%@page import="com.project.execution.surveyDetails.ClsSurveyDetailsDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%

String sertype=request.getParameter("sertype")==null?"":request.getParameter("sertype");
String sertypeid=request.getParameter("sertypeid")==null?"0":request.getParameter("sertypeid");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
ClsSurveyDetailsDAO DAO= new ClsSurveyDetailsDAO();
%>
 
 
<script type="text/javascript">

var sertypedata;

   sertypedata= '<%=DAO.searchSerType(session,sertype,sertypeid,id) %>';
	
     	
        $(document).ready(function () { 	
 
            var source =
            {
                datatype: "json",
                datafields: [
                                
                        
     		 				{name : 'doc_no', type: 'int'},
     						{name : 'name', type: 'string'  },
     						
     						
                 ],
                 localdata: sertypedata,
                
                
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

            
            
            $("#sertypeSearch").jqxGrid(
            {
                width: '100%',
                height: 240,
                source: dataAdapter,
                editable: true,
                //selectionmode: 'singlecell',
                selectionmode: 'checkbox',
                pagermode: 'default',
             
       
                columns: [      
                            //{ text: ' ', datafield: 'chk',columntype: 'checkbox', editable: true,   width: '10%',cellsalign: 'center', align: 'center'},
                            { text: 'Service Type', datafield: 'name', width: '94%'},
    						{ text: 'doc_no', datafield: 'doc_no', width: '10%',hidden:true}
							
			              ]
               
            });
            
            
            
        
            $("#sertypeSearch").on('cellvaluechanged', function (event) 
            		{
            		    
            	  document.getElementById("errormsg").innerText="";
            		    
            		});  
            
            
      
   
        });
    </script>
    <div id=sertypeSearch></div>
 