<%@page import="com.finance.posting.pdcpostingreceipt.ClsPDCPostingReceiptDAO"%>
<% ClsPDCPostingReceiptDAO DAO= new ClsPDCPostingReceiptDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String atype = request.getParameter("atype")==null?"0":request.getParameter("atype");
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String mobile = request.getParameter("mobile")==null?"0":request.getParameter("mobile");
 String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 
	var clientData='<%=DAO.accountsDetails(session,  atype, accountno, accountname, mobile, currency, check)%>';
 	$(document).ready(function () { 

 		var source = 
         {
             datatype: "json",
             datafields: [
                           {name : 'doc_no', type: 'int'   },
  						   {name : 'account', type: 'string'   },
  						   {name : 'description', type: 'string'  },
  						   {name : 'currency', type: 'string'  },
  						   {name : 'mobile', type: 'string'  },
  						   {name : 'curid', type: 'int'  },
  						   {name : 'rate', type: 'string'  }
                       	],
                       	localdata: clientData,
             
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
         $("#jqxAccountsTypeSearch").jqxGrid(
         {
             width: '100%',
             height: 303,
             source: dataAdapter,
             selectionmode: 'singlerow',
  			 editable: false,
  			 localization: {thousandsSeparator: ""},
  			
             columns: [
						{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
						{ text: 'Account', datafield: 'account', width: '25%' },
						{ text: 'Account Name', datafield: 'description', width: '50%' },
						{ text: 'Currency', datafield: 'currency', width: '10%' },
						{ text: 'Mobile', datafield: 'mobile', width: '15%' },
						{ text: 'Currency Id', hidden: true, datafield: 'curid', width: '5%' },
						{ text: 'Rate', hidden: true, datafield: 'rate', width: '5%' },
				       ]
               });
        
    	   $('#jqxAccountsTypeSearch').on('rowdoubleclick', function (event) {
               var rowindex1 = event.args.rowindex;
               document.getElementById("txtdocno").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
               document.getElementById("txtaccid").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "account");
           	   document.getElementById("txtaccname").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "description");
	          
    	      $('#accountDetailsWindow').jqxWindow('close');    
           });  
				           
}); 
				       
                       
</script>
   
<div id="jqxAccountsTypeSearch"></div>
    