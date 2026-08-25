<%@page import="com.finance.transactions.multiplecashpurchase.ClsmultipleCashPurchaseDAO"%>
<% ClsmultipleCashPurchaseDAO DAO= new ClsmultipleCashPurchaseDAO(); %>
<% String type1 = request.getParameter("atype")==null?"0":request.getParameter("atype");
String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

<script type="text/javascript">
   
        var data1= '<%=DAO.multipleCashPurchaseGridSearch(type1, accountno, accountname, currency, date,check) %>';
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
     						{name : 'type', type: 'string'  },
     						
                        ],
                		 localdata: data1, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxMainSearch").jqxGrid(
            {
            	width: '100%',
                height: 300,
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
            
            
            $('#jqxMainSearch').on('rowdoubleclick', function (event) {
	              var rowindex1 =$('#rowindex').val();
	              var rowindex2 = event.args.rowindex;
	               
				    var rows = $('#jqxMultipleCashPurchase').jqxGrid('getrows');
	                var rowlength= rows.length;
	                //var rowindex2 = rowlength - 1;
	                //alert(1);
	                 $('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex1, "docno" ,$('#jqxMainSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                     $('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex1, "accounts" ,$('#jqxMainSearch').jqxGrid('getcellvalue', rowindex2, "account"));
                     $('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex1, "accountname1" ,$('#jqxMainSearch').jqxGrid('getcellvalue', rowindex2, "description"));
                     $("#jqxMultipleCashPurchase").jqxGrid('setcellvalue', rowindex1, "currency" ,$("#jqxMainSearch").jqxGrid('getcellvalue', rowindex2, "curr"));
                     $("#jqxMultipleCashPurchase").jqxGrid('setcellvalue', rowindex1, "currencyid" ,$("#jqxMainSearch").jqxGrid('getcellvalue', rowindex2, "curid"));
                     $("#jqxMultipleCashPurchase").jqxGrid('setcellvalue', rowindex1, "currencytype" ,$("#jqxMainSearch").jqxGrid('getcellvalue', rowindex2, "type"));
                     $("#jqxMultipleCashPurchase").jqxGrid('setcellvalue', rowindex1, "grtype" ,$("#jqxMainSearch").jqxGrid('getcellvalue', rowindex2, "gr_type"));
                     $("#jqxMultipleCashPurchase").jqxGrid('setcellvalue', rowindex1, "rate" ,$("#jqxMainSearch").jqxGrid('getcellvalue', rowindex2, "c_rate"));

	          	    if(typeof(docno) != "undefined" && docno != ""){
	          	    	$("#jqxMultipleCashPurchase").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
	          	    }    
  
	          	    
	          	   
	          	  document.getElementById("errormsg").innerText="";
	              $('#McpGridWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxMainSearch"></div>
 