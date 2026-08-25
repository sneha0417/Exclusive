<%@page import="com.dashboard.realestate.ownerpytsettlementws.*"%>
<%
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
String detaildocno=request.getParameter("detaildocno")==null?"0":request.getParameter("detaildocno");
String jvdesc=request.getParameter("jvdesc")==null?"0":request.getParameter("jvdesc");
String jvdate=request.getParameter("jvdate")==null?"0":request.getParameter("jvdate");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
ClsOwnerpytsettlementDAO dao=new ClsOwnerpytsettlementDAO();
%>
<script type="text/javascript">
var id='<%=id%>';
var jvdata=[];
if(id=="1"){
	jvdata='<%=dao.getJvData(docno,id,detaildocno,jvdesc,jvdate)%>';
}
$(document).ready(function () { 	
	var source =
    {
    	datatype: "json",
        datafields: [
        	{name : 'type' , type: 'String' },
     		{name : 'acno', type: 'number'  },
			{name : 'acname',type:'string'},
			{name : 'debit',type:'number'},
			{name : 'credit',type:'number'},
			{name : 'baseamt',type:'number'},
			{name : 'desc1',type:'string'}
		],
        localdata: jvdata,
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
    $("#jvGrid").jqxGrid(
    {
    	width: '100%',
        height: 120,
        source: dataAdapter,
        columnsresize: true,
        selectionmode: 'singlerow',
        columns: [
			{ text: 'Sr No',datafield: '',editable:false,columntype:'number', width: '4%', 
				cellsrenderer: function (row, column, value) {
	        		return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
            	}
			},
			{ text: 'Type', datafield: 'type',editable:false, width: '8%'},
			{ text: 'Account', datafield: 'acno',editable:false, width: '8%'},
			{ text: 'Account Name', datafield: 'acname', width: '25%'},
			{ text: 'Debit', datafield: 'debit', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right'},
			{ text: 'Credit', datafield: 'credit', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right'},
			{ text: 'Base Amount', datafield: 'baseamt', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right'},
			{ text: 'Description',datafield:'desc1', width: '28%'}
		]
	});
});
</script>
<div id="jvGrid"></div>
