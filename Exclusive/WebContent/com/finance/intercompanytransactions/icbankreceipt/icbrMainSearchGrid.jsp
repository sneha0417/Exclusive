<%@page import="com.finance.intercompanytransactions.icbankreceipt.ClsIcBankReceiptDAO"%>
<% ClsIcBankReceiptDAO DAO= new ClsIcBankReceiptDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String partyname = request.getParameter("partyname")==null?"0":request.getParameter("partyname");
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String amount = request.getParameter("amount")==null?"0":request.getParameter("amount");
 String check = request.getParameter("check")==null?"0":request.getParameter("check"); 
%> 

 <script type="text/javascript">
 
 			var data1='<%=DAO.icbrMainSearch(session, partyname, docNo, date, amount, check)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'description', type: 'String' }, 
                            {name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'amount', type: 'number' }
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
            $("#jqxBankReceiptMainSearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},
     			
                columns: [
                     { text: 'Party Name', datafield: 'description', width: '40%' },
					 { text: 'Doc No', datafield: 'doc_no', width: '20%' },
					 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '20%' },
					 { text: 'Amount', datafield: 'amount', width: '20%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
					]
            });
            
			  $('#jqxBankReceiptMainSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("txtpaymentreceivedfrom").value= $('#jqxBankReceiptMainSearch').jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("docno").value= $('#jqxBankReceiptMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                
                $('#frmIcBankReceipt select').attr('disabled', false);
                $('#icBankReceiptDate').jqxDateTimeInput({disabled: false});
                $('#jqxChequeDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmIcBankReceipt").submit();
                $('#frmIcBankReceipt select').attr('disabled', true);
                $('#icBankReceiptDate').jqxDateTimeInput({disabled: true});
                $('#jqxChequeDate').jqxDateTimeInput({disabled: true});
                
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                       
    </script>
    <div id="jqxBankReceiptMainSearch"></div>
    