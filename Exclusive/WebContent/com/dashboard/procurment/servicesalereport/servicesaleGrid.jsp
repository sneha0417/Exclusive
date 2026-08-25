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
var rdatasex;
 if(temp4!='NA')
{ 
	
	  rdatas='<%=ReportsDAO.servicesaleReports(barchval,fromdate,todate,fromdocno,todocno,fromamount,toamount,accdocno)%>'; 
	  rdatasex='<%=ReportsDAO.servicesaleReportexel(barchval,fromdate,todate,fromdocno,todocno,fromamount,toamount,accdocno)%>'; 
		 
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
                     
 
                        {name : 'voc_no', type: 'String'  },
                        {name : 'reftype', type: 'String'  },
                        {name : 'refno', type: 'String'  },
                        {name : 'invno', type: 'String'  },
						{name : 'date', type: 'date'  },
                        {name: 'invdate', type: 'date'},
                        {name: 'desc1', type: 'String'},
                        {name: 'payterm', type: 'String'},
                        {name: 'delterm', type: 'String'},
                        {name: 'deldate', type: 'date'},

						{name : 'qty', type: 'number'  },
						 
						{name : 'vendaccname', type: 'String'  },
						{name : 'venacno', type: 'String'  },
						{name : 'detaccname', type: 'String'  },
						{name : 'detacno', type: 'String'  },
						
						{name : 'unitprice', type: 'number'  },
						{name : 'total', type: 'number'  },
						{name : 'discount', type: 'number'  },
						{name : 'netamount', type: 'number'  },
						{name : 'branchname', type: 'String'  },
						
				 
						  
						 
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
    
    
   
   
    
    $("#orderlist").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,

        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        columnsresize:true,
        showfilterrow:true,
        sortable:true,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
          
                    { text: 'Branch', datafield: 'branchname', width: '12%' },
                      { text: 'Doc No',datafield: 'voc_no', width: '5%' },
         			 { text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy'},
           	     
					 { text: 'Client', datafield: 'venacno', width: '6%' },
					 
					 { text: ' Name', datafield: 'vendaccname', width: '18%' },
					 
					 
					 
		              { text: 'Account', datafield: 'detacno', width: '6%' },
				     
					 { text: 'Account Name', datafield: 'detaccname',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,width: '18%'  },
					 
					 { text: 'Qty', datafield: 'qty', width: '5%' ,hidden:true   },
					 
					 { text: 'Unit Price', datafield: 'unitprice', width: '8%' ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,hidden:true },
					 { text: 'Total', datafield: 'total', width: '8%' ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true },
					 { text: 'Discount', datafield: 'discount', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true  },
				
					 { text: 'Net Amount', datafield: 'netamount', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
					 { text: 'RefType', datafield: 'reftype', width: '6%',hidden:true },
					 { text: 'RefNo', datafield: 'refno', width: '6%' },
					 { text: 'PO No', datafield: 'invno', width: '6%' },
					 {text: 'PO Date', datafield: 'invdate', width: '6%',cellsformat:'dd.MM.yyyy'},
					 {text: 'Description', datafield: 'desc1', width: '15%'},
					 {text: 'Pay Term', datafield: 'payterm', width:'15%'},
					 {text: 'Del Term', datafield: 'delterm', width:'15%'},
					 {text: 'Del date', datafield: 'deldate', width:'6%',cellsformat:'dd.MM.yyyy'},
					
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
    var rows=$("#orderlist").jqxGrid("getrows");
    var rowcount=rows.length;
    if(rowcount==0){
    	$("#orderlist").jqxGrid("addrow", null, {});	
    }
});


</script>
<div id="orderlist"></div>