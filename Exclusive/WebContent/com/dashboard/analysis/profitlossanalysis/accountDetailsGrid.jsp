<%@page import="com.dashboard.analysis.profitlossanalysis.ClsProfitLossAnalysis" %>
<% ClsProfitLossAnalysis cpla=new ClsProfitLossAnalysis();%>


<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<% String contextPath=request.getContextPath();%>
<html lang="en">
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String name = request.getParameter("name")==null?"0":request.getParameter("name").trim();%>

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
        
    .icon {
		width: 2.5em;
		height: 3em;
		border: none;
		background-color: #E0ECF8;
    }
        
</style>

<script type="text/javascript">
    
       var data1='<%=cpla.accountStatementDetail(branchval, fromDate, toDate, accdocno)%>';
       var name='<%=name%>';
	  	
        $(document).ready(function (){ 
        	 
        	$("#excelExport").click(function() {
    			$("#dayBook").jqxGrid('exportdata', 'xls', name);
    		});
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'trdate' , type: 'date' },
							{name : 'transtype' , type:'string'},
							{name : 'transno' , type:'int'},
							{name : 'description' , type:'string'},
							{name : 'currency',type:'string'},
							{name : 'rate' , type:'number'},
							{name : 'dr' , type:'number'},
							{name : 'cr' , type:'number'},
							{name : 'debit' , type:'number'},
							{name : 'credit' , type:'number'},
     						{name : 'tr_no', type: 'string'   }
                        ],
                		localdata: data1, 
                		id: 'tr_no',
                		root: ''
            };
            
            var cellclassname = function (row, column, value, data) {
        		if (data.debit != '') {
                    return "redClass";
                } else if (data.credit != '') {
                    return "yellowClass";
                }
                else{
                	return "greyClass";
                };
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            var datas='<%=cpla.accountStatementDetailGrid()%>';
            var ordersSource =
            {
            	datatype: "json",
                datafields: [
     						{name : 'account', type: 'string'   },
     						{name : 'currency', type: 'string' },
     						{name : 'rate', type: 'number'   },
     						{name : 'dr', type: 'number' },
     		     		    {name : 'cr', type: 'number'   },
     						{name : 'drcur', type: 'number'   },
     						{name : 'crcur', type: 'number'   },
     						{name : 'tr_no', type: 'string'   }
                ],
                root: '',
                localdata: datas,
                async: false
            };
            var ordersDataAdapter = new $.jqx.dataAdapter(ordersSource, { autoBind: true });
            orders = ordersDataAdapter.records;
            var nestedGrids = new Array();
            // create nested grid.
            var initrowdetails = function (index, parentElement, gridElement, record) {
               
                var row = index;
	            var id = $("#dayBook").jqxGrid('getrowdata', row)['tr_no'];
                var grid = $($(parentElement).children()[0]);
                
                nestedGrids[index] = grid;
                var filtergroup = new $.jqx.filter();
                var filter_or_operator = 1;
                var filtervalue = id;
                var filtercondition = 'equal';
                var filter = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);
                // fill the orders depending on the id.
                var ordersbyid = [];
                for (var m = 0; m < orders.length; m++) {
                    var result = filter.evaluate(orders[m]["tr_no"]);
                    if (result)
                        ordersbyid.push(orders[m]);
                } 
                var orderssource = {datatype: "json", datafields: [
				    {name : 'account', type: 'string'   },
					{name : 'currency', type: 'string' },
					{name : 'rate', type: 'number'   },
					{name : 'dr', type: 'number' },
				    {name : 'cr', type: 'number'   },
					{name : 'drcur', type: 'number'   },
					{name : 'crcur', type: 'number'   },
					{name : 'tr_no', type: 'string'   }
                ],
                    localdata: ordersbyid
                }
                var nestedGridAdapter = new $.jqx.dataAdapter(orderssource);
                if (grid != null) {
                    grid.jqxGrid({
                        source: nestedGridAdapter, width: '95%', height: 80,sortable: true,filtermode:'excel',filterable: true,localization: {thousandsSeparator: ""},
                        columns: [
							{ text: 'Account', datafield: 'account', width: '20%' },	
							{ text: 'Currency', datafield: 'currency', width: '10%' },	
							{ text: 'Rate', datafield: 'rate', width: '10%', cellsformat: 'd2' },
							{ text: 'Dr', datafield: 'dr', width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Cr', datafield: 'cr', width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Dr. base currency', datafield: 'drcur',  width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Cr. base currency' , datafield: 'crcur',  width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Tr No', hidden: true, datafield: 'tr_no',  width: '10%' },
                       ]
                    });
                }
            }
            
            $("#dayBook").jqxGrid(
            {
                width: '98%',
                height: 500,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                rowdetails: true,
                rowsheight: 25,
                localization: {thousandsSeparator: ""},
                initrowdetails: initrowdetails,
                rowdetailstemplate: { rowdetails: "<div id='grid' style='margin: 10px;'></div>", rowdetailsheight: 97, rowdetailshidden: true },
                ready: function () {
                    $("#dayBook").jqxGrid('showrowdetails', 0);
                },
               
                columns: [
						{ text: 'Date', datafield: 'trdate', cellclassname: cellclassname, width: '7%', cellsformat: 'dd.MM.yyyy' ,columngroup:'cashcontrolaccount'},
						{ text: 'Type',  datafield: 'transtype',  cellclassname: cellclassname, width: '6%',columngroup:'cashcontrolaccount' },
						{ text: 'Doc No',  datafield: 'transno',  cellclassname: cellclassname, width: '6%'  ,columngroup:'cashcontrolaccount' },
						{ text: 'Description', datafield:'description', cellclassname: cellclassname, width:'32.59%',columngroup:'cashcontrolaccount'},
						{ text: 'Currency',  datafield: 'currency',  cellclassname: cellclassname, width: '6%'  ,columngroup:'transactedin'},
						{ text: 'Rate',  datafield: 'rate',  cellclassname: cellclassname, width: '6%',cellsformat: 'd2',columngroup:'transactedin'},
						{ text: 'Dr',  datafield: 'dr',  cellclassname: cellclassname, width: '9.09%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'transactedin'},
						{ text: 'Cr',  datafield: 'cr',  cellclassname: cellclassname, width: '9.09%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'transactedin' },
						{ text: 'Debit',  datafield: 'debit',  cellclassname: cellclassname, width: '9.09%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'valueinbasecurrency' },
						{ text: 'Credit',  datafield: 'credit',  cellclassname: cellclassname, width: '9.09%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'valueinbasecurrency' },
						{ text: 'Tr No', hidden: true, datafield: 'tr_no',  width: '10%' },
					], columngroups: 
             			[
               				{ text: 'Account Informations', align: 'center', name: 'cashcontrolaccount',width: '20%' },
               				{ text: 'Transacted In', align: 'center', name: 'transactedin',width: '10%' },
               				{ text: 'Value In Base Currency', align: 'center', name: 'valueinbasecurrency',width: '10%' }
             			]
							
            });
             
        });
    </script>
    
    </head>
<body class='default'>
<button type="button" class="icon" id="excelExport" title="Export current Document to Excel">
 <img alt="excelDocument" src="<%=contextPath%>/icons/excel_new.png">
</button>
        <div id="dayBook"></div>
	
	</body>
</html>
 