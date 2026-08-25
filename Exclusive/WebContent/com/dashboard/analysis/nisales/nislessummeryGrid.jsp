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
	String summery = request.getParameter("summery")==null?"0":request.getParameter("summery").trim();
	
	

	
 %> 
       
 

<script type="text/javascript">
var temp4='<%=barchval%>';
var rdatas;
var putdatasex;
if(temp4!='NA')
{ 
	
	  rdatas='<%=ReportsDAO.nipurchasesummeryReports(barchval,fromdate,todate,type,status,cldocno,psrno,pdocno,salid,summery)%>';
	   
		 
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
                    

                       {name : 'refno', type: 'String'  },
			
						{name : 'refname', type: 'String'  },
						
						{name : 'nettotal', type: 'number'  },
						
						
				 
						  
						 
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
       height: 550,
       source: dataAdapter,
       showaggregates:true,
       showstatusbar:true,
       statusbarheight: 25,

       filtermode:'excel',
       filterable: true,
       selectionmode: 'singlerow',
       pagermode: 'default',
       sortable:true,
       columns: [   
                 { text: 'SL#', sortable: false, filterable: false, editable: false,
                     groupable: false, draggable: false, resizable: false,
                     datafield: 'sl', columntype: 'number', width: '10%',
                     cellsrenderer: function (row, column, value) {
                         return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                     }  
                   },	
         
                  
                     { text: 'Ref No',datafield: 'refno', width: '20%' },
        			 
        			 { text: ' Ref Name', datafield: 'refname', width: '40%' },

					 { text: 'Total', datafield: 'nettotal', width: '30%' ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					 
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