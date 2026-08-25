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
var accountsdata=[];
var id='<%=id%>';
if(id=="1"){
	accountsdata= '<%=mgmtdao.accountstatementSearch(contractdocno,id)%>';
}
$(document).ready(function () {
	var rendererstring=function (aggregates){
    	var value=aggregates['sum'];
        if(typeof(value) == "undefined"){
        	value=0.00;
        }
        return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
	}
        	
    var rendererstring1=function (aggregates){
    	var value1=aggregates['sum1'];
        return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
    }
        	
    var source =
    {
    	datatype: "json",
        datafields: [
			{name : 'trdate' , type: 'date' },
			{name : 'transtype' , type:'string'},
			{name : 'transno' , type:'int'},
			{name : 'rentaldoc' , type:'string'},
			{name : 'rentaltype',type:'string'},
			{name : 'debit' , type:'number'},
			{name : 'credit' , type:'number'},
			{name : 'description' , type:'string'},
			{name : 'brhid',type:'string'},
			{name : 'branchname',type:'string'}
		],
        localdata: accountsdata,
        pager: function (pagenum, pagesize, oldpagenum) {
			// callback called when a page or page size is changed.
        }
	};
        	
    var cellclassname = function (row, column, value, data) {
    	if (data.debit != '') {
        	return "redClass";
        }
        else if (data.credit != '') {
        	return "yellowClass";
        }
	};
            
    var dataAdapter = new $.jqx.dataAdapter(source,
    {
    	loadError: function (xhr, status, error) {
	    	alert(error);    
	    }
	});
            
    $("#accountsStatement").jqxGrid(
    {
    	width: '100%',
        height: 380,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        sortable: true,
        columnsresize: true,
        selectionmode: 'singlerow',
        showaggregates: true,
        showstatusbar:true,
        enabletooltips: true,
        rowsheight:25,
        statusbarheight:25, 
        editable: false,
        columns: [   
			{ text: 'Date', datafield: 'trdate', cellclassname: cellclassname, width: '8%', cellsformat: 'dd.MM.yyyy' },
			{ text: 'Type',  datafield: 'transtype',  cellclassname: cellclassname, width: '6%' },
			{ text: 'Branch',  datafield: 'branchname',  cellclassname: cellclassname, width: '16%' },
			{ text: 'Branch',  datafield: 'brhid',  cellclassname: cellclassname, width: '12%',hidden:true },
			{ text: 'Doc No',  datafield: 'transno',  cellclassname: cellclassname, width: '8%'   },
			{ text: 'RA No',  datafield: 'rentaldoc',  cellclassname: cellclassname, width: '12%' ,hidden:true  },
			 { text: 'RA Type', datafield:'rentaltype', cellclassname: cellclassname, width:'12%',hidden:true},
			{ text: 'Description',  datafield: 'description',  cellclassname: cellclassname, width: '42%',aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
			/* { text: 'Currency',  datafield: 'currency',  cellclassname: cellclassname, width: '6%'  },
			{ text: 'Rate',  datafield: 'rate',  cellclassname: cellclassname, width: '6%',cellsformat: 'd2'},
			{ text: 'Dr',  datafield: 'dr',  cellclassname: cellclassname, width: '9.09%',cellsformat: 'd2',cellsalign:'right',align:'right'},
			{ text: 'Cr',  datafield: 'cr',  cellclassname: cellclassname, width: '9.09%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1 }, */
			{ text: 'Debit',  datafield: 'debit',  cellclassname: cellclassname, width: '10%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
			{ text: 'Credit',  datafield: 'credit',  cellclassname: cellclassname, width: '10%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
	 	]
	});
    
    $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
    // create context menu
    var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
    $("#accountsStatement").on('contextmenu', function () {
    	return false;
    });
               
    $("#Menu").on('itemclick', function (event) {
    	var args = event.args;
        var rowindex = $("#accountsStatement").jqxGrid('getselectedrowindex');
        if ($.trim($(args).text()) == "Edit Selected Row") {
        }
		else {
        	var doctype=document.getElementById("printdoctype").value;
            var url=document.URL;
            if(doctype=="INV" || doctype=="INS" || doctype=="INT"){
				var reurl=url.split("agreement");
				var branch=$('#accountsStatement').jqxGrid('getcellvalue',rowindex,'brhid');
                var printdocno="";
                var win= window.open(reurl[0]+"commtransactions/invoice/printManualInvoice?fromno="+document.getElementById("printinvno").value+"&tono="+document.getElementById("printinvno").value+"&branch="+branch+"&printdocno="+printdocno,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
                win.focus();	 
            }
            else if(doctype=="BPV"){
            	var reurl=url.split("com");
  				var branch=$('#accountsStatement').jqxGrid('getcellvalue',rowindex,'brhid');
  				var win= window.open(reurl[0]+"com/finance/transactions/bankpayment/printBankPayment?docno="+document.getElementById("printinvno").value+"&branch="+branch+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                win.focus(); 
			}
            else if(doctype=="BRV"){
            	var reurl=url.split("com");
            	var branch=$('#accountsStatement').jqxGrid('getcellvalue',rowindex,'brhid');
                var win= window.open(reurl[0]+"com/finance/transactions/bankreceipt/printBankReceipt?docno="+document.getElementById("printinvno").value+"&branch="+branch+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                win.focus();
           	}
            else if(doctype=="CNO"){
    	    	var reurl=url.split("com");
    	    	var branch=$('#accountsStatement').jqxGrid('getcellvalue',rowindex,'brhid');
                var win= window.open(reurl[0]+"com/finance/transactions/creditnote/printCreditNote?docno="+document.getElementById("printinvno").value+"&branch="+branch+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                win.focus(); 
           	}
            else if(doctype=="CRV"){
            	var reurl=url.split("com");
            	var branch=$('#accountsStatement').jqxGrid('getcellvalue',rowindex,'brhid');
                var win= window.open(reurl[0]+"com/finance/transactions/cashreciept/printCashReceipt?docno="+document.getElementById("printinvno").value+"&branch="+branch+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                win.focus(); 
            }
            else if(doctype=="PRIV"){
            	var reurl=url.split("com");
            	var branch=$('#accountsStatement').jqxGrid('getcellvalue',rowindex,'brhid');
                var win= window.open(reurl[0]+"com/realestate/propertyinvoice/printPropertyInvoice?docno="+document.getElementById("printinvno").value+"&branch="+branch+"&brhid="+branch+"&header=1&dtype=PRIV","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                win.focus(); 
            }
		}
	});
    
    $("#accountsStatement").on('rowclick', function (event) {
    	if (event.args.rightclick) {
        	$("#accountsStatement").jqxGrid('selectrow', event.args.rowindex);
            var rowindex=event.args.rowindex;
            document.getElementById("printinvno").value=$('#accountsStatement').jqxGrid('getcellvalue',rowindex,'transno');
            document.getElementById("printdoctype").value=$('#accountsStatement').jqxGrid('getcellvalue',rowindex,'transtype');
            var scrollTop = $(window).scrollTop();
            var scrollLeft = $(window).scrollLeft();
            contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
            return false;
		}
	});       
});
</script>
<div id='jqxWidget'>
	<div id="accountsStatement"></div>
    <div id="popupWindow">
		<div id='Menu'>
        	<ul>
            	<li>Print</li>
        	</ul>
       	</div>
	</div>
</div>


<input type="hidden" name="printinvo" id="printinvno">
<input type="hidden" name="printdoctype" id="printdoctype">