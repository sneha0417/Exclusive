<%@page import="com.project.execution.surveyDetails.ClsSurveyDetailsDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsSurveyDetailsDAO DAO= new ClsSurveyDetailsDAO(); %>
 <%
 String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString();
 
 %>
    <script type="text/javascript">
    var servicedata;
    var docno='<%=docno%>';
      
        $(document).ready(function () { 
        	
        	if(docno>0){
        		servicedata='<%=DAO.serviceGridLoad(session,docno)%>';
        	}
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'srno' , type: 'number' },
     						{name : 'service', type: 'String'  },
     						{name : 'serid', type: 'String'  },
                          	],
                 localdata: servicedata,
                
                
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
            $("#serviceGrid").jqxGrid(
            {
                width: '100%',
                height: 140,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
                sortable: true,
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '10%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Services', datafield: 'service', width: '90%' },
					{ text: 'Serviceid', datafield: 'serid', width: '10%',hidden:true },
					]
            });
            
            $('#serviceGrid').on('celldoubleclick', function(event) 
            		{
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	
 		      
 		      if((datafield=="service"))
	    	   {
 		    	 getservice(rowBoundIndex);
	    	   }
 		     
            			
            		});
            
            if($('#mode').val()=='view'){
                
       		 $("#serviceGrid").jqxGrid({ disabled: true});
           }
                 
            $("#serviceGrid").jqxGrid('addrow', null, {});
        });
    </script>
    <div id="serviceGrid"></div>
