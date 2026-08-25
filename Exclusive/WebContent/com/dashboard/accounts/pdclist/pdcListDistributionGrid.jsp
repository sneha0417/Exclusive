<%@page import="com.dashboard.accounts.pdclist.ClsPdcList"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%ClsPdcList DAO= new ClsPdcList(); %>
<% String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
   String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate");
   String branch = request.getParameter("branchval")==null?"NA":request.getParameter("branchval");
   String criteria = request.getParameter("criteria")==null?"0":request.getParameter("criteria");
   String reporttype = request.getParameter("reporttype")==null?"0":request.getParameter("reporttype");
   String code = request.getParameter("code")==null?"0":request.getParameter("code");
   String distribution = request.getParameter("distribution")==null?"0":request.getParameter("distribution");
   String group = request.getParameter("group")==null?"0":request.getParameter("group");
   String accType = request.getParameter("acctype")==null?"0":request.getParameter("acctype");
   String accId = request.getParameter("accno")==null?"0":request.getParameter("accno");
   String unclrPosted = request.getParameter("unclrposted")==null?"0":request.getParameter("unclrposted");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>
   
 <script type="text/javascript">
 	   var check='<%=check%>';
 	   var grouping='<%=group%>';
 	   var distribute='<%=distribution%>';
 	 
 	   $(document).ready(function () {
 	    var data3;
 	    if(check=='2'){
 	    	 data3='<%=DAO.pdcListDistributionpGridLoading(branch, reporttype, fromDate, toDate, criteria, distribution, group, code, accType, accId, unclrPosted, check)%>'; 
 	    }else{
 	     	data3 = '[{"columns":[{"text":"Sr No.","datafield":"id","cellsAlign":"center","align":"center","width":"5%","cellclassname":""},{"text":"Description","datafield":"description","cellsAlign":"left","align":"left","cellclassname":""},{"text":"Amount","datafield":"amount","cellsAlign":"right","align":"right","width":"10%","cellsFormat":"d2","cellclassname":""}]},{"rows":[{"id":"1","description":"","amount":""}]}]';
 	    }        
 	        
 	    	var obj = $.parseJSON(data3);
            var columns = obj[0].columns;
            var rows = obj[1].rows;
 			
            var source =
            {
                datatype: "json",
                datafields: [
                    	{name : 'id',type:'number'},
                    	{ name: 'description',type:'string'},
                    	{ name: 'amount0',type:'number'},
                    	{ name: 'amount1',type:'number'},
                    	{ name: 'amount2',type:'number'},
                    	{ name: 'amount3',type:'number'},
                    	{ name: 'amount4',type:'number'},
                    	{ name: 'amount5',type:'number'},
                    	{ name: 'amount6',type:'number'},
                    	{ name: 'amount7',type:'number'},
                    	{ name: 'amount8',type:'number'},
                    	{ name: 'amount9',type:'number'},
                    	{ name: 'amount10',type:'number'},
                    	{ name: 'amount11',type:'number'},
                    	{ name: 'amount12',type:'number'},
                    	{ name: 'amount13',type:'number'},
                    	{ name: 'amount14',type:'number'},
                    	{ name: 'amount15',type:'number'},
                    	{ name: 'amount16',type:'number'},
                    	{ name: 'amount17',type:'number'},
                    	{ name: 'amount18',type:'number'},
                    	{ name: 'amount19',type:'number'},
                    	{ name: 'amount20',type:'number'},
                    	{ name: 'amount21',type:'number'},
                    	{ name: 'amount22',type:'number'},
                    	{ name: 'amount23',type:'number'},
                    	{ name: 'amount24',type:'number'},
                    	{ name: 'amount25',type:'number'},
                    	{ name: 'amount26',type:'number'},
                    	{ name: 'amount27',type:'number'},
                    	{ name: 'amount28',type:'number'},
                    	{ name: 'amount29',type:'number'},
                    	{ name: 'amount30',type:'number'}
                    	
                ],
                id: 'id',
                localdata: rows
            };
           
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxDistributionGrid").jqxGrid(
            {
                width: '98%',
                height: 510,
                source: dataAdapter,
                columnsresize: true,
                columns: columns,
                showstatusbar:true,
                showaggregates:true,
            });
            
			$("#overlay, #PleaseWait").hide();
             
 });
 		
</script>

<div id="jqxDistributionGrid"></div>
