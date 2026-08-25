<%@page import="com.finance.intercompanytransactions.iccashpayment.ClsIcCashPaymentDAO"%>
<% ClsIcCashPaymentDAO DAO= new ClsIcCashPaymentDAO(); %>
<% String type1 = request.getParameter("atype")==null?"0":request.getParameter("atype");
   String dbname1 = request.getParameter("dbname")==null?"0":request.getParameter("dbname");
   String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
   String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
   String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
   String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
   String check = request.getParameter("check")==null?"0":request.getParameter("check");%> 

<script type="text/javascript">
   
        var data1= '<%=DAO.icCashPaymentGridSearch(type1, dbname1, accountno, accountname, currency, date, check) %>';
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
            
            $("#jqxCashPaymentSearch").jqxGrid(
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
            
            $('#jqxCashPaymentSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
                var rowindex2 = event.args.rowindex;
                $('#icCashPaymentGridId').jqxGrid('setcellvalue', rowindex1, "docno" ,$('#jqxCashPaymentSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                $('#icCashPaymentGridId').jqxGrid('setcellvalue', rowindex1, "accounts" ,$('#jqxCashPaymentSearch').jqxGrid('getcellvalue', rowindex2, "account"));
                $('#icCashPaymentGridId').jqxGrid('setcellvalue', rowindex1, "accountname1" ,$('#jqxCashPaymentSearch').jqxGrid('getcellvalue', rowindex2, "description"));
                $("#icCashPaymentGridId").jqxGrid('setcellvalue', rowindex1, "currency" ,$("#jqxCashPaymentSearch").jqxGrid('getcellvalue', rowindex2, "curr"));
                $("#icCashPaymentGridId").jqxGrid('setcellvalue', rowindex1, "currencyid" ,$("#jqxCashPaymentSearch").jqxGrid('getcellvalue', rowindex2, "curid"));
                $("#icCashPaymentGridId").jqxGrid('setcellvalue', rowindex1, "currencytype" ,$("#jqxCashPaymentSearch").jqxGrid('getcellvalue', rowindex2, "type"));
                $("#icCashPaymentGridId").jqxGrid('setcellvalue', rowindex1, "grtype" ,$("#jqxCashPaymentSearch").jqxGrid('getcellvalue', rowindex2, "gr_type"));
                $("#icCashPaymentGridId").jqxGrid('setcellvalue', rowindex1, "rate" ,$("#jqxCashPaymentSearch").jqxGrid('getcellvalue', rowindex2, "c_rate"));
                
				var rows = $('#icCashPaymentGridId').jqxGrid('getrows');
            	var rowlength= rows.length;
            	var rowindex2 = rowlength - 1;
          	    var docno=$("#icCashPaymentGridId").jqxGrid('getcellvalue', rowindex2, "docno");
          	    if(typeof(docno) != "undefined" && docno != ""){
          	    	$("#icCashPaymentGridId").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
          	    }
				
				$('#cashPaymentGridWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxCashPaymentSearch"></div>
 