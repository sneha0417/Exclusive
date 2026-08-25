 <%@page import="com.dashboard.procurment.servicesalereport.*" %>
 
 <%
 ClsServiceSaleReportDAO  ReportsDAO=new  ClsServiceSaleReportDAO();

 String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();

	
	String fromdocno = request.getParameter("fromdocno")==null?"0":request.getParameter("fromdocno").trim();
	
	String todocno = request.getParameter("todocno")==null?"0":request.getParameter("todocno").trim();
	
	
	String fromamount = request.getParameter("fromamount")==null?"0":request.getParameter("fromamount").trim();
	
	String toamount = request.getParameter("toamount")==null?"0":request.getParameter("toamount").trim();
	
	
	
	String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
	
	

	
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
var rdatas;
var putdatasex;
 if(temp4!='NA')
{ 
	
	  rdatas='<%=ReportsDAO.servicesaledetailReport(barchval,fromdate,todate,fromdocno,todocno,fromamount,toamount,accdocno)%>'; 
	  putdatasex='<%=ReportsDAO.servicesaledetailreportexel(barchval,fromdate,todate,fromdocno,todocno,fromamount,toamount,accdocno)%>'; 
		 
} 
else
{ 
	
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
                     
 
                        {name : 'doc_no', type: 'String'  },
                        {name : 'voc_no', type: 'String'  },
						{name : 'date', type: 'date'  },


						{name : 'qty', type: 'number'  },
						 
						{name : 'refno', type: 'String'  },
						{name : 'account', type: 'String'  },
						{name : 'accname', type: 'String'  },
						{name : 'desc1', type: 'String'  },
						
						{name : 'unitprice', type: 'number'  },
						{name : 'total', type: 'number'  },
						{name : 'discount', type: 'number'  },
						{name : 'nettotal', type: 'number'  },
						{name : 'taxper', type: 'number'  },
						{name : 'taxamount', type: 'number'  },
						{name : 'nettaxamount', type: 'number'  },
						{name : 'costtype', type: 'String'  },
						{name : 'costcode', type: 'String'  },
						{name : 'remarks', type: 'String'  },
						{name : 'accntt', type: 'String'  },
						{name : 'acc', type: 'String'  },
						{name : 'branchname', type: 'String'  },
						{name : 'atype', type: 'String'  },
						
				 
						  
						 
						],
				    localdata: rdatas,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
 

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#orderlistdetails").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,

        filtermode:'excel',
        columnsresize:true,
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        sortable:true,
        showfilterrow:true,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
          
                    { text: 'Branch', datafield: 'branchname', width: '12%' },
                      { text: 'doc No',datafield: 'doc_no', width: '5%',hidden:true },
                      { text: 'Doc No',datafield: 'voc_no', width: '5%' },
         			 { text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy'},
         			 
         			 { text: 'PO No', datafield: 'refno', width: '8%' },
         			{ text: 'Client', datafield: 'account', width: '6%' },
         			
         			 
				     	 
		             
				     
					 { text: 'Name', datafield: 'accname',aggregates: ['sum1'],aggregatesrenderer:rendererstring1 ,width:'18%'},
					 
					 { text: 'Account', datafield: 'acc', width: '6%' },
					 { text: 'Type', datafield: 'atype', width: '3%' },
					 { text: 'Account Name', datafield: 'accntt', width: '18%' },
					 { text: 'Description', datafield: 'desc1', width: '15%' },
					 { text: 'Qty', datafield: 'qty', width: '5%' ,hidden:false  },
					 
					 { text: 'Unit Price', datafield: 'unitprice', width: '8%' ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,hidden:true },
					 { text: 'Total', datafield: 'total', width: '8%' ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					 { text: 'Discount', datafield: 'discount', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
					 { text: 'Net Total', datafield: 'nettotal', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
					 { text: 'Tax Per', datafield: 'taxper', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
					 { text: 'Tax Amount', datafield: 'taxamount', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
					
					 { text: 'Net TaxTotal', datafield: 'nettaxamount', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  }, 
					 { text: 'Cost Type', datafield: 'costtype', width: '6%' },
					 {text: 'Cost Code', datafield: 'costcode', width: '6%' },
					 {text: 'Remarks', datafield: 'remarks', width: '18%' },
					 ]
   
    });
    $("#overlay, #PleaseWait").hide();
    
    var rows=$("#orderlistdetails").jqxGrid("getrows");
    var rowcount=rows.length;
    if(rowcount==0){
    	$("#orderlistdetails").jqxGrid("addrow", null, {});	
    }
});


</script>
<div id="orderlistdetails"></div>
<!-- <div id="orderlistdetails"></div> -->
