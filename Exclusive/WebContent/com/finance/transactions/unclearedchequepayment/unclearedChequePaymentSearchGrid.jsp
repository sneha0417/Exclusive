<%@page import="com.finance.transactions.unclearedchequepayment.ClsUnclearedChequePaymentDAO"%>
<% ClsUnclearedChequePaymentDAO DAO= new ClsUnclearedChequePaymentDAO(); %>
<% String type1 = request.getParameter("atype")==null?"0":request.getParameter("atype");
String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>

<script type="text/javascript">
        
        var data1= '<%=DAO.unclearedChequePaymentGridSearch(type1, accountno, accountname, currency, date, check) %>'; 
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
            
            $("#jqxUnclearedChequePaymentSearch").jqxGrid(
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
							{ text: 'Rate', datafield: 'c_rate', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '20%' },
							{ text: 'Currency Type', datafield: 'type', hidden: true, width: '20%' },
						]
            });
            
            $('#jqxUnclearedChequePaymentSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
                var rowindex2 = event.args.rowindex;
                $('#jqxUnclearedChequePayment').jqxGrid('setcellvalue', rowindex1, "docno" ,$('#jqxUnclearedChequePaymentSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                $('#jqxUnclearedChequePayment').jqxGrid('setcellvalue', rowindex1, "accounts" ,$('#jqxUnclearedChequePaymentSearch').jqxGrid('getcellvalue', rowindex2, "account"));
                $('#jqxUnclearedChequePayment').jqxGrid('setcellvalue', rowindex1, "accountname1" ,$('#jqxUnclearedChequePaymentSearch').jqxGrid('getcellvalue', rowindex2, "description"));
                $("#jqxUnclearedChequePayment").jqxGrid('setcellvalue', rowindex1, "currency" ,$("#jqxUnclearedChequePaymentSearch").jqxGrid('getcellvalue', rowindex2, "curr"));
                $("#jqxUnclearedChequePayment").jqxGrid('setcellvalue', rowindex1, "currencytype" ,$("#jqxUnclearedChequePaymentSearch").jqxGrid('getcellvalue', rowindex2, "type"));
                $("#jqxUnclearedChequePayment").jqxGrid('setcellvalue', rowindex1, "currencyid" ,$("#jqxUnclearedChequePaymentSearch").jqxGrid('getcellvalue', rowindex2, "curid"));
                $("#jqxUnclearedChequePayment").jqxGrid('setcellvalue', rowindex1, "grtype" ,$("#jqxUnclearedChequePaymentSearch").jqxGrid('getcellvalue', rowindex2, "gr_type"));
                $("#jqxUnclearedChequePayment").jqxGrid('setcellvalue', rowindex1, "rate" ,$("#jqxUnclearedChequePaymentSearch").jqxGrid('getcellvalue', rowindex2, "c_rate"));
              
			    var rows = $('#jqxUnclearedChequePayment').jqxGrid('getrows');
            	var rowlength= rows.length;
            	var rowindex2 = rowlength - 1;
          	    var docno=$("#jqxUnclearedChequePayment").jqxGrid('getcellvalue', rowindex2, "docno");
          	    if(typeof(docno) != "undefined" && docno != ""){
          	    	$("#jqxUnclearedChequePayment").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
          	    }
				
                $('#unclearedChequePaymentGridWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxUnclearedChequePaymentSearch"></div>