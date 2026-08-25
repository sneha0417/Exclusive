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
    var sitedata;
    var doc_no='<%=trno%>';
    var tempid='<%=id%>';
	
     if(parseInt(tempid)==1){
    	 sitedata='<%=DAO.siteGridLoad(session,trno,id)%>';
     }
     
    $(document).ready(function () { 
    	
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'revision', type: 'String'  },
     						{name : 'site', type: 'String'  },
                          	{name : 'area', type: 'String'  },
                          	{name : 'amount', type: 'number'  }
                          	],
                 localdata: sitedata,
                
                
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
            $("#siteGridID").jqxGrid(
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
					{ text: 'Site', datafield: 'site', width: '48%' },
					{ text: 'Area',datafield:'area',width:'40%',editable: false},
					{ text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right',hidden: true },
					]
            });
            
        });
    </script>
    
    <div id="siteGridID"></div>
