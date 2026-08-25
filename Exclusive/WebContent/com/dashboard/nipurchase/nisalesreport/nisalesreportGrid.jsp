<%@page import="com.dashboard.nipurchase.nisalesreport.ClsnisalesReportsDAO" %>
 
<%
ClsnisalesReportsDAO  ReportsDAO=new  ClsnisalesReportsDAO();
int id=Integer.parseInt(request.getParameter("id")==null?"0":request.getParameter("id").trim());
String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
String client = request.getParameter("client")==null?"0":request.getParameter("client").trim();
String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();	
 %> 

<script type="text/javascript">
var rdatas;
var id='<%=id%>';
// var rdatasex;
 if(id=='1'||id=='2')
{ 
	  rdatas='<%=ReportsDAO.nipurchaseReports(fromdate,todate,client,type,id)%>'; 
<%-- 	  rdatasex='<%=ReportsDAO.nipurchaseReportsex(barchval,fromdate,todate,fromdocno,todocno,fromamount,toamount,accdocno)%>';  --%>
} 
else{ 
	rdatas;
}  

$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     	var rendererstring1=function (aggregates){
     	var value1=aggregates['sum1'];
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Total" + '</div>';
     }

    var source =
    {
        datatype: "json",
        datafields: [   
                     
         
                        {name : 'invdate', type: 'date'  },
						{name : 'invno', type: 'String'  },
						{name : 'branchname', type: 'String'  },
						{name : 'customername', type: 'String'  },
						{name : 'projectname', type: 'String'  },
						{name : 'productname', type: 'String'  },
						{name : 'lpono', type: 'String'  },
						{name : 'salesman', type: 'String'  },
						{name : 'qty', type: 'number'  },
						{name : 'pending', type: 'number'  },
						
						{name : 'price', type: 'number'  },
						{name : 'discount', type: 'number'  },
						{name : 'vatamount', type: 'number'  },
						{name : 'amount', type: 'number'  },
						{name : 'rdtype', type: 'String'  },
						{name : 'rrefno', type: 'String'  },
						{name : 'remarks', type: 'String'  },
						{name : 'area', type: 'String'  },
						{name : 'ftype', type: 'String'  },
						{name : 'sqm', type: 'String'  },
						],
				    localdata: rdatas,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    $("#reportGridDiv").on('bindingcomplete', function (event) {
    	if($( "#chkdetail:checked" ).length==0){
        	$('#reportGridDiv').jqxGrid('hidecolumn', 'sqm');
        	$('#reportGridDiv').jqxGrid('hidecolumn', 'qty');
        	$('#reportGridDiv').jqxGrid('hidecolumn', 'pending');
        	$('#reportGridDiv').jqxGrid('hidecolumn', 'productname');
        	if($('#cmbtype').val()!='ctinv'){
        		$('#reportGridDiv').jqxGrid('setcolumnproperty', 'branchname', 'width', '17%');
        		$('#reportGridDiv').jqxGrid('setcolumnproperty', 'customername', 'width', '17%');
        		$('#reportGridDiv').jqxGrid('setcolumnproperty', 'projectname', 'width', '16%');
        		$('#reportGridDiv').jqxGrid('setcolumnproperty', 'salesman', 'width', '17%');
        	}
    		
        }
        else{
        	$('#reportGridDiv').jqxGrid('showcolumn', 'sqm');
        	$('#reportGridDiv').jqxGrid('showcolumn', 'qty');
        	$('#reportGridDiv').jqxGrid('showcolumn', 'pending');
        	$('#reportGridDiv').jqxGrid('showcolumn', 'productname');
        }
    	if($('#cmbtype').val()=='ctinv'){
    		$('#reportGridDiv').jqxGrid('showcolumn', 'rdtype');
    		$('#reportGridDiv').jqxGrid('showcolumn', 'refno');
    		$('#reportGridDiv').jqxGrid('showcolumn', 'ftype');
    		$('#reportGridDiv').jqxGrid('showcolumn', 'area');
    		$('#reportGridDiv').jqxGrid('showcolumn', 'remarks');
    		$('#reportGridDiv').jqxGrid('showcolumn', 'discount');
    		$('#reportGridDiv').jqxGrid('showcolumn', 'vatamount');
    		if($( "#chkdetail:checked" ).length==1){
    			$('#reportGridDiv').jqxGrid('hidecolumn', 'discount');
        		$('#reportGridDiv').jqxGrid('hidecolumn', 'vatamount');
    		}
    	}
    });
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
	            }		
    );
    
    $("#reportGridDiv").jqxGrid(
    {
        width: '99%',
        height: 545,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,
        columnsresize: true,
        showfilterrow:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        sortable:true,
        theme: 'energyblue',
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '2.5%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
          
                     { text: 'Date',datafield: 'invdate', width: '5.5%',cellsformat:'dd.MM.yyyy' },
         			 { text: 'Doc No', datafield: 'invno', width: '4%'},
         			 { text: 'Branch Name', datafield: 'branchname', width: '13%' },
					 { text: 'Customer Name', datafield: 'customername', width: '13%' },
				     { text: ' Project Name', datafield: 'projectname', width: '12%' },
				     { text: ' Product Name', datafield: 'productname', width: '12%',hidden:true },
				     { text: 'Salesman Name', datafield: 'salesman', width:'10%'},
				     { text: 'Type', datafield: 'rdtype', width: '4%',hidden: true },
					 { text: 'Ref No', datafield: 'rrefno', width: '4%',hidden: true },
					 { text: 'Invoice Type', datafield: 'ftype', width: '6.5%',hidden: true },
					 { text: 'LPO No', datafield: 'lpono', width: '5%' },
					 
					 { text: 'Amount', datafield: 'price', width: '7%' ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
				     { text: ' Qty', datafield: 'qty', width: '6%',hidden: true },
				     { text: ' Pending', datafield: 'pending', width: '6%',hidden: true },
				     { text: ' SQM', datafield: 'sqm', width: '6%',hidden: true },
					 { text: 'Discount', datafield: 'discount', width: '5%' ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true  },
					 { text: 'VAT Amount', datafield: 'vatamount', width: '6%' ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true },
					 { text: 'Net Invoice', datafield: 'amount', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
					 
					 { text: ' Area', datafield: 'area', width: '8%',hidden: true },
					 { text: ' Remarks', datafield: 'remarks', width: '12%',hidden: true },
					 
				]
   
    });
    $("#overlay, #PleaseWait").hide();
    
    var rows=$("#reportGridDiv").jqxGrid("getrows");
    var rowcount=rows.length;
    if(rowcount==0){
    	$("#reportGridDiv").jqxGrid("addrow", null, {});	
    }
    
});


</script>
<div id="reportGridDiv"></div>