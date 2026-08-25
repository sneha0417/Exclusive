 <%@page import="com.dashboard.analysis.ginreport.ClsginreportDAO" %>
 
 <%
 ClsginreportDAO  ReportsDAO=new  ClsginreportDAO();

 String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();

	String psrno = request.getParameter("psrno")==null?"0":request.getParameter("psrno").trim();
	
	String aa = request.getParameter("aa")==null?"0":request.getParameter("aa").trim();

	
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
var rdatas;
var nisalesdetexc;
 if(temp4!='NA')
{ 
	
	  rdatas='<%=ReportsDAO.ginReports(barchval,fromdate,todate,psrno,aa)%>';  
	  <%-- nisalesdetexc='<%=ReportsDAO.nipurchasedatailsReportsexcel(barchval,fromdate,todate,type,status,cldocno,psrno,pdocno,salid)%>'; --%>
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
                     
 
                       
   						{name : 'date', type: 'date'  },
                        
                        {name: 'jobno', type: 'String'},
                        {name: 'client', type: 'String'},
                        {name: 'lpono', type: 'String'},
                        {name: 'vendor', type: 'String'},
                        {name: 'gisno', type: 'String'},
						{name : 'product', type: 'String'  },
						 
						{name : 'productname', type: 'String'  },
						
						{name : 'brand', type: 'String'  },
						{name : 'unit', type: 'String'  },
						{name : 'qty', type: 'number'  },
						{name : 'amount', type: 'number'  },
						
						
						{name : 'category', type: 'String'  },
						{name : 'subcategory', type: 'String'  },
						
						
						
				 
						  
						 
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
          
                   
                 
         			 { text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy'},
				{ text: 'GIS Number', datafield: 'gisno', width: '6%' },
         		     { text: 'Job Number/AMC',datafield: 'jobno', width: '9%' },
           	     
					{ text: 'Client', datafield: 'client', width: '15%' },
				     
					 { text: 'Lpo No', datafield: 'lpono', width: '6%' },
					 { text: 'Vendor', datafield: 'vendor', width: '15%' },
					 
					 { text: 'Product', datafield: 'product', width: '15%' },
					 { text: 'Product Name', datafield: 'productname', width: '28%' },
					 
					
					 { text: 'Brand Name', datafield: 'brand', width: '10%' },
					 
					 { text: 'Category', datafield: 'category', width: '15%' },
					 { text: 'Subcategory', datafield: 'subcategory', width: '15%' },

					 { text: 'Unit', datafield: 'unit', width: '8%' },
					 { text: 'Qty', datafield: 'qty', width: '10%'  ,cellsformat:'d2'  },
					 
					 
					 { text: 'Amount', datafield: 'amount', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
					 
					
					 
					 
					
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
