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
    var servdata;
    var doc_no='<%=trno%>';
    var tempid='<%=id%>';

     if(tempid==1){
		
    	servdata = '<%=DAO.quotGridLoad(session,trno) %>';
    	
  }
   
    
        $(document).ready(function () { 	
         var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'site' , type: 'String' },
							{name : 'siteid' , type: 'String' }, 
                          	{name : 'stype' , type: 'String' },
                          	{name : 'stypeid' , type: 'String' },
                          	{name : 'unit' , type: 'String' },
                          	{name : 'unitid' , type: 'String' },
     						{name : 'item', type: 'String'  },
                          	{name : 'qty', type: 'number'  },
     						{name : 'amount', type: 'number'  },
     						{name : 'total', type: 'number'  },
     						{name : 'desc1', type: 'String'  },
     						{name : 'revision', type: 'String'  },
                          	],
                 localdata: servdata,
                
                
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
            $("#qutDetGrid").jqxGrid(
            {
                width: '99%',
                height:220,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
             	selectionmode: 'singlecell',
                editable: false,
                sortable: true,
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					
					
					{ text: 'Revision', datafield: 'revision', width: '7%' },
					{ text: 'Site', datafield: 'site', width: '13%' },
					{ text: 'siteid', datafield: 'siteid', width: '10%',hidden:true},
					{ text: 'Service.Type', datafield: 'stype', width: '13%' },
					{ text: 'stypeid', datafield: 'stypeid', width: '10%',hidden:true},
					{ text: 'Item', datafield: 'item', width: '10%'},
					{ text: 'Unit', datafield: 'unit', width: '5%'  },
					{ text: 'Qty', datafield: 'qty', width: '5%' },
					{ text: 'Unitid', datafield: 'unitid', width: '10%',hidden:true},
					{text: 'Amount',datafield:'amount',width:'10%',cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right'},
					{text: 'Total',datafield:'total',cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right' },
					{text: 'Description',datafield:'desc1'}
					]
            });
                
        });
    </script>
 
   <div id="qutDetGrid"></div>
    