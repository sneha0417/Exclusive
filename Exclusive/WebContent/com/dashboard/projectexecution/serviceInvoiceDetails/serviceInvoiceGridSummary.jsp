<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.serviceInvoiceDetails.ClsServiceInvoiceDetails"%>

<%

String sertypeid = request.getParameter("sertypeid")==null?"0":request.getParameter("sertypeid").trim();
String siteid = request.getParameter("siteid")==null?"0":request.getParameter("siteid").trim();
String statusid = request.getParameter("statusid")==null?"0":request.getParameter("statusid").trim();
String contractid = request.getParameter("contractid")==null?"0":request.getParameter("contractid").trim();
String clientid = request.getParameter("clientid")==null?"0":request.getParameter("clientid").trim();
String branchid = request.getParameter("branchid")==null?"0":request.getParameter("branchid").trim();
String grpby = request.getParameter("grpby")==null?"0":request.getParameter("grpby").trim();
String fromDate = request.getParameter("frmdate")==null?"0":request.getParameter("frmdate").trim();
String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").trim());

	ClsServiceInvoiceDetails dao= new ClsServiceInvoiceDetails();
%>
<style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
     .orangeClass
    {
        background-color: #FFEBC2;
    }
    
</style>
<script type="text/javascript">
    
       var partdata;
       var excelsummarydata;
       var type='<%=type%>';
       
       var rendererstring=function (aggregates){
    	  	var value=aggregates['sum'];
    	  	
    	  	if(typeof(value)=='undefined'){
    	  		value=0;
    	  	}
    	  	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
    		}
    	  	var rendererstring1=function (aggregates){
    	  	var value1=aggregates['sum1'];
    	  	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
    	  }
    	 
	  	if(type=='1'){ 
	  		partdata='<%=dao.serviceInvoiceSummaryGridLoad(session,sertypeid,siteid,statusid,contractid,clientid, branchid,fromDate,toDate,id,grpby)%>';
	  		excelsummarydata='<%=dao.ExcelserviceInvoiceSummaryGridLoad(session,sertypeid,siteid,statusid,contractid,clientid, branchid,fromDate,toDate,id,grpby)%>';
	  	} 
		else{
		partdata;
	}

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
						{name : 'total', type: 'number'  },
						{name : 'leglchrg', type: 'number'  },
						{name : 'taxamt', type: 'number' },
						{name : 'desc1', type: 'String' },
			
			],
				    localdata: partdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, data) {
    	
		 if (data.isqty !=0) {
            return "yellowClass";
        }else{
        	return "orangeClass";
        };
    };

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#jqxSerInvSummaryGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: '', columntype: 'number', width: '5%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }
					},
					{ text: 'DESCRIPTION',  datafield: 'desc1', columntype:'textbox', width: '50%',cellclassname:cellclassname ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },     
					{ text: 'NET AMOUNT',columntype: 'textbox', datafield: 'total', width: '15%',cellclassname:cellclassname,cellsformat: 'd2', cellsalign: 'right', align: 'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'LEGAL CHARGE',columntype: 'textbox',  datafield: 'legalchrg', width: '15%',cellclassname:cellclassname,cellsformat: 'd2', cellsalign: 'right', align: 'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'TAX AMOUNT',columntype: 'textbox', datafield: 'taxamt', width: '15%',cellclassname:cellclassname,cellsformat: 'd2', cellsalign: 'right', align: 'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring },
				
					
			]
    });

    $("#overlay, #PleaseWait").hide();
});


</script>
<div id="jqxSerInvSummaryGrid"></div>