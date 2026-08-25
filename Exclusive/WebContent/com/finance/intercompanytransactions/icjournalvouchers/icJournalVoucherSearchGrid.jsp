<%@page import="com.finance.intercompanytransactions.icjournalvouchers.ClsIcJournalVouchersDAO"%>
<% ClsIcJournalVouchersDAO DAO= new ClsIcJournalVouchersDAO(); %>
<% String type1 = request.getParameter("atype")==null?"0":request.getParameter("atype");
String dbname1 = request.getParameter("dbname")==null?"0":request.getParameter("dbname");
String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

<script type="text/javascript">
   
        var data1= '<%=DAO.icJournalVoucherGridSearch(type1, dbname1, accountno, accountname, currency, date, check) %>'; 
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
            	var rowindex1 =$('#rowindex').val();
                var rowindex2 = event.args.rowindex;
	             $('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindex1, "docno" ,$('#jqxJournalVoucherSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
	             $('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindex1, "accounts" ,$('#jqxJournalVoucherSearch').jqxGrid('getcellvalue', rowindex2, "account"));
	             $('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindex1, "accountname1" ,$('#jqxJournalVoucherSearch').jqxGrid('getcellvalue', rowindex2, "description"));
	             $("#icJournalVoucherGridID").jqxGrid('setcellvalue', rowindex1, "currencyid" ,$("#jqxJournalVoucherSearch").jqxGrid('getcellvalue', rowindex2, "curid"));
	             $("#icJournalVoucherGridID").jqxGrid('setcellvalue', rowindex1, "grtype" ,$("#jqxJournalVoucherSearch").jqxGrid('getcellvalue', rowindex2, "gr_type"));
	             $("#icJournalVoucherGridID").jqxGrid('setcellvalue', rowindex1, "rate" ,$("#jqxJournalVoucherSearch").jqxGrid('getcellvalue', rowindex2, "c_rate"));
	             $("#icJournalVoucherGridID").jqxGrid('setcellvalue', rowindex1, "currencytype" ,$("#jqxJournalVoucherSearch").jqxGrid('getcellvalue', rowindex2, "type"));
					
				  var rows = $('#icJournalVoucherGridID').jqxGrid('getrows');
	              var rowlength= rows.length;
	              var rowindex2 = rowlength - 1;
	          	  var docno=$("#icJournalVoucherGridID").jqxGrid('getcellvalue', rowindex2, "docno");
	          	  if(typeof(docno) != "undefined" && docno != ""){
	          		$("#icJournalVoucherGridID").jqxGrid('addrow', null, {});
	          	  }
				  
	             $('#icJournalVoucherGridWindow').jqxWindow('close'); 
            }); 
        });
    
</script>

<div id="jqxJournalVoucherSearch"></div>
 