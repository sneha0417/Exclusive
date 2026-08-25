<%@page import="com.dashboard.realestate.deferredsalesincome.ClsDeferredSalesIncomeDAO" %>
<%
ClsDeferredSalesIncomeDAO DAO=new ClsDeferredSalesIncomeDAO();    
	String id = request.getParameter("id")==null?"0":request.getParameter("id"); 
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
%>
<style>
	.redClass
    {
    	background-color: #FFEBEB;
    }
</style>
<script type="text/javascript">
var sumdata;
var id='<%=id%>';
if(id=="1"){
	sumdata='<%=DAO.summaryData(fromdate, todate, id)%>';
}     
$(document).ready(function () {  
	
	// prepare the data
    var source =
    {
    	datatype: "json",
        datafields: [
						{name : 'jvtrno', type: 'String'   },
						{name : 'doc_no', type: 'String'   },
						{name : 'invno', type: 'String'   },
						{name : 'ownername', type: 'String'   },
						{name : 'propname', type: 'String'   },
						{name : 'date', type: 'date'   },
						{name : 'reftype', type: 'String'   },
						{name : 'saleval', type: 'number'   },
						{name : 'netamount', type: 'number'   },
						{name : 'remarks', type: 'String'   },
						{name : 'rowno', type: 'String'   },
						{name : 'brhid', type: 'String'   },
						{name : 'amount', type: 'number'   },       
		],         
        localdata: sumdata,    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
	};
    var cellclassname = function (row, column, value, data) {
		 if (parseInt(data.jvtrno)>0) {                 
           return "redClass";
       }
   };
    var dataAdapter = new $.jqx.dataAdapter(source);
            
    $("#jqxsummaryGrid").jqxGrid(
	{
    	width: '100%',
        height: 500,
        source: dataAdapter,
        columnsresize:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        showfilterrow: true,
        sortable:true,
        enabletooltips: true,
        columns: [
        	{ text: 'SL#', sortable: false, filterable: false, editable: false,cellclassname:cellclassname,
            	groupable: false, draggable: false, resizable: false,
                datafield: 'sl', columntype: 'number', width: '2%',
                cellsrenderer: function (row, column, value) {
                	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                }  
            },                          
            { text: 'Date', datafield: 'date', width: '5%' ,cellsformat:'dd.MM.yyyy',cellclassname:cellclassname},
        	{ text: 'Inv No', datafield: 'invno', width: '5%',cellclassname:cellclassname}, 
        	{ text: 'Doc No', datafield: 'doc_no', width: '6%',hidden:true},
        	{ text: 'Row No', datafield: 'rowno', width: '6%',hidden:true},
        	{ text: 'Brhid', datafield: 'brhid', width: '6%',hidden:true},
        	{ text: 'JVTRNO', datafield: 'jvtrno', width: '6%',hidden:true},
            { text: 'Owner Name', datafield: 'ownername', width: '11%',cellclassname:cellclassname},
			{ text: 'Property Name ', datafield: 'propname' ,cellclassname:cellclassname},     
			{ text: 'Ref Type', datafield: 'reftype', width: '6%',cellclassname:cellclassname},
			{ text: 'Sale Value', datafield: 'saleval', width: '7%' , cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname:cellclassname},
			{ text: 'Amount', datafield: 'amount', width: '7%' , cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname:cellclassname},
			{ text: 'Total', datafield: 'netamount', width: '7%' , cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname:cellclassname},
			{ text: 'Remarks', datafield: 'remarks', width: '13%',cellclassname:cellclassname},
		]
	});   
    
    $('#jqxsummaryGrid').on('rowdoubleclick', function (event) {                   
    	var rowindex= event.args.rowindex;
    	$('#hidrowno').val($('#jqxsummaryGrid').jqxGrid('getcellvalue',rowindex,'rowno'));
    	$('#hidamount').val($('#jqxsummaryGrid').jqxGrid('getcellvalue',rowindex,'amount'));
    	$('#hidjvtrno').val($('#jqxsummaryGrid').jqxGrid('getcellvalue',rowindex,'jvtrno')); 
		$('#txtrefname').val($('#jqxsummaryGrid').jqxGrid('getcellvalue',rowindex,'propname'));  
		$('#hiddocno').val($('#jqxsummaryGrid').jqxGrid('getcellvalue',rowindex,'doc_no'));
		$('#hidvocno').val($('#jqxsummaryGrid').jqxGrid('getcellvalue',rowindex,'invno'));
		$('#hidbrhid').val($('#jqxsummaryGrid').jqxGrid('getcellvalue',rowindex,'brhid'));
		var invno=$('#jqxsummaryGrid').jqxGrid('getcellvalue',rowindex,'invno');
		var propname=$('#jqxsummaryGrid').jqxGrid('getcellvalue',rowindex,'propname');     
		$('.textpanel p').text(invno+' - '+propname);  
		 $('.comments-container').html("");
	}); 
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id="jqxsummaryGrid"></div>