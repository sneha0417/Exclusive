<%@page import="com.finance.transactions.bankpayment.ClsBankPaymentDAO"%>
<% ClsBankPaymentDAO DAO= new ClsBankPaymentDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String partyname = request.getParameter("partyname")==null?"0":request.getParameter("partyname");
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String amount = request.getParameter("amount")==null?"":request.getParameter("amount");
 String chequeNo = request.getParameter("chequeNo")==null?"0":request.getParameter("chequeNo");
 String chequeDt = request.getParameter("chequeDt")==null?"0":request.getParameter("chequeDt");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
 String chequename = request.getParameter("chequename")==null?"":request.getParameter("chequename");
%> 

 <script type="text/javascript">
 
 			var data1='<%=DAO.bpvMainSearch(session, partyname, docNo, date, amount, chequeNo, chequeDt, check, chequename)%>';   
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
     						{name : 'chqdt', type: 'date'  },
     						{name : 'chqname', type: 'String' },
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
            $("#jqxBankPaymentMainSearch").jqxGrid(
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
					 { text: 'Doc No', datafield: 'doc_no', width: '10%' },
					 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '10%' },
					 { text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '15%', cellsalign: 'right', align: 'right' },
					 { text: 'Cheque Name', datafield: 'chqname', width: '20%' },
					 { text: 'Cheque No', datafield: 'chqno', width: '10%' },
					 { text: 'Cheque Date', datafield: 'chqdt',cellsformat: 'dd.MM.yyyy' , width: '10%' },
					]
            });
            
			  $('#jqxBankPaymentMainSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("txttoaccname").value= $('#jqxBankPaymentMainSearch').jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("docno").value= $('#jqxBankPaymentMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#frmBankPayment select').attr('disabled', false);
                $('#jqxChequeDate').jqxDateTimeInput({disabled: false});
                $('#jqxBankPaymentDate').jqxDateTimeInput({disabled: false});
                $('#chckpdc').attr('disabled', false);
                funSetlabel();
                document.getElementById("frmBankPayment").submit();
                $('#chckpdc').attr('disabled', true);
                $('#frmBankPayment select').attr('disabled', true);
                $('#jqxChequeDate').jqxDateTimeInput({disabled: true});
                $('#jqxBankPaymentDate').jqxDateTimeInput({disabled: true});
                
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                       
    </script>
    <div id="jqxBankPaymentMainSearch"></div>
    