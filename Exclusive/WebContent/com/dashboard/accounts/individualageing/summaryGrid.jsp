<%@page import="com.dashboard.accounts.individualageing.ClsIndividualAgeing"%>
<%ClsIndividualAgeing DAO=new ClsIndividualAgeing(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
     String atype = request.getParameter("atype"); 
     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String salesperson = request.getParameter("salesperson")==null?"0":request.getParameter("salesperson").trim();
     String category = request.getParameter("category")==null?"0":request.getParameter("category").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check");%>
     
<style type="text/css">
  .advanceClass
  {
      background-color: #FBEFF5;
  }
  .balanceClass
  {
      background-color: #E0F8F1;
  }
 .unappliedClass
  {
     color: #FF0000;
  }
</style>
     
<script type="text/javascript">
    
       var data,exportdata;
       var temp='<%=branchval%>';
    	 
	  	if(temp!='NA'){ 
	  		 data='<%=DAO.individualAgeingSummary(branchval, upToDate, atype, accdocno, salesperson, category, check)%>';
	  		exportdata='<%=DAO.individualAgeingSummaryEXCEL(branchval, upToDate, atype, accdocno, salesperson, category, check)%>';
	  	} 
	  	
        $(document).ready(function (){ 
        	 
        /* 	$("#btnExcel").click(function() {
    			$("#individualAgeingSummary").jqxGrid('exportdata', 'xls', 'IndividualAgeingSummary');
    		});
        	 */
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
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'account_name', type: 'string'   },
                            {name : 'contact_person', type: 'string'   },
                            {name : 'sales_person', type: 'string'   },
     						{name : 'mobile_no', type: 'string'   },
     						{name : 'advance', type: 'number'  },
     						{name : 'balance', type: 'number' },
     						{name : 'unapplied', type: 'number' },
     						{name : 'total', type: 'number' },
     						{name : 'acno', type: 'string'   },
     						{name : 'branch_id', type: 'string'   }
                        ],
                		localdata: data, 
                		id: 'acno',
                		root: ''
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            var datas='<%=DAO.individualAgeing(branchval, upToDate, atype, accdocno, salesperson, category, check)%>';
            var ordersSource =
            {
            	datatype: "json",
                datafields: [
     						 {name : 'date', type: 'date' },
							 {name : 'transno', type: 'int' },
							 {name : 'transtype', type: 'string'   },
							 {name : 'name' , type: 'string' },
							 {name : 'description', type: 'string' },
							 {name : 'advance' , type:'number'},
							 {name : 'unapplied',type:'number'},
							 {name : 'balance' , type:'number'},
							 {name : 'age' , type:'number'},
							 {name : 'acno' , type:'string'},
							 {name : 'brhid' , type:'int'}
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
	            var id = $("#individualAgeingSummary").jqxGrid('getrowdata', row)['acno'];
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
                    var result = filter.evaluate(orders[m]["acno"]);
                    if (result)
                        ordersbyid.push(orders[m]);
                } 
                var orderssource = {datatype: "json", datafields: [
				    {name : 'date', type: 'date' },
					{name : 'transno', type: 'int' },
					{name : 'transtype', type: 'string'   },
					{name : 'name' , type: 'string' },
					{name : 'description', type: 'string' },
					{name : 'advance' , type:'number'},
					{name : 'unapplied',type:'number'},
					{name : 'balance' , type:'number'},
					{name : 'age' , type:'number'},
					{name : 'acno' , type:'string'},
					{name : 'brhid' , type:'int'}
                ],
                    localdata: ordersbyid
                }
                var nestedGridAdapter = new $.jqx.dataAdapter(orderssource);
                if (grid != null) {
                    grid.jqxGrid({
                        source: nestedGridAdapter, width: '95%', height: 100,sortable: true,columnsresize: true,filtermode:'excel',filterable: true,
                        columns: [
									   {  text: 'Sr. No', sortable: false, filterable: false, editable: false,
									     groupable: false, draggable: false, resizable: false,datafield: '',
									     columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
									     cellsrenderer: function (row, column, value) {
									     return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
									     }    
										},
										{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , editable: false, width: '7%' },
										{ text: 'Type', datafield: 'transtype', editable: false, width: '5%' },	
										{ text: 'Doc No.', datafield: 'transno', editable: false, width: '6%' },
										{ text: 'Account Name', datafield: 'name', width: '18%' },
										{ text: 'Description',  datafield: 'description',  width: '20%' },
										{ text: 'Advance', datafield:'advance', width:'12%', cellsformat: 'd2',cellsalign:'right',align:'right', cellclassname: 'advanceClass' },
										{ text: 'Balance', datafield:'balance', width:'12%', cellsformat: 'd2',cellsalign:'right',align:'right', cellclassname: 'balanceClass' },
										{ text: 'Unapplied',  datafield: 'unapplied',  width: '12%', cellsformat: 'd2',cellsalign:'right',align:'right', cellclassname: 'unappliedClass' },
										{ text: 'Age',  datafield: 'age',  width: '4%', cellsalign: 'center', align: 'center' },
										{ text: 'Account No',  datafield: 'acno', hidden: true, width: '8%'  },
										{ text: 'Branch Id',  datafield: 'brhid', hidden: true, width: '8%'  },
                       ]
                    });
                }
            }
            
            $("#individualAgeingSummary").jqxGrid(
            {
                width: '98%',
                height: 490,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                rowdetails: true,
                rowsheight: 25,
                columnsresize: true,
                showaggregates: true,
                showstatusbar:true,
             	statusbarheight:25,
                //localization: {thousandsSeparator: ""},
                initrowdetails: initrowdetails,
                rowdetailstemplate: { rowdetails: "<div id='grid' style='margin: 10px;'></div>", rowdetailsheight: 125, rowdetailshidden: true },
               
                columns: [
							{ text: 'Account Name', datafield: 'account_name', width: '21%' },	
							{ text: 'Contact Person', datafield: 'contact_person', width: '15%' },	
							{ text: 'Sales Person', datafield: 'sales_person', width: '14%' },
							{ text: 'Mobile No', datafield: 'mobile_no', width: '10%', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Advance', datafield: 'advance', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'advanceClass' },
							{ text: 'Balance', datafield: 'balance',  width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'balanceClass' },
							{ text: 'Unapplied', datafield: 'unapplied', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'unappliedClass' },
							{ text: 'Total' , datafield: 'total',  width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: 'Account', hidden: true, datafield: 'account',  width: '14%' },
							{ text: 'Branch Id', hidden: true, datafield: 'branch_id',  width: '14%' },
						]
            });
            
            if(temp=='NA'){ 
               $("#individualAgeingSummary").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
             
        });
    </script>
    <div id="individualAgeingSummary"></div>
 