<%@page import="com.dashboard.accounts.finance.ClsFinance"%>
<%ClsFinance DAO= new ClsFinance(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String accType = request.getParameter("acctype")==null?"0":request.getParameter("acctype").trim();
     String accDocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String dType = request.getParameter("dtype")==null?"0":request.getParameter("dtype").trim();
     String docRangeFrom = request.getParameter("docrangefrom")==null?"0":request.getParameter("docrangefrom").trim();
     String docRangeTo = request.getParameter("docrangeto")==null?"0":request.getParameter("docrangeto").trim();
     String amtRangeFrom = request.getParameter("amtrangefrom")==null?"0":request.getParameter("amtrangefrom").trim();
     String amtRangeTo = request.getParameter("amtrangeto")==null?"0":request.getParameter("amtrangeto").trim();
     String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");%>
     
<script type="text/javascript">
        
		var data4;
		var temp='<%=branchval%>';
		var temp1='<%=dType%>';
		
		if(temp1=='JVT' || temp1=='IJV'){
			if(temp!='NA'){
				  data4='<%=DAO.finance(branchval, fromDate, toDate, accType, accDocno, dType, docRangeFrom, docRangeTo, amtRangeFrom, amtRangeTo, chk)%>';
				  <%-- var dataExcelExport3='<%=DAO.financeExcelExport(branchval, fromDate, toDate, accType, accDocno, dType, docRangeFrom, docRangeTo, amtRangeFrom, amtRangeTo,chk)%>'; --%>
			}
		}
	
        $(document).ready(function () { 
        	
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + "Total : " + '' + value + '</div>';
               }
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
     						{name : 'date', type: 'date'   },
     						{name : 'accountname', type: 'string'  },
     						{name : 'description', type: 'string'  },
     						{name : 'reference', type: 'string'  },
     						{name : 'amount', type: 'string' },
     						{name : 'currency', type: 'string'   },
     						{name : 'localamount', type: 'string' }
                        ],
                		 localdata: data4,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxJournalVoucher").jqxGrid(
            {
               width: '100%',
               height: 470,
               source: dataAdapter,
               filtermode:'excel',
               filterable: true,
               showfilterrow:true,
               sortable: true,
			   columnsresize: true,
               selectionmode: 'singlerow',
               showaggregates: true,
               showstatusbar:true,
               rowsheight:25,
               statusbarheight:25,
               editable: false,
               localization: {thousandsSeparator: ""},
               enabletooltips: true,
                
                columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '4%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
							{ text: 'Doc No',  datafield: 'doc_no', width: '5%' },
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '10%' },
							{ text: 'Account', datafield: 'accountname', width: '20%' },
							{ text: 'Remarks', datafield: 'description', width: '20%' },
							{ text: 'Reference', datafield: 'reference', width: '20%' },
							{ text: 'Amount', datafield: 'amount', width: '10%', cellsalign: 'right', align: 'right' },
							{ text: 'Currency', datafield: 'currency',  width: '5%' },
							{ text: 'Local Amount', datafield: 'localamount', width: '10%', cellsalign: 'right', align: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
						]
            });
           
            $('#jqxJournalVoucher').on('rowdoubleclick', function (event) {
              	 var rowindex1 = event.args.rowindex;
                var path1="",detName="";
              	 var url=document.URL;
       	 		 var reurl=url.split("com/");
       	 		 var mod="v";
       	 		if(temp1=="JVT"){
       	 		  detName= "Journal Vouchers";
       	 		window.parent.formName.value="Journal Vouchers";
       	 		window.parent.formCode.value="JVT";
       	 		 var doc=$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "doc_no");
       	 		 
       	 		 path1='com/finance/transactions/journalvouchers/saveJournalVoucher?mode=view&txtjournalvouchersdocno='+doc; 
       	 		}
       	 		
       	 		if(temp1=="IJV"){
         	 		  detName= "I B Journal Voucher";
         	 		window.parent.formName.value="I B Journal Voucher";
         	 		window.parent.formCode.value="IJV";
         	 		 var doc=$('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindex1, "doc_no");
         	 		 
         	 		 path1='com/finance/interbranchtransactions/ibjournalvouchers/saveIbJournalVoucher?mode=view&txtibjournalvouchersdocno='+doc; 
         	 		}
       	 		
       	     top.addTab( detName,reurl[0]+""+path1);
	    		
 	    	
            });
            
            if(temp=='NA'){
                $("#jqxJournalVoucher").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
});
</script>
<div id="jqxJournalVoucher"></div>
 