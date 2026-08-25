<%@page import="com.finance.posting.pdcpostingpayment.ClsPDCPostingPaymentDAO"%>
<%ClsPDCPostingPaymentDAO DAO= new ClsPDCPostingPaymentDAO(); %>
<% String type1 = request.getParameter("atype")==null?"0":request.getParameter("atype");
   String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
   String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
   String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
   String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

<script type="text/javascript">
   
        var data1= '<%=DAO.journalVoucherGridSearch(type1, accountno, accountname, currency, date, check) %>'; 
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   },
     						{name : 'curr', type: 'string'  },  
     						{name : 'curid', type: 'int'  },
     						{name : 'gr_type', type: 'int'  },
     						{name : 'c_rate', type: 'string' },
     						{name : 'type', type: 'string'  }
                        ],
                		 localdata: data1, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxJournalVoucherSearch").jqxGrid(
            {
            	width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Doc No', hidden : true, datafield: 'doc_no', width: '5%' },
							{ text: 'Account', datafield: 'account', width: '20%' },
							{ text: 'Account Name', datafield: 'description', width: '40%' },
							{ text: 'Currency', datafield: 'curr', width: '20%' },
							{ text: 'Currency ID', datafield: 'curid',  hidden:true, width: '20%' },
							{ text: 'Group Type', datafield: 'gr_type', hidden: true, width: '10%' },
							{ text: 'Rate', datafield: 'c_rate', cellsalign: 'right', align: 'right', width: '20%' },
							{ text: 'Currency Type', datafield: 'type', hidden: true, width: '20%' },
						]
            });
            
            $('#jqxJournalVoucherSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 = 0;
                var rowindex2 = event.args.rowindex;
	             $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', rowindex1, "doc_no" ,$('#jqxJournalVoucherSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
	             $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', rowindex1, "account" ,$('#jqxJournalVoucherSearch').jqxGrid('getcellvalue', rowindex2, "account"));
	             $('#jqxJournalVoucherApplying').jqxGrid('setcellvalue', rowindex1, "accountname" ,$('#jqxJournalVoucherSearch').jqxGrid('getcellvalue', rowindex2, "description"));
	             $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', rowindex1, "currencyid" ,$("#jqxJournalVoucherSearch").jqxGrid('getcellvalue', rowindex2, "curid"));
	             $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', rowindex1, "rate" ,$("#jqxJournalVoucherSearch").jqxGrid('getcellvalue', rowindex2, "c_rate"));
	             $("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', rowindex1, "currencytype" ,$("#jqxJournalVoucherSearch").jqxGrid('getcellvalue', rowindex2, "type"));
					
	             $('#accountDetailsWindow').jqxWindow('close'); 
            }); 
        });
    
</script>

<div id="jqxJournalVoucherSearch"></div>
 