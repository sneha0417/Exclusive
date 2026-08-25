 <%@page import="com.dashboard.pricemanagement.reorderlevel.ClsReorderDAO"%>
 <% ClsReorderDAO searchDAO = new ClsReorderDAO(); 
 
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  
 
  	
  	String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
  	
 	String brandid = request.getParameter("brandid")==null?"0":request.getParameter("brandid").trim();
 	String catid = request.getParameter("catid")==null?"0":request.getParameter("catid").trim();
 	String subcatid = request.getParameter("subcatid")==null?"0":request.getParameter("subcatid").trim();
 	String psrno = request.getParameter("psrno")==null?"0":request.getParameter("psrno").trim();
 	String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
  	
 	
 	String levelcount = request.getParameter("levelcount")==null?"0":request.getParameter("levelcount").trim();
 
  	    
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
    
    .greyClass
    {
        background-color: #f8e0f7;
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
	 
	 
	 datas1='<%=searchDAO.reordersearch(barchval,fromdate,todate,type,brandid,catid,subcatid,psrno,load,levelcount)%>';  
	 
	 dat1='<%=searchDAO.reordersearchex(barchval,fromdate,todate,type,brandid,catid,subcatid,psrno,load,levelcount)%>';  
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
		if (data.reorderlevel>0) {
			 
        return "greyClass";
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
							{name : 'type', type: 'String'  },
						
						  {name : 'brand', type: 'String'  },	 
						  
						  {name : 'reorderlevel', type: 'number'  },	
						  
						  {name : 'reorderqty', type: 'number'  },	
						  
							{name : 'purchasequantity', type: 'number'  },
							{name : 'salequantity', type: 'number'  },
							{name : 'stockquantity', type: 'number'  },
							{name : 'averagesalespermonth', type: 'number'  },
							{name : 'averagepurchasepermonth', type: 'number'  },
					
						  
						  
						
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
        width: '98%',
        height: 320,
        source: dataAdapter,
        columnsresize: true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        editable:true,
       
        
        selectionmode: 'singlerow',
        pagermode: 'default',
         
        columns: [   	
                  { text: 'SL#', sortable: false, filterable: false, pinned: true, editable: false,
                      groupable: false, draggable: false, resizable: false,cellclassname: cellclassname,
                      datafield: 'sl', columntype: 'number', width: '3%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
                   
                                 
                     { text: 'psrno', datafield: 'psrno',  width: '10%' ,hidden:true,cellclassname: cellclassname},
                     { text: 'Product Id', datafield: 'part_no',  width: '12%' , pinned: true,editable: false,cellclassname: cellclassname},
                     { text: 'Product Name', datafield: 'productname',  width: '34%', pinned: true,editable: false,cellclassname: cellclassname }, 
                     
                     { text: 'Brand Name', datafield: 'brand',  width: '13%',editable: false,cellclassname: cellclassname }, 
           	   		 { text: 'Type', datafield: 'type',  width: '5%' ,editable: false,cellclassname: cellclassname},
           	   		 
           	   	    { text: 'Purchase Qty', datafield: 'purchasequantity',  width: '7%' ,editable: false,cellsformat:'d2',cellclassname: cellclassname},
               	   	{ text: 'Sale Qty', datafield: 'salequantity',  width: '5%' ,editable: false,cellsformat:'d2',cellclassname: cellclassname},
                	  { text: 'Stock Qty', datafield: 'stockquantity',  width: '5%' ,editable: false ,cellsformat:'d2',cellclassname: cellclassname},
                	 
                	     { text: 'Avg Purchase/Month', datafield: 'averagepurchasepermonth',  width: '8%',cellsformat:'d2' ,editable: false,cellclassname: cellclassname},
                	     { text: 'Avg Sales/Month', datafield: 'averagesalespermonth',  width: '8%',cellsformat:'d2' ,editable: false,cellclassname: cellclassname},
           	   		 
            		 
           	   		 { text: 'Reorder Level', datafield: 'reorderlevel',  width: '7%' ,editable: false,cellclassname: cellclassname,cellsformat:'d2'},
           	 		 { text: 'Reoder Qty', datafield: 'reorderqty',  width: '7%' ,editable: false,cellclassname: cellclassname,cellsformat:'d2'},
           	   		 
           	   		 
           	   	  
           	     
         	
					]
   
    }); 
    
    
    
    
    $('#mainlistgrid').on('rowdoubleclick', function (event) {
    	
        var rowindex1= event.args.rowindex;
        
   var subpsrno=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex1, "psrno");
   document.getElementById("prddocno").value=subpsrno;
   
   
   var aa=$('#mainlistgrid').jqxGrid('getcellvalue',rowindex1, "type");
 
   document.getElementById("cmpbranch").value="";
if(aa=="Branch")
	{
	 document.getElementById("cmpbranch").value="Branch Name";
	}
else
	{
	 document.getElementById("cmpbranch").value="Company";
	}

	 $("#sublistdiv").load("sublistGrid.jsp?psrno="+subpsrno);
	 $("#btnupdate").attr('disabled',false);


    });
    
    
    
    
    
    
  
  
   if(temp4=='NA')
    	{ 
    	  $("#mainlistgrid").jqxGrid('addrow', null, {});
    	}  
    
    $("#overlay, #PleaseWait").hide();
    
   
});


</script>

<div id="mainlistgrid"></div>