<%@page import="com.dashboard.accounts.daybooknew.ClsDayBook" %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
%>
<%  ClsDayBook dao= new ClsDayBook(); %>      
<script type="text/javascript">    
    
       var data;
       var temp='<%=branchval%>';  
    	 
	  	if(temp!='NA'){  
	  		 data='<%=dao.dayBook(branchval, fromDate, toDate,check)%>';
	  		 //dataExcel='<%=dao.dayBookExcel(branchval, fromDate, toDate,check)%>';
	  		 var exceldata='<%=dao.dayBookExcel(branchval, fromDate, toDate)%>'; 
	  	}              
	  	     
        $(document).ready(function (){    
        	 
        	/*$("#btnExcel").click(function() {    
    			$("#dayBook").jqxGrid('exportdata', 'xls', 'DayBook');
    		});*/
        	
            // prepare the data
            var source =
            {
                datatype: "json",      
                datafields: [
                            {name : 'transno', type: 'string'   },
							{name : 'date', type: 'date'   },
                            {name : 'dtype', type: 'string'   },
     						{name : 'doc_no', type: 'string'   },
     						{name : 'ref', type: 'string'  },
     						{name : 'description', type: 'string' },
     						{name : 'total', type: 'number' },
     						{name : 'tr_no', type: 'string'   }
                        ],
                		localdata: data, 
                		id: 'tr_no',
                		root: ''
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
        	if(temp!='NA'){ 
            	var datas='<%=dao.dayBookGrid(branchval, fromDate, toDate)%>';
            	
        	}
            var ordersSource =
            {
            	datatype: "json",
                datafields: [
     						{name : 'account', type: 'string'   },  
     						{name : 'acno', type: 'string' },      
     						{name : 'brchname', type: 'string' },    
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
				    {name : 'acno', type: 'string' },      
					{name : 'brchname', type: 'string' },   
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
                            { text: 'AC.NO', datafield: 'acno', width: '9%' },
							{ text: 'Account', datafield: 'account', width: '20%' },
							{ text: 'Branch Name', datafield: 'brchname', width: '14%' },
							{ text: 'Currency', datafield: 'currency', width: '10%' },	
							{ text: 'Rate', datafield: 'rate', width: '10%', cellsformat: 'd2' },
							{ text: 'Dr', datafield: 'dr', width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Cr', datafield: 'cr', width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Dr. base currency', datafield: 'drcur',  width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Cr. base currency' , datafield: 'crcur',  width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Tr No', hidden: true, datafield: 'tr_no',  width: '15%' },
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
                            { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '10%' },
                            { text: 'Doc. Type', datafield: 'dtype', width: '10%' },
                            { text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true },
                            { text: 'Doc No', datafield: 'transno', width: '10%' },
							{ text: 'Ref', datafield: 'ref', width: '10%' },
							{ text: 'Remarks', datafield: 'description', width: '50%' },
							{ text: 'Total', datafield: 'total', width: '10%',cellsformat: 'd2',cellsalign: 'right', align: 'right' },
							{ text: 'Tr No', hidden: true, datafield: 'tr_no',  width: '15%' },
						]
            });
            
            if(temp=='NA'){ 
               $("#dayBook").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
             
        });
    </script>
    <div id="dayBook"></div>
 