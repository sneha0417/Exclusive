<%@page import="com.dashboard.realestate.ownerdirectpaymentupdate.ClsOwnerDirectPaymentUpdateDAO" %>
<%	
	ClsOwnerDirectPaymentUpdateDAO DAO=new ClsOwnerDirectPaymentUpdateDAO(); 
 	String id = request.getParameter("id")==null?"0":request.getParameter("id");
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
%>
<script type="text/javascript">         
var id='<%=id%>';
var contractdata=[];
if(id=="1"){
	contractdata='<%=DAO.getContractData(todate, id)%>';
}
$(document).ready(function () {  
	var source =
    {
    	datatype: "json",
        datafields: [
        			{name : 'chk', type: 'bool'},  
		        	{name : 'doc_no', type: 'int'   },                            
		            {name : 'voc_no', type: 'int'   },                         
					{name : 'date', type: 'date'   },                            
					{name : 'period_from', type: 'date'   },
					{name : 'period_to', type: 'date'   },     					 
					{name : 'refname', type: 'string'   },   
					{name : 'protype', type: 'string'   },
					{name : 'period', type: 'string'   },
					{name : 'period_no', type: 'string'   },
					{name : 'pname', type: 'string'   },
					{name : 'not_period', type: 'string'   },
					{name : 'totalamount', type: 'string'   },
					{name : 'recieptstatus',type:'string'},
					{name : 'owner',type:'string'},
					{name : 'notes',type:'string'},
					{name : 'paymentdesc',type:'string'},
					{name : 'amount',type:'number'},
					{name : 'chequedate',type:'date'},
					{name : 'chequeno',type:'string'},
					{name : 'detaildocno',type:'number'}
		],
        localdata: contractdata,
		pager: function (pagenum, pagesize, oldpagenum) {
		    // callback called when a page or page size is changed.
		}
	};
            
    var dataAdapter = new $.jqx.dataAdapter(source);
            
    $("#contractGrid").jqxGrid(
    {
    	width: '100%',
        height: 500,
        source: dataAdapter,
        columnsresize:true,
        editable: true,
        filtermode:'excel',
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
		columns: [     
		 			{ text: '',datafield: 'chk',columntype:'checkbox'},
			        { text: 'Doc No', datafield: 'doc_no', width: '6%',hidden:true,editable: false },
			        { text: 'Detail Doc No', datafield: 'detaildocno', width: '6%',hidden:true,editable: false },
			        { text: 'Doc No', datafield: 'voc_no', width: '5%' ,editable: false},
					{ text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy',editable: false },							 
					{ text: 'Tenant ', datafield: 'refname',width:'10%',editable: false},
					{ text: 'Type', datafield: 'protype', width: '7%',hidden:true,editable: false},
					{ text: 'Property', datafield: 'pname', width: '15%' ,editable: false},
					{ text: 'Owner', datafield: 'owner', width: '15%',editable: false},
					{ text: 'Description',datafield:'paymentdesc',width:'6%',hidden:true,editable: false},
					{ text: 'Amount',datafield:'amount',width:'6%',cellsformat:'d2',align:'right',cellsalign:'right',editable: false},
					{ text: 'Cheque Date',datafield:'chequedate',width:'6%',cellsformat:'dd.MM.yyyy',editable: false},
					{ text: 'Cheque No',datafield:'chequeno',width:'9%',editable: false},
					{ text: 'Period', datafield: 'period', width: '6%' ,editable: false},
					{ text: 'Period No', datafield: 'period_no', width: '6%'  ,editable: false},
					{ text: 'From', datafield: 'period_from', width: '7%' ,cellsformat:'dd.MM.yyyy' ,editable: false},
					{ text: 'To', datafield: 'period_to', width: '7%',cellsformat:'dd.MM.yyyy' ,editable: false },
					{ text: 'Not_Period ', datafield: 'not_period', width: '7%' ,editable: false},						
					{ text: 'total', datafield: 'totalamount', width: '6%',hidden:true ,editable: false},
					{ text: 'Reciept Status', datafield: 'recieptstatus', width: '6%',hidden:true ,editable: false},
					{ text: 'Notes',datafield:'notes',width:'6%',editable: false},
		]
	});
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id="contractGrid"></div>