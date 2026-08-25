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
      var data1;
      var dataExcel;
      var temp1='<%=branchval%>';
      
	  	if(temp1!='NA'){
	  		   data1='<%=DAO.costLedgerGridLoading(rpttype, branchval, fromDate, toDate, costtype, costcode, check)%>';
			    dataExcel='<%=DAO.costLedgerGridLoadingExcel(rpttype, branchval, fromDate, toDate, costtype, costcode, check)%>';
			  <%--  var dataExcelExport='<%=DAO.costLedgerGridIDExcelExport(branchval, fromDate, toDate, accdocno)%>'; --%>
	  	}
	  	
  	
        $(document).ready(function () {
        	
        	var rendererstring2=function (aggregates){
               	var value1=aggregates['sum'];
               	if(typeof(value1) == "undefined"){
               		value1=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value1 + '</div>';
               }
        	
        	var rendererstring3=function (aggregates){
                var value1=aggregates['sum2'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
            }
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'trdate' , type: 'date' },
							{name : 'transtype' , type:'string'},
							{name : 'transno' , type:'int'},
							{name : 'branchname' , type:'string'},
							{name : 'account' , type:'int'},
							{name : 'accountname' , type:'string'},
							{name : 'description' , type:'string'},
							{name : 'currency',type:'string'},
							{name : 'rate' , type:'number'},
							{name : 'debit' , type:'number'},
							{name : 'credit' , type:'number'},
							{name : 'acno' , type:'int'}
	                      ],
                          localdata: data1,
               
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
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#costLedgerDetailGridID").jqxGrid(
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
							{ text: 'Branch',  datafield: 'branchname',  cellclassname: cellclassname, width: '12%'  ,columngroup:'cashcontrolaccount' },
							{ text: 'Description', datafield:'description', cellclassname: cellclassname, width:'20%',columngroup:'cashcontrolaccount'},
							{ text: 'Account',  datafield: 'acno',  hidden: true, width: '10%',columngroup:'cashcontrolaccount' },
							{ text: 'Account',  datafield: 'account',  cellclassname: cellclassname, width: '6%',columngroup:'cashcontrolaccount' },
							{ text: 'Account Name',  datafield: 'accountname',  cellclassname: cellclassname, width: '21%',columngroup:'cashcontrolaccount' },
							{ text: 'Currency',  datafield: 'currency',  cellclassname: cellclassname, width: '5%'  ,columngroup:'transactedin'},
							{ text: 'Rate',  datafield: 'rate',  cellclassname: cellclassname, width: '4%',cellsformat: 'd2',columngroup:'transactedin', aggregates: ['sum2'],aggregatesrenderer:rendererstring3 },
							{ text: 'Debit',  datafield: 'debit',  cellclassname: cellclassname, width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'transactedin',aggregates: ['sum'],aggregatesrenderer:rendererstring2 },
							{ text: 'Credit',  datafield: 'credit',  cellclassname: cellclassname, width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'transactedin',aggregates: ['sum'],aggregatesrenderer:rendererstring2 },
						 ], columngroups: 
					                     [
					                       { text: 'Account Informations', align: 'center', name: 'cashcontrolaccount',width: '20%' },
					                       { text: 'Transacted In', align: 'center', name: 'transactedin',width: '10%' },
					                     ]
            });
            
            if(temp1=='NA'){
                $("#costLedgerDetailGridID").jqxGrid("addrow", null, {});
            }
            
			$("#overlay, #PleaseWait").hide();
			
			if(temp1!='NA'){
	            var debit3="";var credit3="";var netamount1="";
	            var debit2=$('#costLedgerDetailGridID').jqxGrid('getcolumnaggregateddata', 'debit', ['sum'], true);
	            debit3=debit2.sum;
	            var credit2=$('#costLedgerDetailGridID').jqxGrid('getcolumnaggregateddata', 'credit', ['sum'], true);
	            credit3=credit2.sum;
	            if(!isNaN(debit3 || credit3)){
	            	netamount1= parseFloat(debit3) - parseFloat(credit3);
	      		    funRoundAmt(netamount1,"txtnetamount");
	      		  }
	      		else{
			    	 funRoundAmt(0.00,"txtnetamount");
			    }
			}
        });

</script>
<div id="costLedgerDetailGridID"></div>
