<%@page import="com.dashboard.realestate.tenancymanagement.ClsTenancyManagementDAO" %>
<%
	ClsTenancyManagementDAO DAO=new ClsTenancyManagementDAO();   
	String id = request.getParameter("id")==null?"0":request.getParameter("id"); 
 	String branch = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String chkexpiry = request.getParameter("chkexpiry")==null?"0":request.getParameter("chkexpiry").trim();
	String chkcreated = request.getParameter("chkcreated")==null?"0":request.getParameter("chkcreated").trim();
	String allcontracts = request.getParameter("allcontracts")==null?"0":request.getParameter("allcontracts").trim();
	String cmbmanage = request.getParameter("cmbmanage")==null?"":request.getParameter("cmbmanage").trim();
	String cmbowner = request.getParameter("cmbowner")==null || request.getParameter("cmbowner").equalsIgnoreCase("null")?"":request.getParameter("cmbowner").trim();
	String cmbproperty = request.getParameter("cmbproperty")==null || request.getParameter("cmbproperty").equalsIgnoreCase("null")?"":request.getParameter("cmbproperty").trim();
	String cmbtenant = request.getParameter("cmbtenant")==null || request.getParameter("cmbtenant").equalsIgnoreCase("null")?"":request.getParameter("cmbtenant").trim();
%>
<style>
	.redClass
    {
    	background-color: #FFEBEB;
    }
