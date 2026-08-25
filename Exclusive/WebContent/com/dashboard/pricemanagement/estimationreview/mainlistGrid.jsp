
 
 
 <%@page import="com.dashboard.pricemanagement.estimationreview.ClsEstimationReviewDAO"%>
 <% ClsEstimationReviewDAO searchDAO = new ClsEstimationReviewDAO();   
 
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  
 
  	
  	String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
  	
 	String brandid = request.getParameter("brandid")==null?"0":request.getParameter("brandid").trim();
 	String catid = request.getParameter("catid")==null?"0":request.getParameter("catid").trim();
 	String subcatid = request.getParameter("subcatid")==null?"0":request.getParameter("subcatid").trim();
 	String psrno = request.getParameter("psrno")==null?"0":request.getParameter("psrno").trim();
 	
 	String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
  	
 	
 	 
 	String hidbrandid = request.getParameter("hidbrandid")==null?"0":request.getParameter("hidbrandid").trim();
 	String hidtypeid = request.getParameter("hidtypeid")==null?"0":request.getParameter("hidtypeid").trim();
 	String hideptid = request.getParameter("hideptid")==null?"0":request.getParameter("hideptid").trim();
 	String hidcatid = request.getParameter("hidcatid")==null?"0":request.getParameter("hidcatid").trim();
 	String hidsubcatid = request.getParameter("hidsubcatid")==null?"0":request.getParameter("hidsubcatid").trim();
  	    
 	String hidproductid = request.getParameter("hidproductid")==null?"0":request.getParameter("hidproductid").trim();
 	
 	String optype = request.getParameter("optype")==null?"0":request.getParameter("optype").trim();
 	
 	
 	
 %> 
  <style type="text/css">
    .redClass
    {
 /*    background-color: #ffe4e1;   */
         background-color: #f0ffff;  
        
        	
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
    .whiteClass
    {
        background-color: #fff;
    }
    
    
    
    
    
              
</style>       
<script type="text/javascript">
 var temp4='<%=barchval%>';
var datas1;
var dat1;

 if(temp4!='NA')
{ 
	 
	 
	 dat1='<%=searchDAO.mainlistgridsearchExcel(barchval,fromdate,todate,type,brandid,catid,subcatid,psrno,load,hidbrandid,hidtypeid,hideptid,hidcatid,hidsubcatid,hidproductid,optype)%>'; 
	 datas1='<%=searchDAO.mainlistgridsearch(barchval,fromdate,todate,type,brandid,catid,subcatid,psrno,load,hidbrandid,hidtypeid,hideptid,hidcatid,hidsubcatid,hidproductid,optype)%>'; 
		// alert(enqdata); --%>
	 
} 
else
{ 
	
	datas1;
	
	}  

$(document).ready(function () {
	  var rendererstring1=function (aggregates){
         	var value=aggregates['sum1'];
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
         }    
      
   var rendererstring=function (aggregates){
   	var value=aggregates['sum'];
   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
   }
   var cellclassname = function (row, column, value, data) {
		if (data.curmaxdiscount>0) {
			 
        return "redClass";
    }
		else{
			  return "whiteClass";	 
		}
		 
		
		};  
    var source =
    {
        datatype: "json",
        datafields: [   


                        {name : 'psrno', type: 'String'  },
                        {name : 'part_no', type: 'String'  },
						{name : 'productname', type: 'String'  },
						{name : 'unit', type: 'String'  },
						{name : 'qty', type: 'number'  },
						{name : 'costprice', type: 'number'  },
						{name : 'stkqty', type: 'number'  },
						{name : 'totalvalue', type: 'number'  },
						{name : 'avgcost', type: 'number'  },
						
						 {name : 'brandname', type: 'String'  },
						 {name : 'brandid', type: 'String'  },
					 
							{name : 'variation', type: 'number'  },
							
							 {name : 'std_cost', type: 'number'  },
							 
							 {name : 'sal_margin', type: 'number'  },
							 {name : 'sellingprice', type: 'number'  },
							 {name : 'psellingprice', type: 'number'  },
							 {name : 'variation1', type: 'number'  },
							 {name : 'fixing', type: 'number'  },
							
							 {name : 'profitper1', type: 'String'  },
							 {name : 'maxdiscount', type: 'number'  },
							 {name : 'branddoc', type: 'string'  },
							 {name : 'cellselects', type: 'int'  },
							 
							 {name : 'labourcharge', type: 'number'  },
							 
							 
							 {name : 'curmaxdiscount', type: 'number'  },
							 
							 
							 
							 
						
						],
				    localdata: datas1,
        
        
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
    
    
   
   
    
    $("#mainlistgrid").jqxGrid(
    {
        width: '100%',
        height: 350,
        source: dataAdapter,
        
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        editable:true,
    /*     showaggregates:true,
        showstatusbar:true,
        
        statusbarheight: 21, */
        columnsresize: true,
        selectionmode: 'singlecell',
        pagermode: 'default',
         
        columns: [   	
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, pinned: true, resizable: false,cellclassname: cellclassname,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
                   
                                 
                     { text: 'psrno', datafield: 'psrno',  width: '10%' ,hidden:true,cellclassname: cellclassname},
                     { text: 'Product Id', datafield: 'part_no',pinned: true,  width: '10%' ,editable: false,cellclassname: cellclassname },
                     { text: 'Product Name', datafield: 'productname', pinned: true ,editable: false,cellclassname: cellclassname }, 
           	/*    		 { text: 'Type', datafield: 'brandname', width: '15%' ,hidden:true,editable: false}, */
           	         { text: 'Unit', datafield: 'unit',  width: '4%',editable: false/* ,cellclassname: cellclassname */ },
           	         { text: 'Qty', datafield: 'qty',  width: '4%' ,cellsformat:'d2',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,editable: false/* ,cellclassname: cellclassname */},
           	   	     { text: 'Cost Per Unit', datafield: 'costprice',  width: '6%' ,cellsformat:'d2' ,cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,editable: false/* ,cellclassname: cellclassname */},
           	         { text: 'Stock Qty', datafield: 'stkqty',  width: '5%' ,cellsformat:'d2',editable: false/* ,cellclassname: cellclassname */},
		           /* 	 { text: 'Total Value', datafield: 'totalvalue',  width: '8%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellsalign: 'right', align:'right',editable: false,cellclassname: cellclassname,hidden:true }, */
		           	 { text: 'Avg Purchase Cost', datafield: 'avgcost',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,editable: false/* ,cellclassname: cellclassname */},
 
           	         { text: 'Std_Cost', datafield: 'std_cost',  width: '8%'  ,editable:true,cellsformat:'d2' ,cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring/* ,cellclassname: cellclassname  */},
           	  		
         	  		 
         	  		 { text: 'Present Selling Price', datafield: 'psellingprice',  width: '8%' ,cellsformat:'d2' ,cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,editable: false/* ,cellclassname: cellclassname */}, 
         	  		 { text: 'Sales Margin', datafield: 'sal_margin',  width: '6%' ,cellsformat:'d2'  ,editable: true ,cellsalign: 'right', align:'right'}, 
         	  		 { text: 'Final Price', datafield: 'fixing',  width: '8%',cellsformat:'d2', editable: false  ,cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring/* ,cellclassname: cellclassname */ },  	 
         	  		 { text: 'Labour Charge', datafield: 'labourcharge',  width: '8%',cellsformat:'d2' ,cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },  	 
         	    	 { text: 'cellselect', datafield: 'cellselects',  width: '8%' ,hidden:true,cellclassname: cellclassname  },
         	
					]
   
    }); 
 
  
     $('#mainlistgrid').on('cellclick', function (event) {
     
		var rowindex2 = event.args.rowindex;
		$("#updatdata").attr("disabled",false);
		var psrno=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "psrno");
		document.getElementById("psrno").value=psrno;
		document.getElementById("rowindexs").value=rowindex2;
		document.getElementById("std_cost").value=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "std_cost");
		document.getElementById("fixing").value=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "fixing");
		document.getElementById("labourcharge").value=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "labourcharge");
		 $("#pricelistdiv").load("pricelistgrid.jsp?psrno="+psrno);
 	  
     });  
  
    $('#mainlistgrid').on('cellvaluechanged', function (event) {
        var datafield = event.args.datafield;
    	var rowindex2 = event.args.rowindex;
    	$("#updatdata").attr("disabled",false);
    	var psrno=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "psrno");
    	document.getElementById("psrno").value=psrno;
    	document.getElementById("rowindexs").value=rowindex2;
    	document.getElementById("std_cost").value=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "std_cost");
    	document.getElementById("fixing").value=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "fixing");
    	document.getElementById("labourcharge").value=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "labourcharge");
	    	if(datafield=="std_cost" || datafield=="sal_margin")
	    		{
    	              	var std_cost =$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "std_cost");
    				 	var sal_margin=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "sal_margin");
    				 	var sellingprice=0;
		    			 if(parseFloat(sal_margin)>0)
		    				 {
		    				 
		    					  sellingprice=parseFloat(std_cost)*(1+(parseFloat(sal_margin)/100));
		    					  
		    					   
		    				 }
		    			 else
		    				 {
		    				 sellingprice=std_cost;
		    				 }
    					$('#mainlistgrid').jqxGrid('setcellvalue', rowindex2, "fixing",sellingprice);
    					document.getElementById("std_cost").value=std_cost;
    			    	document.getElementById("fixing").value=sellingprice;
    			 
	    		}
     });
    
    
   if(temp4=='NA')
    	{ 
    	  $("#mainlistgrid").jqxGrid('addrow', null, {});
    	}  
    
    $("#overlay, #PleaseWait").hide();
    
   
});


</script>
<div id="mainlistgrid"></div>