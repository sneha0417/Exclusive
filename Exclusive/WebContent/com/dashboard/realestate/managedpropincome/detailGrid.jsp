<%@page import="com.dashboard.realestate.managedpropincome.*" %>
<%	
	ClsManagedPropIncomeDAO DAO=new ClsManagedPropIncomeDAO(); 
 	String id = request.getParameter("id")==null?"0":request.getParameter("id");
    String branch = request.getParameter("branch")==null?"":request.getParameter("branch").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
%>
<script type="text/javascript">
var id='<%=id%>';
var detaildata=[];
if(id=="1"){
	detaildata='<%=DAO.getManagedPropData(branch, fromdate, todate, id)%>';
}
var rendererstring=function (aggregates){
	var value=aggregates['sum'];
    if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
    {
    	value=0.0;
    }
    return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
}
$(document).ready(function () {  
	var source =
    {
    	datatype: "json",
        datafields: [
        	{name : 'propname', type: 'string'   },                            
            {name : 'unitno', type: 'string'   },                         
			{name : 'ownername', type: 'string'   },                            
			{name : 'proptype', type: 'string'   },
			{name : 'unittype', type: 'string'   },     					 
			{name : 'adminfeeamt', type: 'number'   },   
			{name : 'ejariamt', type: 'number'   },
			{name : 'commincome', type: 'number'   },
			{name : 'propmgmtamt', type: 'number'   },
			{name : 'agentcommexp', type: 'number'   },
			{name : 'maintexpamt', type: 'number'   }
		],
        localdata: detaildata,
		pager: function (pagenum, pagesize, oldpagenum) {
		    // callback called when a page or page size is changed.
		}
	};
            
    var dataAdapter = new $.jqx.dataAdapter(source);
            
    $("#detailGrid").jqxGrid(
    {
    	width: '100%',
        height: 450,
        source: dataAdapter,
        columnsresize:true,
        filtermode:'excel',
        filterable: true,
        showfilterrow:true,
        selectionmode: 'singlerow',
        sortable:true,
        enabletooltips : true,
        showaggregates:true,
        showstatusbar:true,
		columns: [ 
			{ text: 'SL#', sortable: false, filterable: false, editable: false,
            	groupable: false, draggable: false, resizable: false,
                datafield: 'sl', columntype: 'number', width: '4%',
                cellsrenderer: function (row, column, value) {
                	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                }  
            },
	        { text: 'Property', datafield: 'propname', width: '12%'},
	        { text: 'Unit No', datafield: 'unitno', width: '8%'},
	        { text: 'Owner', datafield: 'ownername', width: '12%' },
			{ text: 'Property Type', datafield: 'proptype', width: '8%'},							 
			{ text: 'Unit Type', datafield: 'unittype',width:'8%'},
			{ text: 'Admin Fee', datafield: 'adminfeeamt', width: '8%',cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'income',aggregates: ['sum'],aggregatesrenderer:rendererstring},
			{ text: 'Ejari', datafield: 'ejariamt', width: '8%',cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'income',aggregates: ['sum'],aggregatesrenderer:rendererstring},
			{ text: 'Commission', datafield: 'commincome', width: '8%',cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'income',aggregates: ['sum'],aggregatesrenderer:rendererstring},
			{ text: 'Mgmt Fee',datafield:'propmgmtamt', width: '8%',cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'income',aggregates: ['sum'],aggregatesrenderer:rendererstring},
			{ text: 'Agent Commission',datafield:'agentcommexp', width: '8%',cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'expense',aggregates: ['sum'],aggregatesrenderer:rendererstring},
			{ text: 'Maint.Expense',datafield:'maintexpamt', width: '8%',cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'expense',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		],
    	columngroups: 
    	[
        	{ text: 'Income', align: 'center', name: 'income' },
        	{ text: 'Expense', align: 'center', name: 'expense' },
    	]
	});
            
    $('#detailGrid').on('rowdoubleclick', function (event) {    
    	var rowindex = event.args.rowindex;
    	$('#gridrowindex').val(rowindex);
    });
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id="detailGrid"></div>
<input type="hidden" name="gridrowindex" id="gridrowindex">