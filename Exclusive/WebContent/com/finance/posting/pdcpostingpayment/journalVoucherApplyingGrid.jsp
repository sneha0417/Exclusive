<%@page import="com.finance.posting.pdcpostingpayment.ClsPDCPostingPaymentDAO"%>
<%ClsPDCPostingPaymentDAO DAO= new ClsPDCPostingPaymentDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String trNo = request.getParameter("txttrno")==null?"0":request.getParameter("txttrno");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>

<script type="text/javascript">
		 var data2;  
        $(document).ready(function () { 
            
            var temp='<%=trNo%>';
            
             if(temp>0)
           	 {     
            	  data2='<%=DAO.applyingInvoiceGridLoading(trNo,check)%>';    
             } 
             
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int' },
     						{name : 'atype', type: 'string' }, 
     						{name : 'account', type: 'string'   },
     						{name : 'accountname', type: 'string'  },
     						{name : 'debit', type: 'number'   },
     						{name : 'credit', type: 'number'   },
     						{name : 'baseamount', type: 'number' },
     						{name : 'description', type: 'string' },
     						{name : 'currencyid', type: 'int'   },
     						{name : 'currencytype', type: 'string'   },
     						{name : 'rate', type: 'int'   },
     						{name : 'ref_row', type: 'int'  },
     						{name : 'sr_no', type: 'int'  },
     						{name : 'id', type: 'int'  }
                        ],
                           localdata: data2,   
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxJournalVoucherApplying").jqxGrid(
            {
                width: '99%',
                height: 200,
                source: dataAdapter,
                editable: false,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                       
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Doc No', hidden: true, datafield: 'doc_no',  width: '5%' },
							{ text: 'Type',   datafield: 'atype',  width: '7%' },
							{ text: 'Account', datafield: 'account', editable: false, width: '10%' },	
							{ text: 'Account Name', datafield: 'accountname', editable: false, width: '20%' },	
							{ text: 'Debit', datafield: 'debit', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right'},
							{ text: 'Credit', datafield: 'credit', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right'},
							{ text: 'Base Amount', datafield: 'baseamount', editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right' },
							{ text: 'Description', datafield: 'description', width: '34%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currencyid', editable: false, width: '10%' },
							{ text: 'Curr Type', hidden: true, datafield: 'currencytype', editable: false, width: '4%' },
							{ text: 'Rate', hidden: true, datafield: 'rate', editable: false,width: '10%', cellsalign: 'right', align: 'right' },
							{ text: 'Ref Row', hidden: true, datafield: 'ref_row', editable: false, width: '10%' },
							{ text: 'Branch', hidden: true, datafield: 'sr_no', editable: false, width: '10%' },
							{ text: 'Id',  hidden: true, datafield: 'id', editable: false, width: '10%' }
						]
            });
            
          //Add empty row
            if(temp==0){   
         	   $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
          	  } 
    	    
            $("#overlay, #PleaseWait").hide();
            
            $('#jqxJournalVoucherApplying').on('celldoubleclick', function (event) {
	           	  if(event.args.columnindex == 3){
	           		var posted=$('#cmbcriteria').val();
	           		if(posted=="1"){
	           			accountSearchContent('journalVoucherSearch.jsp?atype=GL');
	           		}
	           	  } 
            });
            
        });
    </script>
    <div id="jqxJournalVoucherApplying"></div>
    <input type="hidden" id="rowindex"/> 