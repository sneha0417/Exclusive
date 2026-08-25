<%@page import="com.fixedassets.assets.assetmaster.ClsAssetmasterDAO" %>
<%ClsAssetmasterDAO amd=new ClsAssetmasterDAO(); %>


<%@page import="com.fixedassets.assets.assetmaster.ClsAssetmasterDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 
 //clientaccountno,clientaccountname,clientmobile,curr,date,checked
 
/*  String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
 String atype = request.getParameter("atype")==null?"0":request.getParameter("atype"); */
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String mobile = request.getParameter("mobile")==null?"0":request.getParameter("mobile");
 String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
/*  String debitcredit = request.getParameter("debitcredit")==null?"0":request.getParameter("debitcredit"); */
 String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 
	var clientData='<%=amd.AccountsDetails(session,accountno,accountname, mobile, currency, date, check)%>';
 	$(document).ready(function () { 
 		var doctype='<%=check%>';
 		var debitcredit='<%=check%>';

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
  						   {name : 'rate', type: 'string'  },
  						   {name : 'type', type: 'string'  }
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
				       ]
               });
        
    	   $('#jqxAccountsTypeSearch').on('rowdoubleclick', function (event) {
               var rowindex1 = event.args.rowindex;
              // supplieracc supname supaccdocno supcmbcurrency suprate suphidcurrencytype
              //  supplieraccId supplieraccName
               
            	   document.getElementById("supaccdocno").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
	               document.getElementById("supplieraccId").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "account");
	           	   document.getElementById("supplieraccName").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "description");
	           	   document.getElementById("supcmbcurrency").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "curid");
	           	   funRoundRate($('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "rate"),"suprate");
	           	   document.getElementById("suphidcurrencytype").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "type");
              /*  }else if(debitcredit=="3"){
            	   document.getElementById("txtdocno").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
	               document.getElementById("txtaccid").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "account");
	           	   document.getElementById("txtaccname").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "description");
               }else{
            	   document.getElementById("txttodocno").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
	               document.getElementById("txttoaccid").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "account");
	           	   document.getElementById("txttoaccname").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "description");
	           	   document.getElementById("cmbtocurrency").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "curid");
	           	   document.getElementById("hidtocurrencytype").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "type");
	           	   funRoundRate($('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "rate"),"txttorate");
               }
           	
               if(doctype=="CPV"){
		           	var atype=$('#cmbtotype').val();
		           	if(atype == "AP"){
		            	var indexVal = document.getElementById("txttodocno").value;
			    	    $("#jqxApplyInvoicing1").load("applyInvoicingGrid.jsp?accountno="+indexVal+'&atype='+atype);
		        	}else{
		        		$("#jqxApplyInvoicing").jqxGrid({ disabled: true});
		        	}
          	  }
               
           	   if(doctype=="CRV"){
					 var acctype=$('#cmbtotype').val();
					 if(acctype == "AR"){
		            	var indexVal = document.getElementById("txttodocno").value;
		    	       	$("#jqxApplyInvoicing1").load("applyCashReceiptInvoicingGrid.jsp?accountno="+indexVal+'&atype='+acctype);
			         }else{
			        		$("#jqxApplyCashReceiptInvoicing").jqxGrid({ disabled: true});
			        	}
           	   }
           	  
	          if(doctype=="BPV"){
		           	var atype=$('#cmbtotype').val();
		           	if(atype == "AP"){
		            	var indexVal = document.getElementById("txttodocno").value;
			    	    $("#bankApplyInvoicing1").load("applyBankInvoicingGrid.jsp?accountno="+indexVal+'&atype='+atype);
		        	}else{
		        		$("#jqxApplyBankInvoicing").jqxGrid({ disabled: true});
		        	}
	       	   }
	          
	          if(doctype=="BRV"){
		           	var atype=$('#cmbtotype').val();
		           	if(atype == "AR"){
		            	var indexVal = document.getElementById("txttodocno").value;
			    	    $("#bankApplyInvoicing1").load("applyBankReceiptInvoicingGrid.jsp?accountno="+indexVal+'&atype='+atype);
		        	}else{
		        		$("#jqxApplyBankInvoicing").jqxGrid({ disabled: true});
		        	}
	       	   }
	          
	          if(doctype=="ICPV"){
		           	var atype=$('#cmbtotype').val();
		           	if(atype == "AP"){
		        		var indexVal = document.getElementById("txttodocno").value;
		      	       	$("#jqxIbCashApplyInvoicing1").load("applyIbCashInvoicingGrid.jsp?accountno="+indexVal+'&atype='+$('#cmbtotype').val());
		        	}else{
		        		$("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: true});
		        	}
	       	   }
	          
	          if(doctype=="ICRV"){
		           	var atype=$('#cmbtotype').val();
		           	if(atype == "AR"){
		        		var indexVal = document.getElementById("txttodocno").value;
		      	       	$("#jqxIbCashApplyInvoicing1").load("applyIbCashReceiptInvoicingGrid.jsp?accountno="+indexVal+'&atype='+$('#cmbtotype').val());
		        	}else{
		        		$("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: true});
		        	}
	       	   }
	          
	          if(doctype=="IBP"){
		           	var atype=$('#cmbtotype').val();
		           	if(atype == "AP"){
		        		var indexVal = document.getElementById("txttodocno").value;
		      	       	$("#bankApplyInvoicing1").load("applyIbBankInvoicingGrid.jsp?accountno="+indexVal+'&atype='+$('#cmbtotype').val());
		        	}else{
		        		$("#jqxApplyIbBankInvoicing").jqxGrid({ disabled: true});
		        	}
	       	   }
	          
	          if(doctype=="IBR"){
		           	var atype=$('#cmbtotype').val();
		           	if(atype == "AR"){
		        		var indexVal = document.getElementById("txttodocno").value;
		      	       	$("#bankApplyInvoicing1").load("applyIbBankReceiptInvoicingGrid.jsp?accountno="+indexVal+'&atype='+$('#cmbtotype').val());
		        	}else{
		        		$("#jqxApplyIbBankInvoicing").jqxGrid({ disabled: true});
		        	}
	       	   } */
	       	document.getElementById("errormsg").innerText="";
    	      $('#accountDetailsWindow').jqxWindow('close'); 
           });  
				           
}); 
				       
                       
</script>
   
<div id="jqxAccountsTypeSearch"></div>
    