</style>
<script type="text/javascript">
var griddata=[];
var id='<%=id%>';
if(id=="1"){
	griddata='<%=DAO.getMgmtData(branch, fromdate, todate, id, allcontracts,chkexpiry,cmbmanage,chkcreated,cmbowner,cmbproperty,cmbtenant)%>';
}
$(document).ready(function () {  
	
	// prepare the data
    var source =
    {
    	datatype: "json",
        datafields: [
        	{name : 'doc_no', type: 'number'   },
            {name : 'voc_no', type: 'number'   },
            {name : 'branchname',type:'string'},
            {name : 'tenantname', type: 'String'   },
	        {name : 'propid', type: 'string'   },
	        {name : 'propname', type: 'string'   },
	        {name : 'notifydate', type: 'date'   },
	        {name : 'fromdate', type: 'date'   },
			{name : 'todate', type: 'date'   },
			{name : 'renewalstatus', type: 'string'   },
			{name : 'rent', type: 'number'   },
			{name : 'owner', type: 'string'   },
			{name : 'tenantdocno', type: 'string'   },
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
			{name : 'contactmobile',type:'string'},
			{name : 'contactemail',type:'string'},
			{name : 'poststatus',type:'string'},
			{name : 'ownerdocno',type:'string'},
			{name : 'owneremail',type:'string'},
			{name : 'chequecount',type:'string'}
			
		],
        localdata: griddata,    
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
            
    $("#tenancyGrid").jqxGrid(
	{
    	width: '100%',
        height: 480,
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
        	{ text: 'Doc No', datafield: 'doc_no', width: '4%',hidden:true,cellclassname: cellclassname },
            { text: 'Doc No', datafield: 'voc_no', width: '6%',hidden:false,cellclassname: cellclassname },
            { text: 'Branch', datafield: 'branchname', width: '12%',cellclassname: cellclassname},
            { text: 'Owner', datafield: 'owner', width: '7%',cellclassname: cellclassname },
            { text: 'Tenant Name', datafield: 'tenantname', width: '12%',cellclassname: cellclassname},
			{ text: 'Property ID ', datafield: 'propid' , width: '8%',cellclassname: cellclassname},
			{ text: 'Unit No', datafield: 'unitno' , width: '8%',cellclassname: cellclassname},
			{ text: 'Property Name ', datafield: 'propname' , width: '15%',cellclassname: cellclassname},
			{ text: 'Notify Date', datafield: 'notifydate' , width: '7%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
			{ text: 'Tenant Mobile', datafield: 'tenantmobile', width: '10%' ,cellclassname: cellclassname},
			{ text: 'Tenant Email', datafield: 'tenantemail', width: '10%' ,cellclassname: cellclassname },
			{ text: 'From Date', datafield: 'fromdate', width: '6%' ,cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname},
			{ text: 'To Date', datafield: 'todate', width: '6%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
			{ text: 'Status', datafield: 'renewalstatus', width: '7%',cellclassname: cellclassname },
			{ text: 'Remarks', datafield: 'renewalremarks', width: '12%',cellclassname: cellclassname},
			{ text: 'Rent', datafield: 'rent', width: '6%' , cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname},
			{ text: 'Prop Doc No', datafield: 'propdocno', width: '10%',hidden:true ,cellclassname: cellclassname },
			{ text: 'Branch Id', datafield: 'brhid', width: '10%',hidden:true ,cellclassname: cellclassname },
			{ text: 'Prop Contract no', datafield: 'propcontractno', width: '10%',hidden:true,cellclassname: cellclassname  },
			{ text: 'Contract Status', datafield: 'clstatus', width: '10%',hidden:true ,cellclassname: cellclassname },
			{ text: 'Tenant Ac No', datafield: 'tenantacno', width: '10%',hidden:true ,cellclassname: cellclassname },
			{ text: 'Tenant Doc No', datafield: 'tenantdocno', width: '10%',hidden:true ,cellclassname: cellclassname },
			{ text: 'Owner Ac No', datafield: 'owneracno', width: '10%',hidden:true ,cellclassname: cellclassname },
			{ text: 'MRF Ac No', datafield: 'mrfacno', width: '10%',hidden:true ,cellclassname: cellclassname },
			{ text: 'Tenant Ac Name', datafield: 'tenantaccountname', width: '10%',hidden:true ,cellclassname: cellclassname },
			{ text: 'Owner Ac Name', datafield: 'owneraccountname', width: '10%',hidden:true ,cellclassname: cellclassname },
			{ text: 'MRF Ac Name', datafield: 'mrfaccountname', width: '10%',hidden:true ,cellclassname: cellclassname },
			{ text: 'Contact Mobile', datafield: 'contactmobile', width: '10%',cellclassname: cellclassname },
			{ text: 'Contact Email', datafield: 'contactemail', width: '10%',cellclassname: cellclassname },
			{ text: 'Post Status', datafield: 'poststatus', width: '10%',cellclassname: cellclassname,hidden:true },
			{ text: 'Owner Doc No', datafield: 'ownerdocno', width: '10%',cellclassname: cellclassname,hidden:true },
			{ text: 'Owner E-Mail', datafield: 'owneremail', width: '10%',cellclassname: cellclassname,hidden:true },
			{ text: 'Cheque Count', datafield: 'chequecount', width: '10%',cellclassname: cellclassname,hidden:true },
			
		]
	});
    
    $('#tenancyGrid').on('rowdoubleclick', function (event) {    
    	var rowindex= event.args.rowindex;
    	var tenantacno=$('#tenancyGrid').jqxGrid('getcellvalue',rowindex,'tenantacno');
    	var owneracno=$('#tenancyGrid').jqxGrid('getcellvalue',rowindex,'owneracno');
    	var mrfacno=$('#tenancyGrid').jqxGrid('getcellvalue',rowindex,'mrfacno');
    	var fromdate=$('#tenancyGrid').jqxGrid('getcelltext',rowindex,'fromdate');
    	var todate=$('#tenancyGrid').jqxGrid('getcelltext',rowindex,'todate');
    	var branch=$('#tenancyGrid').jqxGrid('getcellvalue',rowindex,'brhid');
		$('#hiddocno').val($('#tenancyGrid').jqxGrid('getcellvalue',rowindex,'doc_no'));
		$('#vocno').val($('#tenancyGrid').jqxGrid('getcellvalue',rowindex,'voc_no'));
		$('#gridrowindex').val(rowindex);
		$('#modaltncmgmtlog .modal-title').text('Tenancy Management Log of TNC '+$('#vocno').val());
		$('#tncmgmtlogdiv').load("tncMgmtLogGrid.jsp?contractdocno="+$('#hiddocno').val()+"&id=1");
		$('#accountsdiv').load('accountsGrid.jsp?contractdocno='+$('#hiddocno').val()+'&id=1');
		var fdate=window.parent.txtaccountperiodfrom.value;
        fdate=fdate.replace(/-/g, '.');
        var tdate=window.parent.txtaccountperiodto.value; 
        tdate=tdate.replace(/-/g, '.');
        <%System.out.println("TenantGrid Loading");%>
		$('#tenantaccountsdiv').load("tenantAccountsGrid.jsp?fromdate="+fdate+"&todate="+tdate+"&branchval="+branch+"&accdocno="+tenantacno+"&id=1");
		$('#owneraccountsdiv').load("ownerAccountsGrid.jsp?fromdate="+fdate+"&todate="+tdate+"&branchval="+branch+"&accdocno="+owneracno+"&id=1");
		$('#mrfaccountsdiv').load("mrfAccountsGrid.jsp?fromdate="+fdate+"&todate="+tdate+"&branchval="+branch+"&accdocno="+mrfacno+"&id=1");
		$('.comments-container').html('');
		var tenantname=$('#tenancyGrid').jqxGrid('getcellvalue',rowindex,'tenantname');
		var propid=$('#tenancyGrid').jqxGrid('getcellvalue',rowindex,'propid');
		var propname=$('#tenancyGrid').jqxGrid('getcellvalue',rowindex,'propname');
		$('.textpanel p').text(tenantname+' - '+propid+' - '+propname);
		var doc=$('#tenancyGrid').jqxGrid('getcellvalue',rowindex,'doc_no');
		var propdocno=$('#tenancyGrid').jqxGrid('getcellvalue',rowindex,'propdocno');
		funcheckHandBack(doc,propdocno);
	}); 
    $("#popupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
    // create context menu
	var contextMenu = $("#Menu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
    $("#tenancyGrid").on('contextmenu', function () {
    	return false;
    });
    
    $("#Menu2").on('itemclick', function (event) {
    	var args = event.args;
        var rowindex = $("#tenancyGrid").jqxGrid('getselectedrowindex');
        if ($.trim($(args).text()) == "View Tenancy Contract") {
        
        	var url=document.URL;
			var reurl=url.split("com/");
			var vocno=$("#tenancyGrid").jqxGrid('getcellvalue',rowindex,'voc_no');
			var brhid=$("#tenancyGrid").jqxGrid('getcellvalue',rowindex,'brhid');
			
			if (top.checkTab("Tenancy Contract")){
				console.log()
	       		top.addTab("Tenancy Contract",reurl[0]+"com/realestate/tenancycontract/saveTenancyContract.action?docno="+vocno+"&mode=view&reqbrhid="+brhid);
			}
	
        }
    });
    $("#tenancyGrid").on('rowclick', function (event) {
    	if (event.args.rightclick) {
           	$("#tenancyGrid").jqxGrid('selectrow', event.args.rowindex);
            var scrollTop = $(window).scrollTop();
            var scrollLeft = $(window).scrollLeft();
            contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
            return false;
		}
	});
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id='jqxWidget'>
    <div id="tenancyGrid"></div>
    <div id="popupWindow2">
 		<div id='Menu2'>
        	<ul>
            	<li>View Tenancy Contract</li>
        	</ul>
       	</div>
	</div>
</div>
<input type="hidden" name="gridrowindex" id="gridrowindex">