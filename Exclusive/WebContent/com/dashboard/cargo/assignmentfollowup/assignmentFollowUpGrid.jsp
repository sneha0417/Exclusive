
 
 <%@page import="com.dashboard.purchase.ClspurchaseReportsDAO"%>
 <% ClspurchaseReportsDAO searchDAO = new ClspurchaseReportsDAO(); 
 
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  
  	//String acno = request.getParameter("acno")==null?"NA":request.getParameter("acno").trim();
  	
  //	String statusselect = request.getParameter("statusselect")==null?"0":request.getParameter("statusselect").trim();
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
	
	
} 
else
{ 
	
	datas;
	
	}  

$(document).ready(function () {

    var source =
    {
        datatype: "json",
        datafields: [   
                     {name :'sertype', type:'String' },
                     {name :'cur', type:'number' },
                     {name :'rate', type:'number' },
                     {name :'price', type:'number' },
				     {name : 'qty', type: 'number'  },
					 {name :'uom', type:'String' },
					 {name :'tot', type:'number'},
					 {name :'btot', type:'number'},
					 {name :'bill', type:'String'},
					 {name :'vendor' ,type:'String'}, 	
					 
				    ],
				    localdata: datas,
        
        
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
    
    
   
   
    
    $("#orderlistgrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        
        showaggregates:true,
        showstatusbar:true,
        
        statusbarheight: 21,
        
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                 
          
                   /// doc_no, voc_no, date, type, expdeldt, qty, brand, model, color  
                     { text: 'SERVICE TYPE',datafield: 'sertype', width: '12%' },
                	 { text: 'CURRENCY', datafield: 'cur', width: '8%'},
         			 { text: 'RATE',datafield: 'rate', width: '10%'},
         			 { text: 'PRICE',datafield: 'price', width: '10%' },
         		     { text: 'QTY', datafield: 'qty',  width: '5%' },
                     { text: 'UOM', datafield: 'uom',  width: '12%' },
           	         { text: 'TOTAL', datafield: 'tot',  width: '13%' }, 
           	         { text: 'BASE TOTAL', datafield: 'btot',  width: '16%' },
           	         { text: 'BILL', datafield: 'bill',  width: '7%' },
           	         { text: 'VENDOR', datafield: 'vendor',  width: '8%' },
           	     	 ]
   
    });
    $("#overlay, #PleaseWait").hide();
    
    
   
});


</script>
<div id="orderlistgrid"></div>