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
var vatinputdata=[];
 

if(id=='1'){
 	vatinputdata='<%=vatdao.getVatInputData(id, branch, fromdate, todate)%>'; 
 
}
else{
	vatinputdata=[];
 
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
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
    var source =
    {
        datatype: "json",
        datafields: [
 


                  		{name : 'branchname',type:'string'},
                  		{name : 'vendor',type:'string'},
                  		{name : 'trnno',type:'string'},
                  		{name : 'doctype',type:'string'},
                  		{name : 'docno',type:'number'},
                  		{name : 'exempted',type:'number'},
                  		{name : 'totalamount',type:'number'},
                  		{name : 'vat5perpurchase',type:'number'},
                  		{name : 'vat0perpurchase',type:'number'},
                  		{name : 'vatpaid',type:'number'},
                  		{name : 'vendorinvno',type:'string'},
                  		{name : 'date',type:'string'},
                  		{name : 'vendorinvdate',type:'string'},
                  		{name : 'type',type:'string'},
                  		
                  		
                  		
                  		],
				    localdata: vatinputdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#vatInputGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	var totalinput=$("#vatInputGrid").jqxGrid('getcolumnaggregateddata', 'vatpaid', ['sum']);
    	$('#totalinput').val(parseFloat(totalinput.sum));
    	funRoundAmt(totalinput.sum,"totalinput");
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
    
    
    
    $("#vatInputGrid").jqxGrid(
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
           				}    
       				},
       				{ text: 'Branch',datafield:'branchname',width:'12%'},
       				{ text: 'Date',datafield:'date',width:'8%' },       				
       				{ text: 'Vendor',datafield:'vendor',width:'20%'},
       				{ text: 'TRN',datafield:'trnno',width:'10%'},
       				{ text: 'Doc Type',datafield:'doctype',width:'5%'},
       				{ text: 'Doc No',datafield:'docno',width:'6%'},
       		 
       				{ text: 'Vendor Inv No',datafield:'vendorinvno',width:'8%'},
       				{ text: 'Vendor Inv Date',datafield:'vendorinvdate',width:'8%'},
       				{ text: 'Total Amount',datafield:'totalamount',width:'7%',cellsalign: 'right', align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:renderertotal},
       				{ text: 'VAT 5% Purchase',datafield:'vat5perpurchase',width:'7%',cellsalign: 'right', align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererapplied},
					{ text: 'VAT 0% Purchase',datafield:'vat0perpurchase',width:'7%',cellsalign: 'right', align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:renderernotapplied},
       				{ text: 'VAT Paid',datafield:'vatpaid',width:'7%',cellsalign: 'right', align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:renderercollected},
       				{ text: 'Exempted',datafield:'exempted',width:'7%',cellsalign: 'right', align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:renderercollected},
					{ text: 'Type',datafield:'type',width:'5%'},
					
					
					]

    });
    $('#vatInputGrid').on('rowdoubleclick', function (event) 
    { 
  		var rowindex1=event.args.rowindex;
    });	 
    
});

	
	
</script>
<div id="vatInputGrid"></div>