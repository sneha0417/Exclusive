<%@page import="com.dashboard.audit.vatreportnew.*"%>
<%
ClsVatReportNewDAO vatdao=new ClsVatReportNewDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>

<script type="text/javascript">
 
var id='<%=id%>';
var vatoutputdata=[];
 
if(id=='1'){
	vatoutputdata='<%=vatdao.getVatOutputData(id, branch, fromdate, todate)%>';
 
}
else{
	vatoutputdata=[];
	 
}
 
$(document).ready(function () {
   
    // prepare the data
	var renderertotal=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
	var rendererapplied=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
	var renderernotapplied=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
	var renderercollected=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	/* var nettotal=parseFloat($('#nettotal').val());
     	if(value!="" && value!=null && value!="undefined"){
     		 //$('#genuinetotal').val(value.replace(/\,/g,""));
     		nettotal=parseFloat(value.replace(/\,/g,""))-nettotal;
     	}
     	$('#nettotal').val(nettotal);
     	funRoundAmt(nettotal,"nettotal"); */
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
    var source =
    {
        datatype: "json", 
        datafields: [

                  		{name : 'branchname',type:'string'},
                  		{name : 'customer_name',type:'string'},
                  		{name : 'trnno',type:'string'},
                  		{name : 'doctype',type:'string'},
                  		{name : 'docno',type:'number'},
                  		{name : 'invno',type:'number'},
                  		{name : 'total_invoicevalue',type:'number'},
                  		{name : 'vat5persales',type:'number'},
                  		{name : 'vat0persales',type:'number'},
                  		{name : 'vatcollected',type:'number'},
                  		{name : 'date',type:'string'},
                  		{name : 'exempted',type:'number'},
                  		 
                  		{name : 'type',type:'string'},
                  		],
				    localdata: vatoutputdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#vatOutputGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	var totaloutput=$("#vatOutputGrid").jqxGrid('getcolumnaggregateddata', 'vatcollected', ['sum']);
    	$('#totaloutput').val(parseFloat(totaloutput.sum));
    	funRoundAmt(totaloutput.sum,"totaloutput");
    	var nettotalinput=$('#totalinput').val();
    	var nettotaloutput=$('#totaloutput').val();
    	var nettotal=parseFloat(nettotaloutput)-parseFloat(nettotalinput);
    	funRoundAmt(nettotal,"nettotal");
    });       
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#vatOutputGrid").jqxGrid(
    {
        width: '98%',
        height: 220,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
       	sortable:false,
       	columnsresize:true,
       	showaggregates:true,
        showstatusbar:true,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             			groupable: false, draggable: false, resizable: false,datafield: '',
             			columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
             			cellsrenderer: function (row, column, value) {
              				return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           				}},
		 
       				{ text: 'Branch',datafield:'branchname',width:'12%'},
       				{ text: 'Date',datafield:'date',width:'7%' },
       				{ text: 'Customer',datafield:'customer_name',width:'18%'},
       				{ text: 'TRN',datafield:'trnno',width:'10%'},
       				{ text: 'Inv Type',datafield:'doctype',width:'5%'},
       				{ text: 'Doc_No',datafield:'docno',width:'5%'},
       				{ text: 'Invoice No',datafield:'invno',width:'7%'}, 
       				 
       				{ text: 'Total Invoice Value',datafield:'total_invoicevalue',width:'8%',cellsalign: 'right', align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:renderertotal},
       				{ text: 'VAT 5% Sales',datafield:'vat5persales',width:'8%',cellsalign: 'right', align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererapplied},
					{ text: 'VAT 0% Sales',datafield:'vat0persales',width:'8%',cellsalign: 'right', align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:renderernotapplied},
       				{ text: 'VAT Collected',datafield:'vatcollected',width:'8%',cellsalign: 'right', align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:renderercollected},
				
					{ text: 'Exempted',datafield:'exempted',width:'7%',cellsalign: 'right', align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:renderercollected},
					{ text: 'Type',datafield:'type',width:'5%'},
					
					]

    });
    $('#vatOutputGrid').on('rowdoubleclick', function (event) 
    { 
  		var rowindex1=event.args.rowindex;
    });	 
    
});

	
	
</script>
<div id="vatOutputGrid"></div>