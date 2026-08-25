<%@page import="com.dashboard.humanresource.salarypaymentNew.ClsSalaryPaymentDAO"%>
<%ClsSalaryPaymentDAO DAO= new ClsSalaryPaymentDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <% String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
    String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
    String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

 <script type="text/javascript">
 
	var data3='<%=DAO.accountsDetails(session, accountno, accountname,check)%>';
	
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
            		localdata: data3, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#accountDetailsSearchGridID").jqxGrid(
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
        
         $('#accountDetailsSearchGridID').on('rowdoubleclick', function (event) {
            	var rowindex1 = event.args.rowindex;
            
	            document.getElementById("txtaccountdocno").value = $('#accountDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
	            document.getElementById("txtaccount").value = $('#accountDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "account");
	        	document.getElementById("txtaccountname").value = $('#accountDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "description");
	        	//document.getElementById("cmbcurrency").value = $('#accountDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "curid");
	        	//funRoundRate($('#accountDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "rate"),"txtrate");

	        	$('#accountDetailsWindow').jqxWindow('close');  
        });  
    });
</script>

<div id="accountDetailsSearchGridID"></div>
    