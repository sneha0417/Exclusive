<%@page import="com.dashboard.realestate.reports.ClsReportsDAO"%>
<% ClsReportsDAO DAO= new ClsReportsDAO(); %>       
<%   
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
	String mtype = request.getParameter("mtype")==null?"":request.getParameter("mtype").trim();
	String type = request.getParameter("type")==null?"":request.getParameter("type").trim();      
%>
<style>
	.redClass
    {
    	background-color: #FFEBEB;
    }
</style>
<script type="text/javascript">
var insddata;   
var id='<%=id%>';
if(id=="1"){
	insddata='<%=DAO.loadinspStatistics(type, mtype, id)%>';          
}
$(document).ready(function () {  
	// prepare the data
    var source =
    {
    	datatype: "json",
        datafields: [  
		            {name : 'doc_no', type: 'String'   },
		            {name : 'user', type: 'String'   },
			        {name : 'inspdate', type: 'date'   },
			        {name : 'insdate', type: 'date'   },
		],
        localdata: insddata,    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
	};
    
    var dataAdapter = new $.jqx.dataAdapter(source);
            
    $("#jqxinsdetailsGrid").jqxGrid(
	{
    	width: '100%',
        height: 300,
        source: dataAdapter,
        columnsresize:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        showfilterrow: true,
        sortable:true,
        enabletooltips: true,
        showstatusbar:true,
        showaggregates:true,
        statusbarheight:25,
        columns: [
        	{ text: 'SL#', sortable: false, filterable: false, editable: false,
            	groupable: false, draggable: false, resizable: false,
                datafield: 'sl', columntype: 'number', width: '2%',
                cellsrenderer: function (row, column, value) {
                	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                }  
            },
        	{ text: 'Doc No', datafield: 'doc_no', width: '8%' },           
            { text: 'Date', datafield: 'inspdate', width: '8%',cellsformat:'dd.MM.yyyy HH:mm' },
            { text: 'Inspection Date', datafield: 'insdate', width: '8%' ,cellsformat:'dd.MM.yyyy'},   
			{ text: 'User', datafield: 'user'},
			]
	});           
          
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id="jqxinsdetailsGrid"></div>