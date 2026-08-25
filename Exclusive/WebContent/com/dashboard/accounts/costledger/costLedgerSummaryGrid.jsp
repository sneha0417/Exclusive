<%@page import="com.dashboard.accounts.costledger.ClsCostLedgerDAO" %>
<% ClsCostLedgerDAO DAO=new ClsCostLedgerDAO(); %>
<%   String rpttype = request.getParameter("rpttype")==null?"0":request.getParameter("rpttype").trim(); 
	 String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String costtype = request.getParameter("costtype")==null?"0":request.getParameter("costtype").trim();
     String costcode = request.getParameter("costcode")==null?"0":request.getParameter("costcode").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim(); %> 
<style type="text/css">
        .redClass
        {
            background-color: #FFEBEB;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .greyClass
        {
           background-color: #D8D8D8;
        }
</style>
<script type="text/javascript">
      var data;
       var dataExcel;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){
	  		   data='<%=DAO.costLedgerGridLoading(rpttype, branchval, fromDate, toDate, costtype, costcode, check)%>';
	  	        dataExcel='<%=DAO.costLedgerGridLoadingExcel(rpttype, branchval, fromDate, toDate, costtype, costcode, check)%>';
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
								{name : 'acno' , type:'int'},
								{name : 'account' , type:'int'},
								{name : 'accountname' , type:'string'},
								{name : 'debits' , type:'number'},
								{name : 'credits' , type:'number'}
	                      ],
                          localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	var cellclassname = function (row, column, value, data) {
        		if (data.debits != '') {
                    return "redClass";
                } else if (data.credits != '') {
                    return "yellowClass";
                }
                else{
                	return "greyClass";
                };
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#costLedgerSummaryGridID").jqxGrid(
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
							{ text: 'Account',  datafield: 'acno',  hidden: true, width: '10%' },
							{ text: 'Account',  datafield: 'account',  cellclassname: cellclassname, width: '17%' },
							{ text: 'Account Name',  datafield: 'accountname',  cellclassname: cellclassname, width: '43%', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Debit',  datafield: 'debits',  cellclassname: cellclassname, width: '20%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Credit',  datafield: 'credits',  cellclassname: cellclassname, width: '20%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
						 ]
            });
            
            if(temp=='NA'){
                $("#costLedgerSummaryGridID").jqxGrid("addrow", null, {});
            }
            
			$("#overlay, #PleaseWait").hide();
			
            var debit1="";var credit1="";var netamount="";
            var debit=$('#costLedgerSummaryGridID').jqxGrid('getcolumnaggregateddata', 'debits', ['sum'], true);
            debit1=debit.sum;
            var credit=$('#costLedgerSummaryGridID').jqxGrid('getcolumnaggregateddata', 'credits', ['sum'], true);
            credit1=credit.sum;
            if(!isNaN(debit1 || credit1)){
            	netamount= parseFloat(debit1) - parseFloat(credit1);
      		    funRoundAmt(netamount,"txtnetamount");
      		  }
      		else{
		    	 funRoundAmt(0.00,"txtnetamount");
		    } 
        });

</script>
<div id="costLedgerSummaryGridID"></div>
