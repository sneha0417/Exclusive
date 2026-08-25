<%@page import="com.finance.posting.pdcpostingpayment.ClsPDCPostingPaymentDAO"%>
<%ClsPDCPostingPaymentDAO DAO= new ClsPDCPostingPaymentDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
 String criteria = request.getParameter("txtcriteria")==null?"0":request.getParameter("txtcriteria"); 
 String accId = request.getParameter("accId")==null?"0":request.getParameter("accId");
 String accType = request.getParameter("accType")==null?"0":request.getParameter("accType");
 String fromDate = request.getParameter("fromDate")==null?"0":request.getParameter("fromDate");
 String toDate = request.getParameter("toDate")==null?"0":request.getParameter("toDate");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%>

<script type="text/javascript">
		 var data1;  
        $(document).ready(function () { 
            
            var temp='<%=criteria%>';
            
             if(temp!="0")
           	 {     
            	  data1='<%=DAO.applyInvoiceGridReloading(session, criteria, accId, accType, fromDate, toDate, check)%>';     
             } 
            
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'branchname', type: 'string' },
							{name : 'bankacno', type: 'int'  },
     						{name : 'bank', type: 'string' }, 
     						{name : 'bankname', type: 'string' },
     						{name : 'atype', type: 'string'   },
     						{name : 'acno', type: 'int'  },
     						{name : 'account', type: 'int'  },
     						{name : 'accountname', type: 'string' },
     						{name : 'chqno', type: 'string'   },
     						{name : 'chqdt', type: 'string' },
     						{name : 'tr_dr', type: 'string'   },
     						{name : 'lamount', type: 'number'   },
     						{name : 'curr', type: 'int'  },
     						{name : 'rate', type: 'int'  },
     						{name : 'curid', type: 'int'  },
     						{name : 'currtype', type: 'string' },
     						{name : 'brhid', type: 'int'  },
     						{name : 'doc_no', type: 'int'  },
     						{name : 'tr_no', type: 'int'  },
     						{name : 'rowno', type: 'int'  },
     						{name : 'dtype', type: 'string'  },
     						{name : 'ib', type: 'int'  },
     						{name : 'pdcposttrno', type: 'int'  }
     						
                        ],
                          localdata: data1,   
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxJournalVoucher").jqxGrid(
            {
                width: '99%',
                height: 250,
                source: dataAdapter,
                editable: false,
                selectionmode: 'singlerow',
				filterable: true,
                showfilterrow: true,
                
				columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Branch',  datafield: 'branchname',  width: '10%' },
							{ text: 'Bank Doc No', hidden: true, datafield: 'bankacno', width: '10%' },	
							{ text: 'Bank No.',  datafield: 'bank',  width: '5%' },
							{ text: 'Bank Name',  datafield: 'bankname',  width: '15%' },
							{ text: 'A/C Type', datafield: 'atype', width: '5%' },	
							{ text: 'Account No', hidden: true, datafield: 'acno', width: '10%' },	
							{ text: 'Account No', datafield: 'account', width: '10%' },
							{ text: 'Account Name', datafield: 'accountname', width: '20%' },
							{ text: 'Cheque No', datafield: 'chqno', width: '10%' },
							{ text: 'Cheque Date', datafield: 'chqdt', width: '10%' },
							{ text: 'Amount', datafield: 'tr_dr', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Base Amt',  hidden: true, datafield: 'lamount', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Currency',  hidden: true, datafield: 'curr', width: '10%' },
							{ text: 'Rate',  hidden: true, datafield: 'rate', width: '10%' },
							{ text: 'Currency Id',  hidden: true, datafield: 'curid', width: '10%' },
							{ text: 'Currency Type',  hidden: true, datafield: 'currtype', width: '10%' },
							{ text: 'Branch Id',  hidden: true, datafield: 'brhid', width: '10%' },
							{ text: 'Doc No', hidden: true, datafield: 'doc_no', width: '10%' },
							{ text: 'Tr No', hidden: true, datafield: 'tr_no', width: '10%' },
							{ text: 'Row No', hidden: true, datafield: 'rowno', width: '10%' },
							{ text: 'Dtype', hidden: true, datafield: 'dtype', width: '10%' },
							{ text: 'Inter-branch', hidden: true, datafield: 'ib', width: '10%' },
							{ text: 'Post Tr No', hidden: true, datafield: 'pdcposttrno', width: '10%' },
						]
            });
            
             if(temp==0)
          	 {   
              //Add empty row
         	   $("#jqxJournalVoucher").jqxGrid('addrow', null, {});
          	  } 
             
             $("#overlay, #PleaseWait").hide();
             
            $('#jqxJournalVoucher').on('rowdoubleclick', function (event) {
            	 var rowindex1 = event.args.rowindex;
            	 var posted=$('#cmbcriteria').val();
            	 var criteria = "";
            	 
            	 if(posted=="1"){criteria="POSTED";}else if(posted=="2"){criteria="PDC RETURNED";}else if(posted=="3"){criteria="PDC DISHONURED";}
            	 else if(posted=="5"){criteria="RETURNED PDC REVERSED";}else if(posted=="6"){criteria="DISHONURED PDC REVERSED";}else if(posted=="7"){criteria="CDC DISHONURED";}

            	 if(posted=="4"){
            		 $('#chequedate').jqxDateTimeInput({disabled: false}); 
                	 document.getElementById("txtbankdocno").value= $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "bankacno");
                	 document.getElementById("txtbankaccid").value= $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "bank");
                	 document.getElementById("txtbankaccname").value= $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "bankname");
                	 document.getElementById("txtchequeno").value= $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "chqno");
                	 $("#chequedate").jqxDateTimeInput('val', $("#jqxJournalVoucher").jqxGrid('getcellvalue', rowindex1, "chqdt"));
                	 document.getElementById("txtgriddocno").value= $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "doc_no");
                	 document.getElementById("txttrno").value= $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "tr_no");
                  } else if(posted=="2"){
	                	 $("#jqxJournalVoucherApplying").jqxGrid({ disabled: false});
		                 var indexVal =  $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "tr_no");
		                 document.getElementById("txtchqno").value= $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "chqno");
		                 document.getElementById("txtrowno").value= $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "rowno");
		                 document.getElementById("txtdtype").value= $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "dtype");
		                 document.getElementById("txtgriddocno").value= $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "doc_no");
		                 document.getElementById("txtbankdocno").value= $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "bankacno");
		                 document.getElementById("txttrno").value= indexVal;
		   			     if(indexVal>0){
		   	                var amount = $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "tr_dr");
		   	                
		   	                var postrows = $("#jqxJournalVoucherApplying").jqxGrid('getrows');
		   	              	if(postrows.length<2){
		   	                	$("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
		   			     	}
		   	                
		   			    	$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "doc_no", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "acno"));
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "atype", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "atype"));
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "account", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "account"));
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "accountname", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "accountname"));
		   		    	 
		   		    	    if(!isNaN(amount)){
		   		    		    if($('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "currtype").trim()=="M"){
		   		    		    		var baseamount = parseFloat(amount) * parseFloat($('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "rate"));
		   		    		    		$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "baseamount", baseamount);
		   		    		    }else{
		   		    		    	var baseamount = parseFloat(amount) / parseFloat($('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "rate"));
			    		    		$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "baseamount", baseamount);
		   		    		    }
		   		    	    }
	   		    	        $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "description", criteria+" on "+$('#jqxDate').val()+ " " +$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "dtype")+" - "+$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "doc_no")+" of Cheque No. "+$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "chqno")+" Dated "+$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "chqdt"));
	   		    	        $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "currencyid", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "curid"));
	   		    	        $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "currencytype", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "currtype"));
	   		    	        $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "rate", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "rate"));
		   		    	 	$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "credit", amount);
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "sr_no", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "brhid"));
		   		    	 
		   		    		$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "doc_no", $('#txtpdcdocno').val());
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "atype", $('#txtpdcatype').val());
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "account", $('#txtpdcaccid').val());
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "accountname", $('#txtpdcaccname').val());
		   		    	    
		   		    	    if(!isNaN(amount)){
		   		    		    if($('#txtpdctype').val().trim()=="M"){
		   		    		    	var pdcbaseamount = parseFloat(amount) * parseFloat($('#txtpdcrate').val());
		   		    		    	$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "baseamount", pdcbaseamount);
		   		    		    }else{
		   		    		    	var pdcbaseamount = parseFloat(amount) / parseFloat($('#txtpdcrate').val());
		   		    	    		$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "baseamount", pdcbaseamount);
		   		    		    }
		   		    	    }
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "description", criteria+" on "+$('#jqxDate').val()+" "+$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "dtype")+" - "+$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "doc_no")+" of Cheque No. "+$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "chqno")+" Dated "+$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "chqdt"));
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "currencyid", $('#txtpdccurid').val());
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "currencytype", $('#txtpdctype').val());
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "rate", $('#txtpdcrate').val()); 
		   		    	 	$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "debit", amount);
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "sr_no", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "brhid"));
	   			     }
                 } else {
	            	 $("#jqxJournalVoucherApplying").jqxGrid({ disabled: false});
	                 var indexVal =  $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "tr_no");
	                 document.getElementById("txtchqno").value= $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "chqno");
	                 document.getElementById("txtrowno").value= $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "rowno");
	                 document.getElementById("txtdtype").value= $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "dtype");
	                 document.getElementById("txtgriddocno").value= $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "doc_no");
	                 document.getElementById("txtbankdocno").value= $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "bankacno");
	                 document.getElementById("txtibbranch").value= $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "ib");
	                 document.getElementById("txttrno").value= indexVal;
	   			     if(indexVal>0){
	   	                var amount = $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "tr_dr");
	   	                
	   	                if(posted!="5" || posted!="6"){
	   	                	
	   	              	var postrows = $("#jqxJournalVoucherApplying").jqxGrid('getrows');
	   	              	if(postrows.length<2){
	   	                	$("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
	   			     	}
	   	                
	   			    	$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "doc_no", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "bankacno"));
	   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "atype", "GL");
	   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "account", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "bank"));
	   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "accountname", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "bankname"));
	   		    	 
	   		    	    if(!isNaN(amount)){
	   		    		    if($('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "currtype").trim()=="M"){
	   		    		    		var baseamount = parseFloat(amount) * parseFloat($('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "rate"));
	   		    		    		$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "baseamount", baseamount);
	   		    		    }else{
	   		    		    	var baseamount = parseFloat(amount) / parseFloat($('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "rate"));
   		    		    		$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "baseamount", baseamount);
	   		    		    }
	   		    	    }
	   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "description", ""+$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "dtype")+" - "+$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "doc_no")+" of Cheque No. "+$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "chqno")+" Dated "+$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "chqdt")+" is "+criteria+" on "+$('#jqxDate').val()+"");
	   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "currencyid", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "curid"));
	   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "currencytype", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "currtype"));
	   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "rate", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "rate"));
	   	                
	   	                }
	   	                
	   		    	 	if(posted=="1"){
		   		    	 	$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "credit", amount);
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "sr_no", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "brhid"));
		   		    	 
		   		    		$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "doc_no", $('#txtpdcdocno').val());
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "atype", $('#txtpdcatype').val());
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "account", $('#txtpdcaccid').val());
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "accountname", $('#txtpdcaccname').val());
		   		    	    
		   		    	    if(!isNaN(amount)){
		   		    		    if($('#txtpdctype').val().trim()=="M"){
		   		    		    	var pdcbaseamount = parseFloat(amount) * parseFloat($('#txtpdcrate').val());
		   		    		    	$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "baseamount", pdcbaseamount);
		   		    		    }else{
		   		    		    	var pdcbaseamount = parseFloat(amount) / parseFloat($('#txtpdcrate').val());
		   		    	    		$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "baseamount", pdcbaseamount);
		   		    		    }
		   		    	    }
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "description", ""+$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "dtype")+" - "+$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "doc_no")+" of Cheque No. "+$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "chqno")+" Dated "+$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "chqdt")+" is "+criteria+" on "+$('#jqxDate').val()+"");
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "currencyid", $('#txtpdccurid').val());
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "currencytype", $('#txtpdctype').val());
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "rate", $('#txtpdcrate').val()); 
		   		    	 	$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "debit", amount);
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "sr_no", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "brhid"));
		   		    	 
							if(posted=="1"){
		   		    		 $.messager.confirm('Confirm', 'Selected Bank Account is '+$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "bankname")+', Do you want to change ?', function(r){
		 						if (r){
		 							$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "doc_no","");
		 		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "account", "");
		 		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "accountname","");
		 						 }
		 						else{
		 							
		 						}
		 					   });
		   		    	   }
						 
		   		    	 }else if(posted=="3" || posted=="7"){
		   		    		document.getElementById("txtposttrno").value= $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "pdcposttrno");
		   		    		
		   		    		$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "debit", amount);
		   		    		
		   		    		$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "doc_no", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "acno"));
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "atype", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "atype"));
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "account", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "account"));
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "accountname", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "accountname"));
		   		    	    
		   		    	    if(!isNaN(amount)){
		   		    		    if($('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "currtype").trim()=="M"){
		   		    		    	var baseamount = parseFloat(amount) * parseFloat($('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "rate"));
		   		    		    	$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "baseamount", baseamount);
		   		    		    }else{
		   		    		    	var baseamount = parseFloat(amount) / parseFloat($('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "rate"));
		   		    	    		$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "baseamount", baseamount);
		   		    		    }
		   		    	    }
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "description", ""+$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "dtype")+" - "+$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "doc_no")+" of Cheque No. "+$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "chqno")+" Dated "+$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "chqdt")+" is "+criteria+" on "+$('#jqxDate').val()+"");
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "currencyid", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "curid"));
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "currencytype", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "currtype"));
		   		    	    $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "rate", $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "rate")); 
		   		    	 	$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 1, "credit", amount);
		   		    	 	
		   		    	 }
	   		    	    
		   		    	else if(posted=="5" || posted=="6"){
		   		    		document.getElementById("txtrowno").value= $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "rowno");
		   		    		document.getElementById("txttrno").value= $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "tr_no");
		   		    		var returnedtrno = $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "pdcposttrno");
		   		    		document.getElementById("txtposttrno").value= returnedtrno;
		   		    		var check = 1;
		   		    		
		   		    		$("#overlay, #PleaseWait").show();
		   		    		
		   		    		$("#jqxJournalVoucherApplyingGrid").load("journalVoucherApplyingGrid.jsp?txttrno="+returnedtrno+'&check='+check);
		   		    	}
	   			     }
                 }

            });  
          
        });
    </script>
    <div id="jqxJournalVoucher"></div>
    <input type="hidden" id="rowindex"/> 