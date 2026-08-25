<%@page import="com.dashboard.realestate.tenancymanagement.*" %>
<%
ClsTenancyManagementDAO mgmtdao=new ClsTenancyManagementDAO();
String contractdocno = request.getParameter("contractdocno")==null?"0":request.getParameter("contractdocno").trim();
String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
%>

<style type="text/css">
	.redClass
    {
    	background-color: #FFEBEB;
    }
    .yellowClass
    {
    	background-color: #FFFFD1;
    }
       
</style> 
<script type="text/javascript">
var logdata=[];
var id='<%=id%>';
if(id=="1"){
	logdata= '<%=mgmtdao.getMgmtLogData(contractdocno,id)%>';
}
$(document).ready(function () {
		
    var source =
    {
    	datatype: "json",
        datafields: [
			{name : 'logdate' , type: 'date' },
			{name : 'tncvocno' , type:'string'},
			{name : 'tncdocno' , type:'string'},
			{name : 'branchname' , type:'string'},
			{name : 'user_name',type:'string'},
			{name : 'remarks' , type:'string'},
			{name : 'systemremarks' , type:'string'}
		],
        localdata: logdata,
        pager: function (pagenum, pagesize, oldpagenum) {
			// callback called when a page or page size is changed.
        }
	};
          
    var dataAdapter = new $.jqx.dataAdapter(source,
    {
    	loadError: function (xhr, status, error) {
	    	alert(error);    
	    }
	});
            
    $("#tncMgmtLogGrid").jqxGrid(
    {
    	width: '100%',
        height: 380,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        sortable: true,
        columnsresize: true,
        selectionmode: 'singlerow',
        enabletooltips: true,
        editable: false,
        columns: [   
        	{ text: 'Sr No.',datafield: '',columntype:'number', width: '4%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },  
			{ text: 'Branch', datafield: 'branchname', width: '14%'},
			{ text: 'User',  datafield: 'user_name', width: '12%' },
			{ text: 'Date',  datafield: 'logdate',width: '12%',cellsformat: 'dd.MM.yyyy HH:mm' },
			{ text: 'Remarks',  datafield: 'remarks', width: '29%'   },
			{ text: 'System Remarks',  datafield: 'systemremarks', width: '29%'},
	 	]
	});
           
});
</script>
<div id="tncMgmtLogGrid"></div>