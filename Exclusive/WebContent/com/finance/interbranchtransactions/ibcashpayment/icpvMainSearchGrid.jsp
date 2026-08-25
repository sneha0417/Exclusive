<%@page import="com.finance.interbranchtransactions.ibcashpayment.ClsIbCashPaymentDAO" %>
<%  ClsIbCashPaymentDAO DAO=new ClsIbCashPaymentDAO(); %>
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
 
 			var data1='<%=DAO.icpvMainSearch(session, partyname, docNo, date, amount, check)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'description', type: 'String' }, 
                            {name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'amount', type: 'number' },
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
            $("#jqxIbCashPaymentMainSearch").jqxGrid(
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
					 { text: 'Date', datafield: 'date', width: '20%', cellsformat: 'dd.MM.yyyy' },
					 { text: 'Amount', datafield: 'amount', width: '20%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
					]
            });
            
			  $('#jqxIbCashPaymentMainSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("txttoaccname").value= $('#jqxIbCashPaymentMainSearch').jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("docno").value= $('#jqxIbCashPaymentMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                
                $('#frmIbCashPayment select').attr('disabled', false);
                $('#jqxIBCashPaymentDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmIbCashPayment").submit();
                $('#frmIbCashPayment select').attr('disabled', true);
                $('#jqxIBCashPaymentDate').jqxDateTimeInput({disabled: true});
                
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                       
    </script>
    <div id="jqxIbCashPaymentMainSearch"></div>
   