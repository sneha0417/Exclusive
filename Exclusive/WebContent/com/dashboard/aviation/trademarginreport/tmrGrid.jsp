<%@page import="com.dashboard.aviation.trademarginreport.ClsTradeMarginReportDAO"%>
<% ClsTradeMarginReportDAO sd=new ClsTradeMarginReportDAO();%>
  <% String sortby =request.getParameter("sortby")==null?"0":request.getParameter("sortby").toString();%>
  <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
  <% String portid =request.getParameter("portid")==null?"0":request.getParameter("portid").toString();%>
  <% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());%>
  <% String vendorid =request.getParameter("vendorid")==null?"0":request.getParameter("vendorid").toString();%>
  <% String date =request.getParameter("date")==null?"0":request.getParameter("date").toString();%>
 <% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();%>
  <% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();%>
<style type="text/css">
  .advanceClass
  {
      color: #FF0000;
  }
  .yellowClass
        {
       background-color: #ffc0cb; 
        }
</style>
 
<script type="text/javascript">

var data;
var exdata;
var id='<%= id%>';
if(id>0){
 data= '<%=sd.loadGridData(sortby,clientid,portid,date,vendorid,fromdate,todate,id)%>'; 
 exdata= '<%=sd.exloadGridData(sortby,clientid,portid,date,vendorid,fromdate,todate,id)%>';
}else{
	data;
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
        	{name :'delno', type:'String' },
        	{name :'invno', type:'String' },
        	{name :'dno', type:'String' },
        	{name :'invdate', type:'date' },
        	{name :'fueldate', type:'date' },
        	{name :'vendor', type:'String' },
        	{name :'client', type:'String' },
        	{name :'port', type:'String' },
        	{name :'sales', type:'number' },
        	{name :'purc', type:'number' },
        	{name :'qty', type:'number' },
        	{name :'sval', type:'number' },
        	{name :'pval', type:'number' },
        	{name :'usc', type:'number' },
        	{name :'total', type:'number' },
        	{name :'perc', type:'number' }
           ],
				    localdata: data,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
   var cellclassname =  function (row, column, value, data) {
	    
   }
   
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    $("#orderlistgrid").jqxGrid(
    {
        width: '98%',
        height: 505,
        statusbarheight:25,
        showstatusbar:true,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        columnsresize: true,
        showaggregates:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [  
                      { text: 'Sl. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
                       return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                       }   },
                      { text: 'DEL NO', datafield: 'delno', width: '6%'},
                      { text: 'INV NO', datafield: 'invno', width: '6%'},
                      { text: 'DNO', datafield: 'dno', width: '6%'},
                      { text: 'INV DATE', datafield: 'invdate',cellsformat: 'dd.MM.yyyy', width: '7%'},
                      { text: 'FUEL DATE', datafield: 'fueldate',cellsformat: 'dd.MM.yyyy', width: '7%'},
                      { text: 'CLIENT', datafield: 'client', width: '15%'},
                      { text: 'VENDOR', datafield: 'vendor', width: '15%'},
                      { text: 'PORT', datafield: 'port', width: '10%',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname},
                      { text: 'SALES', datafield: 'sales',columngroup:'unitprice', width: '5%',cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
                      { text: 'PURC', datafield: 'purc',columngroup:'unitprice', width: '5%',cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
                      { text: 'QTY', datafield: 'qty', width: '6%',cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},     
                      { text: 'SALES VALUE', datafield: 'sval', width: '8%',cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
                      { text: 'PURCHASE VALUE', datafield: 'pval', width: '8%',cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
                      { text: 'USC/USG', datafield: 'usc',columngroup:'margin', width: '6%',cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
                      { text: 'TOTAL', datafield: 'total',columngroup:'margin', width: '6%',cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
                      { text: '%', datafield: 'perc', width: '5%',cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
           ],columngroups: 
	                     [
	                       { text: 'Unit Price', align: 'center', name: 'unitprice',width: '10%' },
	                       { text: 'Margin', align: 'center', name: 'margin',width: '12%' }
	                     ]
   
    });
    $("#overlay, #PleaseWait").hide();
   
});


</script>
<div id="orderlistgrid"></div>