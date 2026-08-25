<%@page import="com.dashboard.fixedasset.fixedassetissue.ClsFixedAssetIssueDAO" %>
<%ClsFixedAssetIssueDAO cfar=new ClsFixedAssetIssueDAO(); %>


<script type="text/javascript">
  
	   var branchdata='<%=cfar.branchdetails()%>';
	  $(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'string'  },
                            {name : 'branchname', type: 'string'  }
                           ],
                            localdata: branchdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#branchSearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Branch Id', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Branch', datafield: 'branchname', width: '80%' },
						]
            });
            
          $('#branchSearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex; 
                document.getElementById("txtbranch").value=$('#branchSearch').jqxGrid('getcellvalue', rowindex2, "branchname");
                document.getElementById("txtbranchid").value=$('#branchSearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
                
              $('#branchDetailsWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="branchSearch"></div>