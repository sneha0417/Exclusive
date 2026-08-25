<%@page import="com.dashboard.realestate.agentcommissionlist.ClsAgentCommissionListDAO" %>
<%
    ClsAgentCommissionListDAO DAO=new ClsAgentCommissionListDAO();   
	String salid = request.getParameter("salid")==null?"0":request.getParameter("salid"); 
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
var griddata;
var id='<%=id%>';
if(id=="1"){
	griddata='<%=DAO.getMgmtData(fromdate, todate, id, salid)%>';
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
	// prepare the data
    var source =
    {
    	datatype: "json",
        datafields: [
						{name : 'doc_no', type: 'String'   },
						{name : 'invno', type: 'String'   },
						{name : 'acno', type: 'String'   },
						{name : 'agent', type: 'String'   },
						{name : 'ownername', type: 'String'   },
						{name : 'propname', type: 'String'   },
						{name : 'date', type: 'date'   },
						{name : 'reftype', type: 'String'   },
						{name : 'commval', type: 'number'   },
						{name : 'claimamt', type: 'number'   },
						{name : 'saleval', type: 'number'   },
						{name : 'remarks', type: 'String'   },
						{name : 'rowno', type: 'String'   },
						{name : 'status', type: 'String'   },
						{name : 'brhid', type: 'String'   },
						{name : 'statusid', type: 'String'   }, 
						{name : 'netamount', type: 'number'   },
						{name : 'description', type: 'String'   }, 
						{name : 'commpercent', type: 'number'   },
		],         
        localdata: griddata,    
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
            
    $("#jqxAgentGrid").jqxGrid(
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
        showaggregates: true,
        showstatusbar:true,
        columns: [
        	{ text: 'SL#', sortable: false, filterable: false, editable: false,cellclassname:cellclassname,
            	groupable: false, draggable: false, resizable: false,
                datafield: 'sl', columntype: 'number', width: '2%',
                cellsrenderer: function (row, column, value) {
                	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                }  
            },                          
            { text: 'Date', datafield: 'date', width: '5%' ,cellsformat:'dd.MM.yyyy',cellclassname:cellclassname},
            { text: 'Ref Type', datafield: 'reftype', width: '4%',cellclassname:cellclassname},
        	{ text: 'Ref No', datafield: 'invno', width: '5%',cellclassname:cellclassname}, 
        	{ text: 'Doc No', datafield: 'doc_no', width: '6%',hidden:true},
        	{ text: 'Brhid', datafield: 'brhid', width: '6%',hidden:true},
            { text: 'Acno', datafield: 'acno', width: '5%',cellclassname:cellclassname},
            { text: 'Agent', datafield: 'agent' , width: '15%',cellclassname:cellclassname},
            //{ text: 'Owner Name', datafield: 'ownername', width: '11%',cellclassname:cellclassname},
            
			{ text: 'Property Name ', datafield: 'propname',cellclassname:cellclassname},
			{ text: 'Account Name', datafield: 'description', width: '11%'},
			{ text: 'Commission %', datafield: 'commpercent', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname:cellclassname},
			{ text: 'Commission Value', datafield: 'commval', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname:cellclassname, aggregates: ['sum'], aggregatesrenderer:rendererstring },
			{ text: 'Claim Amount', datafield: 'claimamt', width: '7%' , cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname:cellclassname, aggregates: ['sum'], aggregatesrenderer:rendererstring },
			{ text: 'Value', datafield: 'saleval', width: '7%' , cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname:cellclassname, aggregates: ['sum'], aggregatesrenderer:rendererstring },
			{ text: 'Inv Total', datafield: 'netamount', width: '7%' , cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname:cellclassname, aggregates: ['sum'], aggregatesrenderer:rendererstring },
			//{ text: 'Remarks', datafield: 'remarks', width: '12%',cellclassname:cellclassname},
			{ text: 'Status', datafield: 'status', width: '5%',cellclassname:cellclassname},
			{ text: 'Status ID', datafield: 'statusid', width: '5%',cellclassname:cellclassname,hidden:true},
		]
	});
    
    $('#jqxAgentGrid').on('rowdoubleclick', function (event) {        
    	var rowindex= event.args.rowindex;
    	$('#hidreftype').val($('#jqxAgentGrid').jqxGrid('getcellvalue',rowindex,'reftype'));
		$('#hiddocno').val($('#jqxAgentGrid').jqxGrid('getcellvalue',rowindex,'doc_no'));
		$('#hidvocno').val($('#jqxAgentGrid').jqxGrid('getcellvalue',rowindex,'invno'));
		$('#hidbrhid').val($('#jqxAgentGrid').jqxGrid('getcellvalue',rowindex,'brhid'));
		var invno=$('#jqxAgentGrid').jqxGrid('getcellvalue',rowindex,'invno');
		var propname=$('#jqxAgentGrid').jqxGrid('getcellvalue',rowindex,'propname');     
		$('.textpanel p').text(invno+' - '+propname);  
		$('.comments-container').html("");
	}); 
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id="jqxAgentGrid"></div>