<%@page import="com.dashboard.accounts.chequeupdate.ClsChequeUpdateDAO"%>
<%ClsChequeUpdateDAO DAO= new ClsChequeUpdateDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String bankacno = request.getParameter("bankacno")==null?"0":request.getParameter("bankacno");
     String chqno = request.getParameter("chqno")==null?"0":request.getParameter("chqno");
     String chqdate = request.getParameter("chqdate")==null?"0":request.getParameter("chqdate");
     String unclrchq = request.getParameter("unclrchq")==null?"0":request.getParameter("unclrchq");
     String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>
     
<script type="text/javascript">
 	var temp1='<%=check%>';
 	 var datas;
 	 
	 if(temp1=='2'){ 
		datas='<%=DAO.multiChequeGridLoading(branchval,fromDate,toDate,bankacno,chqno,chqdate,unclrchq,check)%>';  
	 }
	
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
								{ name: 'chqno', type: 'String' },
								{ name: 'chqdt', type: 'date' },
								{ name: 'account', type: 'int' },
								{ name: 'description', type: 'String' },
								{ name: 'tr_no', type: 'int' },
								{ name: 'doc_no', type: 'int' },
								{ name: 'dtype', type: 'String' }
                 			],               
               localdata:datas,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            $("#jqxChqGrid").on("bindingcomplete", function (event) {
            	$("#overlay, #PleaseWait").hide();
            	});

            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#jqxChqGrid").jqxGrid(
            {
                width: '100%',
                height: 230,
                source: dataAdapter,
                columnsresize: true,
                showfilterrow: false, 
                filterable: true,  
                sortable: true,
                selectionmode: 'checkbox',
                
                columns: [
							{ text: 'Cheque No', datafield: 'chqno', width: '20%' },
							{ text: 'Cheque Date', datafield: 'chqdt', cellsformat: 'dd.MM.yyyy' ,width: '10%' },
							{ text: 'A/C No.', datafield: 'account', width: '10%' },
							{ text: 'Account Name', datafield: 'description', width: '55.7%' },
							{ text: 'Tr No', datafield: 'tr_no', hidden: true, width: '10%' },
							{ text: 'Doc No', datafield: 'doc_no', hidden: true, width: '10%' },
							{ text: 'Dtype', datafield: 'dtype', hidden: true, width: '10%' },
	              ]
            });
            
});

</script>
<div id="jqxChqGrid"></div>
 
