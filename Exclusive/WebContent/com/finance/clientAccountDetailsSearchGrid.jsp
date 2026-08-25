<%@page import="com.search.ClsAccountSearch"%>
<% ClsAccountSearch DAO= new ClsAccountSearch(); %>
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
 
	var clientData='<%=DAO.clientAccountsDetails(session, dtype, atype, accountno, accountname, mobile, currency, date, check)%>';
 	$(document).ready(function () { 
 		var doctype='<%=dtype%>';
 		var debitcredit='<%=debitcredit%>';

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
               if(debitcredit=="2"){
            	   document.getElementById("txtdocno").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
	               document.getElementById("txtaccid").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "account");
	           	   document.getElementById("txtaccname").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "description");
	           	   document.getElementById("cmbcurrency").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "curid");
	           	   funRoundRate($('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "rate"),"txtrate");
	           	   document.getElementById("hidcurrencytype").value = $('#jqxAccountsTypeSearch').jqxGrid('getcellvalue', rowindex1, "type");
               }else if(debitcredit=="3"){
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
           	var apcheck=document.getElementById("hidapprvlcheck").value;
               if(doctype=="CPV"){    
		           	var atype=$('#cmbtotype').val();
		           	if(atype == "AP" && apcheck=="0"){
		            	var indexVal = document.getElementById("txttodocno").value;
		            	var check = 1;
			    	    $("#jqxApplyInvoicing1").load("applyInvoicingGrid.jsp?accountno="+indexVal+'&atype='+atype+"&check="+check);
		        	}else{
		        		$("#jqxApplyInvoicing").jqxGrid({ disabled: true});
		        	}
          	  }
               
           	   if(doctype=="CRV"){
					 var acctype=$('#cmbtotype').val();
					 if(acctype == "AR" && apcheck=="0"){
		            	var indexVal = document.getElementById("txttodocno").value;
		            	var check = 1;
		            	$("#jqxApplyInvoicing1").load("applyCashReceiptInvoicingGrid.jsp?accountno="+indexVal+'&atype='+acctype+"&check="+check);
			         }else{
			        		$("#jqxApplyCashReceiptInvoicing").jqxGrid({ disabled: true});
			        	}
           	   }
           	  
	          if(doctype=="BPV"){
		           	var atype=$('#cmbtotype').val();
		           	if(atype == "AP" && apcheck=="0"){
		            	var indexVal = document.getElementById("txttodocno").value;
		            	var check = 1;
		            	$("#bankApplyInvoicing1").load("applyBankInvoicingGrid.jsp?accountno="+indexVal+'&atype='+atype+"&check="+check);
		        	}else{
		        		$("#jqxApplyBankInvoicing").jqxGrid({ disabled: true});
		        	}
	       	   }
	          
	          if(doctype=="BRV"){
		           	var atype=$('#cmbtotype').val();
		           	if(atype == "AR" && apcheck=="0"){
		            	var indexVal = document.getElementById("txttodocno").value;
		            	var check = 1;
		            	$("#bankApplyInvoicing1").load("applyBankReceiptInvoicingGrid.jsp?accountno="+indexVal+'&atype='+atype+"&check="+check);
		        	}else{
		        		$("#jqxApplyBankInvoicing").jqxGrid({ disabled: true});
		        	}
	       	   }
	          
	          if(doctype=="ICPV"){
		           	var atype=$('#cmbtotype').val();
		           	if(atype == "AP" && apcheck=="0"){
		        		var indexVal = document.getElementById("txttodocno").value;
		        		var check = 1;
		      	       	$("#jqxIbCashApplyInvoicing1").load("applyIbCashInvoicingGrid.jsp?accountno="+indexVal+'&atype='+$('#cmbtotype').val()+"&check="+check);
		        	}else{
		        		$("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: true});
		        	}
	       	   }
	          
	          if(doctype=="ICRV"){
		           	var atype=$('#cmbtotype').val();
		           	if(atype == "AR" && apcheck=="0"){
		        		var indexVal = document.getElementById("txttodocno").value;
		        		var check = 1;
		      	       	$("#jqxIbCashApplyInvoicing1").load("applyIbCashReceiptInvoicingGrid.jsp?accountno="+indexVal+'&atype='+$('#cmbtotype').val()+"&check="+check);
		        	}else{
		        		$("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: true});
		        	}
	       	   }
	          
	          if(doctype=="IBP"){
		           	var atype=$('#cmbtotype').val();
		           	if(atype == "AP" && apcheck=="0"){
		        		var indexVal = document.getElementById("txttodocno").value;
		        		var check = 1;
		      	       	$("#bankApplyInvoicing1").load("applyIbBankInvoicingGrid.jsp?accountno="+indexVal+'&atype='+$('#cmbtotype').val()+"&check="+check);
		        	}else{
		        		$("#jqxApplyIbBankInvoicing").jqxGrid({ disabled: true});
		        	}
	       	   }
	          
	          if(doctype=="IBR"){
		           	var atype=$('#cmbtotype').val();
		           	if(atype == "AR" && apcheck=="0"){
		        		var indexVal = document.getElementById("txttodocno").value;
		        		var check = 1;
		      	       	$("#bankApplyInvoicing1").load("applyIbBankReceiptInvoicingGrid.jsp?accountno="+indexVal+'&atype='+$('#cmbtotype').val()+"&check="+check);
		        	}else{
		        		$("#jqxApplyIbBankInvoicing").jqxGrid({ disabled: true});
		        	}
	       	   }
	          
    	      $('#accountDetailsToWindow').jqxWindow('close'); 
           });  
				               
}); 
 	 function checkapprvl(doctype){
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();	
					if(parseInt(items)>0)        
						{  
						 document.getElementById("hidapprvlcheck").value="1";  
						}  
					else 
						{    
						 document.getElementById("hidapprvlcheck").value="0";      
						}
					
				} else {    
				}                
			}
			x.open("GET","../../getConfrmApprvl.jsp?doctype="+doctype, true);     
			x.send();
		}			       
                       
</script>
   
<div id="jqxAccountsTypeSearch"></div>
    