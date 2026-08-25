<%@page import="com.dashboard.cargo.joblisting.ClsJobListing"%>
<%
ClsJobListing DAO = new ClsJobListing();;
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
%>

<script type="text/javascript">
var reqdata1;

var id='<%=docno%>';

$(document).ready(function () {
	
	if(id>=1){
// 		alert(docno+"-"+enqdocno+"-"+modeid+"-"+smodeid+"-"+shipid);
		reqdata1='<%=DAO.estmDataLoad(docno)%>';
	}
	var source =
	{
			datatype: "json",
			datafields: [
			             {name : 'sertype', type: 'string'},
			             {name : 'srvdocno', type: 'int'},
			             {name : 'currency', type: 'string'},
			             {name : 'rate', type: 'number'},
			             {name : 'price', type: 'number'},
			             {name : 'qty', type: 'number'},
			             {name : 'uom', type: 'string'},
			             {name : 'basetotal', type: 'number'},
			             {name : 'total', type: 'number'},
			             {name : 'billing', type: 'string'},
			             {name : 'vendor', type: 'string'},
			             {name : 'unitid', type: 'string'},
			             {name : 'vndid', type: 'string'},
			             {name : 'curid', type: 'string'},
						 {name : 'name', type: 'string'},
  			             {name : 'atype', type: 'string'},
  			           {name : 'regno', type: 'string'},
  			         {name : 'trackid', type: 'string'},
  			       {name : 'expdate', type: 'date'},
  			     {name : 'remarks', type: 'string'}
  			             
                 ],
                 localdata: reqdata1,
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

            $("#jqxEstimation").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                editable: false,
                altRows: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                theme: 'energyblue',
                columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }
							  },
                          { text: 'Service Type', datafield: 'sertype', width: '6%', editable: false },	
      					  { text: 'Currency', datafield: 'currency', width: '4%', editable: false },	
      					  { text: 'Rate', datafield: 'rate', width: '3%', editable: false,cellsformat: 'd2', align: 'right', cellsalign: 'right' },
      					  { text: 'Price', datafield: 'price', width: '6%',cellsformat: 'd2', align: 'right', cellsalign: 'right' },
						  { text: 'QTY', datafield: 'qty', width: '3%',cellsformat: 'd2' },	
						  { text: 'UOM', datafield: 'uom', width: '3%', editable: false },
						  { text: 'Total', datafield: 'total', width: '6%',cellsformat: 'd2', align: 'right', cellsalign: 'right' , editable: false},	
						  { text: 'Base Total', datafield: 'basetotal', width: '6%',cellsformat: 'd2', align: 'right', cellsalign: 'right', editable: false},
						  { text: 'Billing', datafield: 'billing', width: '5%'},	
						  { text: 'Vendor', datafield: 'vendor', width: '12%', editable: false},
						  
						  { text: 'srvdocno', datafield: 'srvdocno', width: '12%',hidden: true },
						  { text: 'unitid', datafield: 'unitid', width: '12%',hidden: true },
						  { text: 'vndid', datafield: 'vndid', width: '12%',hidden: true },
						  { text: 'curid', datafield: 'curid', width: '12%',hidden: true },
						  
						  { text: 'Assigned Type ', datafield: 'atype', width: '6%'   },	
						  { text: 'Asign To', datafield: 'name' ,width:'12%'  },
						  { text: 'Reg No.', datafield: 'regno', width: '5%'   },
						  { text: 'Trailer No.', datafield: 'trackid', width: '5%'   },
						  { text: 'Completion Date', datafield: 'expdate', width: '7%',cellsformat :'dd.MM.yyyy'   },
						  { text: 'Remarks', datafield: 'remarks', width: '8%'   },
			              ]
               
            });
           
	          	  
});
</script>
    <div id="jqxEstimation"></div>
  <input type="hidden" id="rowindex"/> 