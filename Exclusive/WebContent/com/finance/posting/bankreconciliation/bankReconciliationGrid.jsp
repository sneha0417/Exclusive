<%@page import="com.finance.posting.bankreconciliation.ClsBankReconciliationDAO"%>
<%ClsBankReconciliationDAO DAO= new ClsBankReconciliationDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String date = request.getParameter("date")==null?"0":request.getParameter("date");
   String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
   String mode = request.getParameter("mode")==null?"0":request.getParameter("mode");
   String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>

<script type="text/javascript">
       var data1;
       var dataExcelExport;
        $(document).ready(function () { 	
             var bookbalance=""; 
             var temp='<%=accountno%>';
             var temp1='<%=mode%>';
             
             if(temp>0 && temp1!='E') { 
            	 bookbalance='<%=DAO.bookBalance(session, accountno, date, check , docno)%>';
            	 data1='<%=DAO.bankReconciliationGridLoading(session, accountno, date, check, docno)%>'; 
            	 dataExcelExport='<%=DAO.bankReconciliationGridLoadingExcel(session, accountno, date, check, docno)%>';
           	 } else if(temp>0 && temp1=='E') { 
            	 bookbalance='<%=DAO.bookBalance(session, accountno, date, check , docno)%>';
            	 data1='<%=DAO.bankReconciliationEditGridLoading(session, docno, mode, check)%>'; 
<%--             	 dataExcelExport='<%=DAO.bankReconciliationEditGridLoadingExcel(session, docno, mode, check)%>'; --%>
           	 }
             //$('#txtbookbalance').val(bookbalance);
             funRoundAmt(bookbalance,"txtbookbalance");
             
             var rendererstring=function (aggregates){
                	var value=aggregates['sum'];
                	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Total" + ': ' + value + '</div>';
             } 
             
             // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'date', type: 'date' },
     						{name : 'dtype', type: 'string'   },
     						{name : 'doc_no', type: 'int' },
     						{name : 'chqno', type: 'string'   },
     						{name : 'chqdt', type: 'date' },
     		     		    {name : 'cr', type: 'number'   },
     						{name : 'dr', type: 'number'   },
     						{name : 'chk', type: 'bool' },
     						{name : 'c_date', type: 'date'   },
     						{name : 'description', type: 'string'   },
     						{name : 'party', type: 'string'   },
     						{name : 'ref_detail', type: 'string'   },
     						{name : 'tranid', type: 'int'   }
                        ],
                		  localdata: data1,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });

            $("#jqxBankReconciliation").jqxGrid(
            {
                width: '99%',
                height: 350,
                source: dataAdapter,
                showaggregates:true,
                editable: true,
                selectionmode: 'singlecell',
				filterable: true,
                showfilterrow: true,
                localization: {thousandsSeparator: ""},
                    
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy',  width: '6%' },
							{ text: 'Doc Type', datafield: 'dtype',  width: '5%' },
							{ text: 'Doc No.', datafield: 'doc_no',  width: '5%' },			
							{ text: 'Cheque No.', datafield: 'chqno',  width: '5%' },
							{ text: 'Cheque Date', datafield: 'chqdt', cellsformat: 'dd.MM.yyyy',  width: '6%' },	
							{ text: 'Receipts', datafield: 'cr', cellsformat: 'd2', aggregates: ['sum'], aggregatesrenderer:rendererstring , width: '7%', cellsalign: 'right', align: 'right' },	
							{ text: 'Payments', datafield: 'dr', cellsformat: 'd2', aggregates: ['sum'],aggregatesrenderer:rendererstring , width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Choose Item', datafield: 'chk', columntype: 'checkbox', editable: true, width: '5%',cellsalign: 'center', align: 'center' },
							{ text: 'Posted Date', datafield: 'c_date', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy',  width: '7%' },
							{ text: 'Description', datafield: 'description',  width: '21%' },
							{ text: 'Party Name' , datafield: 'party',  width: '15%' },
							{ text: 'Reference', datafield: 'ref_detail',  width: '6%' },
							{ text: 'Tran Id', hidden: true, datafield: 'tranid',  width: '6%' },
						]
            });   
            
            if(temp==0){
          	   $("#jqxBankReconciliation").jqxGrid('addrow', null, {});
            }
            
            if(temp1=='view'){
            	$("#jqxBankReconciliation").jqxGrid('disabled', true);
            }
            
            if(temp1!='E') {
            	var receiptsTotal= $("#jqxBankReconciliation").jqxGrid('getcolumnaggregateddata', 'cr', ['sum'],true);
            	funRoundAmt(receiptsTotal.sum,"txtunclrreceipts");
            
            	var paymentsTotal= $("#jqxBankReconciliation").jqxGrid('getcolumnaggregateddata', 'dr', ['sum'],true);
            	funRoundAmt(paymentsTotal.sum,"txtunclrpayments");
            }
            
            $("#overlay, #PleaseWait").hide();
            
             $("#jqxBankReconciliation").on('cellvaluechanged', function (event) {
            	     var rowBoundIndex = event.args.rowindex;
            	     var dataField = event.args.datafield;
            	     
            	     if(dataField=='chk'){
            	    	 
               		 var receiptsTotal=document.getElementById("txtunclrreceipts").value;
               		 var paymentsTotal=document.getElementById("txtunclrpayments").value;
               		 var bookBalance=document.getElementById("txtbookbalance").value;
               	     var cr=0.0,dr=0.0;
               	    
             		 var value = $('#jqxBankReconciliation').jqxGrid('getcellvalue', rowBoundIndex, "chk");
                     var receipt= $("#jqxBankReconciliation").jqxGrid('getcellvalue', rowBoundIndex, "cr");
                     var payment= $("#jqxBankReconciliation").jqxGrid('getcellvalue', rowBoundIndex, "dr");
                     
                     if(value==true){
                    	 
                    	 if(!isNaN(receiptsTotal)){
                         	cr=parseFloat(receiptsTotal)-parseFloat(receipt);
                    	 } else if(isNaN(receiptsTotal)){
                    		 receiptsTotal=0.00;
                    		 cr=parseFloat(receiptsTotal)-parseFloat(receipt);
                    	 }
                    	 
                    	 if(!isNaN(paymentsTotal)){
                         	dr=parseFloat(paymentsTotal)-parseFloat(payment);
                    	 } else if(isNaN(paymentsTotal)){
                    		 paymentsTotal=0.00;
                    		 dr=parseFloat(paymentsTotal)-parseFloat(payment);
                    	 }
                    	 
                     } else{
                    	 
                    	 if(!isNaN(receiptsTotal)){
                    	 	cr=parseFloat(receiptsTotal)+parseFloat(receipt);
                    	 } else if(isNaN(receiptsTotal)){
                    		 receiptsTotal=0.00;
                    		 cr=parseFloat(receiptsTotal)+parseFloat(receipt);
                    	 }
                    	 
                    	 if(!isNaN(paymentsTotal)){
                    	 	dr=parseFloat(paymentsTotal)+parseFloat(payment);
                    	 } else if(isNaN(paymentsTotal)){
                    		 paymentsTotal=0.00;
                    		 dr=parseFloat(paymentsTotal)+parseFloat(payment);
                    	 }	
                    	 
                     }
                     
                     if(!isNaN(receiptsTotal)){
                         funRoundAmt(cr,"txtunclrreceipts");
                      }
                     
                     if(!isNaN(paymentsTotal)){
                         funRoundAmt(dr,"txtunclrpayments");
                      }
                     
                     if(!isNaN(cr || dr || bookBalance)){
                		    var bankStatement= (parseFloat(bookBalance) + parseFloat(dr)) - (parseFloat(cr));
                		    funRoundAmt(bankStatement,"txtbankbalance");
                		  }
                		else{
 	         		    	funRoundAmt(0,"txtbankbalance");
          		    	  }
                     
            	     }
              });

            $("#jqxBankReconciliation").bind('cellendedit', function (event) {
                var dataField = event.args.datafield;
                var rowIndex = event.args.rowindex;

                if(dataField=='chk'){
                var value = event.args.value;
                if(value==true){
               	 	var bankreconciledate = $('#jqxBankReconciliationDate').jqxDateTimeInput('getDate');
               	 	$("#jqxBankReconciliation").jqxGrid('setcellvalue', rowIndex, "c_date",bankreconciledate); 
                 } else {
               	 	$("#jqxBankReconciliation").jqxGrid('setcellvalue', rowIndex, "c_date",null);
                 }
                }
           });
            
            var receiptsTotal=document.getElementById("txtunclrreceipts").value;
      		var paymentsTotal=document.getElementById("txtunclrpayments").value;
      		var bookBalance=document.getElementById("txtbookbalance").value;
      		 
            if(!isNaN(receiptsTotal || paymentsTotal || bookBalance)){
       		    var bankStatement= (parseFloat(bookBalance) + parseFloat(paymentsTotal)) - (parseFloat(receiptsTotal));
       		    funRoundAmt(bankStatement,"txtbankbalance");
       		  }
       		else{
       			funRoundAmt(0,"txtbankbalance");
 		    }
            
        });
        
       
        
    </script>
    <div id="jqxBankReconciliation"></div>
 