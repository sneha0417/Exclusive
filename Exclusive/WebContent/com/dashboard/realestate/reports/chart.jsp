<%@page import="com.dashboard.realestate.reports.ClsReportsDAO"%>
<% ClsReportsDAO DAO= new ClsReportsDAO(); %>
<% String id =request.getParameter("id")==null?"0":request.getParameter("id").toString(); %>
<script type="text/javascript">
       
       var data2;
        data2='<%=DAO.getchartData(id)%>';      
            
     $(document).ready(function () {
         // prepare chart data as an array
         var source =
	            {
	                datatype: "json",
	                datafields: [
						    {name : 'type'},
							{name : 'total' },
							{name : 'available'},
							{name : 'contract'},
							{name : 'forsale'},
	                ],
	                localdata: data2
	            };
	            
	            var dataAdapter = new $.jqx.dataAdapter(source,
	            		 {
	            	        async: false,
	            	        autoBind: true,
	                		loadError: function (xhr, status, error) {
		                    alert(error);       
		                    }
				            
			            } );
         // prepare jqxChart settings
         var settings = {
             title: "Availability Analysis",
             description: "",
			 enableAnimations: true,
             showLegend: true,
             padding: { left: 5, top: 5, right: 5, bottom: 5 },
             titlePadding: { left: 90, top: 0, right: 0, bottom: 10 },
             source: dataAdapter,
             xAxis:
                 {
                     dataField: 'type',
                     showGridLines: true
                 },
             colorScheme: 'scheme01',
             seriesGroups:
                 [
                     {
                         type: 'column',
                         columnsGapPercent: 50,
                         seriesGapPercent: 0,
                         valueAxis:
                         {
                             unitInterval: 100,
                             displayValueAxis: true,
                             description: 'Count',
                             axisSize: 'auto',
                             tickMarksColor: '#888888'
                         },
                         series: [
									{ dataField: 'total', displayText: 'Total'},
									{ dataField: 'available', displayText: 'Available'},
									{ dataField: 'contract', displayText: 'Contract'},
									{ dataField: 'forsale', displayText: 'For sale'},
                             ]
                     }
                 ]
         };
         
         // setup the chart
         $('#reportchart').jqxChart(settings);
     });
 </script>
	<div id='reportchart' style="width:100%; height:300px;">  
	</div>