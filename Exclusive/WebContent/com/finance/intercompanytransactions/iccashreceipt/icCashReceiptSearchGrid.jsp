<%@page import="com.finance.intercompanytransactions.iccashreceipt.ClsIcCashReceiptDAO"%>
<% ClsIcCashReceiptDAO DAO= new ClsIcCashReceiptDAO(); %>
<% String type1 = request.getParameter("atype")==null?"0":request.getParameter("atype");
   String dbname1 = request.getParameter("dbname")==null?"0":request.getParameter("dbname");
   String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
   String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
   String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
   String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
   String check = request.getParameter("check")==null?"0":request.getParameter("check");%> 

<script type="text/javascript">
   
        var data1= '<%=DAO.icCashReceiptGridSearch(type1, dbname1, accountno, accountname, currency, date, check) %>';
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
            
            $("#jqxCashReceiptSearch").jqxGrid(
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
            
            $('#jqxCashReceiptSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
                var rowindex2 = event.args.rowindex;
                $('#icCashReceiptGridId').jqxGrid('setcellvalue', rowindex1, "docno" ,$('#jqxCashReceiptSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                $('#icCashReceiptGridId').jqxGrid('setcellvalue', rowindex1, "accounts" ,$('#jqxCashReceiptSearch').jqxGrid('getcellvalue', rowindex2, "account"));
                $('#icCashReceiptGridId').jqxGrid('setcellvalue', rowindex1, "accountname1" ,$('#jqxCashReceiptSearch').jqxGrid('getcellvalue', rowindex2, "description"));
                $("#icCashReceiptGridId").jqxGrid('setcellvalue', rowindex1, "currency" ,$("#jqxCashReceiptSearch").jqxGrid('getcellvalue', rowindex2, "curr"));
                $("#icCashReceiptGridId").jqxGrid('setcellvalue', rowindex1, "currencyid" ,$("#jqxCashReceiptSearch").jqxGrid('getcellvalue', rowindex2, "curid"));
                $("#icCashReceiptGridId").jqxGrid('setcellvalue', rowindex1, "currencytype" ,$("#jqxCashReceiptSearch").jqxGrid('getcellvalue', rowindex2, "type"));
                $("#icCashReceiptGridId").jqxGrid('setcellvalue', rowindex1, "grtype" ,$("#jqxCashReceiptSearch").jqxGrid('getcellvalue', rowindex2, "gr_type"));
                $("#icCashReceiptGridId").jqxGrid('setcellvalue', rowindex1, "rate" ,$("#jqxCashReceiptSearch").jqxGrid('getcellvalue', rowindex2, "c_rate"));
                
				var rows = $('#icCashReceiptGridId').jqxGrid('getrows');
            	var rowlength= rows.length;
            	var rowindex2 = rowlength - 1;
          	    var docno=$("#icCashReceiptGridId").jqxGrid('getcellvalue', rowindex2, "docno");
          	    if(typeof(docno) != "undefined" && docno != ""){
          	    	$("#icCashReceiptGridId").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
          	    }
				
				$('#cashReceiptGridWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxCashReceiptSearch"></div>
 