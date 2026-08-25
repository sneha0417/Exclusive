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
var summdata;
var id='<%=id%>';
if(id=="1"){
	summdata='<%=DAO.getSummaryData(fromdate, todate, id, salid)%>';   
}          
$(document).ready(function () {  
	
	// prepare the data
    var source =
    {
    	datatype: "json",
        datafields: [    
						{name : 'doc_no', type: 'String'   },
						{name : 'invno', type: 'String'   },
						{name : 'team', type: 'String'   },
						{name : 'agent', type: 'String'   },
						{name : 'property', type: 'String'   },
						{name : 'tenant', type: 'String'   },
						{name : 'date', type: 'date'   },
						{name : 'type', type: 'String'   },
						{name : 'commval', type: 'number'   },
						{name : 'commper', type: 'number'   },
						{name : 'saleval', type: 'number'   },
						{name : 'remarks', type: 'String'   },
						{name : 'brhid', type: 'String'   },
						{name : 'shared', type: 'String'   }, 
						{name : 'total', type: 'number'   },
		],         
        localdata: summdata,    
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
            
    $("#jqxAgentSummaryGrid").jqxGrid(
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
        	{ text: 'Doc No', datafield: 'invno', width: '5%',cellclassname:cellclassname}, 
        	{ text: 'Type', datafield: 'type', width: '6%',cellclassname:cellclassname},
        	{ text: 'Date', datafield: 'date', width: '5%' ,cellsformat:'dd.MM.yyyy',cellclassname:cellclassname},
        	{ text: 'Team', datafield: 'team' , width: '12%',cellclassname:cellclassname},
        	{ text: 'Agent', datafield: 'agent' , width: '14%',cellclassname:cellclassname},       
        	{ text: 'Tenant', datafield: 'tenant', width: '15%',cellclassname:cellclassname},
        	{ text: 'Property', datafield: 'property' ,cellclassname:cellclassname},     
        	{ text: 'Shared Among(Persons)', datafield: 'shared' , width: '7%',cellclassname:cellclassname},  
        	{ text: 'Total', datafield: 'total', width: '7%' , cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname:cellclassname},
        	{ text: '%', datafield: 'commper', width: '7%' , cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname:cellclassname},
        	{ text: 'Commission', datafield: 'commval', width: '7%' , cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname:cellclassname},
        	{ text: 'Doc No', datafield: 'doc_no', width: '6%',hidden:true},
        	{ text: 'brhid', datafield: 'brhid', width: '6%',hidden:true},    
		]
	});
    
    $('#jqxAgentSummaryGrid').on('rowdoubleclick', function (event) {           
    	var rowindex= event.args.rowindex;
    	$('#hidreftype').val($('#jqxAgentGrid').jqxGrid('getcellvalue',rowindex,'reftype'));
		$('#hiddocno').val($('#jqxAgentSummaryGrid').jqxGrid('getcellvalue',rowindex,'doc_no'));
		$('#hidvocno').val($('#jqxAgentSummaryGrid').jqxGrid('getcellvalue',rowindex,'invno'));
		$('#hidbrhid').val($('#jqxAgentSummaryGrid').jqxGrid('getcellvalue',rowindex,'brhid'));  
		var invno=$('#jqxAgentSummaryGrid').jqxGrid('getcellvalue',rowindex,'invno');   
		var propname=$('#jqxAgentSummaryGrid').jqxGrid('getcellvalue',rowindex,'propname');       
		$('.textpanel p').text(invno+' - '+propname);   
		 $('.comments-container').html("");   
	}); 
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id="jqxAgentSummaryGrid"></div>