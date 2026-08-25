<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.realestate.propertyinvoice.*" %>
<%
ClsPropertyInvoiceDAO viewDAO=new ClsPropertyInvoiceDAO();
String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
String accountss = request.getParameter("accountss")==null?"NA":request.getParameter("accountss");
String accnamess = request.getParameter("accnamess")==null?"NA":request.getParameter("accnamess");
String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
String reftypess = request.getParameter("reftypess")==null?"NA":request.getParameter("reftypess"); 
String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
String mobileno=request.getParameter("mobileno")==null?"NA":request.getParameter("mobileno");
%>
<script type="text/javascript">
var nipurmain= '<%=viewDAO.mainsearch(session,docnoss,accountss,accnamess,datess,reftypess,aa,mobileno) %>'; 
$(document).ready(function () { 
	var source =
    {
    	datatype: "json",
        datafields: [
        	{name : 'doc_no', type: 'int'   },
            {name : 'date', type: 'date'   },
     		{name : 'netamount', type: 'number'   },
     		{name : 'type', type: 'string'   },
			{name : 'atype', type: 'string'   },
     		{name : 'account', type: 'string'   },
			{name : 'description', type: 'string'   },
			{name : 'refno', type: 'string'   },
			{name : 'rate', type: 'string'   },
			{name : 'delterm', type: 'string'   },
			{name : 'payterm', type: 'string'   },
            {name : 'deldate', type: 'date'   },
			{name : 'desc1', type: 'string'   },
			{name : 'acno', type: 'string'   },
			{name : 'curid', type: 'string'   },
			{name : 'reftype', type: 'string'   },
			{name : 'tr_no', type: 'int'   },
			{name : 'voc_no', type: 'int'   },
			{name : 'refvocno', type: 'int'   },
			{name :	'mobno',type:'String'},
			{name : 'invdate', type: 'date'   },
			{name : 'invno', type: 'String'   },
			{name : 'tax', type: 'number'   },
			{name : 'billingname',type:'string'},
			{name : 'billingtrn',type:'string'},
			{name : 'property',type:'string'},
			{name : 'owner',type:'string'},
			{name : 'fromdate',type:'date'},
			{name : 'todate',type:'date'},
			{name : 'rentsalevalue',type:'number'},
			{name : 'manual',type:'number'}
		],
        localdata: nipurmain, 
		pager: function (pagenum, pagesize, oldpagenum) {
        	// callback called when a page or page size is changed.
        }
	};
            
    var dataAdapter = new $.jqx.dataAdapter(source);
	$("#mainsearshgrid").jqxGrid(
    {
    	width: '100%',
        height: 280,
        source: dataAdapter,
		//showfilterrow: true, 
        //filterable: true,
		selectionmode: 'singlerow',
        columns: [
        	{ text: 'Doc No', datafield: 'voc_no', width: '6%' },
			{ text: 'Date', datafield: 'date', width: '9%',cellsformat:'dd.MM.yyyy' },
			{ text: 'atype', datafield: 'atype', width: '0%', hidden: true },
			{ text: 'Account', datafield: 'account', width: '8%' },
			{ text: 'Account Name', datafield: 'description', width: '22%' },
			{ text: 'Ref Type', datafield: 'reftype', width: '7%'},
			{ text: 'Mob No', datafield: 'mobno', width: '11%'},
			{ text: 'Amount', datafield: 'netamount', width: '12%' ,cellsformat: 'd2', cellsalign: 'right', align:'right'},
			{ text: 'type', datafield: 'type', width: '5%',hidden:true },
			{ text: 'refno', datafield: 'refno', width: '5%',hidden:true },
			{ text: 'rate', datafield: 'rate', width: '2%' ,hidden:true},
			{ text: 'delterm', datafield: 'delterm', width: '8%',hidden:true },
			{ text: 'payterm',  datafield: 'payterm', width: '5%' ,hidden:true},
			{ text: 'deldate', datafield: 'deldate', width: '5%' ,cellsformat:'dd.MM.yyyy',hidden:true},
			{ text: 'Description', datafield: 'desc1', width: '25%' },
			{ text: 'acno', datafield: 'acno', width: '2%' ,hidden:true},
			{ text: 'curid', datafield: 'curid', width: '2%',hidden:true },
			{ text: 'invdate', datafield: 'invdate', width: '10%',cellsformat:'dd.MM.yyyy' ,hidden:true}, 
			{ text: 'invno', datafield: 'invno', width: '2%',hidden:true},
			{ text: 'tr_no', datafield: 'tr_no', width: '2%',hidden:true},
			{ text: 'voc_no', datafield: 'doc_no', width: '2%',hidden:true},
			{ text: 'refvocno', datafield: 'refvocno', width: '2%',hidden:true},
			{ text: 'tax', datafield: 'tax', width: '10%',hidden:true},
			{ text: 'Property', datafield: 'property', width: '10%',hidden:true},
			{ text: 'Owner', datafield: 'owner', width: '10%',hidden:true},
			{ text: 'From Date', datafield: 'fromdate', width: '10%',hidden:true,cellsformat:'dd.MM.yyyy'},
			{ text: 'To Date', datafield: 'todate', width: '10%',hidden:true,cellsformat:'dd.MM.yyyy'},
			{ text: 'Rent Sale Value', datafield: 'rentsalevalue', width: '10%',hidden:true,cellsformat:'d2'},
			{ text: 'Manual', datafield: 'manual', width: '10%',hidden:true},
		]
	});
    $('#mainsearshgrid').on('rowdoubleclick', function (event) {
    	var rowindex1 = event.args.rowindex;
        $('#nipurchasedate').jqxDateTimeInput({ disabled: false});
        $('#cmbcurr').attr('disabled', false);
		$('#acctype').attr('disabled', false);
        document.getElementById("docno").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "voc_no");
        document.getElementById("masterdoc_no").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
        $('#nipurchasedate').val($("#mainsearshgrid").jqxGrid('getcellvalue', rowindex1, "date")) ;
        document.getElementById("refno").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "refvocno");
        document.getElementById("ordermasterdoc_no").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "refno");
		$('#acctypeval').val($('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "type"));
		$('#acctype').val($('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "type"));
        $('#cmbcurr').val($('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "curid"));
        $('#cmbtype').val($('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "atype"));
        document.getElementById("reftypeval").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "reftype");
        document.getElementById("currate").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "rate");
        document.getElementById("purdesc").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "desc1");
        document.getElementById("nipuraccid").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "account");
        document.getElementById("puraccname").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "description");
        document.getElementById("nettotal").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "netamount");
        document.getElementById("accdocno").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "acno");
        document.getElementById("tarannumber").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
        document.getElementById("taxpers").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "tax");
        document.getElementById("billingname").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "billingname");
        document.getElementById("billingtrn").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "billingtrn");
        document.getElementById("property").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "property");
        document.getElementById("owner").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "owner");
        $('#contractfromdate').jqxDateTimeInput('val',$('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "fromdate"));
        $('#contracttodate').jqxDateTimeInput('val',$('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "todate"));
        document.getElementById("cmbreftype").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "reftype");
        document.getElementById("rentsalevalue").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "rentsalevalue");
        var manual=$('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "manual");
        $('#manual').val($('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "manual"));
        var invtypedesc="";
        //alert(manual)
       	if(parseInt(manual)==3){
        	invtypedesc="Invoice created from Inv Processing";
        }
        else if(parseInt(manual)==2){
        	invtypedesc="Invoice created from Tenancy Contract Posting";
        }
        else if(parseInt(manual)==1){
        	invtypedesc="Manual Invoice";
        }
        else if(parseInt(manual)==4){
        	invtypedesc="Invoice created from Maintenance Posting";
        }
        else{
        	invtypedesc="Imported Invoice";
        }
        $('#lblinvoicetype').text(invtypedesc);
        $('#window').jqxWindow('close');  
       	$('#refno').attr('disabled', false);
		$('#refslno').attr('disabled', false);
		$('#nipurchasedate').jqxDateTimeInput({ disabled: false});
        var docno = document.getElementById("masterdoc_no").value;
		$("#agentdiv").load("agentGrid.jsp?rdocno="+docno+"&id=1");
        $("#nipurdetails").load("descgridDetails.jsp?id=1&nipurdoc="+$("#mainsearshgrid").jqxGrid('getcellvalue',rowindex1,"doc_no"));
        checkEdit();
        // $('#cmbcurr').attr('disabled', false);
        // $('#acctype').attr('disabled', false);
        //funSetlabel();
		funchkforedit();
        //document.getElementById("frmNipurchase").submit();
	}); 
});
</script>
<div id="mainsearshgrid"></div>