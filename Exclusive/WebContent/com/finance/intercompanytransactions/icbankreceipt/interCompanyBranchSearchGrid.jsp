<%@page import="com.finance.intercompanytransactions.icbankreceipt.ClsIcBankReceiptDAO"%>
<% ClsIcBankReceiptDAO DAO= new ClsIcBankReceiptDAO(); %>
<script type="text/javascript">
        
        var data7= '<%= DAO.interCompanyBranchSearch() %>'; 
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'intercompname', type: 'String' },
     						{name : 'compname', type: 'String' },
     						{name : 'branchname', type: 'String' },
     						{name : 'dbname', type: 'String' },
     						{name : 'brhid', type: 'int' },
     						{name : 'cmpid', type: 'int' },
     						{name : 'doc_no', type: 'int' }
                        ],
                		 localdata: data7, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxBranchSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Company / Branch', datafield: 'intercompname', width: '100%' },
							{ text: 'Company', hidden: true, datafield: 'compname', width: '60%' },
							{ text: 'Branch', hidden: true, datafield: 'branchname', width: '40%' },
							{ text: 'Database', hidden: true, datafield: 'dbname', width: '10%' },
							{ text: 'Branch Id', hidden: true, datafield: 'brhid', width: '10%' },
							{ text: 'Company Id', hidden: true, datafield: 'cmpid', width: '10%' },
							{ text: 'Inter Company Id', hidden: true, datafield: 'doc_no', width: '10%' },
						]
            });
            
            $('#jqxBranchSearch').on('celldoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
                var rowindex2 = event.args.rowindex;
                $('#icBankReceiptGridId').jqxGrid('setcellvalue', rowindex1, "intrcompid" ,$('#jqxBranchSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                $('#icBankReceiptGridId').jqxGrid('setcellvalue', rowindex1, "compbranch" ,$('#jqxBranchSearch').jqxGrid('getcellvalue', rowindex2, "intercompname"));
                $('#icBankReceiptGridId').jqxGrid('setcellvalue', rowindex1, "intrbrhid" ,$('#jqxBranchSearch').jqxGrid('getcellvalue', rowindex2, "brhid"));
                $('#icBankReceiptGridId').jqxGrid('setcellvalue', rowindex1, "dbname" ,$('#jqxBranchSearch').jqxGrid('getcellvalue', rowindex2, "dbname"));
               
                $('#branchSearchWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxBranchSearch"></div>
 