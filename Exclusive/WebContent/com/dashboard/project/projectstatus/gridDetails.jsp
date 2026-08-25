    <%-- <jsp:include page="../../includes.jsp"></jsp:include>  --%> 
    
  <%@page import="com.dashboard.project.projectstatus.projectstatusDAO" %>
<%
	projectstatusDAO sd=new projectstatusDAO();
%>
    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


 <% String fromdate =request.getParameter("froms")==null?"0":request.getParameter("froms").toString();%>
 <% String todate =request.getParameter("tos")==null?"0":request.getParameter("tos").toString();%>
 <% String rds =request.getParameter("rds")==null?"0":request.getParameter("rds").toString();%>
 <% String barchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype").toString();%>
<% String clientid =request.getParameter("clientid")==null||request.getParameter("clientid")==""?"0":request.getParameter("clientid").toString();%>
 <% String asgngrpid =request.getParameter("asgngrpid")==null||request.getParameter("asgngrpid")==""?"0":request.getParameter("asgngrpid").toString();%>
 
 <script type="text/javascript">
 var data,projectstatusexcel;
 
 var bb='<%=rds%>';
	if(bb!='0'){
data= '<%= sd.loadGridData(fromdate,todate,rds,barchval,dtype,clientid,asgngrpid) %>';
 projectstatusexcel= '<%= sd.loadGridExcel(fromdate,todate,rds,barchval,dtype,clientid,asgngrpid) %>';
	}
	else{
		bb=1;
	}
    //alert("==================loadSalikData");
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'number'  },
     						{name : 'dtype', type: 'String'  },
     						{name : 'client', type: 'String' },
     						{name : 'sdate', type: 'date' },
     						{name : 'edate', type: 'date' },
     						{name : 'cval', type: 'String' },
     						{name : 'site', type: 'String' },
     						{name : 'schedule', type: 'String' },
     						{name : 'assign', type: 'String' },
     						{name : 'complete', type: 'String' },
     						{name : 'closed', type: 'String' },
						{name : 'date', type: 'date' },
     						
                 ],
                 localdata: data,
                
                
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
            $("#jqxloaddataGrid").jqxGrid(
            {
                width: '99%',
                height: 550,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
					{ text: 'Doc No', datafield: 'doc_no', width: '5%' },
					{ text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Doc Type',  datafield: 'dtype', width: '5%' },
					{ text: 'Client', datafield: 'client', width: '16%' },
					{ text: 'Start Date', datafield: 'sdate', width: '6%',cellsformat:'dd.MM.yyyy' },
					{ text: 'End Date', datafield: 'edate', width: '6%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Contract Value',  datafield: 'cval', width: '10%' },
					{ text: 'Site',  datafield: 'site', width: '16%' },
					{ text: 'Schedule',  datafield: 'schedule', width: '6%' },
					{ text: 'Assigned',  datafield: 'assign', width: '7%' },
					{ text: 'Completed',  datafield: 'complete', width: '7%' },
					{ text: 'Closed',  datafield: 'closed', width: '6%' },
					
					
	              ]
            });
            if(bb==1)
        	{
        	 $("#jqxloaddataGrid").jqxGrid('addrow', null, {});
        	}

                 $("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="jqxloaddataGrid"></div>
