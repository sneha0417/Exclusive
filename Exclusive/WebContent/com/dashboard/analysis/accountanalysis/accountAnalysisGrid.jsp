<%@page import="com.dashboard.analysis.accountanalysis.ClsAccountAnalysis" %>
<%ClsAccountAnalysis caa=new ClsAccountAnalysis(); %>


<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
	 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();  
	 String frequencyType = request.getParameter("frequencytype")==null||request.getParameter("frequencytype")==""?"0":request.getParameter("frequencytype").trim();
	 String noOfDays = request.getParameter("noofdays")==null||request.getParameter("noofdays")==""?"0":request.getParameter("noofdays").trim();
	 String check = request.getParameter("check")==null?"0":request.getParameter("check");%>  
	 
<style type="text/css">
        .headClass
        {
            background-color: #FFEBC2;
        }
        .redClass
        {
            background-color: #FFEBEB;
        }
        .violetClass
        {
            background-color: #EBD6FF;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .whiteClass
        {
           background-color: #FFF;
        }
        .greenClass
        {
           background-color: #CEFFCE;
        }
        
</style>

 <script type="text/javascript">
 
 		var temp='<%=branchval%>';
 		var temp1='<%=fromDate%>';
 		var temp2='<%=toDate%>';
 		var check='<%=check%>';
 		
 		$(document).ready(function () {
			var data ="";
 			
 			if(check=='1'){
 			   data = '<%=caa.analysisGrid(branchval, fromDate, toDate, frequencyType, noOfDays, check)%>';  
			}else {
 			   data = '[{"columns":[{"text":"Id","datafield":"id","cellsAlign":"center","align":"center","hidden":"true"},{"text":"Parent Id","datafield":"parentid","cellsAlign":"center","align":"center","hidden":"true"},{"text":"Ord No","datafield":"ordno","cellsAlign":"center","align":"center","hidden":"true"},{"text":"Group No","datafield":"groupno","cellsAlign":"center","align":"center","hidden":"true"},{"text":"Group Id","datafield":"gp_id","cellsAlign":"center","align":"center","hidden":"true"},{"text":"Account","datafield":"subac","cellsAlign":"center","align":"center","hidden":"true"},{"text":"Description","datafield":"description","cellsAlign":"left","align":"left","width":"70%","cellclassname":"whiteClass"},{"text":"","datafield":"amount0","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"30%","cellclassname":"whiteClass"}]},{"rows":[{"id":"1","ordno":"5","groupno":"0","gp_id":"11","subac":"0","description":"","amount0":""}]}]';
 			}
			
            var obj = $.parseJSON(data);
            var columns = obj[0].columns;
            var	rows = obj[1].rows;
            	
           	/*$("#btnExcel").click(function () {
   	            $("#analysisGrid").jqxTreeGrid('exportData', 'xls');
   	        });*/
 			
            var source =
            {
                datatype: "json",
                datafields: [
                    
                    { name: "id", type: "number" },
                    { name: 'description', type: "string" },
                    { name: 'total', type: "number" },
                    { name: 'amount0', type: "number" },
                    { name: 'amount1', type: "number" },
                    { name: 'amount2', type: "number" },
                    { name: 'amount3', type: "number" },
                    { name: 'amount4', type: "number" },
                    { name: 'amount5', type: "number" },
                    { name: 'amount6', type: "number" },
                    { name: 'amount7', type: "number" },
                    { name: 'amount8', type: "number" },
                    { name: 'amount9', type: "number" },
                    { name: 'amount10', type: "number" },
                    { name: 'amount11', type: "number" },
                    { name: 'amount12', type: "number" },
                    { name: 'amount13', type: "number" },
                    { name: 'amount14', type: "number" },
                    { name: 'amount15', type: "number" },
                    { name: 'amount16', type: "number" },
                    { name: 'amount17', type: "number" },
                    { name: 'amount18', type: "number" },
                    { name: 'amount19', type: "number" },
                    { name: 'amount20', type: "number" },
                    { name: 'amount21', type: "number" },
                    { name: 'amount22', type: "number" },
                    { name: 'amount23', type: "number" },
                    { name: 'amount24', type: "number" },
                    { name: 'amount25', type: "number" },
                    { name: 'amount26', type: "number" },
                    { name: 'amount27', type: "number" },
                    { name: 'amount28', type: "number" },
                    { name: 'amount29', type: "number" },
                    { name: 'amount30', type: "number" },
                    { name: "parentid", type: "number" },
                    { name: "ordno", type: "number" },
                    { name: "groupno", type: "number" },
                    { name: "subac", type: "number" },
                    { name: "gp_id", type: "number" }
                ],
                hierarchy:
                {
                    keyDataField: { name: "id" },
                    parentDataField: { name: "parentid" }
                },
                id: "id",
                localdata: rows
            };
           
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#analysisGrid").jqxTreeGrid(
            {
                width: '99.5%',
                height: 510,
                source: dataAdapter,
                columnsresize: true,
                columns: columns,
                ready: function() 
                {
                	var rows = $("#analysisGrid").jqxTreeGrid('getRows');
                	for(var i=1;i <= rows.length; i++){
                		$("#analysisGrid").jqxTreeGrid('expandRow',rows[i-1].id);
                	}
                }, 
            });
            
			$("#overlay, #PleaseWait").hide();
            
            $('#analysisGrid').on('rowDoubleClick', function (event) {
                var row = event.args.row;      
                var desc= "Account Analysis"; 
                var accdocno="";
          	    if(row.ordno == 6)
          	    {
          	        var url=document.URL;
					var reurl=url.split("com/");
					
					accdocno=row.subac;
					var detName=row.description;
					var path="com/dashboard/analysis/accountanalysis/accountDetails.jsp";
					top.addTab( detName,reurl[0]+""+path+"?name="+detName.replace(/ /g, "%20")+"&main="+desc.replace(/ /g, "%20")+"&branchval="+temp+'&fromdate='+temp1+'&todate='+temp2+'&accdocno='+accdocno);
          		}
          	    
              });
             
        });
 		
    </script>

    <div id="analysisGrid"></div>
