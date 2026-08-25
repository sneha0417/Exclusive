<%@page import="com.dashboard.ClsDashBoardDAO"%>
<%
	ClsDashBoardDAO DAO = new ClsDashBoardDAO();
%>
<!DOCTYPE html>
<%
	String contextPath = request.getContextPath();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>

<style>
.redClass {
	color: #FF0000;
}

.nopadding {
	padding: 0 !important;
	margin: 0 !important;
}
</style>

<script type="text/javascript">
/*function addTab(title, url){
	if ($('../../menu.jsp #tt').tabs('exists', title)){
		alert("exist");
		$('../../menu.jsp #tt').tabs('select', title);
	} else {
		alert("addtab"); 
	 var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
		$('../../menu.jsp #tt').tabs('add',{
			title:title,
			content:content,
			closable:true
			/* showCloseButtons: true 
		 });
		alert("ens");
	} 
}
*/
        
        $(document).ready(function () {
        	
        	//$('#db').hide();
        	$("#btnPrevious").hide();$("#btnRemove").hide();$('#hidbrandgarage').val('Veh. in Garage - Brand Wise');
            /* Partial Pie Chart Starts*/
            
           <%--  var data  = <%=DAO.maintainrequeststatus()%>; --%>
           var data  = <%=DAO.PropertyAvailbilityForChart()%>;
            
           // console.log(data);
            var dataStatCounter = data;
        
            var charts = [
                { title: '', label: 'Stat', dataSource: dataStatCounter }
            ];
            for (var i = 0; i < charts.length; i++) {
                var chartSettings = {
                    source: charts[i].dataSource,
                    title: 'Property Availability',
                    description: charts[i].title,
                    enableAnimations: false,
                    showLegend: true,
                    showBorderLine: true,
                    padding: { left: 5, top: 5, right: 5, bottom: 5 },
                    titlePadding: { left: 0, top: 0, right: 0, bottom: 10 },
                    colorScheme: 'scheme02',
                    seriesGroups: [
                        {
                            type: 'pie',
                            showLegend: true,
                            enableSeriesToggle: true,
                            series:
                                [
                                    {
                                        dataField: 'available',
                                        displayText: 'stat',
                                        showLabels: true,
                                        labelRadius: 140,
                                        labelLinesEnabled: true,
                                        labelLinesAngles: true,
                                        labelsAutoRotate: false,
                                        initialAngle: 0,
                                        radius: 110,
                                        minAngle: 0,
                                        maxAngle: 180,
                                        centerOffset: 0,
                                        offsetY: 110,
                                        formatFunction: function (value, itemIdx, serieIndex, groupIndex) {
                                            if (isNaN(value))
                                                return value;
                                            return value + '%';
                                        }
                                    }
                                ]
                        }
                    ]
                };
                // select container and apply settings
                var selector = '#contractStatus' + (i + 1);
                $(selector).jqxChart(chartSettings);
            } // for
            
           /* Partial Pie Ends */
            
            /* Bar Chart Starts */
            /* ----------------------------------- */
            var data10= '<%=DAO.TenancyContractExpiry()%>';
            var source =
            {
                datatype: "json",
                datafields: [
                    { name: 'count1' },
                    { name: 'validupto1' }
                  //  { name: 'ins_exp1' }
                    /* { name: 'doc_no' } */
                ],
                localdata: data10
            };
            
            // prepare chart data as an array            
            
           var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            } );
           
           // prepare jqxChart settings
            var settings = {
                title: "Teanancy Contract Expiry",
                description: "",
                showLegend: true,
                enableAnimations: true,
                padding: { left: 5, top: 5, right: 5, bottom: 5 },
                titlePadding: { left: 90, top: 0, right: 0, bottom: 10 },
                source: dataAdapter,
                xAxis:
                    {
                		//description: 'Count of Vehicles',
                        dataField: 'count1',
                        showGridLines: true
                    },
                colorScheme: 'scheme02',
                seriesGroups:
                    [
                        {
                            type: 'column',
                            columnsGapPercent: 15,
                            seriesGapPercent: 10,
                            columnsMaxWidth: 20,
                            columnsMinWidth: 1,
                            valueAxis:
                            {
                                displayValueAxis: true,
                                description: ' Days'
                            },
                            series: [
                                    { dataField: 'validupto1', displayText: 'Expiry'},
                                 //   { dataField: 'ins_exp1', displayText: 'Ins. Expiry' }
                                ]
                        }
                    ]
            };
            // setup the chart
            $('#regInsExpiry').jqxChart(settings);
            /* -------------------------------------- */
            /* Bar Chart Ends */
            
            /* Color change Chart Starts */
            /* ------------------------------------------ */
            <%-- var data4= '<%= DAO.idleDays() %>';
            var source =
            {
                datatype: "json",
                datafields: [
                    { name: 'idledays' },
                    { name: 'noofvehicles' }
                ],
                localdata: data4
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            } );
            
            settings = {
                title: "Idle Days",
                description: "",
                borderLineWidth: 1,
                showBorderLine: true,
                enableAnimations: true,
                showLegend: false,
                padding: { left: 5, top: 5, right: 10, bottom: 5 },
                titlePadding: { left: 0, top: 0, right: 0, bottom: 10 },
                source: dataAdapter,
                categoryAxis:
                {
                    description: 'Days',
                    dataField: 'idledays',
                    textRotationAngle: -75,
                    formatFunction: function (value, itemIndex, serie, group) {
                        return value;
                    },
                    valuesOnTicks: false
                },
                colorScheme: 'scheme05',
                seriesGroups:
                [
                    {
                        type: 'line',
                        valueAxis:
                        {
                            description: 'No. of Vehicles',
                            formatFunction: function (value) {
                                return value /* + '%' */;
                            }
                        },
                        series:
						    [
                                {
                                    dataField: 'noofvehicles',
                                    displayText: 'No. of Days',
                                    // Modify this function to return desired colors.
                                    // jqxChart will call the function for each data point.
                                    // Sequential points that have the same color will be
                                    // grouped automatically in a line segment
                                    colorFunction: function (value, itemIndex, serie, group) {
                                        return (value < 0) ? '#FF0000' : '#00FF00';
                                    }
                                }
                            ]
                    }
                ]
            };
            $("#idleDays").jqxChart(settings);  --%>
            /* -------------------------------- */
            /* Color change Chart Ends */
            
            /* Ready To Rent starts */
            /* ------------------------- */
         <%--   var data3= '<%= DAO.readyToRents() %>';
            
	        $(document).ready(function () {
	            // prepare chart data as an array            
	            var source =
	            {
	                datatype: "json",
	                datafields: [
	                    { name: 'availability' },
	                    { name: 'gname' }
	                ],
	                localdata: data3
	            };
	            
	            var dataAdapter = new $.jqx.dataAdapter(source,
	            		 {
	                		loadError: function (xhr, status, error) {
		                    alert(error);    
		                    }
				            
			            } );
	            
	            // prepare jqxChart settings
	            var settings = {
	                title: "Schedule Status",
	                description: "",
	                showLegend: true,
	                enableAnimations: true,
	                padding: { left: 5, top: 5, right: 5, bottom: 5 },
	                titlePadding: { left: 90, top: 0, right: 0, bottom: 5 },
	                source: dataAdapter,
	                xAxis:
	                    {
	                        dataField: 'gname',
	                        //textRotationAngle: -75,
	                        gridLines: { visible: false },
	                        showGridLines: false,
	                        valuesOnTicks: false,
	                    },
	                colorScheme: 'scheme04',
	                columnSeriesOverlap: false,
	                seriesGroups:
	                    [
	                        {
	                            type: 'column',
	                            columnsGapPercent: 15,
	                            seriesGapPercent: 10,
	                            columnsMaxWidth: 20,
	                            columnsMinWidth: 1,
	                            skipOverlappingPoints: false,
	                            valueAxis:
	                            {
	                                visible: true,
	                                minValue: 0,
	                                description: 'Availabilty',
	                                title: { text: 'Group' },
	                            },
	                            series: [
	                                    { dataField: 'availability', displayText: 'Group' }
	                                ]
	                        }
	                    ]
	            };
	            // setup the chart
	            $('#readyToRent').jqxChart(settings);
	        }); --%>
            /* ------------------------- */
            /* Ready To Rent Ends */
            
            /* Line Chart Starts */
            /* ----------------------- */
           <%--  var data7= '<%= DAO.lineSeriesChart() %>';
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                    /* { name: 'doc_no' }, */
                    { name: 'fleet_no' },
                    { name: 'brdid' },
                    { name: 'vmodid' },
                    { name: 'availabilty' }
                ],
                localdata: data7
            };
             
             var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            } );
            
            // prepare jqxChart settings
            var settings = {
                title: "Idle Days",
                description: "",
                enableAnimations: true,
                showLegend: true,
                padding: { left: 15, top: 5, right: 20, bottom: 5 },
                titlePadding: { left: 10, top: 0, right: 0, bottom: 10 },
                source: dataAdapter,
                categoryAxis:
                    {
                        text: 'Category Axis',
                        textRotationAngle: 0,
                        dataField: 'fleet_no',
                        showTickMarks: true
                        //tickMarksInterval: 1,
                        //tickMarksColor: '#888888',
                        //unitInterval: 5,
                        //showGridLines: true
                        //gridLinesInterval: 5,
                        //gridLinesColor: '#888888',
                        //axisSize: 'auto',
                        //minValue: 1948,
                        //maxValue: 2013,
                        //valuesOnTicks: true
                    },
                colorScheme: 'scheme05',
                seriesGroups:
                    [
                        {
                            alignEndPointsWithIntervals: false,
                            type: 'splinearea',
                            valueAxis:
                            {
                                visible: true,
                                //unitInterval: 20,
                               // maxValue: 200,
                                description: 'Brand & Model'
                            },
                            series: [
                                    { dataField: 'brdid', displayText: 'Brand', opacity: 0.7 },
                                    { dataField: 'vmodid', displayText: 'model', opacity: 0.9 } 
                                ]
                        },
                        {
                            type: 'spline',
                            alignEndPointsWithIntervals: false,
                            valueAxis:
                            {
                                //unitInterval: 0.01,
                                //maxValue: 0.2,
                                //formatSettings: { decimalPlaces: 2},
                                visible: true,
                                showTickMarks: true,
                                //tickMarksInterval: 0.005,
                                tickMarksColor: '#888888',
                                showGridLines: true,
                                //gridLinesInterval: 0.01,
                                description: 'Availabilty',
                                position: 'right',
								visible: false
                            },
                            series: [
                                    { dataField: 'availabilty', displayText: 'Availabilty', opacity: 1.0, lineWidth: 4, dashStyle: '4,4' }
                                ]
                        }
                    ]
            };
            // setup the chart
            $('#idleDays').jqxChart(settings); --%>
            /* ----------------------------------- */
            /* Line Chart Ends */
            
            /* Stacked Chart Starts */
            /* ----------------------------- */
            <%-- var data5= '<%= DAO.stackedchart() %>';
           // alert(data5);  
            var source =
            {
                datatype: "json",
                datafields: [
                    { name: 'dramount' },
                    { name: 'ldramount' }
                ],
                 localdata: data5
            }; 
            
            var dataAdapter = new $.jqx.dataAdapter(source,
              		 {
                  		loadError: function (xhr, status, error) {
   	                    alert(error);    
   	                    }
   			            
   		            } );
            
            var settings = {
                 title: "Amounts",
                 //description: "Amounts",
                 padding: { left: 5, top: 5, right: 5, bottom: 5 },
                 titlePadding: { left: 0, top: 0, right: 0, bottom: 10 },
                 source: dataAdapter,
                 enableAnimations: true,
                 xAxis:
                         {
                             dataField: '',
                             description: '',
                             showGridLines: true,
                             showTickMarks: true
                         },
                 seriesGroups:
                         [
                             {
                             type: 'stackedcolumn',
                             columnsGapPercent: 100,
                             valueAxis: {
                                 description: 'Value',
                                 logarithmicScale: true,
                                 logarithmicScaleBase: 2,
                                 unitInterval: 1,
                                 tickMarksInterval: 1,
                                 gridLinesInterval: 1,
                                 formatSettings: { decimalPlaces: 3 },
                                 horizontalTextAlignment: 'right'
                             },
                             series: [
                                         { dataField: 'dramount', displayText: 'Dr Amount' },
                                         { dataField: 'ldramount', displayText: 'Ldr Amount' }
                                     ]
                             }
                         ]
             };
             $('#stackedChart').jqxChart(settings); --%>
             /* ------------------------------------------ */
             /* Stacked Chart Ends */
            
