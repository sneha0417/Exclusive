<%@page import=" com.dashboard.realestate.mgmtfeeinvprocessing.*" %>
<%	
	ClsMgmtFeeInvProcessingDAO DAO=new ClsMgmtFeeInvProcessingDAO(); 
 	String id = request.getParameter("id")==null?"0":request.getParameter("id");
    String branch = request.getParameter("branch")==null?"":request.getParameter("branch").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim(); 
%>
<script type="text/javascript">
var id='<%=id%>';
var contractdata=[];
if(id=="1"){
	contractdata='<%=DAO.getContractData(branch, fromdate, todate, id)%>';
}
$(document).ready(function () {  
	var source =
    {
    	datatype: "json",
        datafields: [
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
			{name : 'amount',type:'number'},
			{name : 'chqdt', type: 'date'   },
			{name : 'mgmtamt',type:'number'},
			{name : 'rentalamt',type:'number'},
			{name : 'pytdesc',type:'string'},
			{name : 'detaildocno',type:'number'},
			{name : 'fromchk',type:'string'},
			{name : 'tochk',type:'string'}
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
        //filtermode:'excel',
        filterable: true,
        showfilterrow:true,
        selectionmode: 'singlerow',
		columns: [ 
	        { text: 'Doc No', datafield: 'doc_no', width: '6%',hidden:true },
	        { text: 'Detail Doc No', datafield: 'detaildocno', width: '6%',hidden:true },
	        { text: 'Doc No', datafield: 'voc_no', width: '5%' },
			{ text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy' },							 
			{ text: 'Tenant ', datafield: 'refname',width:'10%'},
			{ text: 'Type', datafield: 'protype', width: '7%',hidden:true},
			{ text: 'Property', datafield: 'pname', width: '18%' },
			{ text: 'Owner', datafield: 'owner', width: '15%'},
			{ text: 'Description',datafield:'paymentdesc',width:'6%',hidden:true},
			{ text: 'Period', datafield: 'period', width: '6%',hidden:true },
			{ text: 'Period No', datafield: 'period_no', width: '3%',hidden:true  },
			{ text: 'Payment Description',datafield:'pytdesc',width:'9%'},
			{ text: 'From', datafield: 'period_from', width: '7%' ,cellsformat:'dd.MM.yyyy' },
			{ text: 'To', datafield: 'period_to', width: '7%',cellsformat:'dd.MM.yyyy'  },
			{ text: 'Not_Period ', datafield: 'not_period', width: '4%' },						
			{ text: 'total', datafield: 'totalamount', width: '6%',hidden:true },
			{ text: 'Reciept Status', datafield: 'recieptstatus', width: '6%',hidden:true },
			{ text: 'Chqdt', datafield: 'chqdt', width: '7%',cellsformat:'dd.MM.yyyy'  },
			{ text: 'Rental Amount',datafield:'rentalamt',width:'6%',cellsformat:'d2',align:'right',cellsalign:'right'},
			{ text: 'Mgmt Amount',datafield:'mgmtamt',width:'6%',cellsformat:'d2',align:'right',cellsalign:'right'},
		]
	});
            
    $('#contractGrid').on('rowdoubleclick', function (event) {    
    	var rowindex = event.args.rowindex;
    	var docno=$('#contractGrid').jqxGrid('getcellvalue',rowindex,'doc_no');
    	$('#docno').val(docno);
    	$('#fromchk').val($('#contractGrid').jqxGrid('getcellvalue',rowindex,'fromchk'));
    	$('#tochk').val($('#contractGrid').jqxGrid('getcellvalue',rowindex,'tochk'));
    	$('#gridrowindex').val(rowindex);
    });
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id="contractGrid"></div>
<input type="hidden" name="gridrowindex" id="gridrowindex">