<%@page import="com.dashboard.analysis.salesinvoice.ClsSalesInvoiceDAO" %>
<% ClsSalesInvoiceDAO csd=new ClsSalesInvoiceDAO();%>

<%
String temp=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String grpby1=request.getParameter("grpby1")==null?"":request.getParameter("grpby1");
String hidclientcat=request.getParameter("hidclientcat")==null?"":request.getParameter("hidclientcat");
String hidclient=request.getParameter("hidclient")==null?"":request.getParameter("hidclient");
String hidsalesman=request.getParameter("hidsalesman")==null?"":request.getParameter("hidsalesman");
String hidrentalagent=request.getParameter("hidrentalagent")==null?"":request.getParameter("hidrentalagent");
String hidbrand=request.getParameter("hidbrand")==null?"":request.getParameter("hidbrand");
String hidmodel=request.getParameter("hidmodel")==null?"":request.getParameter("hidmodel");
String hidgroup=request.getParameter("hidgroup")==null?"":request.getParameter("hidgroup");
String hidyom=request.getParameter("hidyom")==null?"":request.getParameter("hidyom");
%>

<script type="text/javascript">
var invoicedatedata ;
$(document).ready(function () {
   var id='<%=temp%>';

//var invoiceexcel;
   if(id=='1'){
	invoicedatedata='<%=csd.getSalesInvoices_Dates(branch,fromdate,todate,grpby1,hidclientcat,hidclient,hidsalesman,hidrentalagent,hidbrand,hidmodel,hidgroup,hidyom,temp)%>';
   }
else{
	invoicedatedata;
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'refno',type:'number'},
                  		{name : 'description',type:'String'},
                  		{name : 'total',type:'number'}
                  		
                  		],
				    localdata: invoicedatedata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#salesInvListGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    
    var rendererstring=function (aggregates){
    	var value=aggregates['sum'];
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + '' + value + '</div>';
    }
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#salesInvListGrid").jqxGrid(
    {
        width: '98%',
        height: 515,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        showaggregates:true,
        showstatusbar:true,
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Ref No',datafield:'refno',width:'10%'},
       				{ text:'Description',datafield:'description',width:'75%'},
       				{ text: 'Total',datafield:'total',width:'10%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellsalign:'right'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    });

	
	
</script>
<div id="salesInvListGrid"></div>