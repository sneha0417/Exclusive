<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.accounts.prepaymentdistribution.ClsPrePaymentDistributionDAO"%>
<% ClsPrePaymentDistributionDAO DAO= new ClsPrePaymentDistributionDAO(); %> 
 <%
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 
	var accountData='<%=DAO.accountsDetails(session, accountno, accountname, currency, check)%>';
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
 						{name : 'gr_type', type: 'int'  }
                    ],
            		localdata: accountData, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#jqxAccountsSearch").jqxGrid(
        {
        	width: '100%',
            height: 303,
            source: dataAdapter,
            selectionmode: 'singlerow',
 			editable: false,
 			localization: {thousandsSeparator: ""},
            
            columns: [
						{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
						{ text: 'Account', datafield: 'account', width: '30%' },
						{ text: 'Account Name', datafield: 'description', width: '50%' },
						{ text: 'Currency', datafield: 'currency', width: '10%' },
						{ text: 'Currency Id', hidden: true, datafield: 'curid', width: '5%' },
						{ text: 'Gr Type', hidden: true, datafield: 'gr_type', width: '5%' },
						{ text: 'Rate', datafield: 'rate', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '10%' },
					]
        });
        
         $('#jqxAccountsSearch').on('rowdoubleclick', function (event) {
        	 var rowindex1 =$('#rowindex').val();
             var rowindex2 = event.args.rowindex;
           
             $('#prepaymentDistributionGridID').jqxGrid('setcellvalue', rowindex1, "postacno" ,$('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
             $('#prepaymentDistributionGridID').jqxGrid('setcellvalue', rowindex1, "paccount" ,$('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex2, "account"));
             $('#prepaymentDistributionGridID').jqxGrid('setcellvalue', rowindex1, "paccountname" ,$('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex2, "description"));
             $('#prepaymentDistributionGridID').jqxGrid('setcellvalue', rowindex1, "grtype" ,$('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex2, "gr_type"));
            
          	 $('#prepaymentDistributionGridWindow').jqxWindow('close');  
        });  
    });
</script>

<div id="jqxAccountsSearch"></div>
    