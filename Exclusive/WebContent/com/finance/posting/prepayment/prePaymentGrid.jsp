<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.posting.prePayment.ClsPrePaymentDAO"%>
<% ClsPrePaymentDAO DAO= new ClsPrePaymentDAO(); %> 
<% 
String type = request.getParameter("txttype")==null?"0":request.getParameter("txttype"); 
String accId = request.getParameter("accId")==null?"0":request.getParameter("accId");
String fromDate = request.getParameter("fromDate")==null?"0":request.getParameter("fromDate");
String toDate = request.getParameter("toDate")==null?"0":request.getParameter("toDate");
String check = request.getParameter("check")==null?"0":request.getParameter("check");
%>
<script type="text/javascript">
        var data1; 
		var dataExcelExport; 
        $(document).ready(function () { 	
        	var temp='<%=type%>';
            
            if(temp!=0)
            	{
            	   data1='<%=DAO.prePaymentGridLoading(session, type, accId, fromDate, toDate, check)%>';
				   dataExcelExport='<%=DAO.prePaymentGridExcelExport(session, type, accId, fromDate, toDate, check)%>';				   
           	   } 
            
             // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'branch', type: 'string' },
     						{name : 'dtype', type: 'string'  },
     						{name : 'transno', type: 'int' },
     						{name : 'atype', type: 'string'   },
     						{name : 'acno', type: 'int' },
     						{name : 'account', type: 'int'   },
     		     		    {name : 'accountname', type: 'string'   },
     						{name : 'postacno', type: 'int'   },
     						{name : 'paccount', type: 'int'   },
     						{name : 'paccountname', type: 'string'   },
     						{name : 'date', type: 'date' },
							{name : 'description', type: 'string'   },
     						{name : 'dramount', type: 'number'   },
     						{name : 'postamount', type: 'number'   },
     						{name : 'pendamount', type: 'number'   },
     						{name : 'trno', type: 'int' },
     						{name : 'tranid', type: 'int' },
     						{name : 'curid', type: 'int'   },
     						{name : 'c_rate', type: 'number' },
     						{name : 'costtype', type: 'string'    },
							{name : 'costgroup', type: 'string'    },
							{name : 'costcode', type: 'number'    },
							{name : 'desc1', type: 'string'  },
							{name : 'rowno', type: 'int'   },
							{name : 'freq', type: 'int'   },
							{name : 'freqtype', type: 'int'   },
							{name : 'noofins', type: 'string'   },
							{name : 'costcde', type: 'string'  },
							{name : 'stdate', type: 'date' },
							{name : 'enddate', type: 'date' },
     						{name : 'doc_no', type: 'int' }
                        ],
                		   localdata: data1,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
             
            if($('#cmbtype').val()==3)
 	         {
    	   $('#jqxPrePayment').jqxGrid({ selectionmode: 'checkbox'}); 
       	
 	           }
            else{
            	$('#jqxPrePayment').jqxGrid({ selectionmode: 'singlerow'});
            }
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });

            $("#jqxPrePayment").jqxGrid(
            {
                width: '99%',
                height: 250,
                source: dataAdapter,
                editable: false,
                columnsresize: true,
                localization: {thousandsSeparator: ""},
                
                 //Add row method
                 handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxPrePayment').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxPrePayment').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'pendamount' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {                                                        
                            var commit = $("#jqxPrePayment").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    }
                },  
                    
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '3%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Branch', datafield: 'branch',  width: '8%' },
							{ text: 'Doc Type', datafield: 'dtype',  width: '4%' },
							{ text: 'Doc No.', datafield: 'transno',  width: '7%' },	
							{ text: 'Type', datafield: 'atype',  width: '3%' },
							{ text: 'Account', hidden: true, datafield: 'acno',  width: '5%' },
							{ text: 'Account No.', datafield: 'account',  width: '5%' },
							{ text: 'Account Name', datafield: 'accountname'},	
							{ text: 'Post A/C', hidden: true, datafield: 'postacno',  width: '5%' },
							{ text: 'Post A/C No.', datafield: 'paccount',  width: '5%' },
							{ text: 'Post A/C Name' , datafield: 'paccountname',  width: '14%' },
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy',  width: '5%' },
							{ text: 'Description' , datafield: 'description',  width: '11%' },
							{ text: 'Amount', datafield: 'dramount',  width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Posted', datafield: 'postamount',  width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Balance' , datafield: 'pendamount',  width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Tr No', hidden: true, datafield: 'trno',  width: '7%' },
							{ text: 'Tran Id', hidden: true, datafield: 'tranid',  width: '7%' },
							{ text: 'Currency Id', hidden: true, datafield: 'curid',  width: '7%' },
							{ text: 'Rate', hidden: true, datafield: 'c_rate',  width: '7%' },
							{ text: 'Cost Type', hidden: true, datafield: 'costgroup', width: '8%' },
							{ text: 'Cost Id', hidden: true, datafield: 'costtype', width: '8%' },
							{ text: 'Cost Code', hidden: true, datafield: 'costcode', width: '5%' },
							{ text: 'Description', hidden: true, datafield: 'desc1', width: '25%' },
							{ text: 'Row No', hidden: true, datafield: 'rowno', width: '8%' },
							{ text: 'Frequency', hidden: true, datafield: 'freq', width: '8%' },
							{ text: 'Frequency Type', hidden: true, datafield: 'freqtype', width: '8%' },
							{ text: 'Inst. Nos', hidden: true, datafield: 'noofins', width: '8%' },
							{ text: 'costcde', hidden: true, datafield: 'costcde', width: '8%' },
							{ text: 'St Date', hidden: true, datafield: 'stdate', cellsformat: 'dd.MM.yyyy',  width: '5%' },
							{ text: 'End Date', hidden: true, datafield: 'enddate', cellsformat: 'dd.MM.yyyy',  width: '5%' },
							{ text: 'Doc No.', hidden: true, datafield: 'doc_no',  width: '7%' },	
						]
            });   
            
           
            //Add empty row
            if(temp==0){
          	   $("#jqxPrePayment").jqxGrid('addrow', null, {});
            }
            
          	 /* if(temp>0){
          		$("#jqxPrePayment").jqxGrid('disabled', true); 
         	} */
            
         	$("#overlay, #PleaseWait").hide();
         	
          	 $('#jqxPrePayment').on('rowdoubleclick', function (event) {
                 var rowindex1 = event.args.rowindex;
                 var value = $('#cmbtype').val();
                 if(value==1){
	                 document.getElementById("txtaccountdocno").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "acno");
	                 document.getElementById("txttrno").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "trno");
	                 document.getElementById("txttranid").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "tranid");
	                 document.getElementById("txtamount").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "dramount");
	                 /* document.getElementById("txtcostgroup").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "costgroup");
                	 document.getElementById("txtcosttype").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "costtype"); */
                	 document.getElementById("txtcostno").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "costcode");
                 }
                 
                 if(value==2){
                	 document.getElementById("txtaccountdocno").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "acno");
                	 document.getElementById("txtdistributiondocno").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "postacno");
                	 document.getElementById("txtdistributionaccid").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "paccount");
                	 document.getElementById("txtdistributionaccname").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "paccountname");
	                 document.getElementById("txttrno").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "trno");
	                 document.getElementById("txtdtype").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "dtype");
	                 document.getElementById("txttranid").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "tranid");
	                  document.getElementById("txtcostgroup").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "costgroup");
                	 document.getElementById("txtcosttype").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "costtype"); 
                	 document.getElementById("txtcostno").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "costcode");
                	 document.getElementById("txtcostcode").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "costcde");
                	 document.getElementById("txtdueafter").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "freq");
	                 document.getElementById("txtamount").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "dramount");
	                 document.getElementById("hidcmbfrequency").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "freqtype");
	  			     getInstallmentEndDate($('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "freqtype"),$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "noofins"),$("#jqxPrePayment").jqxGrid('getcelltext', rowindex1, "stdate"));
	                 $("#jqxStartDate").jqxDateTimeInput('val', $("#jqxPrePayment").jqxGrid('getcellvalue', rowindex1, "stdate"));
                	 document.getElementById("txtinstnos").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "noofins");
                	 document.getElementById("txtinstamt").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "dramount");
                	 document.getElementById("txtdescription").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "desc1");
                	 funreloaddistributiongrid();$("#btnPrintSummary").show();
                	 document.getElementById("btnUpdate").value="Edit";
                 }
                 
                 /* if(value==3){
                	 $("#jqxJournalVoucherApplying").jqxGrid({ disabled: false});
                	 document.getElementById("txttrno").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "trno");
                	 document.getElementById("txtdtype").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "dtype");
                	 document.getElementById("txttranid").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "tranid");
                	 document.getElementById("txtaccountdocno").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "acno");
                	 document.getElementById("txtdistributiondocno").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "postacno");
                	 document.getElementById("txtdebittotal").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "dramount");
                	  document.getElementById("txtcostgroup").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "costgroup");
                	 document.getElementById("txtcosttype").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "costtype"); 
                	 document.getElementById("txtcostno").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "costcode");
                	 document.getElementById("txtrowno").value = $('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "rowno");
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 0, "doc_no" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "acno"));
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 0, "atype" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "atype"));
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 0, "account" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "account"));
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 0, "accountname" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "accountname"));
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 0, "costgroup" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "costgroup"));
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 0, "costtype" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "costtype"));
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 0, "costcode" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "costcode"));
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 0, "debit" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "dramount"));
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 0, "currencyid" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "curid"));
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 0, "rate" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "c_rate"));
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 0, "description" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "desc1"));
                	 
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 1, "doc_no" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "postacno"));
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 1, "atype" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "atype"));
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 1, "account" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "paccount"));
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 1, "accountname" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "paccountname"));
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 1, "costgroup" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "costgroup"));
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 1, "costtype" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "costtype"));
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 1, "costcode" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "costcode"));
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 1, "credit" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "dramount"));
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 1, "currencyid" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "curid"));
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 1, "rate" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "c_rate"));
                	 $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', 1, "description" ,$('#jqxPrePayment').jqxGrid('getcellvalue', rowindex1, "desc1"));
                 } */
             }); 
            
        });
    </script>
    <div id="jqxPrePayment"></div>
 