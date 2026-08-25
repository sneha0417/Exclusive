<%@page import="com.finance.transactions.termloanmaster.ClstermloanmasterDAO" %>
<%
ClstermloanmasterDAO cvp1=new ClstermloanmasterDAO();
%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%

 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 
 var accountData1='<%=cvp1.bankaccountsDetails(session,accountno,accountname,currency,check)%>';
 	$(document).ready(function () { 
 		var searchtype='<%=check%>'; 		
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
 						{name : 'rate', type: 'number'  }
                    ],
            		localdata: accountData1, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#jqxAccountsSearch").jqxGrid(
        {
        	width: '100%',
            height: 325,
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
					]
        });
        
         $('#jqxAccountsSearch').on('rowdoubleclick', function (event) {
            var rowindex1 = event.args.rowindex;
            if(searchtype=="bankaac"){ 
    	 // bankaccid,bankaccname,banckaccdocno
	            document.getElementById("banckaccdocno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
	            document.getElementById("bankaccid").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "account");
	        	document.getElementById("bankaccname").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "description");
	        	document.getElementById("bankcurrency").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "curid");
	        	funRoundRate($('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "rate"),"bankrate"); 
	      
             }else if(searchtype=="intrestacc"){
	            document.getElementById("interestaccdocno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
	            document.getElementById("interestaccid").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "account");
	        	document.getElementById("intaccname").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "description");
	          	document.getElementById("intercurrency").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "curid");
	        	funRoundRate($('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "rate"),"interrate");
            }
             else{
            	document.getElementById("loanaccdocno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
	            document.getElementById("loanaccid").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "account");
	        	document.getElementById("loanaccname").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "description");
	        	document.getElementById("loancurrecy").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "curid");
	        	funRoundRate($('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "rate"),"loanrate");
            } 
        	
          $('#accountSearchwindow').jqxWindow('close');  
        });  
    });
</script>

<div id="jqxAccountsSearch"></div>
    