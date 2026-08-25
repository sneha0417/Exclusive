<%@page import="com.dashboard.accounts.cashledger.ClsCashLedgerDAO" %>
<% ClsCashLedgerDAO DAO=new ClsCashLedgerDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();%> 
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
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){   
	  		   data='<%=DAO.cashLedgerGridLoading(branchval, fromDate, toDate, accdocno,check)%>';
			   var dataExcelExport='<%=DAO.cashLedgerGridExcelExport(branchval, fromDate, toDate, accdocno,check)%>';
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
							{name : 'trdate' , type: 'date' },
							{name : 'transtype' , type:'string'},
							{name : 'transno' , type:'int'},
							{name : 'account' , type:'string'},
							{name : 'accountname' , type:'string'},
							{name : 'branchname' , type:'string'},
							{name : 'description' , type:'string'},
							{name : 'currency',type:'string'},
							{name : 'rate' , type:'number'},
							{name : 'dr' , type:'number'},
							{name : 'cr' , type:'number'},
							{name : 'debit' , type:'number'},
							{name : 'credit' , type:'number'}
	                      ],
                          localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
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
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#accountsStatement").jqxGrid(
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
							{ text: 'Date', datafield: 'trdate', cellclassname: cellclassname, width: '6%', cellsformat: 'dd.MM.yyyy' ,columngroup:'cashcontrolaccount'},
							{ text: 'Type',  datafield: 'transtype',  cellclassname: cellclassname, width: '4%',columngroup:'cashcontrolaccount' },
							{ text: 'Doc No',  datafield: 'transno',  cellclassname: cellclassname, width: '6%'  ,columngroup:'cashcontrolaccount' },
							{ text: 'Account No',  datafield: 'account',  cellclassname: cellclassname, width: '6%'  ,columngroup:'cashcontrolaccount' },
							{ text: 'Account', datafield:'accountname', cellclassname: cellclassname, width:'15%',columngroup:'cashcontrolaccount'},
							{ text: 'Branch',  datafield: 'branchname',  cellclassname: cellclassname, width: '9%'  ,columngroup:'cashcontrolaccount' },
							{ text: 'Description', datafield:'description', cellclassname: cellclassname, width:'17.5%',columngroup:'cashcontrolaccount'},
							{ text: 'Currency',  datafield: 'currency',  cellclassname: cellclassname, width: '5%'  ,columngroup:'transactedin'},
							{ text: 'Rate',  datafield: 'rate',  cellclassname: cellclassname, width: '3%',cellsformat: 'd2',columngroup:'transactedin'},
							{ text: 'Dr',  datafield: 'dr',  cellclassname: cellclassname, width: '7.09%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'transactedin'},
							{ text: 'Cr',  datafield: 'cr',  cellclassname: cellclassname, width: '7.09%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'transactedin', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Debit',  datafield: 'debit',  cellclassname: cellclassname, width: '7.09%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'valueinbasecurrency',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Credit',  datafield: 'credit',  cellclassname: cellclassname, width: '7.09%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'valueinbasecurrency',aggregates: ['sum'],aggregatesrenderer:rendererstring },
						 ], columngroups: 
					                     [
					                       { text: 'Account Informations', align: 'center', name: 'cashcontrolaccount',width: '20%' },
					                       { text: 'Transacted In', align: 'center', name: 'transactedin',width: '10%' },
					                       { text: 'Value In Base Currency', align: 'center', name: 'valueinbasecurrency',width: '10%' }
					                     ]
            });
            
            if(temp=='NA'){
                $("#accountsStatement").jqxGrid("addrow", null, {});
            }
            
			$("#overlay, #PleaseWait").hide();
			
            var debit1="";var credit1="";var netamount="";
            var debit=$('#accountsStatement').jqxGrid('getcolumnaggregateddata', 'debit', ['sum'], true);
            debit1=debit.sum;
            var credit=$('#accountsStatement').jqxGrid('getcolumnaggregateddata', 'credit', ['sum'], true);
            credit1=credit.sum;
            if(!isNaN(debit1 || credit1)){
            	netamount= parseFloat(debit1) - parseFloat(credit1);
      		    funRoundAmt(netamount,"txtnetamount");
      		  }
      		else{
		    	 $('#txtnetamount').val(0.00);
		    }
        });

</script>
<div id="accountsStatement"></div>
