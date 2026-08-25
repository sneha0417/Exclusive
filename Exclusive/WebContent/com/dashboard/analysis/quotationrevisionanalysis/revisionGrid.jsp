<%@page import="com.dashboard.analysis.quotationrevisionanalysis.ClsquotationRevisionAnalysisDAO"%>
<% ClsquotationRevisionAnalysisDAO DAO= new ClsquotationRevisionAnalysisDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%
 String trno=request.getParameter("trno")==null?"0":request.getParameter("trno").trim().toString();
 int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());
%>
    <script type="text/javascript">
    var revisiondata;
    var doc_no='<%=trno%>';
    var tempid='<%=id%>';
	
     if(parseInt(tempid)==1){
    	 revisiondata='<%=DAO.revisionGridLoad(session,trno,id)%>';
     }
     
    $(document).ready(function () { 
    	
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'revision', type: 'String'  },
     						{name : 'date', type: 'date'  },
                          	{name : 'remarks', type: 'String'  }
                          	],
                 localdata: revisiondata,
                
                
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
            $("#revisionGridID").jqxGrid(
            {
                width: '99%',
                height: 130,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                selectionmode: 'singlerow',
                sortable: true,
                editable: false,
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Revision', datafield: 'revision', width: '7%' },
					{ text: 'Date', datafield: 'date', width: '7%', cellsformat: 'dd.MM.yyyy' },
					{ text: 'Remarks',datafield:'remarks',width:'81%' },
					]
            });
            
        });
    </script>
    
    <div id="revisionGridID"></div>
