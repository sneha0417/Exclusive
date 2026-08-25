<%@page import="com.dashboard.analysis.salesinvoice.ClsSalesInvoiceDAO" %>
<% ClsSalesInvoiceDAO csd=new ClsSalesInvoiceDAO();%>


<%   String branch = request.getParameter("branchval")==null?"":request.getParameter("branchval").trim();
	 String fromdate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
	 String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
	 String cmbfrequency =request.getParameter("distribution")==null?"2":request.getParameter("distribution").trim();
	 String noOfDays = "0";
	 String check = request.getParameter("check")==null?"0":request.getParameter("check");
	 String grpby1=request.getParameter("grpby1")==null?"":request.getParameter("grpby1");
	 String hidbrand=request.getParameter("hidbrand")==null?"":request.getParameter("hidbrand");
	 String hidmodel=request.getParameter("hidmodel")==null?"":request.getParameter("hidmodel");
	 String hidgroup=request.getParameter("hidgroup")==null?"":request.getParameter("hidgroup");
	 String hidyom=request.getParameter("hidyom")==null?"":request.getParameter("hidyom");
	 String hidclientcat=request.getParameter("hidclientcat")==null?"":request.getParameter("hidclientcat");
	 String hidclient=request.getParameter("hidclient")==null?"":request.getParameter("hidclient");
	 String hidsalesman=request.getParameter("hidsalesman")==null?"":request.getParameter("hidsalesman");
	 String hidrentalagent=request.getParameter("hidrentalagent")==null?"":request.getParameter("hidrentalagent");
	 %>
 <%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<style type="text/css">
       .headClass
        {
            background-color: #FFEBC2;
        }
        .openingClass
        {
            background-color: #FFFFD1;
        }
        .invoiceClass
  	    {	
	      background-color: #FBEFF5;
	    }
	    .receiptClass
	    {
	      background-color: #E0F8F1;
	    }
</style>

 <script type="text/javascript">

 		var check='<%=check%>';
 	   
 	   $(document).ready(function () {
 	    var data;
 	    if(check=='1'){
 	          data = '<%=csd.analysisGrid(branch,fromdate,todate,cmbfrequency,noOfDays,check,grpby1,hidbrand,hidmodel,hidgroup,hidyom,hidclientcat,hidclient,hidsalesman,hidrentalagent)%>';     
 	          // alert(data);
 	    }else{
 	     data = '[{"columns":[{"text":"Sr No.","datafield":"id","cellsAlign":"center","align":"center","width":"5%","cellclassname":""},{"text":"Ref No.","datafield":"refno","cellsAlign":"center","align":"center","width":"10%","cellclassname":""},{"text":"Description","datafield":"description","cellsAlign":"left","align":"left","cellclassname":""},{"text":"Total","datafield":"amount","cellsAlign":"right","align":"right","width":"10%","cellsFormat":"d2","cellclassname":""}]},{"rows":[{"id":"1","refno":"","description":"","amount":""}]}]';

 	    }        
 	    	var obj = $.parseJSON(data);
            var columns = obj[0].columns;
           // var columngroups = obj[1].columngroups; 
            var rows = obj[1].rows;
 			
            var source =
            {
                datatype: "json",
                datafields: [
                    	{name : 'id',type:'number'},
                    	{ name: 'refno',type:'number'},
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
            /*   var rendererstring=function (aggregates){
            	var value=aggregates['sum'];
            	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + '' + value + '</div>';
            }  */ 
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#distributionGrid").jqxGrid(
            {
                width: '99.5%',
                height: 515,
                source: dataAdapter,
                columnsresize: true,
                columns: columns,
                showstatusbar:true,
                showaggregates:true,
                //columngroups: columngroups
            });
            
			$("#overlay, #PleaseWait").hide();
             
        });
 		
</script>

<div id="distributionGrid"></div>
