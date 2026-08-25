
<%@page import=" com.dashboard.realestate.ownerpytsettlementws.*" %>
<%
ClsOwnerpytsettlementDAO DAO=new ClsOwnerpytsettlementDAO();  
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
String detaildocno = request.getParameter("detaildocno")==null?"0":request.getParameter("detaildocno");
String id = request.getParameter("id")==null?"0":request.getParameter("id"); 
%>
<script type="text/javascript">
var id='<%=id%>';
var paymentdata=[];
if(id=="1"){
	paymentdata='<%=DAO.getPaymentData(docno, id,detaildocno)%>';
}
$(document).ready(function () { 
	var rendererstring=function (aggregates){
    	var value=aggregates['sum'];
        if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
        {
        	value=0.0;
        }
		return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
	}
    
	var source =
    {
    	datatype: "json",
        datafields: [
			{name : 'doc_no', type: 'string'   },
			{name : 'description', type: 'string'   },
			{name : 'date', type: 'date' },
			{name : 'amount', type: 'number'   },
			{name : 'notes', type: 'string'   },
			{name : 'chqno', type: 'string'   },
			{name : 'paidto', type: 'string'   },
			{name : 'paymentmethod', type: 'string'   },
			{name : 'bankaccount', type: 'string'   },
			{name : 'rdocno', type: 'string'   },
			{name : 'recieptno',type:'string'}
	   ],
       localdata: paymentdata,  
       pager: function (pagenum, pagesize, oldpagenum) {
           // callback called when a page or page size is changed.
       }
	};
            
    var dataAdapter = new $.jqx.dataAdapter(source);
    var list = ['Bank', 'Cash','On Account'];
    var list1 = ['Owner', 'Self'];
             
    $("#jqxPaymentGrid").jqxGrid(
    {
    	width: '100%',
        height: 0,
        source: dataAdapter,
        editable: true,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 21,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlecell',
        localization: {thousandsSeparator: ""},
       	columns: [
			{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
            	groupable: false, draggable: false, resizable: false,datafield: '',
                columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
                cellsrenderer: function (row, column, value) {
                	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                }    
			}, 
			{ text: 'docno', datafield: 'doc_no', width: '15%',hidden:true  },	
			{ text: 'Description', datafield: 'description', width: '15%'  },	
			{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '8%'},
			{ text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
			{ text: 'Notes', datafield: 'notes', width: '15%'}, 
			{ text: 'Cheque No', datafield: 'chqno' },
			{ text: 'Payment', datafield: 'paymentmethod', width: '7%'   },
			{ text: 'Paid To', datafield: 'paidto', width: '15%'   },
			{ text: 'Bank', datafield: 'bankaccount', width: '13%'}, 
			{ text: 'Reciept No', datafield: 'recieptno', width: '10%'},   
			{ text: 'rdocno', datafield: 'rdocno', width: '15%',hidden:true  },	
		]
	});  
});

</script>
<div id="jqxPaymentGrid"></div>
    