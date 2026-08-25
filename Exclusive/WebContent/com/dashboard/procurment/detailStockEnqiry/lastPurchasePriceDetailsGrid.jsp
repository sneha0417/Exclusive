<%@page import="com.dashboard.procurment.detailStockEnqiry.ClsStockEnqiry"%>
<%ClsStockEnqiry DAO= new ClsStockEnqiry(); %>
<%String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("frmdate")==null?"0":request.getParameter("frmdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String rpttype = request.getParameter("rpttype")==null?"0":request.getParameter("rpttype").trim();
 String productid = request.getParameter("productid")==null?"0":request.getParameter("productid").trim();
 String trtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype").trim();
 String aa = request.getParameter("aa")==null?"0":request.getParameter("aa").trim();
 
 %>
<script type="text/javascript">
    
       var lpmasterdata;
       var temp='<%=branchval%>';
	  	if(temp!='NA'){ 
	  		 lpmasterdata='<%=DAO.transactionPriceMasterDetails(session,branchval,fromDate, toDate, productid,trtype,aa)%>';
	  		
	  	} 
	  	
        $(document).ready(function (){ 
        	 
        	$("#btnExcel").click(function() {
    			$("#lastPurchasePriceDetailsGridID").jqxGrid('exportdata', 'xls', 'DayBook');
    		});
        	
            // prepare the lpmasterdata
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'parties', type: 'string'   },
                            {name : 'qty', type: 'string'   },
     						{name : 'unit_price', type: 'string' },
     						{name : 'mindate', type: 'string'  },
     						{name : 'maxdate', type: 'string' },
     						{name : 'units', type: 'string' },
     						{name : 'psrno', type: 'string'   }
                        ],
                		localdata: lpmasterdata, 
                		id: 'unit_price',
                		root: ''
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            var datas='<%=DAO.transactionPriceDetails(session,branchval,fromDate, toDate, productid,trtype)%>';
            var ordersSource =
            {
            	datatype: "json",
                datafields: [
     						{name : 'voc_no', type: 'string'   },
     						{name : 'date', type: 'string' },
     						{name : 'qty', type: 'number'   },
     						{name : 'units', type: 'string' },
     		     		    {name : 'psrno', type: 'string'   },
     						{name : 'desc1', type: 'string'   },
     						{name : 'unit_price', type: 'string' }
     						
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
	            var id = $("#lastPurchasePriceDetailsGridID").jqxGrid('getrowdata', row)['unit_price'];
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
                    var result = filter.evaluate(orders[m]["unit_price"]);
                    if (result)
                        ordersbyid.push(orders[m]);
                } 
                var orderssource = {datatype: "json", datafields: [
				    {name : 'voc_no', type: 'string'   },
     						{name : 'date', type: 'string' },
     						{name : 'qty', type: 'number'   },
     						{name : 'units', type: 'string' },
     		     		    {name : 'psrno', type: 'string'   },
     						{name : 'desc1', type: 'string'   },
     						{name : 'unit_price', type: 'string' }
                ],
                    localdata: ordersbyid
                }
                var nestedGridAdapter = new $.jqx.dataAdapter(orderssource);
                if (grid != null) {
                    grid.jqxGrid({
                        source: nestedGridAdapter, width: '80%', height: 80,sortable: true,filtermode:'excel',filterable: true,localization: {thousandsSeparator: ""},
                        columns: [
							{ text: 'Doc No', datafield: 'voc_no', width: '12%' },	
							{ text: 'Date', datafield: 'date', width: '15%' },
							{ text: 'Vendor', datafield: 'desc1', width: '32%' },
							{ text: 'Qty', datafield: 'qty', width: '11%', cellsformat: 'd2'  },
							{ text: 'Unit', datafield: 'units', width: '15%'  },
							{ text: 'Unit Price', datafield: 'unit_price',  width: '15%',cellsalign: 'right', align:'right' },
							{ text: 'psrno' , datafield: 'psrno',  width: '15%', align: 'right',hidden:true }
                       ]
                    });
                }
            }
            
            $("#lastPurchasePriceDetailsGridID").jqxGrid(
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
                    $("#lastPurchasePriceDetailsGridID").jqxGrid('showrowdetails', 0);
                },
               
                columns: [
                            { text: 'Parties', datafield: 'parties', cellsformat: 'dd.MM.yyyy' , width: '20%' },
                            { text: 'Qty', datafield: 'qty', width: '20%' },
                            { text: 'Unit Price', datafield: 'unit_price', width: '20%' },
							{ text: 'Unit', datafield: 'units', width: '20%' },
							{ text: 'Period', datafield: 'mindate', width: '10%' },
							{ text: 'Upto', datafield: 'maxdate', width: '10%',cellsformat: 'd2',cellsalign: 'right', align: 'right' },
							{ text: 'psrno', hidden: true, datafield: 'psrno',  width: '15%' },
						]
            });
            
            if(temp=='NA'){ 
               $("#lastPurchasePriceDetailsGridID").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
             
        });
    </script>
    <div id="lastPurchasePriceDetailsGridID"></div>
 