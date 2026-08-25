<%@page import="com.dashboard.accounts.journalvoucherlist.ClsJournalVoucherListDAO"%>
<%ClsJournalVoucherListDAO DAO= new ClsJournalVoucherListDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String chk = request.getParameter("check")==null?"0":request.getParameter("check").trim();
     String dType = request.getParameter("dtype")==null?"0":request.getParameter("dtype").trim();
     String jvType = request.getParameter("jvtype")==null || request.getParameter("jvtype")=="undefined"?"0":request.getParameter("jvtype").trim(); 
System.out.println("jvType==="+jvType);
%>
                    
<script type="text/javascript">
        
		var data4;   
		var temp='<%=branchval%>';
		var rendererstring=function (aggregates){  
           	var value=aggregates['sum'];
           	if(typeof(value) == "undefined"){   
           		value=0.00;
           	}
           	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + "Total : " + '' + value + '</div>';
           }            
		if(temp!='NA'){
			  data4='<%=DAO.jvGridLoad(branchval, fromDate, toDate, dType, chk, jvType)%>';
			  var dataExcelExport='<%=DAO.jvExcelExportLoad(branchval, fromDate, toDate, dType, chk, jvType)%>';  
	     }           
        $(document).ready(function () {       
            // prepare the data    
            
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
							{name : 'tr_no', type: 'String'   },
     						{name : 'date', type: 'date'   },
     						{name : 'accountname', type: 'string'  },
     						{name : 'description', type: 'string'  },
     						{name : 'reference', type: 'string'  },
     						{name : 'amount', type: 'number' },
     						{name : 'currency', type: 'string'   },
     						{name : 'localamount', type: 'number' }
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
               sortable: true,
			   columnsresize: true,
               selectionmode: 'checkbox',       
               showaggregates: true,
               showstatusbar:true,
               rowsheight:25,   
               statusbarheight:25,
               enabletooltips: true,
               editable: false,
               localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false,enabletooltips: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							     return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							  					}    
			             	},   
							{ text: 'Doc No',  datafield: 'doc_no', width: '5%',enabletooltips: false },
							{ text: 'Tr No',  datafield: 'tr_no', width: '5%',hidden: true  },
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '8%',enabletooltips: false },
							{ text: 'Account', datafield: 'accountname', width: '20%' },
							{ text: 'Remarks', datafield: 'description'},
							{ text: 'Reference', datafield: 'reference', width: '20%' },
							{ text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right',enabletooltips: false },
							{ text: 'Currency', datafield: 'currency',  width: '5%',enabletooltips: false },
							{ text: 'Local Amount', datafield: 'localamount', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring,enabletooltips: false },
						]          
            });  
           
            if(temp=='NA'){
                $("#jqxJournalVoucher").jqxGrid("addrow", null, {});
            }
                 
            $("#overlay, #PleaseWait").hide();
});
</script>
<div id="jqxJournalVoucher"></div>
 