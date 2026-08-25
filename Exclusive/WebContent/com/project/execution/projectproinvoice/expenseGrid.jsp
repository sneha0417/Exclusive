<%@page import="com.project.execution.projectproInvoice.ClsProjectProInvoiceDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsProjectProInvoiceDAO DAO= new ClsProjectProInvoiceDAO(); %>
 <%
 String gridload=request.getParameter("gridload")==null?"0":request.getParameter("gridload").trim().toString(); 
 String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString();
 
 %>
    <script type="text/javascript">
    var servdata;
    var gridload='<%=gridload%>';
    var docno='<%=docno%>';
    
  <%--   if(docno>0){
		
    	servdata = '<%=DAO.serviceGridLoad(session,docno)  %>';
    	
  } --%>
    
    
        $(document).ready(function () { 	
         var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'stype' , type: 'String' },
                          	{name : 'stypeid' , type: 'String' },
     						{name : 'item', type: 'String'  },
                          	{name : 'qty', type: 'String'  },
     						{name : 'amount', type: 'String'  },
     						{name : 'total', type: 'String'  },
     						{name : 'desc1', type: 'String'  },
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
            $("#expenseGrid").jqxGrid(
            {
                width: '100%',
                height: 170,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                disabled:true,
                selectionmode: 'singlerow',
                editable:true,
                sortable: true,
              //  hidden:true,
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Description', datafield: 'stype', width: '40%' },
					{ text: 'stypeid', datafield: 'stypeid', width: '10%',hidden:true},
					{ text: 'Qty', datafield: 'item', width: '10%'},
					{ text: 'Unit price', datafield: 'qty', width: '10%' },
					{text: 'Total',datafield:'amount',width:'36%'},
					
					
					]
            });
            
            $("#expenseGrid").jqxGrid('addrow', null, {});
            if(($('#mode').val()=='A')||($('#mode').val()=='E'))
    		{
    		  $("#expenseGrid").jqxGrid({ disabled: false}); 
    		}
            $("#expenseGrid").on('cellvaluechanged', function (event) 
                    {
            	 var rowBoundIndex = event.args.rowindex;
            	 var rows = $('#expenseGrid').jqxGrid('getrows');
                 var rowlength= rows.length;
                 if(rowBoundIndex == rowlength - 1)
                  {  
                 $("#expenseGrid").jqxGrid('addrow', null, {});
                  } 
                     });
        
           
        });
    </script>
    <div id="expenseGrid"></div>
