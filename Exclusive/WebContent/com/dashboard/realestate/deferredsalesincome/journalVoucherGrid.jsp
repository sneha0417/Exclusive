<%@page import="com.dashboard.realestate.deferredsalesincome.ClsDeferredSalesIncomeDAO" %>
<%
ClsDeferredSalesIncomeDAO DAO=new ClsDeferredSalesIncomeDAO();     
	String id = request.getParameter("id")==null?"0":request.getParameter("id"); 
	String acno = request.getParameter("acno")==null?"0":request.getParameter("acno").trim();
	String amount = request.getParameter("amount")==null?"0":request.getParameter("amount").trim(); 
%>
<style>
	.redClass
    {
    	background-color: #FFEBEB;
    }  
</style>
<script type="text/javascript">
var data1;
var id='<%=id%>';
if(id=="1"){
	data1='<%=DAO.loadjvGrid(acno, id, amount)%>';
}     
$(document).ready(function () {     
	
	// prepare the data
    var source =
    {
    	datatype: "json",
        datafields: [
						{name : 'account', type: 'string'   },
						{name : 'accountname', type: 'string'  },
						{name : 'debit', type: 'number'   },
						{name : 'credit', type: 'number'   },
						{name : 'baseamt', type: 'number'   },
						{name : 'id', type: 'number'   },
		],         
        localdata: data1,             
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.   
        }
	};
   
    var dataAdapter = new $.jqx.dataAdapter(source);
            
    $("#jqxjvGrid").jqxGrid(
	{
    	width: '100%',
        height: 150,
        source: dataAdapter,
        columnsresize:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        showfilterrow: true,
        sortable:true,
        enabletooltips: true,
        columns: [
        	{ text: 'SL#', sortable: false, filterable: false, editable: false,
            	groupable: false, draggable: false, resizable: false,
                datafield: 'sl', columntype: 'number', width: '2%',
                cellsrenderer: function (row, column, value) {
                	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                }  
            },                          
            { text: 'Account', datafield: 'account',width: '10%' },    	
			{ text: 'Account Name', datafield: 'accountname',width: '65.6%' },    	     
			{ text: 'Debit', datafield: 'debit', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum']},
			{ text: 'Credit', datafield: 'credit', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum']},
			{ text: 'Base', datafield: 'baseamt', hidden:true,width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum']},
			{ text: 'ID', datafield: 'id',width: '5%', hidden:true },  
		]     
	});
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id="jqxjvGrid"></div>        