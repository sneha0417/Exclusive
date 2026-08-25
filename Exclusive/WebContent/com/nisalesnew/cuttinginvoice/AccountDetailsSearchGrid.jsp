 <%@page import="com.nisalesnew.cuttinginvoice.ClsCuttingInvoiceDAO"%>
<% ClsCuttingInvoiceDAO  sDAO = new ClsCuttingInvoiceDAO();%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
 String atype = request.getParameter("atype")==null?"0":request.getParameter("atype");
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String mobile = request.getParameter("mobile")==null?"0":request.getParameter("mobile");
 String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
 String debitcredit = request.getParameter("debitcredit")==null?"0":request.getParameter("debitcredit");
 String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 
	var clientData='<%=sDAO.clientAccountsDetails(session, dtype, atype, accountno, accountname, mobile, currency, date, check)%>';
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
  						 {name : 'msg', type: 'int'  },
  						   
  						 
  						   {name : 'rate', type: 'string'  },
  						   {name : 'type', type: 'string'  },
  						   {name : 'tax', type: 'string'  },
  						   {name : 'taxper', type: 'string'  }
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
  			 columnsresize: true,
  			 localization: {thousandsSeparator: ""},
  			
             columns: [
						{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
						{ text: 'Account', datafield: 'account', width: '25%' },
						{ text: 'Account Name', datafield: 'description', width: '50%' },
						{ text: 'Currency', datafield: 'currency', width: '10%' },
						{ text: 'Mobile', datafield: 'mobile', width: '15%' },
						{ text: 'Currency Id', hidden: true, datafield: 'curid', width: '5%' },
						{ text: 'Rate', hidden: true, datafield: 'rate', width: '5%' },
						{ text: 'Currency Type', hidden: true, datafield: 'type', width: '5%' },
						{ text: 'Tax', hidden: true, datafield: 'tax', width: '5%' },
						{ text: 'Taxper', hidden: true, datafield: 'taxper', width: '5%' },
				       ]
               });
        
    	   $('#jqxAccountsTypeSearch').on('rowdoubleclick', function (event) {
               var rowindex1 = event.args.rowindex; 
 var msg=$('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "msg");
               
               if(parseInt(msg)==1)
            	   {
            	   document.getElementById("errormsg").innerText="Credit Limit Exceeded";
            	 return 0;
            	   }
               else
            	   {
            	   document.getElementById("errormsg").innerText="";
            	   document.getElementById("acno").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
	               document.getElementById("accid").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "account");
	           	   document.getElementById("accname").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "description");
	           	   document.getElementById("currs").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "currency");
	        	   document.getElementById("currsid").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "curid");
				   document.getElementById("hidtaxper").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "taxper");
	           	   funRoundRate($('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "rate"),"ratess");
               
    	      $('#accountSearchwindow').jqxWindow('close'); 
            	   }
           });  
				           
}); 
				       
                       
</script>
   
<div id="jqxAccountsTypeSearch"></div>
    