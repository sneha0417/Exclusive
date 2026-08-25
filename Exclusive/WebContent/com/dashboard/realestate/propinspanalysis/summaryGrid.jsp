<%@page import="com.dashboard.realestate.propinspanalysis.*" %>
<%
	ClsPropInspAnalysisDAO DAO=new ClsPropInspAnalysisDAO();
	String id= request.getParameter("id")==null?"0":request.getParameter("id"); 
 	String branch = request.getParameter("branch")==null?"":request.getParameter("branch").trim();
	String fromdate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
	String tenantdocno = request.getParameter("tenantdocno")==null?"":request.getParameter("tenantdocno").trim();
	String propdocno = request.getParameter("propdocno")==null?"":request.getParameter("propdocno").trim();
	String summarytype = request.getParameter("summarytype")==null?"":request.getParameter("summarytype").trim();
%>
<script type="text/javascript">
var summarydata=[];
var id='<%=id%>';
if(id=="1"){
	summarydata='<%=DAO.getSummaryData(branch,fromdate,todate,tenantdocno,propdocno,id,summarytype)%>';
}
$(document).ready(function () {  
	// prepare the data
    var source =
    {
    	datatype: "json",
        datafields: [
        	{name : 'inspcount', type: 'number'   },
            {name : 'handbackcount', type: 'number'   },
            {name : 'handovercount', type: 'number'   },
            {name : 'inspmonthname', type: 'string'   },
            {name : 'inspyear', type: 'string'   }
     	],
        localdata: summarydata, 
                
        pager: function (pagenum, pagesize, oldpagenum) {
        	// callback called when a page or page size is changed.
        }
	};
    
    var dataAdapter = new $.jqx.dataAdapter(source);
    $("#summaryGrid").jqxGrid(
    {
    	width: '100%',
        height: 550,
        source: dataAdapter,
        columnsresize:true,
        filterable: true,
        selectionmode: 'singlerow',
        showfilterrow: true,
        sortable:true,
        
		columns: [
			{ text: 'SL#', sortable: false, filterable: false, editable: false,
            	groupable: false, draggable: false, resizable: false,
                datafield: 'sl', columntype: 'number', width: '15%',
                cellsrenderer: function (row, column, value) {
                	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                }  
            },
        	{ text: 'Year', datafield: 'inspyear', width: '20%'},
        	{ text: 'Month', datafield: 'inspmonthname', width: '20%'},
        	{ text: 'Inspection Count', datafield: 'inspcount', width: '15%',cellsalign:'right',align:'right'},
			{ text: 'Hand Over Count', datafield: 'handovercount', width: '15%',cellsalign:'right',align:'right'},
			{ text: 'Hand Back Count', datafield: 'handbackcount', width: '15%',cellsalign:'right',align:'right'},
			
		]
	});
            
    $('#summaryGrid').on('rowdoubleclick', function (event) {    
    }); 
    var summarytype='<%=summarytype%>';
    if(summarytype=="Y"){
    	$('#summaryGrid').jqxGrid('hidecolumn', 'inspmonthname');
    	$('#summaryGrid').jqxGrid('setcolumnproperty','inspyear', 'width','40%');
    }
    else if(summarytype=="M"){
    	$('#summaryGrid').jqxGrid('setcolumnproperty','inspyear', 'width','20%');
    	$('#summaryGrid').jqxGrid('showcolumn', 'inspmonthname');
    	
    }
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id="summaryGrid"></div>