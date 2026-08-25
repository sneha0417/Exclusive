<%@page import="com.dashboard.audit.bankreconciliation.ClsBankReconciliationDAO"%>
<%ClsBankReconciliationDAO DAO= new ClsBankReconciliationDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");
   String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
   String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
   String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
   String check = request.getParameter("check")==null?"0":request.getParameter("check").trim(); %>

<script type="text/javascript">
		var data;
		var temp='<%=check%>';
	
		if(temp=='1'){ 
			     data='<%=DAO.bankReconciliationGridLoading(branch, fromdate, todate, accdocno, check)%>'; 
			     var dataExcelExport='<%=DAO.bankReconciliationExcelExport(branch, fromdate, todate, accdocno, check)%>';
		}
       
        $(document).ready(function () { 	
            
             var rendererstring=function (aggregates){
                	var value=aggregates['sum'];
                	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Total" + ': ' + value + '</div>';
             } 
             
             // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'date', type: 'date' },
     						{name : 'dtype', type: 'string'   },
     						{name : 'doc_no', type: 'int' },
     						{name : 'chqno', type: 'string'   },
     						{name : 'chqdt', type: 'date' },
     		     		    {name : 'cr', type: 'number'   },
     						{name : 'dr', type: 'number'   },
     						{name : 'chk', type: 'bool' },
     						{name : 'c_date', type: 'date'   },
     						{name : 'description', type: 'string'   },
     						{name : 'party', type: 'string'   },
     						{name : 'ref_detail', type: 'string'   },
     						{name : 'tranid', type: 'int'   }
                        ],
                		  localdata: data,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });

            $("#jqxBankReconciliation").jqxGrid(
            {
            	width: '98%',
                height: 500,
                source: dataAdapter,
                rowsheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                showaggregates:true,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                localization: {thousandsSeparator: ""},
                                  
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy',  width: '6%' },
							{ text: 'Doc Type', datafield: 'dtype',  width: '5%' },
							{ text: 'Doc No.', datafield: 'doc_no',  width: '5%' },			
							{ text: 'Cheque No.', datafield: 'chqno',  width: '6%' },
							{ text: 'Cheque Date', datafield: 'chqdt', cellsformat: 'dd.MM.yyyy',  width: '7%' },	
							{ text: 'Receipts', datafield: 'cr', cellsformat: 'd2', aggregates: ['sum'], aggregatesrenderer:rendererstring , width: '7%', cellsalign: 'right', align: 'right' },	
							{ text: 'Payments', datafield: 'dr', cellsformat: 'd2', aggregates: ['sum'],aggregatesrenderer:rendererstring , width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Posted', datafield: 'chk', columntype: 'checkbox', editable: true, width: '5%',cellsalign: 'center', align: 'center' },
							{ text: 'Posted Date', datafield: 'c_date', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy',  width: '7%' },
							{ text: 'Description', datafield: 'description',  width: '20%' },
							{ text: 'Party Name' , datafield: 'party',  width: '15%' },
							{ text: 'Reference', datafield: 'ref_detail',  width: '6%' },
							{ text: 'Tran Id', hidden: true, datafield: 'tranid',  width: '6%' },
						]
            });   
            
            $("#overlay, #PleaseWait").hide();
            
        });
        
       
        
    </script>
    <div id="jqxBankReconciliation"></div>
 