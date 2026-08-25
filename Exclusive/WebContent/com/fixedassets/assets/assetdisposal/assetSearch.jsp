<%@page import="com.fixedassets.assets.assetdisposal.*" %>
<%ClsAssetDisposalDAO asi=new ClsAssetDisposalDAO(); %>
<%String branch=request.getParameter("branch")==null?"0":request.getParameter("branch"); %>
<script type="text/javascript">
      var dataassets= '<%=asi.assetSearch(branch)%>';
        $(document).ready(function () { 	

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'assetid' , type: 'String' },
     						{name : 'assetname', type: 'String'  },
     						{name : 'assetno',type:'int'}
     						
     						
     					
                 ],
                localdata: dataassets,
                //url: url,
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
            $("#assetSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
               // editable: true,
                selectionmode: 'singlerow',
				filterable: true,
				showfilterrow: true,
				selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Asset ID', datafield: 'assetid', width: '20%' },
							
							{ text: 'Asset Name', datafield: 'assetname', width: '80%'},
							{ text: 'Asset No', datafield: 'assetno', width: '80%',hidden:true}
						
							]
            });
           
           $('#assetSearch').on('rowdoubleclick', function (event) {
        	   var row2=event.args.rowindex;
           	var row5=document.getElementById("assetrow").value;
           	var assetid=$('#assetSearch').jqxGrid('getcellvalue', row2, "assetid");
           	var assetname=$('#assetSearch').jqxGrid('getcellvalue', row2, "assetname");
           	var assetno=$('#assetSearch').jqxGrid('getcellvalue', row2, "assetno");
           	$('#assetInvoiceGrid').jqxGrid('setcellvalue',row5,'salesprice',0.0);
           	$('#assetInvoiceGrid').jqxGrid('setcellvalue',row5,'dep_posted',null);
	    	$('#assetInvoiceGrid').jqxGrid('setcellvalue',row5,'pur_value',0.0);
	    	$('#assetInvoiceGrid').jqxGrid('setcellvalue',row5,'acc_dep',0.0);
	    	$('#assetInvoiceGrid').jqxGrid('setcellvalue',row5,'cur_dep',0.0);
	    	$('#assetInvoiceGrid').jqxGrid('setcellvalue',row5,'netbook',0.0);
	    	$('#assetInvoiceGrid').jqxGrid('setcellvalue',row5,'net_pl',0.0);
	    	
               $("#assetInvoiceGrid").jqxGrid('setcellvalue', row5, "assetid", assetid);
               $("#assetInvoiceGrid").jqxGrid('setcellvalue', row5, "assetname", assetname);
               $("#assetInvoiceGrid").jqxGrid('setcellvalue', row5, "assetno", assetno);
               $("#assetInvoiceGrid").jqxGrid('addrow', null, {});
               $('#assetwindow').jqxWindow('close');
            }); 
        
        });
    </script>
    <div id="assetSearch"></div>