/* sheduled status starts */

    
           <%--   var data10= '<%=DAO.scheduleStatus()%>'; --%>
           var data10= '<%=DAO.maintainrequeststatus()%>';
             
             var source =
             {
                 datatype: "json",
                 datafields: [
                     { name: 'stat' },
                     { name: 'per' },
                      
                 ],
                 localdata: data10
             };
             
             // prepare chart data as an array            
             
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
 	                    alert(error);    
 	                    }
 			            
 		            } );
            
            // prepare jqxChart settings
             var settings = {
                 title: "Maintenane Request Status",
                 description: "",
                 showLegend: true,
                 enableAnimations: true,
                 padding: { left: 5, top: 5, right: 5, bottom: 5 },
                 titlePadding: { left: 90, top: 0, right: 0, bottom: 10 },
                 source: dataAdapter,
                 xAxis:
                     {
                 		//description: 'Count of Vehicles',
                         dataField: 'stat',
                         showGridLines: true
                     },
                 colorScheme: 'scheme01',
                 seriesGroups:
                     [
                         {
                             type: 'column',
                             columnsGapPercent: 15,
                             seriesGapPercent: 10,
                             columnsMaxWidth: 20,
                             columnsMinWidth: 1,
                             valueAxis:
                             { 
                                 displayValueAxis: true,
                                 description: ' Numbers' 
                             },
                             series: [
                                     { dataField: 'per', displayText: 'Value'},
                                      
                                 ]
                         }
                     ]
             };
             // setup the chart
             $('#schedulestatus').jqxChart(settings);

