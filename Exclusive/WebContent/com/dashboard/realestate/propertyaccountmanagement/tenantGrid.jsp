<%@page import="com.dashboard.realestate.propertyaccountmanagement.ClsPropertyAccountManagementDAO"%>
<% ClsPropertyAccountManagementDAO DAO= new ClsPropertyAccountManagementDAO();  %> 
<%
	String id = request.getParameter("id")==null?"0":request.getParameter("id"); 
 	String branch = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String pdocno = request.getParameter("pdocno")==null?"0":request.getParameter("pdocno").trim();
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
	griddata='<%=DAO.getMgmtData(branch, fromdate, todate, id, pdocno)%>';
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
	        	{name : 'srno', type: 'number'   },
	            {name : 'cnt_no', type: 'number'   },
	            {name : 'tenantname', type: 'String'   },
		        {name : 'cnt_date', type: 'date'   },
		        {name : 'fromdate', type: 'date'   },
				{name : 'todate', type: 'date'   }, 
			 	{name : 'rentalv', type: 'number'   },
				{name : 'tadminfee', type: 'number'   },    
				{name : 'commamt', type: 'number'   },
				{name : 'oadminfee', type: 'number'   },
				{name : 'agentcomm', type: 'number'   },       
				{name : 'income', type: 'number'   },
				{name : 'mgmtamt', type: 'number'   },
				{name : 'agent', type: 'String'  }, 
		],
        localdata: griddata,    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
	};
    
    var dataAdapter = new $.jqx.dataAdapter(source);
            
    $("#tenancyGrid").jqxGrid(
	{
    	width: '100%',
        height: 300,
        source: dataAdapter,
        columnsresize:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        showfilterrow: true,
        sortable:true,
        enabletooltips: true,
        showstatusbar:true,
        showaggregates:true,
        statusbarheight:25,
        columns: [
        	{ text: 'SL#', sortable: false, filterable: false, editable: false,
            	groupable: false, draggable: false, resizable: false,
                datafield: 'sl', columntype: 'number', width: '2%',
                cellsrenderer: function (row, column, value) {
                	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                }  
            },
        	{ text: 'Contract No', datafield: 'cnt_no', width: '4%' },           
            { text: 'Contract Date', datafield: 'cnt_date', width: '6%',cellsformat:'dd.MM.yyyy' },
			{ text: 'Tenant Name', datafield: 'tenantname'},
			{ text: 'Agent', datafield: 'agent',  width: '10%'},
			{ text: 'From Date', datafield: 'fromdate', width: '6%' ,cellsformat:'dd.MM.yyyy'},   
			{ text: 'To Date', datafield: 'todate', width: '6%',cellsformat:'dd.MM.yyyy' },
			{ text: 'Rental Value', datafield: 'rentalv', width: '7%' , cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregatesrenderer:rendererstring, aggregates: ['sum']},
			{ text: 'Tenant Admin Fee', datafield: 'tadminfee', width: '7%' , cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregatesrenderer:rendererstring, aggregates: ['sum']},
			{ text: 'Tenant Commission Fee', datafield: 'commamt', width: '7%' , cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregatesrenderer:rendererstring, aggregates: ['sum']},
			{ text: 'Management Fee', datafield: 'mgmtamt', width: '7%' , cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregatesrenderer:rendererstring, aggregates: ['sum'] },
			{ text: 'Owner Admin Fee', datafield: 'oadminfee', width: '7%' , cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregatesrenderer:rendererstring, aggregates: ['sum']},
			{ text: 'Agent Commission Total', datafield: 'agentcomm', width: '7%' , cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregatesrenderer:rendererstring, aggregates: ['sum']},
			{ text: 'Income', datafield: 'income', width: '7%' , cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregatesrenderer:rendererstring, aggregates: ['sum']},
			]
	});           
          
    $("#overlay, #PleaseWait").hide();
    
    $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
    // create context menu
       var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
       $("#tenancyGrid").on('contextmenu', function () {
           return false;
       });
       
       $("#Menu").on('itemclick', function (event) {
    	   var args = event.args;
           var rowindex = $("#tenancyGrid").jqxGrid('getselectedrowindex');
           if ($.trim($(args).text()) == "Edit Selected Row") {
               
           }
           else {
		        if($.trim($(args).text()) == "Tenancy Contract"){
					 var validcheck=document.getElementById("validcheck").value;
					 if(typeof(validcheck)!="undefined" && typeof(validcheck)!="NaN" && validcheck!=""){              
						 var path1="",detName="";
						 var url=document.URL;
						 var reurl=url.split("com/");
						 var mod="v";
						  detName= "Tenancy Contract";   
						  window.parent.formName.value="Tenancy Contract";
						  window.parent.formCode.value="TNC";       
						  var doc=$('#tenancyGrid').jqxGrid('getcellvalue', rowindex, "cnt_no");   
						  path1='com/realestate/tenancycontract/saveTenancyContract?mode=view&docno='+doc;                
								//var path= path1+"?&docno="+doc+"&accname="+acname;
							document.getElementById("validcheck").value="";                   	
						  top.addTab( detName,reurl[0]+""+path1);                
					  }
					  
				    }
                 }
       });
       $("#tenancyGrid").on('rowclick', function (event) {
           if (event.args.rightclick) {
               $("#tenancyGrid").jqxGrid('selectrow', event.args.rowindex);
               var rowindex=event.args.rowindex;
               document.getElementById("validcheck").value=$('#tenancyGrid').jqxGrid('getcellvalue',rowindex,'cnt_no');               
               var scrollTop = $(window).scrollTop();
               var scrollLeft = $(window).scrollLeft();
               contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
               return false;
           }
       });              
});
</script>
<div id='jqxWidget'>          
    <div id="tenancyGrid"></div>
    <div id="popupWindow">
 
 <div id='Menu'>   
        <ul>
            <li>Tenancy Contract</li>             
        </ul>
       </div>
       </div>
       </div>     
<input type="hidden" name="validcheck" id="validcheck">  
<input type="hidden" name="gridrowindex" id="gridrowindex">             