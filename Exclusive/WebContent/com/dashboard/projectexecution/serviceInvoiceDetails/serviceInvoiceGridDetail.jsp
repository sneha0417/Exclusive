<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.serviceInvoiceDetails.ClsServiceInvoiceDetails" %>
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
    
    .greyClass
    {
        background-color: #e6e6e6;
    }
    
     .orangeClass
    {
        background-color: #FFEBC2;
    }
    
</style>
<script type="text/javascript">
    
       var detdata;
       var exceldetaildata;
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
    	 
	  	if(type=='2'){ 
	  	 detdata='<%=dao.serviceInvoiceDetailGridLoad(session,sertypeid,siteid,statusid,contractid,clientid, branchid,fromDate,toDate,id)%>'; 
	  	exceldetaildata='<%=dao.ExcelserviceInvoiceDetailGridLoad(session,sertypeid,siteid,statusid,contractid,clientid, branchid,fromDate,toDate,id)%>';
	  	} 
		else{
			detdata;
	}

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
						{name : 'dtype', type: 'String'  },
						{name : 'refdocno', type: 'String'  },
						{name : 'tr_no', type: 'String' },
						{name : 'site', type: 'String' },
						{name : 'area', type: 'String' },
						{name : 'refname', type: 'String' },
						{name : 'pldate', type: 'String' },
						{name : 'invdate', type: 'String' },
						{name : 'pltime', type: 'String' },
						{name : 'pldte', type: 'String' },
						{name : 'sertype', type: 'String' },
						{name : 'serdocno', type: 'String' },
						{name : 'statuss', type: 'String' },
						{name : 'apprdate', type: 'String' },
						{name : 'validupto', type: 'String' },
						{name : 'complaint', type: 'String' },
						{name : 'priority', type: 'String' },
						{name : 'gridrow', type: 'String' },
						{name : 'docno2', type: 'int'   },
						{name : 'claddress', type: 'string'   },
						{name : 'acno', type: 'string'   },
						{name : 'invno', type: 'string'   },
						{name : 'invamt', type: 'number'   },
						{name : 'contracttrno', type: 'String' },
						{name : 'contractdetails', type: 'String' },
						{name : 'siteid', type: 'String' },
						{name : 'areaid', type: 'String' },
						{name : 'sport', type: 'String' },
						{name : 'contr', type: 'String' },
						{name : 'maintrno', type: 'String' },
						{name : 'asgngrp', type: 'String' },
						{name : 'teampid', type: 'String' },
						{name : 'grpid', type: 'String' },
						{name : 'emp', type: 'String' },
						{name : 'empid', type: 'String' },
						{name : 'asgnmode', type: 'String' },
						{name : 'asignid', type: 'String' },
						{name : 'path', type: 'String' },
						{name : 'name', type: 'String' },
						{name : 'doctrno', type: 'String' }
						
          ],
				    localdata: detdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, data) {
    	
		 if (data.trtype==0) {
            return "greyClass";
        };
    };

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
   
    $("#jqxSerInvDetailGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        enableAnimations: true,
        filtermode:'excel',
        showaggregates:true,
        filterable: true,
        sortable:true,
        showstatusbar:true,
        statusbarheight: 25,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [     
					{ text: 'DTYPE',columntype: 'textbox', datafield: 'dtype', width: '4%',cellclassname:cellclassname },
					{ text: 'DOC NO',columntype: 'textbox',  datafield: 'refdocno', width: '5%',cellclassname:cellclassname },
					{ text: 'CLIENT NAME',columntype: 'textbox',  datafield: 'refname', width: '20%',cellclassname:cellclassname },
					{ text: 'SCH.NO',columntype: 'textbox', datafield: 'tr_no', width: '8%',cellclassname:cellclassname },
					{ text: 'STATUS',columntype: 'textbox', datafield: 'statuss', width: '8%',cellclassname:cellclassname },
					{ text: 'PLANNED DATE',columntype: 'textbox',  datafield: 'pldate', width: '6%',cellclassname:cellclassname },
					{ text: 'INVOICE DATE',columntype: 'textbox',  datafield: 'invdate', width: '6%',cellclassname:cellclassname },
					{ text: 'END DATE',columntype: 'textbox',  datafield: 'validupto', hidden: true, width: '6%',cellclassname:cellclassname },
					{ text: 'AREA',columntype: 'textbox', datafield: 'area', width: '10%',cellclassname:cellclassname },
					{ text: 'SITE NAME',columntype: 'textbox', width: '11%', datafield: 'site',cellclassname:cellclassname },
					{ text: 'SERVICE TYPE',columntype: 'textbox', width: '10%', datafield: 'sertype',cellclassname:cellclassname },
					
					{ text: 'INV NO',columntype: 'textbox', datafield: 'invno', width: '6%',cellclassname:cellclassname ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
					{ text: 'INV AMT',columntype: 'textbox', datafield: 'invamt', width: '6%',cellclassname:cellclassname,cellsformat: 'd2', cellsalign: 'right', align: 'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring },
					
					{ text: 'ASSIGN.GROUP',columntype: 'textbox', hidden: true, datafield: 'asgngrp', width: '10%',cellclassname:cellclassname },
					{ text: 'EMPLOYEE',columntype: 'textbox', hidden: true, datafield: 'emp', width: '10%',cellclassname:cellclassname },
					{ text: 'ASSIGN.MODE',columntype: 'textbox', hidden: true, datafield: 'asgnmode', width: '8%',cellclassname:cellclassname },
					{ text: 'teampid',columntype: 'textbox', hidden: true, datafield: 'teampid',cellclassname:cellclassname, hidden: true },
					{ text: 'grpid',columntype: 'textbox', hidden: true, datafield: 'grpid',cellclassname:cellclassname, hidden: true },
					{ text: 'empid',columntype: 'textbox', hidden: true, datafield: 'empid',cellclassname:cellclassname, hidden: true },
					{ text: 'asignid',columntype: 'textbox', hidden: true, datafield: 'asignid',cellclassname:cellclassname, hidden: true },
					{ text: 'APPR.DATE',columntype: 'textbox', hidden: true,  datafield: 'apprdate', hidden: true, width: '6%',cellclassname:cellclassname },
					{ text: 'COMPLAINT',columntype: 'textbox',  datafield: 'complaint',cellclassname:cellclassname,hidden:true },
					{ text: 'cmpldate',columntype: 'textbox',  datafield: 'pldte', width: '10%',hidden:true,cellclassname:cellclassname },
					{ text: 'gridrow',columntype: 'textbox',  datafield: 'gridrow', width: '10%',hidden:true,cellclassname:cellclassname },
					{ text: 'Doc No',  datafield: 'docno2', hidden: true, width: '5%' },
					{ text: 'Acc No',  datafield: 'acno', hidden: true, width: '5%' },
					{ text: 'Address',  datafield: 'claddress', hidden: true, width: '15%' },
					{ text: 'serdocno',  datafield: 'serdocno', hidden: true, width: '5%' },
					{ text: 'Contracttrno',  datafield: 'contracttrno', hidden: true, width: '5%' },
					{ text: 'Contractdetails',  datafield: 'contractdetails', hidden: true, width: '5%' },
					{ text: 'Site Id',  datafield: 'siteid', hidden: true, width: '5%' },
					{ text: 'Area Id',  datafield: 'areaid', hidden: true, width: '5%' },
					{ text: 'Path',  datafield: 'path', hidden: true, width: '5%' },
					{ text: 'name',  datafield: 'name', hidden: true, width: '5%' },
					{ text: 'doctrno',  datafield: 'doctrno', hidden: true, width: '5%' },
					
	              ]		
   
    });

    $("#overlay, #PleaseWait").hide();
});


</script>
<div id="jqxSerInvDetailGrid"></div>