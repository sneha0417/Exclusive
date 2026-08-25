<%@page import="com.dashboard.fixedasset.fixedassetissuelist.ClsFixedAssetIssueListDAO" %>
<%ClsFixedAssetIssueListDAO cfar=new ClsFixedAssetIssueListDAO(); %>


<script type="text/javascript">
  
	   var fleetdata='<%=cfar.assetdetails()%>';
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'asset_no', type: 'string'  },
                            {name : 'assetname', type: 'string'  }
                           ],
                            localdata: fleetdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#assetSearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Asset', datafield: 'asset_no', width: '20%'},
                              { text: 'Name', datafield: 'assetname', width: '80%' },
						]
            });
            
          $('#assetSearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex; 
                document.getElementById("txtasset").value=$('#assetSearch').jqxGrid('getcellvalue', rowindex2, "assetname");
                document.getElementById("hiassetno").value=$('#assetSearch').jqxGrid('getcellvalue', rowindex2, "asset_no");
                
              $('#assetDetailsWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="assetSearch"></div>