<%@page import="com.dashboard.humanresource.salarypaymentNew.ClsSalaryPaymentDAO"%>
<%ClsSalaryPaymentDAO DAO= new ClsSalaryPaymentDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <% String bankaccountno = request.getParameter("bankaccountno")==null?"0":request.getParameter("bankaccountno");
    String bankaccountname = request.getParameter("bankaccountname")==null?"0":request.getParameter("bankaccountname");
    String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

 <script type="text/javascript">
 
	var data5='<%=DAO.bankAccountsDetails(session, bankaccountno, bankaccountname,check)%>';
	
 	$(document).ready(function () { 
 		
 		 // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
                        {name : 'doc_no', type: 'int'   },
 						{name : 'account', type: 'string'   },
 						{name : 'description', type: 'string'  },
 						{name : 'currency', type: 'string'  },
 						{name : 'curid', type: 'int'  },
 						{name : 'rate', type: 'number'  },
 						{name : 'type', type: 'string'  }
                    ],
            		localdata: data5, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#bankAccountDetailsSearchGridID").jqxGrid(
        {
        	width: '100%',
            height: 303,
            source: dataAdapter,
            selectionmode: 'singlerow',
 			editable: false,
 			columnsresize: true,
 			localization: {thousandsSeparator: ""},
            
            columns: [
						{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
						{ text: 'Account', datafield: 'account', width: '30%' },
						{ text: 'Account Name', datafield: 'description', width: '50%' },
						{ text: 'Currency', datafield: 'currency', width: '10%' },
						{ text: 'Currency Id', hidden: true, datafield: 'curid', width: '5%' },
						{ text: 'Rate', datafield: 'rate', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '10%' },
						{ text: 'Currency Type', hidden: true, datafield: 'type', width: '5%' },
					]
        });
        
         $('#bankAccountDetailsSearchGridID').on('rowdoubleclick', function (event) {
            	var rowindex1 = event.args.rowindex;
            
	            document.getElementById("txtbankaccountdocno").value = $('#bankAccountDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
	            document.getElementById("txtbankaccount").value = $('#bankAccountDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "account");
	        	document.getElementById("txtbankaccountname").value = $('#bankAccountDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "description");

	        	$('#accountDetailsWindow').jqxWindow('close');  
        });  
    });
</script>

<div id="bankAccountDetailsSearchGridID"></div>
    