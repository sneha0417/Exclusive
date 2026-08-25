<%@page import="com.dashboard.realestate.reports.ClsReportsDAO"%>
<% ClsReportsDAO DAO= new ClsReportsDAO(); %>       
<%   
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
	String mtype = request.getParameter("mtype")==null?"":request.getParameter("mtype").trim();
%>
<style>
	.redClass
    {
    	background-color: #FFEBEB;
    }
</style>
<script type="text/javascript">
var cdsdata;
var id='<%=id%>';
if(id=="1"){
	cdsdata='<%=DAO.loadcontractsStatistics(mtype,id)%>';                
}
$(document).ready(function () {  
	
	// prepare the data
    var source =
    {
    	datatype: "json",
        datafields: [
        	{name : 'doc_no', type: 'number'   },
            {name : 'voc_no', type: 'number'   },
            {name : 'tenantname', type: 'String'   },
	        {name : 'propid', type: 'string'   },
	        {name : 'propname', type: 'string'   },
	        {name : 'notifydate', type: 'date'   },
	        {name : 'fromdate', type: 'date'   },
			{name : 'todate', type: 'date'   },
			{name : 'renewalstatus', type: 'string'   },
			{name : 'rent', type: 'number'   },
			{name : 'owner', type: 'string'   },
			{name : 'tenantmobile', type: 'string'   },
			{name : 'tenantemail', type: 'string'   },
			{name : 'propdocno', type: 'number'   },
			{name : 'brhid',type:'number'},
			{name : 'propcontractno',type:'number'},
			{name : 'clstatus',type:'number'},
			{name : 'renewalremarks',type:'string'},
			{name : 'unitno',type:'string'},
			{name : 'tenantacno',type:'number'},
			{name : 'owneracno',type:'number'},
			{name : 'mrfacno',type:'number'},
			{name : 'owneraccountname',type:'string'},
			{name : 'tenantaccountname',type:'string'},
			{name : 'mrfaccountname',type:'string'},
		],
        localdata: cdsdata,    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
	};
    var cellclassname = function (row, column, value, data) {
    	if (data.clstatus == '1') {
        	return "redClass";
        }
    };
    var dataAdapter = new $.jqx.dataAdapter(source);
            
    $("#jqxcdstscGrid").jqxGrid(
	{
    	width: '100%',
        height: 250,
        source: dataAdapter,
        columnsresize:true,
        //filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        showfilterrow: true,
        sortable:true,
        enabletooltips: true,
        columns: [
        	{ text: 'SL#', sortable: false, filterable: false, editable: false,cellclassname: cellclassname,
            	groupable: false, draggable: false, resizable: false,
                datafield: 'sl', columntype: 'number', width: '2%',
                cellsrenderer: function (row, column, value) {
                	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                }  
            },
        	{ text: 'Doc No', datafield: 'doc_no', width: '4%',hidden:false,cellclassname: cellclassname },
            { text: 'Doc No', datafield: 'voc_no', width: '6%',hidden:true,cellclassname: cellclassname },
			{ text: 'Tenant Name', datafield: 'tenantname', width: '12%',cellclassname: cellclassname},
			{ text: 'Property ID ', datafield: 'propid' , width: '8%',cellclassname: cellclassname},
			{ text: 'Unit No', datafield: 'unitno' , width: '8%',cellclassname: cellclassname},
			{ text: 'Property Name ', datafield: 'propname' , width: '15%',cellclassname: cellclassname},
			{ text: 'Notify Date', datafield: 'notifydate' , width: '7%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
			{ text: 'From Date', datafield: 'fromdate', width: '6%' ,cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname},
			{ text: 'To Date', datafield: 'todate', width: '6%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
			{ text: 'Status', datafield: 'renewalstatus', width: '7%',cellclassname: cellclassname },
			{ text: 'Remarks', datafield: 'renewalremarks', width: '12%',cellclassname: cellclassname},
			{ text: 'Rent', datafield: 'rent', width: '6%' , cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname},
			{ text: 'Owner', datafield: 'owner', width: '7%',cellclassname: cellclassname },
			{ text: 'Tenant Mobile', datafield: 'tenantmobile', width: '10%' ,cellclassname: cellclassname},
			{ text: 'Tenant Email', datafield: 'tenantemail', width: '10%' ,cellclassname: cellclassname },
			{ text: 'Prop Doc No', datafield: 'propdocno', width: '10%',hidden:true ,cellclassname: cellclassname },
			{ text: 'Branch Id', datafield: 'brhid', width: '10%',hidden:true ,cellclassname: cellclassname },
			{ text: 'Prop Contract no', datafield: 'propcontractno', width: '10%',hidden:true,cellclassname: cellclassname  },
			{ text: 'Contract Status', datafield: 'clstatus', width: '10%',hidden:true ,cellclassname: cellclassname },
			{ text: 'Tenant Ac No', datafield: 'tenantacno', width: '10%',hidden:true ,cellclassname: cellclassname },
			{ text: 'Owner Ac No', datafield: 'owneracno', width: '10%',hidden:true ,cellclassname: cellclassname },
			{ text: 'MRF Ac No', datafield: 'mrfacno', width: '10%',hidden:true ,cellclassname: cellclassname },
			{ text: 'Tenant Ac Name', datafield: 'tenantaccountname', width: '10%',hidden:true ,cellclassname: cellclassname },
			{ text: 'Owner Ac Name', datafield: 'owneraccountname', width: '10%',hidden:true ,cellclassname: cellclassname },
			{ text: 'MRF Ac Name', datafield: 'mrfaccountname', width: '10%',hidden:true ,cellclassname: cellclassname },
			
		]
	});
    $("#overlay, #PleaseWait").hide();
});
</script>
    <div id="jqxcdstscGrid"></div>  