<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
	 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	 String rptType = request.getParameter("rptType")==null?"1":request.getParameter("rptType").trim();
	 String chckclient = request.getParameter("chckclient")==null?"0":request.getParameter("chckclient").trim();
	 String chckcategory = request.getParameter("chckcategory")==null?"0":request.getParameter("chckcategory").trim();
	 String chckmonthwise = request.getParameter("chckmonthwise")==null?"0":request.getParameter("chckmonthwise").trim();
	 String check = request.getParameter("check")==null?"1":request.getParameter("check");%>
	 <jsp:include page="../../../../includes.jsp"></jsp:include>
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
 
 		$(document).ready(function () {
 			
 			var data;
 			<%-- '<%=com.dashboard.analysis.salesinvoice.ClsSalesInvoiceDAO.branchwiseGrid(branchval, fromDate, toDate, rptType, chckclient, chckcategory, chckmonthwise, check)%>'; --%>   

            var obj = $.parseJSON(data);
            var columns = obj[0].columns;
            var columngroups = obj[1].columngroups;
            var rows = obj[2].rows;
 			
            var source =
            {
                datatype: "json",
                datafields: [
                    
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
{ name: 'amount10',type:'number'}
                ],
                id: 'id',
                localdata: rows
            };
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#salesBranchwiseGrid").jqxGrid(
            {
                width: '99.5%',
                height: 515,
                source: dataAdapter,
                columnsresize: true,
                columns: columns,
               
            });
            
			$("#overlay, #PleaseWait").hide();
             
        });
 		
</script>

<div id="salesBranchwiseGrid"></div>
