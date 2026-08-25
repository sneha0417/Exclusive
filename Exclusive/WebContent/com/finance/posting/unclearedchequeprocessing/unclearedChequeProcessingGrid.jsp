<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%@page import="com.finance.posting.unclearedchequeprocessing.ClsUnclearedChequeProcessingDAO"%>
<%ClsUnclearedChequeProcessingDAO DAO= new ClsUnclearedChequeProcessingDAO(); %>
<% String fromDate = request.getParameter("fromDate")==null?"0":request.getParameter("fromDate");
    String toDate = request.getParameter("toDate")==null?"0":request.getParameter("toDate");
    String type = request.getParameter("type")==null?"0":request.getParameter("type");
    String check = request.getParameter("check")==null?"0":request.getParameter("check");
    String disable = request.getParameter("disable")==null?"1":request.getParameter("disable");
 %> 
<script type="text/javascript">
		 var data1;  
        $(document).ready(function () { 
           
            var temp='<%=check%>';
            var temp1='<%=disable%>';
            var temp2='<%=type%>';
             
             if(temp=='1'){   
            	 data1='<%=DAO.unclearedChequePaymentGridReloading(session,fromDate, toDate,type,check)%>';     
           	 }
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'branchname', type: 'string' },
     						{name : 'bank', type: 'string' }, 
     						{name : 'bankname', type: 'string' },
     						{name : 'atype', type: 'string'   },
     						{name : 'acno', type: 'int'  },
     						{name : 'account', type: 'int'  },
     						{name : 'accountname', type: 'int'   },
     						{name : 'chqno', type: 'string'   },
     						{name : 'chqdt', type: 'date' },
     						{name : 'tr_dr', type: 'number'   },
     						{name : 'lamount', type: 'number'   },
     						{name : 'curr', type: 'int'  },
     						{name : 'rate', type: 'number'  },
     						{name : 'curid', type: 'int'  },
     						{name : 'brhid', type: 'int'  },
     						{name : 'doc_no', type: 'int'  },
     						{name : 'rowno', type: 'int'  },
     						{name : 'dtype', type: 'string'  },
     						{name : 'chqname', type: 'string'  },
     						{name : 'pdc', type: 'string'  },
     						{name : 'dealno', type: 'string'  }
                        ],
                         localdata: data1,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            
            
            
            $("#jqxUnclearedChequePayment").on("bindingcomplete", function (event) {
        		
            	
            	if(temp2=='UCR'){
    				
    				$('#jqxUnclearedChequePayment').jqxGrid('hidecolumn', 'dealno');
    			}
        	}); 
            
            
            
            
            
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxUnclearedChequePayment").jqxGrid(
            {
            	width: '99%',
                height: 250,
                source: dataAdapter,
                editable: false,
                showfilterrow: true,
                filterable: true,
                selectionmode: 'singlerow',
                       
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Branch',  datafield: 'branchname',  width: '10%' },
							{ text: 'Bank No.',  datafield: 'bank',  width: '5%' },
							{ text: 'Bank Name',  datafield: 'bankname',  width: '15%' },
							{ text: 'A/C Type', datafield: 'atype', width: '5%' },	
							{ text: 'Account No', hidden: true, datafield: 'acno', width: '20%' },	
							{ text: 'Account No', datafield: 'account', width: '10%' },
							{ text: 'Account Name', datafield: 'accountname'},
							{ text: 'Deal No', datafield: 'dealno', width: '9%' },
							{ text: 'Cheque No', datafield: 'chqno', width: '8%' },
							{ text: 'Cheque Date', datafield: 'chqdt', cellsformat: 'dd.MM.yyyy' ,width: '8%' },
							{ text: 'Amount', datafield: 'tr_dr', width: '8%', cellsformat: 'd2',cellsalign: 'right', align: 'right' },
							{ text: 'Base Amt',  hidden: true, datafield: 'lamount', cellsformat: 'd2', width: '10%' },
							{ text: 'Currency',  hidden: true, datafield: 'curr', width: '10%' },
							{ text: 'Rate',  hidden: true, datafield: 'rate', cellsformat: 'd2', width: '10%' },
							{ text: 'Currency Id',  hidden: true, datafield: 'curid', width: '10%' },
							{ text: 'Branch Id',  hidden: true, datafield: 'brhid', width: '10%' },
							{ text: 'Doc No', hidden: true, datafield: 'doc_no', width: '10%' },
							{ text: 'Row No', hidden: true, datafield: 'rowno', width: '10%' },
							{ text: 'Dtype', hidden: true, datafield: 'dtype', width: '10%' },
							{ text: 'Cheque Name', hidden: true, datafield: 'chqname', width: '10%' },
							{ text: 'PDC', hidden: true, datafield: 'pdc', width: '10%' },
						]
            });
            
            //Add empty row
            
            
            
            
            
            
            
            if(temp!='1'){   
         	   $("#jqxUnclearedChequePayment").jqxGrid('addrow', null, {});
          	 }
         	  
            if(temp1==0){
            	$("#jqxUnclearedChequePayment").jqxGrid('disabled', true);
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#jqxUnclearedChequePayment').on('rowdoubleclick', function (event) {
           	 
                var rowindex1 = event.args.rowindex;
                var toform = "";
                
                var indexVal =  $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "doc_no");
                var dtype =  $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "dtype");
                
                if(dtype=='UCP'){
                	toform='Bank Payment';
                	fromform='Uncleared Cheque Payment';
                }else if(dtype=='UCR'){
                	
                	
                	
                	toform='Bank Receipt';
                	fromform='Uncleared Cheque Receipt';
                	
                	
                }
                
                $.messager.confirm('Message', 'Do you want to Create '+toform+' Voucher Against '+fromform+' Voucher Doc No - '+indexVal+'?', function(r){
    		        
    		     	if(r==false)
    		     	  {
    		     		return false; 
    		     	  }
    		     	else{
    		     		 if(indexVal>0){
    		     			  $("#jqxBankPayment").jqxGrid({ disabled: false});
    		     			  document.getElementById("txtchqno").value= $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "chqno");
    		     			  document.getElementById("txtchqdt").value= $('#jqxUnclearedChequePayment').jqxGrid('getcelltext', rowindex1, "chqdt");
    		     			  document.getElementById("txtchqname").value= $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "chqname");
    		     			  document.getElementById("chckpdc").value= $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "pdc");
    		     			  document.getElementById("txtfromrate").value= $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "rate");
    		     			  document.getElementById("txtgriddtype").value= $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "dtype");
    		                  document.getElementById("txtdocno").value= indexVal;
    		                  var postingDate = document.getElementById("postingDate").value;
							  
    		                  $("#overlay, #PleaseWait").show();
    		                  
    		  	              $("#bankPaymentDiv").load("bankPaymentGrid.jsp?txtbankpaydocno2="+indexVal+'&dtype='+dtype+'&postingDate='+postingDate+'&check=1');
    		  	              
    		  			     }	
    		     	}
    		});
               
            });
});

</script>
<div id="jqxUnclearedChequePayment"></div>
    
<input type="hidden" id="rowindex"/> 
<input type="hidden" id="type"/>  