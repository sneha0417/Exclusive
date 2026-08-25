<%@page import="com.common.ClsExeFolio" %>
<%ClsExeFolio cef=new ClsExeFolio(); %>

<!DOCTYPE html>
<% String contextPath=request.getContextPath();%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<style>
.redClass
{
   color: #FF0000;            
}
</style>

<script type="text/javascript">
 	
$(document).ready(function () {
	
    /* Partial Pie Chart Starts*/
    
    var data  =<%=cef.ApprovalStatus()%>;
    
    var dataStatCounter = data;

    var charts = [
        { title: '', label: 'Stat', dataSource: dataStatCounter }
    ];
    for (var i = 0; i < charts.length; i++) {
        var chartSettings = {
            source: charts[i].dataSource,
            title: 'Approval Status',
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
                                dataField: 'per',
                                displayText: 'level',
                                showLabels: true,
                                labelRadius: 140,
                                labelLinesEnabled: true,
                                labelLinesAngles: true,
                                labelsAutoRotate: false,
                                initialAngle: 0,
                                radius: 110,
                                minAngle: 0,
                                maxAngle: 360,
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
        var selector = '#approvalStatus' + (i + 1);
        $(selector).jqxChart(chartSettings);
    }
});
        
    </script>
    
    
</head>
<body >
<!-- <div class='hidden-scrollbar'> -->


	<table width="100%">

		<tr>
			<td colspan="2" align="center"><h2>
					<b>Executive Management Folio</b>
				</h2></td>
		</tr>
		<tr>
			<td width="35%"><div id="approvalGrid"><jsp:include
						page="approvalGrid.jsp"></jsp:include></div></td>
			<td width="65%" rowspan="2"><div id="approvalData"><jsp:include
						page="approvalData.jsp"></jsp:include></div></td>
		</tr>
		<tr>
			<td><div id='approvalStatus1'
					style="width: 100%; height: 300px;"></div></td>
		</tr>
	</table>
	<!-- </div>  -->

</body>
</html>