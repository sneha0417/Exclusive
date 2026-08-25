<%@page import="customerlogin.ClsCustomerLoginDAO"%>
<% String contextPath=request.getContextPath();%>
 <%@page import="javax.servlet.http.HttpServletRequest" %>
 <%@page import="javax.servlet.http.HttpSession" %>
<%ClsCustomerLoginDAO dao=new ClsCustomerLoginDAO();%>
 <% String fromdate =request.getParameter("fromdate")==null?"":request.getParameter("fromdate").toString();%>
 <% String todate =request.getParameter("todate")==null?"":request.getParameter("todate").toString();%>
 <% String id =request.getParameter("id")==null?"":request.getParameter("id").toString();%>
 <script type="text/javascript">
         var data='<%=dao.getTicketPivotData(fromdate,todate,id,session)%>';
	     $(document).ready(function () { 
	    	 var rendererstring1=function (aggregates){  
	             	var value=aggregates['sum'];
	             	if(typeof(value) == "undefined"){
	             		value=0.00;
	             	}
	             	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
	             }
            // create a data source and data adapter
            var source =
            {
                localdata: data,  
                datatype: "json",
                datafields:
                [
					 {name : 'ticketno', type: 'String' },
					 {name : 'guest', type: 'String' },
					 {name : 'issuedate', type: 'date' },
					 {name : 'bookdate',type: 'date' },
					 {name : 'name',type: 'string' },
					 {name : 'sector',type: 'string' },
					 {name : 'class', type: 'string' },
					 {name : 'prnno',type: 'string' },   
					 {name : 'sprice',type: 'number' }
                ]
            };
            var dataAdapter = new $.jqx.dataAdapter(source);
            dataAdapter.dataBind();
            // create a pivot data source from the dataAdapter
            var pivotDataSource = new $.jqx.pivot(
                dataAdapter,
                {
                    customAggregationFunctions: {
                        'var': function (values) {
                            if (values.length <= 1)
                                return 0;
                            // sample's mean
                            var mean = 0;
                            for (var i = 0; i < values.length; i++)
                                mean += values[i];
                            mean /= values.length;
                            // calc squared sum
                            var ssum = 0;
                            for (var i = 0; i < values.length; i++)
                                ssum += Math.pow(values[i] - mean, 2)
                            // calc the variance
                            var variance = ssum / values.length;
                            return variance;
                        }
                    },
                    pivotValuesOnRows: false,
                    fields: [
                         { dataField: 'ticketno', text: 'Ticket No'},
                         { dataField: 'guest', text: 'Guest'},
                         { dataField: 'issuedate', text: 'Issue Date'},
                         { dataField: 'bookdate', text: 'Book Date' },
                         { dataField: 'name', text: 'Airline'},
                         { dataField: 'sector', text: 'Sector'},
                         { dataField: 'class', text: 'Class'},
                         { dataField: 'prnno', text: 'PRN No' },
                         { dataField: 'sprice', text: 'Selling Price' }
                    ],
                    rows: [
							{ dataField: 'name', text: 'Airline'}, //width:400   
						
                    ],
                    columns: [
                            
                              /*{ dataField: 'sertype', text: 'Service Type' },*/
                          
                              ],
                    values: [
                             { dataField: 'sprice', text: 'Selling Price','function': 'sum', align: 'right', formatSettings: { decimalPlaces: 2, align: 'right' }, cellsClassName: 'myItemStyle', cellsClassNameSelected: 'myItemStyleSelected' }
                      ]         
                });
            var localization = { 'var': 'Variance' };        
            // create a pivot grid
            $('#pivotInvoiceGrid').jqxPivotGrid(
            {
                localization: localization,
                source: pivotDataSource,
                treeStyleRows: true,
                autoResize: false,   
                multipleSelectionEnabled: true,
            });
            var pivotGridInstance = $('#pivotInvoiceGrid').jqxPivotGrid('getInstance');
            // create a pivot grid
            $('#divPivotGridDesigner').jqxPivotDesigner(
            {
                type: 'pivotGrid',
                target: pivotGridInstance
            });
      	  $("#overlay, #PleaseWait").hide();
        });
    </script>
    <table>
        <tr>
            <td>
                <div id="divPivotGridDesigner" style="height: 400px; width: 250px;">
                </div>
            </td>
            <td>
                <div id="pivotInvoiceGrid" style="height: 500px; width: 1050px;">
                </div>
            </td>
        </tr>
    </table>
       <div id="pivotInvoiceGrid"></div>