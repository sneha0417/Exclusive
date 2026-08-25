 <%@page import="com.dashboard.purchase.ClspurchaseReportsnewDAO"%>
 <% ClspurchaseReportsnewDAO searchDAO = new ClspurchaseReportsnewDAO(); 
 
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  
  	String acno = request.getParameter("acno")==null?"NA":request.getParameter("acno").trim();
  	
  	String statusselect = request.getParameter("statusselect")==null?"0":request.getParameter("statusselect").trim();
 %> 
       
   <style type="text/css">
  .advanceClass
  {
      color: #FF0000;
  }
  .yellowClass
        {
        
       
       background-color: #ffc0cb; 
        
        }
</style>
 
<script type="text/javascript">   
 var temp4='<%=barchval%>';
var datas;

 if(temp4!='NA') 
{ 
	
	 
	 datass='<%=searchDAO.purchaselistdetsearchExcel(barchval,fromdate,todate,statusselect,acno)%>'; 
	 datas='<%=searchDAO.purchaselistdetsearch(barchval,fromdate,todate,statusselect,acno)%>'; 
		// alert(enqdata); --%>
} 
else
{ 
	
	datas;
	
	}  

$(document).ready(function () {
	chkfoc();chkbatch();chkexpdate();
	  var rendererstring1=function (aggregates){
         	var value=aggregates['sum1'];
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
         }    
      
   var rendererstring=function (aggregates){
   	var value=aggregates['sum'];
   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
   }
      
    var source =
    {
        datatype: "json",
        datafields: [   
                        {name : 'voc_no', type: 'int'  },
						{name : 'date', type: 'date'  },
						{name : 'qty', type: 'number'  },
						{name : 'productid', type: 'String'  },
						{name : 'productname', type: 'String'  },
						{name : 'category', type: 'String'  },
						
						{name : 'unit', type: 'String'  },
						{name : 'refno', type: 'String'  },
						{name : 'dtype', type: 'String'  },
						{name : 'foc', type: 'number'  },
						{name : 'out_qty', type: 'number'  },
						{name : 'balqty', type: 'number'  },
						{name : 'amount', type: 'number'  },
						{name : 'total', type: 'number'  },
						{name : 'disper', type: 'number'  },
						{name : 'discount', type: 'number'  },
						{name : 'nettotal', type: 'number'  },
						{name : 'account', type: 'String'  },      
						{name : 'acname', type: 'String'  }, 
						{name : 'clstatus', type: 'Int'  }, 
						{name : 'taxper', type: 'number'  }, 
						{name : 'taxamount', type: 'number'  }, 
						{name : 'nettaxamount', type: 'number'  }, 
						{name : 'cancelamt', type: 'number'  },
						
						//{name : 'totaltax', type:'number'},
						//{name : 'sgst', type:'number'},
						//{name : 'cgst', type:'number'},
						{name : 'brand', type: 'String'  },
						{name : 'expdate', type: 'date'  },
						{name : 'batch', type: 'String'  },
						],
				    localdata: datas,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname =  function (row, column, value, data) {


   	  var ss= $('#orderlistgrid').jqxGrid('getcellvalue', row, "clstatus");
   		          if(parseInt(ss)>0)
   		  		{
   		  		
   		  		return "yellowClass";
   		  	
   		  		}
   	    
   	    	/* return "greyClass";
   	    	
   		        var element = $(defaultHtml);
   		        element.css({ 'background-color': '#F3F297', 'width': '100%', 'height': '100%', 'margin': '0px' });
   		        return element[0].outerHTML;
   	*/

   		}

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#orderlistgrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        showfilterrow: true,
        filterable: true,
        sortable:true,
        columnsresize:true,
        showaggregates:true,
        showstatusbar:true,
        
        statusbarheight: 21,
        
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,cellclassname: cellclassname,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
          
                   /// doc_no, voc_no, date, type, expdeldt, qty, brand, model, color  
                     { text: 'Doc No',datafield: 'voc_no', width: '5%' ,cellclassname: cellclassname},
         			 { text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
         			 { text: 'Ref No',datafield: 'refno', width: '7%',cellclassname: cellclassname },
         			 { text: 'Type',datafield: 'dtype', width: '10%',cellclassname: cellclassname },
         		     { text: 'Account No', datafield: 'account',  width: '7%' ,cellclassname: cellclassname },
                     { text: 'Account Name', datafield: 'acname',  width: '20%' ,cellclassname: cellclassname },
           	         { text: 'Product Id', datafield: 'productid',  width: '10%',cellclassname: cellclassname }, 
           	         { text: 'Product Name', datafield: 'productname',  width: '20%',cellclassname: cellclassname },
           	         { text: 'Brand Name', datafield: 'brand',  width: '10%' ,cellclassname: cellclassname },
           	      { text: 'Category', datafield: 'category',  width: '20%' ,cellclassname: cellclassname },
           	         
           	         { text: 'Batch No', datafield: 'batch',  width: '6%' ,cellclassname: cellclassname },
           	         { text: 'Exp Date', datafield: 'expdate',  width: '7%' ,cellsformat:'dd.MM.yyyy',cellclassname: cellclassname },
           	         { text: 'Unit', datafield: 'unit',  width: '5%' ,cellclassname: cellclassname},
           	         { text: ' Qty', datafield: 'qty',  width: '6%' ,cellsformat:'d2',cellclassname: cellclassname,cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
           	         { text: ' FOC', datafield: 'foc',  width: '6%' ,cellsformat:'d2',cellclassname: cellclassname,cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
           	        
				    // { text: 'CGST', datafield: 'cgst'   ,cellclassname: cellclassname ,  width: '6%',cellsformat: 'd2',cellsalign:'right',align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring},
				   //  { text: 'IGST', datafield: 'igst'   ,cellclassname: cellclassname,  width: '6%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
				     { text: 'Discount %', datafield: 'disper',  width: '7%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
		           	 { text: 'Discount Amount', datafield: 'discount',  width: '9%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
		            
		           	 
		           	 
           	      /*          	         { text: 'Out Qty', datafield: 'out_qty',  width: '6%' ,cellsformat:'d2',cellclassname: cellclassname},
		           	 { text: 'Balance Qty', datafield: 'balqty',  width: '6%' ,cellsformat:'d2',cellclassname: cellclassname}, */
		           	 { text: 'Unit Price', datafield: 'amount',  width: '7%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
		           	 { text: 'Total', datafield: 'total',  width: '7%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
		             { text: 'Net Total', datafield: 'nettotal',  width: '7%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
		             
		             { text: 'TAX', datafield: 'taxamount'   ,cellclassname: cellclassname ,  width: '6%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
		             
		             
		             /* { text: 'Tax %', datafield: 'taxper',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',cellclassname: cellclassname},
		             
		             
		             { text: 'Tax Amount', datafield: 'taxamount',  width: '7%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
		            */  { text: ' Total Amount', datafield: 'nettaxamount',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
					/*  { text: ' Cancel Amount', datafield: 'cancelamt',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname}, */
 					]
   
    });
    $("#overlay, #PleaseWait").hide();
    function chkfoc()
    {
     
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
    if (x.readyState==4 && x.status==200)
     {
       var items= x.responseText.trim();
      
       if(parseInt(items)>0)
        {
      
        
        $('#orderlistgrid').jqxGrid('showcolumn', 'foc');
     
        
        
         }
           else
       {
       
            $('#orderlistgrid').jqxGrid('hidecolumn', 'foc');
       
       }
       
        }}
    x.open("GET","checkfoc.jsp?",true);
  x.send();
    }
    function chkbatch()
    {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
    if (x.readyState==4 && x.status==200)
     {
       var items= x.responseText.trim();
      
       if(parseInt(items)>0)
        {
      
        
        $('#orderlistgrid').jqxGrid('showcolumn', 'batch');
     
        
        
         }
           else
       {
       
            $('#orderlistgrid').jqxGrid('hidecolumn', 'batch');
       
       }
       
        }}
    x.open("GET","checkbatch.jsp?",true);
  x.send();
    } 
    function chkexpdate()
    {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
    if (x.readyState==4 && x.status==200)
     {
       var items= x.responseText.trim();
      
       if(parseInt(items)>0)
        {
        $('#orderlistgrid').jqxGrid('showcolumn', 'expdate');
         }
           else
       {
            $('#orderlistgrid').jqxGrid('hidecolumn', 'expdate');  
       }
        }}
    x.open("GET","checkexpdate.jsp?",true);
  x.send();
    }  
});


</script>
<div id="orderlistgrid"></div>