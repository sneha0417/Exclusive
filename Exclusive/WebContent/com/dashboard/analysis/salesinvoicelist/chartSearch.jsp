<%@page import="com.dashboard.analysis.salesinvoice.ClsSalesInvoiceDAO" %>
<% ClsSalesInvoiceDAO csd=new ClsSalesInvoiceDAO();%>


<%String id=request.getParameter("id")==null?"0":request.getParameter("id");
	String grpby1=request.getParameter("grpby1")==null?"0":request.getParameter("grpby1");
	String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
	String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
	String branch=request.getParameter("branch")==null?"a":request.getParameter("branch");
%>
 
<script type="text/javascript">
        $(document).ready(function () {
            // prepare chart data as an array

            var data  =<%=csd.getChart(grpby1,  fromdate,  todate,  branch,id)%>;
 var source =
            {
                datatype: "json",
                datafields: [
                    { name: 'amount' },
                    { name: 'description' }
                ],
                localdata: data
            };
            var dataAdapter = new $.jqx.dataAdapter(source, { async: false, autoBind: true,loadComplete: function () {
                $("#loadingImage").css("display", "none");
            },loadError: function (xhr, status, error) { alert('Error loading "' + source.url + '" : ' + error); } });
            // prepare jqxChart settings
            var settings = {
                title: "Sales Analysis",
                description: "",
                enableAnimations: true,
                showLegend: true,
                showBorderLine: true,
                legendLayout: { left: 450, top: 50, width: 330, height: 400, flow: 'vertical' },
                padding: { left: 5, top: 5, right: 275, bottom: 0 },
                titlePadding: { left: 0, top: 0, right: 0, bottom: 10 },
                source: dataAdapter,
                colorScheme: 'scheme02',
                seriesGroups:
                    [
                        {
                            type: 'pie',
                            showLabels: true,
                            series:
                                [
                                    { 
                                        dataField: 'amount',
                                        displayText: 'description',
                                        labelRadius: 120,
                                        initialAngle: 15,
                                        radius: 170,
                                        centerOffset: 0,
                                       
                                        formatFunction: function (value, itemIdx, serieIndex, groupIndex) {
                                            if (isNaN(value))
                                                return value;
                                            return value;
                                        }
                                    }
                                ]
                        }
                    ]
            };
            
            	
            
            // setup the chart
            $('#saleschart1').jqxChart(settings);
            
        });
    </script>
     
<div id='saleschart1'  style="width: 700px; height: 400px;"></div>