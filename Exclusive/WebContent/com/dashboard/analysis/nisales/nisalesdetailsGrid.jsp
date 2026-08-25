 <%@page import="com.dashboard.analysis.nisales.ClsnisalesDAO" %>
 
 <%
 ClsnisalesDAO  ReportsDAO=new  ClsnisalesDAO();

 String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();

	
	String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
	
	String status = request.getParameter("status")==null?"0":request.getParameter("status").trim();
	
	
	String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
	
	String psrno = request.getParameter("psrno")==null?"0":request.getParameter("psrno").trim();
	
	
	
	String pdocno = request.getParameter("pdocno")==null?"0":request.getParameter("pdocno").trim();
	
	String salid = request.getParameter("salid")==null?"0":request.getParameter("salid").trim();

	
	

	
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
var rdatas;
var nisalesdetexc;
 if(temp4!='NA')
{ 
	
	  rdatas='<%=ReportsDAO.nipurchasedatailsReports(barchval,fromdate,todate,type,status,cldocno,psrno,pdocno,salid)%>';  
	  nisalesdetexc='<%=ReportsDAO.nipurchasedatailsReportsexcel(barchval,fromdate,todate,type,status,cldocno,psrno,pdocno,salid)%>';
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
   						{name : 'date', type: 'date'  },
                        
                        {name: 'jobname', type: 'String'},
                        {name: 'salesman', type: 'String'},
                        {name: 'client', type: 'String'},
                        {name: 'lpono', type: 'String'},

						{name : 'productcode', type: 'String'  },
						 
						{name : 'productname', type: 'String'  },
						{name : 'qty', type: 'String'  },
						{name : 'pending', type: 'String'  },
						{name : 'sqm', type: 'String'  },
						
						{name : 'price', type: 'number'  },
						
						{name : 'nettotal', type: 'number'  },
						{name : 'taxamount', type: 'number'  },
						{name : 'invvalue', type: 'number'  },
						
				 
						  
						 
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
        height: 550,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,
	columnsresize: true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        sortable:true,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
          
                   
                      { text: 'Doc No',datafield: 'doc_no', width: '5%' },
         			 { text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy'},
           	     
					 { text: 'Job Name', datafield: 'jobname', width: '15%' },
					 
					 { text: ' Salesman', datafield: 'salesman', width: '13%' },
					 
					 
					 
		              { text: 'Client', datafield: 'client', width: '12%' },
				     
					 { text: 'Lpo No', datafield: 'lpono', width: '6%' },
					 { text: 'Product Code', datafield: 'productcode', width: '10%' },
					 { text: 'Product Name', datafield: 'productname', width: '15%' },
					 { text: 'Qty', datafield: 'qty', width: '5%'    },
					 
					 
					 { text: 'Pending', datafield: 'pending', width: '8%' },
					 { text: 'SQM', datafield: 'sqm', width: '8%' },
					 { text: 'Price', datafield: 'price', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' },
					 { text: 'Total', datafield: 'nettotal', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
					 { text: 'Tax Amount', datafield: 'taxamount', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					 { text: 'Net Total', datafield: 'invvalue', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					 
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
