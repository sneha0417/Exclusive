<%@page import="com.dashboard.accounts.costpandl.ClsCostPAndLDAO" %>
<% ClsCostPAndLDAO DAO=new ClsCostPAndLDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String costtype = request.getParameter("costtype")==null?"0":request.getParameter("costtype").trim();
     String costcode = request.getParameter("costcode")==null?"0":request.getParameter("costcode").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim(); %> 
<style type="text/css">
        .expenditureClass
        {
            background-color: #FFEBEB;
        }
        .incomeClass
        {
            background-color: #FFFFD1;
        }
        .netamountClass
        {
        	color: #FF5733;
        }
        .whiteClass
        {
           background-color: #FFFFFF;
        }
</style>
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){
	  		   data='<%=DAO.costPAndLGridLoading(branchval, fromDate, toDate, costtype, costcode, check)%>';
	  		   var dataExcelExport='<%=DAO.costPAndLExcelExport(branchval, fromDate, toDate, costtype, costcode, check)%>';
	  	}
  	
        $(document).ready(function () {
        	
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
            }
        	
        	var source =
            {
                datatype: "json",
                datafields: [
								{name : 'costtype' , type:'int'},
								{name : 'costgroup' , type:'string'},
								{name : 'costcode' , type:'string'},
								{name : 'income' , type:'number'},
								{name : 'expenditure' , type:'number'},
								{name : 'netamount' , type:'number'}
	                      ],
                          localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
        	var cellclassname = function (row, column, value, data) {
        		if (data.netamount != '') {
                    return "netamountClass";
                } 
                else{
                	return "whiteClass";
                };
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#costPAndLGridID").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                columnsresize: true,
                selectionmode: 'singlerow',
             	showaggregates: true,
             	showstatusbar:true,
             	rowsheight:25,
             	statusbarheight:25,
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Costtype',  datafield: 'costtype',  hidden: true, width: '10%' },
							{ text: 'Costtype',  datafield: 'costgroup', width: '15%' },
							{ text: 'Costcode',  datafield: 'costcode',  width: '40%', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Income',  datafield: 'income',  cellclassname: 'incomeClass', width: '15%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Expenditure',  datafield: 'expenditure',  cellclassname: 'expenditureClass', width: '15%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Netamount',  datafield: 'netamount',  cellclassname: cellclassname, width: '15%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
						 ]
            });
            
            if(temp=='NA'){
                $("#costPAndLGridID").jqxGrid("addrow", null, {});
            }
            
			$("#overlay, #PleaseWait").hide();
			
            var income1="";var expenditure1="";var netamount="";
            var income=$('#costPAndLGridID').jqxGrid('getcolumnaggregateddata', 'income', ['sum'], true);
            income1=income.sum;
            var expenditure=$('#costPAndLGridID').jqxGrid('getcolumnaggregateddata', 'expenditure', ['sum'], true);
            expenditure1=expenditure.sum;
            if(!isNaN(income1 || expenditure1)){
            	netamount= parseFloat(income1) - parseFloat(expenditure1);
      		    funRoundAmt(netamount,"txtnetamount");
      		  }
      		else{
		    	 funRoundAmt(0.00,"txtnetamount");
		    } 
        });

</script>
<div id="costPAndLGridID"></div>
