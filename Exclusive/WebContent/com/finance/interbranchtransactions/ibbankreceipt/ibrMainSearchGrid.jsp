<%@page import="com.finance.interbranchtransactions.ibbankreceipt.ClsIbBankReceiptDAO" %>
<%  ClsIbBankReceiptDAO DAO=new ClsIbBankReceiptDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String partyname = request.getParameter("partyname")==null?"0":request.getParameter("partyname");
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String amount = request.getParameter("amount")==null?"0":request.getParameter("amount");
 String chequeNo = request.getParameter("chequeNo")==null?"0":request.getParameter("chequeNo");
 String chequeDt = request.getParameter("chequeDt")==null?"0":request.getParameter("chequeDt");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 
 			var data1='<%=DAO.ibrMainSearch(session, partyname, docNo, date, amount, chequeNo, chequeDt, check )%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'description', type: 'String' }, 
                            {name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'amount', type: 'number' },
     						{name : 'chqno', type: 'String' },
     						{name : 'chqdt', type: 'date'  } 
                          	],
                          	localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxIbBankReceiptMainSearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},
     			
                columns: [
                     { text: 'Party Name', datafield: 'description', width: '25%' },
					 { text: 'Doc No', datafield: 'doc_no', width: '15%' },
					 { text: 'Date', datafield: 'date', width: '15%', cellsformat: 'dd.MM.yyyy' },
					 { text: 'Amount', datafield: 'amount', width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
					 { text: 'Cheque No', datafield: 'chqno', width: '15%' },
					 { text: 'Cheque Date', datafield: 'chqdt', width: '15%', cellsformat: 'dd.MM.yyyy' },
					]
            });
            
			  $('#jqxIbBankReceiptMainSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("txttoaccname").value= $('#jqxIbBankReceiptMainSearch').jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("docno").value= $('#jqxIbBankReceiptMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
            
                $('#frmIbBankReceipt select').attr('disabled', false);
                $('#jqxChequeDate').jqxDateTimeInput({disabled: false});
                $('#jqxIbBankReceiptDate').jqxDateTimeInput({disabled: false});
                $('#chckpdc').attr('disabled', false);
                funSetlabel();
                document.getElementById("frmIbBankReceipt").submit();
                $('#chckpdc').attr('disabled', true);
                $('#frmIbBankReceipt select').attr('disabled', true);
                $('#jqxChequeDate').jqxDateTimeInput({disabled: true});
                $('#jqxIbBankReceiptDate').jqxDateTimeInput({disabled: true});
                
               $('#window').jqxWindow('close');
            });   
}); 
				       
    </script>
    <div id="jqxIbBankReceiptMainSearch"></div>
    