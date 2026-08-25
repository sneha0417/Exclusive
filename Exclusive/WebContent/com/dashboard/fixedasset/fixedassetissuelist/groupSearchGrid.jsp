<%@page import="com.dashboard.fixedasset.fixedassetissuelist.ClsFixedAssetIssueListDAO"%>
<%ClsFixedAssetIssueListDAO DAO= new ClsFixedAssetIssueListDAO(); %>


<script type="text/javascript">
  
       var groupdata='<%=DAO.groupdetails()%>';
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'gname', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
                           ],
                        localdata: groupdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#groupsearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',

                columns: [
                              { text: 'DOC_NO', datafield: 'doc_no', width: '20%',hidden: false},
                              { text: 'Group', datafield: 'gname', width: '100%' },
						]
            });
            
          $('#groupsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("txtgroup").value=$('#groupsearch').jqxGrid('getcellvalue', rowindex2, "gname");
                document.getElementById("txtgroupno").value=$('#groupsearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
           
              $('#groupDetailsWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="groupsearch"></div>