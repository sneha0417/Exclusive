<%@page import="com.dashboard.accounts.finance.ClsFinance"%>
<%@page import="com.finance.transactions.bankpayment.ClsBankPaymentDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%ClsFinance DAO= new ClsFinance(); 
ClsBankPaymentDAO bankPayDAO= new ClsBankPaymentDAO();%>
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
        
		var data2;
		var temp='<%=branchval%>';
		var temp1='<%=dType%>';
		
		if(temp1=='BPV' || temp1=='BRV' || temp1=='IBP' || temp1=='IBR'){
			if(temp!='NA'){
				  data2='<%=DAO.finance(branchval, fromDate, toDate, accType,accDocno, dType, docRangeFrom, docRangeTo, amtRangeFrom, amtRangeTo,chk)%>';
				  <%-- var dataExcelExport1='<%=DAO.financeExcelExport(branchval, fromDate, toDate, accType, accDocno, dType, docRangeFrom, docRangeTo, amtRangeFrom, amtRangeTo,chk)%>'; --%>
			}
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
     						{name : 'remarks', type: 'string'  },
     						{name : 'description', type: 'string'  },
     						{name : 'reference', type: 'string'  },
     						{name : 'amount', type: 'string' },
     						{name : 'currency', type: 'string'   },
     						{name : 'localamount', type: 'string' },
     						{name : 'chqno', type: 'String' },
     						{name : 'dates', type: 'date'   },
                        ],
                		 localdata: data2,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxBankVoucher").jqxGrid(
            {
                width: '100%',
                height: 470,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                showfilterrow:true,
                sortable: true,
				columnsresize: true,
                selectionmode: 'singlerow',
             	showaggregates: true,
             	showstatusbar:true,
             	rowsheight:25,
             	statusbarheight:25,
                editable: false,
                localization: {thousandsSeparator: ""},
                enabletooltips: true,
                
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
							{ text: 'Doc No',  datafield: 'doc_no', width: '5%' },
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '10%' },
							{ text: 'Remarks', datafield: 'remarks', width: '20%' },
							{ text: 'description', datafield: 'description', width: '20%',hidden:true },
							{ text: 'Reference', datafield: 'reference', width: '20%' },
							{ text: 'Amount', datafield: 'amount',  width: '10%', cellsalign: 'right', align: 'right' },
							{ text: 'Currency', datafield: 'currency',  width: '5%' },
							{ text: 'Local Amount', datafield: 'localamount',  width: '10%', cellsalign: 'right', align: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: 'Cheque No', datafield: 'chqno', width: '10%' },
							{ text: 'Cheque Date', datafield: 'dates', cellsformat: 'dd-MM-yyyy' , width: '10%' },
						]
            });
            $('#jqxBankVoucher').on('rowdoubleclick', function (event) {
            	 var rowindex1 = event.args.rowindex;
                 var detName="",path1="";
            	 var url=document.URL;
     	 		 var reurl=url.split("com/");
     	 		 var mod="v";
     	 		if(temp1=="BPV"){
     	 		 
     	 	    detName= "Bank Payments";
     	 		window.parent.formName.value="Bank Payments";
     	 		window.parent.formCode.value="BPV";
     	 		 var doc=$('#jqxBankVoucher').jqxGrid('getcellvalue', rowindex1, "doc_no");
     	 		 
     	 		  path1='com/finance/transactions/bankpayment/saveBankPayment?mode=view&txtbankpaydocno='+doc; 
     	 		}
     	 		
     	 		if(temp1=="BRV"){
        	 		 
         	 	    detName= "Bank Receipts";
         	 		window.parent.formName.value="Bank Receipts";
         	 		window.parent.formCode.value="BRV";
         	 		 var doc=$('#jqxBankVoucher').jqxGrid('getcellvalue', rowindex1, "doc_no");
         	 		 
         	 		  path1='com/finance/transactions/bankreceipt/saveBankReceipt?mode=view&txtbankreceiptdocno='+doc; 
         	 		}
     	 		
     	 		if(temp1=="IBP"){
       	 		 
         	 	    detName= "I B Bank Payment";
         	 		window.parent.formName.value="I B Bank Payment";
         	 		window.parent.formCode.value="IBP";
         	 		 var doc=$('#jqxBankVoucher').jqxGrid('getcellvalue', rowindex1, "doc_no");
         	 		 
         	 		  path1='com/finance/interbranchtransactions/ibbankpayment/saveIbBankPayment?mode=view&txtibbankpaydocno='+doc; 
         	 		}
     	 		
     	 		if(temp1=="IBR"){
          	 		 
         	 	    detName= "I B Bank Receipt";
         	 		window.parent.formName.value="I B Bank Receipt";
         	 		window.parent.formCode.value="IBR";
         	 		 var doc=$('#jqxBankVoucher').jqxGrid('getcellvalue', rowindex1, "doc_no");
         	 		 
         	 		  path1='com/finance/interbranchtransactions/ibbankreceipt/saveIbBankReceipt?mode=view&txtibbankreceiptdocno='+doc; 
         	 		}
     	 		  
     	    		   // var path= path1+"?&docno="+doc+"&accname="+acname;
     	    		    top.addTab( detName,reurl[0]+""+path1);
     	    		
     	    	
            });
            if(temp=='NA'){
                $("#jqxBankVoucher").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
});
</script>
<div id="jqxBankVoucher"></div>
 