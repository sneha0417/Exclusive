<%@page import="com.finance.interbranchtransactions.ibcashpayment.ClsIbCashPaymentDAO" %>
<%  ClsIbCashPaymentDAO DAO=new ClsIbCashPaymentDAO(); %>
<% String type1 = request.getParameter("atype")==null?"0":request.getParameter("atype");
String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

<script type="text/javascript">
   
        var data1= '<%=DAO.ibCashPaymentGridSearch(type1, accountno, accountname, currency, date, check) %>';
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
            
            $("#jqxIbCashPaymentSearch").jqxGrid(
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
            
            $('#jqxIbCashPaymentSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
                var rowindex2 = event.args.rowindex;
              $('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindex1, "docno" ,$('#jqxIbCashPaymentSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
              $('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindex1, "accounts" ,$('#jqxIbCashPaymentSearch').jqxGrid('getcellvalue', rowindex2, "account"));
              $('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindex1, "accountname1" ,$('#jqxIbCashPaymentSearch').jqxGrid('getcellvalue', rowindex2, "description"));
              $("#jqxIbCashPayment").jqxGrid('setcellvalue', rowindex1, "currency" ,$("#jqxIbCashPaymentSearch").jqxGrid('getcellvalue', rowindex2, "curr"));
              $("#jqxIbCashPayment").jqxGrid('setcellvalue', rowindex1, "currencytype" ,$("#jqxIbCashPaymentSearch").jqxGrid('getcellvalue', rowindex2, "type"));
              $("#jqxIbCashPayment").jqxGrid('setcellvalue', rowindex1, "currencyid" ,$("#jqxIbCashPaymentSearch").jqxGrid('getcellvalue', rowindex2, "curid"));
              $("#jqxIbCashPayment").jqxGrid('setcellvalue', rowindex1, "grtype" ,$("#jqxIbCashPaymentSearch").jqxGrid('getcellvalue', rowindex2, "gr_type"));
              $("#jqxIbCashPayment").jqxGrid('setcellvalue', rowindex1, "rate" ,$("#jqxIbCashPaymentSearch").jqxGrid('getcellvalue', rowindex2, "c_rate"));
              
			  var rows = $('#jqxIbCashPayment').jqxGrid('getrows');
              var rowlength= rows.length;
              var rowindex2 = rowlength - 1;
          	  var docno=$("#jqxIbCashPayment").jqxGrid('getcellvalue', rowindex2, "docno");
          	  if(typeof(docno) != "undefined" && docno != ""){
          		$("#jqxIbCashPayment").jqxGrid('addrow', null, {"docno": "","branch": "","brhid": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
          	  }
			  
			  $('#ibCashPaymentGridWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxIbCashPaymentSearch"></div>
 