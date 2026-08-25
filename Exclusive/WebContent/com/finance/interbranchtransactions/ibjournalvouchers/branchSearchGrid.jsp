<%@page import="com.finance.interbranchtransactions.ibjournalvouchers.ClsIbJournalVouchersDAO" %>
<%  ClsIbJournalVouchersDAO DAO=new ClsIbJournalVouchersDAO(); %>
<script type="text/javascript">
        
        var data7= '<%= DAO.branchlist(session) %>'; 
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'doc_no', type: 'int' },
     						{name : 'branchname', type: 'String' },
                        ],
                		 localdata: data7, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxbranchSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
                            { text: 'Branch Id', hidden: true, datafield: 'doc_no', width: '10%' },
							{ text: 'Branch', datafield: 'branchname', width: '100%' }
						]
            });
            
            $('#jqxbranchSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
                var rowindex2 = event.args.rowindex;
                $('#jqxIbJournalVoucher').jqxGrid('setcellvalue', rowindex1, "brhid" ,$('#jqxbranchSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                $('#jqxIbJournalVoucher').jqxGrid('setcellvalue', rowindex1, "branch" ,$('#jqxbranchSearch').jqxGrid('getcellvalue', rowindex2, "branchname"));
               $('#branchSearchWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxbranchSearch"></div>
 