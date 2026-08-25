<%@page import="com.search.ClsAccountSearch"%>
<% ClsAccountSearch DAO= new ClsAccountSearch(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
 String searchtype = request.getParameter("searchtype")==null?"0":request.getParameter("searchtype");
 String date = request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 
	var accountData='<%=DAO.accountsDetails(session, dtype,accountno, accountname, currency, date, check)%>';
 	$(document).ready(function () { 
 		var searchtype='<%=searchtype%>';
 		
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
        
         $('#jqxAccountsSearch').on('rowdoubleclick', function (event) {
            var rowindex1 = event.args.rowindex;
            alert(1);
            if(searchtype=="2"){
                $('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex, "accounts",$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
	            $('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex, "accountname1",$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "account"));
	        	$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex, "currencyid",$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "curid"));
	       
	        	funRoundRate($('#jqxMultipleCashPurchase').jqxGrid('getcellvalue', rowindex1, "rate"),"txtrate");
            alert(2);
            }else if(searchtype=="3"){
	            $('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex, "accounts",$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
	            $('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex, "accountname1",$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "account"));
	        	$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex, "currencyid",$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "curid"));
	       
	        	funRoundRate($('#jqxMultipleCashPurchase').jqxGrid('getcellvalue', rowindex1, "rate"),"txtrate");
            alert(3);
            }else{
            	$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex, "accounts",$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
	            $('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex, "accountname1",$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "account"));
	        	$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex, "currencyid",$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "curid"));
	       
	        	funRoundRate($('#jqxMultipleCashPurchase').jqxGrid('getcellvalue', rowindex1, "rate"),"txtrate");
            alert(4);
            }
        	
          $('#accountDetailsFromWindow').jqxWindow('close');  
        });  
    });
</script>

<div id="jqxAccountsSearch"></div>
    