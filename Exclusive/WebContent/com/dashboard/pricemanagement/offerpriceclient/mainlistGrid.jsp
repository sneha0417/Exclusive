
 
 
 <%@page import="com.dashboard.pricemanagement.review.ClsreviewDAO"%>
 <% ClsreviewDAO searchDAO = new ClsreviewDAO(); 
 
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  
  	String load = request.getParameter("aaa")==null?"0":request.getParameter("aaa").trim();
  	
  	
  	String salescount = request.getParameter("salescount")==null?"0":request.getParameter("salescount").trim();
  	
  
  	
  	String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
  	
 	String brandid = request.getParameter("brandid")==null?"0":request.getParameter("brandid").trim();
 	String catid = request.getParameter("catid")==null?"0":request.getParameter("catid").trim();
 	String subcatid = request.getParameter("subcatid")==null?"0":request.getParameter("subcatid").trim();
 	String psrno = request.getParameter("psrno")==null?"0":request.getParameter("psrno").trim();
  	
	 
	String hidbrandid = request.getParameter("hidbrandid")==null?"0":request.getParameter("hidbrandid").trim();
	String hidtypeid = request.getParameter("hidtypeid")==null?"0":request.getParameter("hidtypeid").trim();
	String hideptid = request.getParameter("hideptid")==null?"0":request.getParameter("hideptid").trim();
	String hidcatid = request.getParameter("hidcatid")==null?"0":request.getParameter("hidcatid").trim();
	String hidsubcatid = request.getParameter("hidsubcatid")==null?"0":request.getParameter("hidsubcatid").trim();
 	    
	String hidproductid = request.getParameter("hidproductid")==null?"0":request.getParameter("hidproductid").trim();
  	 
	String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
 	 
	
	
 %> 
 <style type="text/css">
 
    .greyClass
    {
        background-color: #D8D8D8;
    }
    
    .saveClass
    {
        background-color: #f8e0f7;
    }
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

 if(temp4!='NA')
{ 
	 
	 datas1='<%=searchDAO.offerlistgridsearch(barchval,fromdate,todate,salescount,type,brandid,catid,subcatid,psrno,load,
			 hidbrandid,hidtypeid,hideptid,hidcatid,hidsubcatid,hidproductid,cldocno)%>'; 
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
  		
		  
		  if (data.savecell==1) {
	 			 
	            return "saveClass";
	        }
		  
  		if (data.cellselects==1) {
 			 
            return "greyClass";
        }
  		if (data.cellselects1==1) {
 			 
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
							 {name : 'age', type: 'number'  },
							 {name : 'cellselects', type: 'string'  },
							 
							 {name : 'clearprice', type: 'number'  },
							 
							 {name : 'cellselects1', type: 'number'  },
							 
							 {name : 'savecell', type: 'number'  },
							 
							 
						
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
        height: 540,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        editable:true,
        showaggregates:true,
        showstatusbar:true,
        columnsresize:true,
        statusbarheight: 21,
        
        selectionmode: 'checkbox',
        pagermode: 'default',
         
        columns: [   	
                   { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,cellclassname: cellclassname,
                      datafield: 'sl', columntype: 'number', width: '3%', pinned: true,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
          
                                 
                     { text: 'psrno', datafield: 'psrno', pinned: true,  width: '10%' ,hidden:true,cellclassname: cellclassname},
                     { text: 'Product Id', datafield: 'part_no', pinned: true,  width: '10%' ,editable: false,cellclassname: cellclassname},
                     { text: 'Product Name', datafield: 'productname', pinned: true,  width: '23%',editable: false ,cellclassname: cellclassname}, 
           	   		 { text: 'Brand', datafield: 'brandname', pinned: true,  width: '12%' ,editable: false,aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname},
           	         { text: 'Unit', datafield: 'unit', pinned: true,  width: '3%',editable: false ,hidden:true,cellclassname: cellclassname},
           	         { text: 'Qty', datafield: 'qty', pinned: true,  width: '3%' ,cellsformat:'d2',editable: false,hidden:true,cellclassname: cellclassname},
           	   	     { text: 'Cost Per Unit', datafield: 'costprice',  width: '7%' ,cellsformat:'d2' ,cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,editable: false,hidden:true,cellclassname: cellclassname}, 
           	         { text: 'Stock Qty', datafield: 'stkqty',  width: '5%' ,cellsformat:'d2',editable: false,cellclassname: cellclassname},
           	   	     { text: 'Total Value', datafield: 'totalvalue',  width: '6%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellsalign: 'right', align:'right',editable: false ,cellclassname: cellclassname},
		           	 { text: 'Avg Cost Price', datafield: 'avgcost',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,editable: false,cellclassname: cellclassname},
		         	 { text: 'Variation', datafield: 'variation',  width: '6%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,editable: false,hidden:true,cellclassname: cellclassname},	
		         	 { text: 'Avg Age In Days', datafield: 'age',  width: '8%',cellsformat:'d2',editable: false,cellclassname: cellclassname},
		       	 
           	         { text: 'Std_Cost', datafield: 'std_cost',  width: '7%'  ,editable:false,cellsformat:'d2' ,cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
           	         { text: 'Final Price', datafield: 'fixing',  width: '7%',cellsformat:'d2' ,cellsalign: 'right',editable:false, align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname   },
           	         { text: 'Offer Price	', datafield: 'clearprice',  width: '8%'  ,editable:true,cellsformat:'d2' ,cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: "yellowClass" },
           	         
           	  		 { text: 'Sales Margin', datafield: 'sal_margin',  width: '8%' ,cellsformat:'d2'  ,editable: false,cellclassname: cellclassname ,hidden:true}, 
         	  		 { text: 'Selling Price', datafield: 'sellingprice',  width: '8%' ,cellsformat:'d2' ,cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,editable: false,cellclassname: cellclassname,hidden:true},  
         	  		 { text: 'Present Selling Price', datafield: 'psellingprice',  width: '8%' ,cellsformat:'d2' ,cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,editable: false,cellclassname: cellclassname ,hidden:true},  
         	  		 { text: 'Variation', datafield: 'variation1',  width: '8%' ,cellsformat:'d2' ,cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,editable: false,cellclassname: cellclassname ,hidden:true}, 
         	  		  	 
         	         { text: 'Profit% On Selling Price', datafield: 'profitper1',  width: '8%',cellsformat:'d2',editable: false,cellclassname: cellclassname ,hidden:true},  	 
         	         { text: 'Max Discount', datafield: 'maxdiscount',  width: '8%',cellsformat:'d2',hidden:true,cellclassname: cellclassname ,hidden:true},  	
         	         
         	         { text: 'cellselect', datafield: 'cellselects',  width: '8%'  ,cellclassname: cellclassname ,hidden:true },  //cellclick
         	         
         	        { text: 'cellselects1', datafield: 'cellselects1',  width: '8%'  ,cellclassname: cellclassname,hidden:true  },    //load
         	        
         	       	{ text: 'saveclick', datafield: 'savecell',  width: '8%'  ,cellclassname: cellclassname ,hidden:true }, //savecell
         	 
         	        
					]
   
    }); 
    
    
    

    
    $('#mainlistgrid').on('rowselect', function (event) {
    	
     
    	
    	 var datafield = event.args.datafield;
     	var rowindex2 = event.args.rowindex;
     	
     	
     	 $('#mainlistgrid').jqxGrid('setcellvalue', rowindex2, "cellselects","1");
     	$('#fromdate1').jqxDateTimeInput({ disabled: false}); 
		 $('#todate1').jqxDateTimeInput({ disabled: false}); 
		 
		 $('#updatdata1').attr("disabled", false);
		// $('#clearprice').attr("disabled", false);
		
		  $('#plusmin').attr("disabled", false);
		  
		  $('#Calculate').attr("disabled", false);
		  $('#piceper').attr("disabled", false);
     	 
    });
    
    
 
    
     /*    $('#mainlistgrid').on('rowselect', function (event) {
     	
    	
    	  
    	  var j=0;
  		var rows = $("#mainlistgrid").jqxGrid('getrows');
          var selectedrows=$("#mainlistgrid").jqxGrid('selectedrowindexes');
          
         
  		selectedrows = selectedrows.sort(function(a,b){return a - b});
          
  		   for(var i=0 ; i < rows.length ; i++){
  		 
  				if(selectedrows[j]==i){
  					
  				 
  					 $('#mainlistgrid').jqxGrid('setcellvalue', i, "cellselects","1");
  					 j++; 
  				}
  				else
  					{
  					 $('#mainlistgrid').jqxGrid('setcellvalue', i, "cellselects","0");
  					}
  				
  		   }
  		
    	  
    	  
    	document.getElementById("psrno").value=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "psrno");
    	
    	
    	
    	 var datafield = event.args.datafield;
     	var rowindex2 = event.args.rowindex;
     	
     	var rows = $("#mainlistgrid").jqxGrid('getrows');
		 
		 
 
     	var std_cost=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "std_cost");
     	var brandid=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "branddoc");
     	var psrno=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "psrno");
     	
         var type= $('#type').val();
     	 
     	
     	document.getElementById("psrno").value=psrno;



 
     	if(std_cost=="")
     		{
     		 
     		return 0;
     		}
     		 
   
     		var x=new XMLHttpRequest();
     		x.onreadystatechange=function(){
     			if (x.readyState==4 && x.status==200)
     				{
     				 var items= x.responseText.trim();
     				 	 
     				 	var itemval=items.split("::");
  
     				 	var salesmargin=itemval[0];
     				 	
     				 	var psellingprice=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "psellingprice");
     				 	$('#mainlistgrid').jqxGrid('setcellvalue', rowindex2, "sal_margin",salesmargin);
     				 	
     				 	var sellingprice=parseFloat(std_cost)*(1+(parseFloat(salesmargin)/100));
     					$('#mainlistgrid').jqxGrid('setcellvalue', rowindex2, "sellingprice",sellingprice);
     					$('#mainlistgrid').jqxGrid('setcellvalue', rowindex2, "psellingprice",psellingprice);
     					
     					var variation1=parseFloat(sellingprice)-parseFloat(psellingprice);
     					$('#mainlistgrid').jqxGrid('setcellvalue', rowindex2, "variation1",variation1);
     					$('#mainlistgrid').jqxGrid('setcellvalue', rowindex2, "fixing",sellingprice);
     			 
     					var profitper=((parseFloat(sellingprice)-parseFloat(std_cost))/(parseFloat(sellingprice))*100);
      
     			 
     					
  						$('#mainlistgrid').jqxGrid('setcellvalue', rowindex2, "profitper1",profitper);
     				}		
     	 
     		}
     	x.open("GET","getprice.jsp?std_cost="+std_cost+'&brandid='+brandid+"&psrno="+psrno);
     		x.send();
    }); */
     
/*       $('#mainlistgrid').on('celldoubleclick', function (event) {
     
var rowindex2 = event.args.rowindex;
 
var datafield = event.args.datafield;

if(datafield=="std_cost" || datafield=="fixing" || datafield=="maxdiscount")
	{
	 
	}
else
	{

var barchval = document.getElementById("cmbbranch").value;
 
var psrno=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "psrno");


document.getElementById("name1").innerText="Product Id";
document.getElementById("name2").innerText="Product Name";
document.getElementById("name3").innerText="Type ";
document.getElementById("productid").innerText=": "+$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "part_no");
document.getElementById("productname").innerText=": "+$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "productname");
document.getElementById("productbrand").innerText=": "+$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "brandname");


 
 
document.getElementById("psrno").value=psrno;

$("#updatdata").attr("disabled",true);
 
 

  $("#overlay, #PleaseWait").show();
  $("#pricelistdiv").load("pricelistgrid.jsp?barchval="+barchval+"&psrno="+psrno);

	}
 	  
     });   */
  
/*     $('#mainlistgrid').on('cellvaluechanged', function (event) {
        var datafield = event.args.datafield;
    	var rowindex2 = event.args.rowindex;
    	
    	$("#updatdata").attr("disabled",true);
    	var std_cost=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "std_cost");
    	var brandid=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "branddoc");
    	var psrno=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "psrno");
    	
        var type= $('#type').val();
    	 
    	
    	document.getElementById("psrno").value=psrno;



    	document.getElementById("rowindexs").value=rowindex2;
    	document.getElementById("discountval").value=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "maxdiscount");
    	
    	document.getElementById("std_cost").value=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "std_cost");
    	document.getElementById("fixing").value=$('#mainlistgrid').jqxGrid('getcellvalue', rowindex2, "fixing");
    	if(datafield=="std_cost")
    		{
    		
    		var x=new XMLHttpRequest();
    		x.onreadystatechange=function(){
    			if (x.readyState==4 && x.status==200)
    				{
    				 var items= x.responseText.trim();
    				 	 
    				 	var itemval=items.split("::");
 
    				 	var salesmargin=itemval[0];
    				 	
    				 	var psellingprice=itemval[1];
    				 	$('#mainlistgrid').jqxGrid('setcellvalue', rowindex2, "sal_margin",salesmargin);
    				 	
    				 	var sellingprice=parseFloat(std_cost)*(1+(parseFloat(salesmargin)/100));
    					$('#mainlistgrid').jqxGrid('setcellvalue', rowindex2, "sellingprice",sellingprice);
    					$('#mainlistgrid').jqxGrid('setcellvalue', rowindex2, "psellingprice",psellingprice);
    					
    					var variation1=parseFloat(sellingprice)-parseFloat(psellingprice);
    					$('#mainlistgrid').jqxGrid('setcellvalue', rowindex2, "variation1",variation1);
    					$('#mainlistgrid').jqxGrid('setcellvalue', rowindex2, "fixing",sellingprice);
    			 
    					var profitper=((parseFloat(sellingprice)-parseFloat(std_cost))/(parseFloat(sellingprice))*100);
     
    			 
    					
 						$('#mainlistgrid').jqxGrid('setcellvalue', rowindex2, "profitper1",profitper);
    					
    		}
    		}
    	x.open("GET","getprice.jsp?std_cost="+std_cost+'&brandid='+brandid+"&psrno="+psrno);
    		x.send();
    		
    		
    		}
    	
 
    });
     */
 
   if(temp4=='NA')
    	{ 
    	  $("#mainlistgrid").jqxGrid('addrow', null, {});
    	}  
    
    $("#overlay, #PleaseWait").hide();
    
   
});


</script>
<div id="mainlistgrid"></div>