/* scheduled status ends */


        });
        
		function getMessengerCount() {
		var x=new XMLHttpRequest();
		var msgcnt;
		var user;
		x.onreadystatechange=function(){
			
			if (x.readyState==4 && x.status==200)
				{
				
					items= x.responseText;
				
					items=items.trim().split('####');
					user=items[0];
					msgcnt=items[1];
		
						if(msgcnt>0){
							window.parent.document.getElementById("iconnm").style.display = 'none';
							window.parent.document.getElementById("iconym").style.display = 'inline-block';
						}
						else{
							window.parent.document.getElementById("iconym").style.display = 'none';
							window.parent.document.getElementById("iconnm").style.display = 'inline-block';
		
						}
					
				    
				}
			else
				{
				}
		}
		x.open("GET",<%=contextPath + "/"%>+"com/messenger/getMsgCount.jsp",true);
		x.send();
	}
	
    </script>

<style>
.hidden-scrollbar {
	overflow: auto;
	height: 580px;
}
</style>


</head>
<body style="background-color: #fff;" onclick="getMessengerCount();">
	<div class='hidden-scrollbar'>
		<div class="row nopadding">
			<div class="col-md-4  ">
				<div id='contractStatus1' style="width: 100%; height: 190px;"></div>
				<div id='schedulestatus' style="width: 100%; height: 170px;"></div>
				<div id='regInsExpiry' style="width: 100%; height: 170px;"></div>
			</div>
			<div class="col-md-5 nopadding">
				<center>
					<img src="../../icons/gw.png" onclick="location.reload ();"
						style="width: 50%; height: 30px;">
				</center>
				<div class="col-md-6  "><jsp:include
						page="dashboardGridMaster.jsp"></jsp:include></div>

				<div class="col-md-6 nopadding" id="dashboardGridDetail1"><jsp:include
						page="dashboardGridDetails.jsp"></jsp:include></div>
			</div>
			<div class="col-md-3 nopadding">
			<%-- 	<div id="brandGarageDiv" class="col-md-12"><jsp:include
						page="brandGarageGrid.jsp"></jsp:include></div> --%>
	<div id="brandGarageDiv" class="col-md-12"><jsp:include
						page="propertytypeGrid.jsp"></jsp:include></div>
				<div class="col-md-12">
					<jsp:include page="toDoList.jsp"></jsp:include>
				</div>

			</div>
		</div>
		<input type="hidden" id="hidbrandgarage" name="hidbrandgarage"
			value='<s:property value="hidbrandgarage"/>' />
	</div>

</body>
</html>