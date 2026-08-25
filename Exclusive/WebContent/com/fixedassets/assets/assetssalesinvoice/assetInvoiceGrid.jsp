<%@page import="com.fixedassets.assets.assetssalesinvoice.ClsAssetSalesInvDAO" %>
<%ClsAssetSalesInvDAO asi=new ClsAssetSalesInvDAO(); %>

<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
  
<style>
.column{
background-color: #FFA375;
}
</style>
<%String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno");
String branch=request.getParameter("branch")==null || request.getParameter("branch")==""?"0":request.getParameter("branch");

%>
<script type="text/javascript">

var temp='<%=request.getParameter("id")==null?"0":request.getParameter("id")%>';

var dataasset;   
if(temp=="1"){
	dataasset='<%=asi.assetgriddata(branch,docno)%>';
}
else{

}

        $(document).ready(function () { 	

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'assetid' , type: 'String' },
     						{name : 'assetname', type: 'String'  },
     						{name : 'assetno',type:'int'},
     						{name : 'salesprice',type:'number'},
     						{name : 'dep_posted',type:'date'},
     						{name : 'pur_value',type:'number'},
     						{name : 'acc_dep',type:'number'},
     						{name : 'cur_dep',type:'number'},
     						{name : 'netbook',type:'number'},
     						{name : 'net_pl',type:'number'}
     						
     					
                 ],
                localdata: dataasset,
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
            $("#assetInvoiceGrid").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                columnsresize: true,
                disabled: true,
                altRows: true,
                editable: true,
                selectionmode: 'singlecell',
                //Add row method
                        handlekeyboardnavigation: function (event) {
                    var cell = $('#assetInvoiceGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'assetid' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                         var commit = $("#assetInvoiceGrid").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                    var cell1 = $('#assetInvoiceGrid').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'assetid') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	document.getElementById("assetrow").value=cell1.rowindex;
                        	$('#assetwindow').jqxWindow('open');
        					$('#assetwindow').jqxWindow('focus');
        					 assetSearchContent('assetSearch.jsp?branch='+document.getElementById("brchName").value, $('#assetwindow'));
        					 
                          }
                        
                    }
},
                columns: [
							{ text: 'Sr No',datafield: '',editable:false,columntype:'number', width: '4%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            } },
							{ text: 'Asset ID', datafield: 'assetid',editable:false, width: '7%'},
							{ text: 'Asset Name', datafield: 'assetname',editable:false, width: '14.1%'},
							{ text: 'Asset No', datafield: 'assetno',editable:false, width: '14.1%',hidden:true},
							{ text: 'Sales Price', datafield: 'salesprice', width: '10.69%',cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Dep Posted', datafield: 'dep_posted', width: '10.69%',cellclassname:'column',editable:false ,cellsformat:'dd.MM.yyyy',cellsalign:'right',align:'right'},
							{ text: 'Purchase Value', datafield: 'pur_value', width: '10.69%',cellclassname:'column',editable:false,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Acc.Dep', datafield: 'acc_dep', width: '10.69%',cellclassname:'column' ,editable:false,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Current Dep',datafield:'cur_dep', width: '10.69%',cellclassname:'column' ,editable:false,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Net Book',datafield:'netbook', width: '10.69%',cellclassname:'column' ,editable:false,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Net P /(L)',  datafield:'net_pl',width: '10.69%',cellclassname:'column' ,editable:false,cellsformat:'d2',cellsalign:'right',align:'right'}
							
							]
            });
            $('#assetInvoiceGrid').on('celldoubleclick', function (event) {
         	   var row1=event.args.rowindex;
     				document.getElementById("assetrow").value=row1;
     				if(event.args.datafield=='assetid'){
     				    $('#assetwindow').jqxWindow('open');
     					$('#assetwindow').jqxWindow('focus');
     					assetSearchContent('assetSearch.jsp?branch='+document.getElementById("brchName").value, $('#assetwindow'));
     				}
     				
                     });
            
            $("#assetInvoiceGrid").on('cellvaluechanged', function (event) 
            		{
            		    var datafield = event.args.datafield;
            		    // row's bound index.
            		    var rowBoundIndex = event.args.rowindex;
            		    // new cell value.
            		    var value = event.args.newvalue;
            		    // old cell value.
            		    var oldvalue = event.args.oldvalue;       
            		    if(datafield=='salesprice'){
            		    	
            		    	$('#assetInvoiceGrid').jqxGrid('setcellvalue',rowBoundIndex,'dep_posted',null);
            		    	$('#assetInvoiceGrid').jqxGrid('setcellvalue',rowBoundIndex,'pur_value',0.0);
            		    	$('#assetInvoiceGrid').jqxGrid('setcellvalue',rowBoundIndex,'acc_dep',0.0);
            		    	$('#assetInvoiceGrid').jqxGrid('setcellvalue',rowBoundIndex,'cur_dep',0.0);
            		    	$('#assetInvoiceGrid').jqxGrid('setcellvalue',rowBoundIndex,'netbook',0.0);
            		    	$('#assetInvoiceGrid').jqxGrid('setcellvalue',rowBoundIndex,'net_pl',0.0);
            		    }
            		    
            		});
            
            if(document.getElementById("docno").value==''){
            	  $("#assetInvoiceGrid").jqxGrid('addrow', null, {});
                }
          var rows=$("#assetInvoiceGrid").jqxGrid('getrows');
          var rowlength=rows.length;
          if(rowlength==0){
        	  $("#assetInvoiceGrid").jqxGrid('addrow', null, {});

          }
        });
    </script>
    <div id="assetInvoiceGrid"></div>
<input type="hidden" name="assetrow" id="assetrow">