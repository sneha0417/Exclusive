<%@page import="com.dashboard.accounts.intercompanytransactions.ClsInterCompanyTransactions"%>
<% ClsInterCompanyTransactions DAO= new ClsInterCompanyTransactions(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String accType = request.getParameter("acctype")==null?"0":request.getParameter("acctype").trim();
     String accDocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String dType = request.getParameter("dtype")==null?"0":request.getParameter("dtype").trim();
     String docRangeFrom = request.getParameter("docrangefrom")==null?"0":request.getParameter("docrangefrom").trim();
     String docRangeTo = request.getParameter("docrangeto")==null?"0":request.getParameter("docrangeto").trim();
     String amtRangeFrom = request.getParameter("amtrangefrom")==null?"0":request.getParameter("amtrangefrom").trim();
     String amtRangeTo = request.getParameter("amtrangeto")==null?"0":request.getParameter("amtrangeto").trim();
     String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");%>

<script type="text/javascript">
        
		var data1;
		var temp='<%=branchval%>';
		var temp1='<%=dType%>';
		
		if(temp!='NA'){
			  data1='<%=DAO.interCompanyTransactionsGridLoading(branchval, fromDate, toDate, accType, accDocno, dType, docRangeFrom, docRangeTo, amtRangeFrom, amtRangeTo,chk)%>';
			  var dataExcelExport='<%=DAO.interCompanyTransactionsExcelExport(branchval, fromDate, toDate, accType, accDocno, dType, docRangeFrom, docRangeTo, amtRangeFrom, amtRangeTo,chk)%>';
		}
		
	
        $(document).ready(function () { 
        	
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + "Total : " + '' + value + '</div>';
               }
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
     						{name : 'date', type: 'date'   },
     						{name : 'ref_detail', type: 'string'  },
     						{name : 'compbranch', type: 'string'  },
     						{name : 'atype', type: 'string'  },
     						{name : 'account', type: 'string'   },
     						{name : 'accountname', type: 'string'   },
     						{name : 'costtype', type: 'string'   },
     						{name : 'costcode', type: 'string'   },
     						{name : 'debit', type: 'number' },
     						{name : 'credit', type: 'number' },
     						{name : 'baseamount', type: 'number' },
     						{name : 'description', type: 'string'   }
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#interCompanyTransactionsGridID").jqxGrid(
            {
                width: '100%',
                height: 470,
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
							{ text: 'Doc No',  datafield: 'doc_no', width: '5%' },
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '8%' },
							{ text: 'Ref No', datafield: 'ref_detail', width: '8%' },
							{ text: 'Branch', datafield: 'compbranch', width: '10%' },
							{ text: 'Type', datafield: 'atype', width: '4%' },
							{ text: 'Account', datafield: 'account',  width: '8%' },
							{ text: 'Account Name', datafield: 'accountname',  width: '20%' },
							{ text: 'Costtype', datafield: 'costtype',  width: '8%' },
							{ text: 'Costcode', datafield: 'costcode',  width: '6%' },
							{ text: 'Debit', datafield: 'debit', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: 'Credit', datafield: 'credit', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: 'Baseamount', datafield: 'baseamount', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: 'Description', datafield: 'description',  width: '25%' },
						]
            });
           
            if(temp=='NA'){
                $("#interCompanyTransactionsGridID").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
});
</script>
<div id="interCompanyTransactionsGridID"></div>
 