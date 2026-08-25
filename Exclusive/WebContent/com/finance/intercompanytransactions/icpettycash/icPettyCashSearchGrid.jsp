<%@page import="com.finance.intercompanytransactions.icpettycash.ClsIcPettyCashDAO"%>
<% ClsIcPettyCashDAO DAO= new ClsIcPettyCashDAO(); %>
<% String type1 = request.getParameter("atype")==null?"0":request.getParameter("atype");
String dbname1 = request.getParameter("dbname")==null?"0":request.getParameter("dbname");
String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

<script type="text/javascript">
   
        var data1= '<%=DAO.icPettyCashGridSearch(type1, dbname1, accountno, accountname, currency, date,check) %>';
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
            
            $("#icPettyCashSearchGridID").jqxGrid(
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
            
            
            $('#icPettyCashSearchGridID').on('rowdoubleclick', function (event) {
	              var rowindex1 =$('#rowindex').val();
	              var rowindex2 = event.args.rowindex;
	              $('#icPettyCashGridID').jqxGrid('setcellvalue', rowindex1, "docno" ,$('#icPettyCashSearchGridID').jqxGrid('getcellvalue', rowindex2, "doc_no"));
	              $('#icPettyCashGridID').jqxGrid('setcellvalue', rowindex1, "accounts" ,$('#icPettyCashSearchGridID').jqxGrid('getcellvalue', rowindex2, "account"));
	              $('#icPettyCashGridID').jqxGrid('setcellvalue', rowindex1, "accountname1" ,$('#icPettyCashSearchGridID').jqxGrid('getcellvalue', rowindex2, "description"));
	              $("#icPettyCashGridID").jqxGrid('setcellvalue', rowindex1, "currency" ,$("#icPettyCashSearchGridID").jqxGrid('getcellvalue', rowindex2, "curr"));
	              $("#icPettyCashGridID").jqxGrid('setcellvalue', rowindex1, "currencyid" ,$("#icPettyCashSearchGridID").jqxGrid('getcellvalue', rowindex2, "curid"));
	              $("#icPettyCashGridID").jqxGrid('setcellvalue', rowindex1, "currencytype" ,$("#icPettyCashSearchGridID").jqxGrid('getcellvalue', rowindex2, "type"));
	              $("#icPettyCashGridID").jqxGrid('setcellvalue', rowindex1, "grtype" ,$("#icPettyCashSearchGridID").jqxGrid('getcellvalue', rowindex2, "gr_type"));
	              $("#icPettyCashGridID").jqxGrid('setcellvalue', rowindex1, "rate" ,$("#icPettyCashSearchGridID").jqxGrid('getcellvalue', rowindex2, "c_rate"));
				  
				    var rows = $('#icPettyCashGridID').jqxGrid('getrows');
	                var rowlength= rows.length;
	                var rowindex2 = rowlength - 1;
	          	    var docno=$("#icPettyCashGridID").jqxGrid('getcellvalue', rowindex2, "docno");
	          	    if(typeof(docno) != "undefined" && docno != ""){
	          	    	$("#icPettyCashGridID").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
	          	    }
					
	              $('#icPettyCashGridWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="icPettyCashSearchGridID"></div>
 