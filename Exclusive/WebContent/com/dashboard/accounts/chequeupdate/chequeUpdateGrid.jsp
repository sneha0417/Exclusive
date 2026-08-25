<%@page import="com.dashboard.accounts.chequeupdate.ClsChequeUpdateDAO"%>
<%ClsChequeUpdateDAO DAO= new ClsChequeUpdateDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check");%>
<script type="text/javascript">
      var data1;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		   data1='<%=DAO.chequeUpdateGridLoading(branchval,fromDate,toDate, check)%>';  
	  	}
	  	
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					{ name: 'date', type: 'date' },
					{ name: 'doc_no', type: 'int' },
					{ name: 'dtype', type: 'int' },
					{ name: 'chqno', type: 'String' },
					{ name: 'chqdt', type: 'date' },
					{ name: 'pdc', type: 'bool' },
					{ name: 'account', type: 'int' },
                    { name: 'description', type: 'String' },
                    { name: 'tr_no', type: 'int' },
                    { name: 'brhid', type: 'int' },
                    { name: 'bankacno', type: 'int' }
	            ],
                localdata: data1,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#chequeUpdate").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                
                columns: [
						{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' ,width: '10%' },
						{ text: 'Doc No', datafield: 'doc_no', width: '8%' },
						{ text: 'Dtype', datafield: 'dtype', width: '7%' },
						{ text: 'Cheque No', datafield: 'chqno', width: '20%' },
						{ text: 'Cheque Date', datafield: 'chqdt', cellsformat: 'dd.MM.yyyy' ,width: '10%' },
						{ text: 'PDC', datafield: 'pdc', columntype: 'checkbox', editable: true, checked: true, width: '5%',cellsalign: 'center', align: 'center' },
	                    { text: 'A/C No.', datafield: 'account', width: '10%' },
	                    { text: 'Account Name', datafield: 'description', width: '30%' },
	                    { text: 'Tr No', datafield: 'tr_no', hidden: true, width: '10%' },
	                    { text: 'Branch', datafield: 'brhid', hidden: true, width: '10%' },
	                    { text: 'Bank Acno', datafield: 'bankacno', hidden: true, width: '10%' },
					 ]
            });
            
            $("#overlay, #PleaseWait").hide();
            
            $('#chequeUpdate').on('rowdoubleclick', function (event) { 
            	  var rowindex1=event.args.rowindex;
            	  $('#txtchequeno').attr('readonly', false);$('#chequedate').jqxDateTimeInput({disabled: false});
            	  document.getElementById("txtchequeno").value=$('#chequeUpdate').jqxGrid('getcellvalue', rowindex1, "chqno"); 
            	  $('#chequedate').val($('#chequeUpdate').jqxGrid('getcellvalue', rowindex1, "chqdt")) ;
            	  document.getElementById("txtbranch").value=$('#chequeUpdate').jqxGrid('getcellvalue', rowindex1, "brhid");
            	  document.getElementById("txttrno").value=$('#chequeUpdate').jqxGrid('getcellvalue', rowindex1, "tr_no");
            	  document.getElementById("txtdocumentno").value=$('#chequeUpdate').jqxGrid('getcellvalue', rowindex1, "doc_no");
            	  document.getElementById("txtdoctype").value=$('#chequeUpdate').jqxGrid('getcellvalue', rowindex1, "dtype");
            	  document.getElementById("txtbankacno").value=$('#chequeUpdate').jqxGrid('getcellvalue', rowindex1, "bankacno");
               }); 

        });

</script>
<div id="chequeUpdate"></div>
