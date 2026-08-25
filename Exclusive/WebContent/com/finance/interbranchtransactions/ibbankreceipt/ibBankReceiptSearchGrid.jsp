<%@page import="com.finance.interbranchtransactions.ibbankreceipt.ClsIbBankReceiptDAO" %>
<%  ClsIbBankReceiptDAO DAO=new ClsIbBankReceiptDAO(); %>
<% String type1 = request.getParameter("atype")==null?"0":request.getParameter("atype");
String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

<script type="text/javascript">
   
        var data1= '<%=DAO.ibBankReceiptGridSearch(type1, accountno, accountname, currency, date, check) %>';
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
     						{name : 'c_rate', type: 'number'  },
     						{name : 'type', type: 'string'  }
                        ],
                		  localdata: data1,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxIbBankReceiptSearch").jqxGrid(
            {
            	width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Doc No', hidden : true, datafield: 'doc_no', width: '5%' },
							{ text: 'Account', datafield: 'account', width: '20%' },
							{ text: 'Account Name', datafield: 'description', width: '40%' },
							{ text: 'Currency', datafield: 'curr', width: '20%' },
							{ text: 'Currency ID', datafield: 'curid',  hidden:true, width: '20%' },
							{ text: 'Group Type', datafield: 'gr_type', hidden: true, width: '10%' },
							{ text: 'Rate', datafield: 'c_rate', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '20%' },
							{ text: 'Currency Type', datafield: 'type', hidden: true, width: '20%' },
						]
            });
            
            $('#jqxIbBankReceiptSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
                var rowindex2 = event.args.rowindex;
              $('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindex1, "docno" ,$('#jqxIbBankReceiptSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
              $('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindex1, "accounts" ,$('#jqxIbBankReceiptSearch').jqxGrid('getcellvalue', rowindex2, "account"));
              $('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindex1, "accountname1" ,$('#jqxIbBankReceiptSearch').jqxGrid('getcellvalue', rowindex2, "description"));
              $("#jqxIbBankReceipt").jqxGrid('setcellvalue', rowindex1, "currency" ,$("#jqxIbBankReceiptSearch").jqxGrid('getcellvalue', rowindex2, "curr"));
              $("#jqxIbBankReceipt").jqxGrid('setcellvalue', rowindex1, "currencyid" ,$("#jqxIbBankReceiptSearch").jqxGrid('getcellvalue', rowindex2, "curid"));
              $("#jqxIbBankReceipt").jqxGrid('setcellvalue', rowindex1, "currencytype" ,$("#jqxIbBankReceiptSearch").jqxGrid('getcellvalue', rowindex2, "type"));
              $("#jqxIbBankReceipt").jqxGrid('setcellvalue', rowindex1, "grtype" ,$("#jqxIbBankReceiptSearch").jqxGrid('getcellvalue', rowindex2, "gr_type"));
              $("#jqxIbBankReceipt").jqxGrid('setcellvalue', rowindex1, "rate" ,$("#jqxIbBankReceiptSearch").jqxGrid('getcellvalue', rowindex2, "c_rate"));
              
			  var rows = $('#jqxIbBankReceipt').jqxGrid('getrows');
          	    var rowlength= rows.length;
          	    var rowindex2 = rowlength - 1;
        	    var docno=$("#jqxIbBankReceipt").jqxGrid('getcellvalue', rowindex2, "docno");
        	    if(typeof(docno) != "undefined" && docno != ""){
        	    	$("#jqxIbBankReceipt").jqxGrid('addrow', null, {"docno": "","branch": "","brhid": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
        	    }
				
			  $('#ibBankReceiptGridWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxIbBankReceiptSearch"></div>
 