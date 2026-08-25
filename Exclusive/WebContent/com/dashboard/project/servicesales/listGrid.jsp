 
 <%@page import="com.dashboard.project.servicesales.ClsServiceSalesDAO"%>
 <% ClsServiceSalesDAO ClsServiceSalesDAO = new ClsServiceSalesDAO(); 
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  
  	String acno = request.getParameter("acno")==null?"NA":request.getParameter("acno").trim();
  	
  	String statusselect = request.getParameter("statusselect")==null?"0":request.getParameter("statusselect").trim();
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
var datas;

 if(temp4!='NA')
{ 
	 datas='<%=ClsServiceSalesDAO.listsearch(barchval,fromdate,todate,acno)%>'; 
}
else
{ 
	
	datas;
	
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
      
    var source =
    {
        datatype: "json",
        datafields: [   
                     
                     {name : 'doc_no', type: 'String'  },
                     {name : 'voc_no', type: 'String'  },
						{name : 'date', type: 'date'  },
					 
						{name : 'refno', type: 'String'  },
						{name : 'client', type: 'String'  },
						{name : 'total', type: 'number'  },
						{name : 'taxvalue', type: 'number'  },
		 
						{name : 'nettotal', type: 'number'  },
						
						{name : 'lpono', type: 'String'  },
						
						
						{name : 'remarks', type: 'String'  },
						{name : 'salesman', type: 'String'  },
						
					 
						{name : 'ftype', type: 'number'  },
						{name : 'reftype', type: 'number'  },
						
						{name : 'tax', type: 'number'  },
						{name : 'brhid', type: 'number'  },
						
						
						
					
				
						
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
        width: '100%',
        height: 250,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        
        showaggregates:true,
        showstatusbar:true,
        columnsresize: true,
        statusbarheight: 21,
        
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
          
               	 
	 
                    { text: 'Doc No',datafield: 'doc_no', width: '5%',hidden:true },
                    { text: 'Doc No',datafield: 'voc_no', width: '5%' },
                     
                     { text: 'tax',datafield: 'tax', width: '5%',hidden:true  },
                     
         			 { text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy'},
         			 { text: 'Client', datafield: 'client',  width: '20%'  },
         			 { text: 'Total', datafield: 'total',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
         			 { text: 'Tax value', datafield: 'taxvalue',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		             { text: 'Net Total', datafield: 'nettotal',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		             { text: 'Lpono', datafield: 'lpono',  width: '13%' }, 
		             { text: 'Remarks', datafield: 'remarks',  width: '15%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
		             { text: 'Salesman', datafield: 'salesman',  width: '12%' }, 
		             { text: 'Invoice Type',datafield: 'ftype', width: '10%' },
         			 { text: 'Ref Type',datafield: 'reftype', width: '5%' },
         			 { text: 'Ref No',datafield: 'refno', width: '5%' },
         		     
                    
					]
   
    });
    
    $("#overlay, #PleaseWait").hide();
    
/*     var tot= $('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "total");
    var taxvalue= $('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "taxvalue"); */
  //  $("#listdiv1").load("descgridDetails.jsp?unitprice="+tot+"&total="+tot+"&nettotal="+tot+"&taxamount="+taxvalue);
    
       $('#orderlistgrid').on('rowdoubleclick', function (event) {
        var rowindex1 = event.args.rowindex;
        
      
             document.getElementById("masterdocno").value =$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
        	 document.getElementById("brhid").value =$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "brhid");
        	 var tax =$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "tax");
        	    if(parseInt(tax)>0)
        	    	{
        	    	getTaxper($('#orderlistgrid').jqxGrid('getcellText', rowindex1, "date"));
        	    	}
        	         {
        	        	   $('#taxperc').val(0);
        	        }
        	         
        	         dis(1); 
        	         setTimeout(function(){
        	        	   
        	        
			
        	         document.getElementById("setdocno").value =1;
         	 $("#nidescdetailsGrid").jqxGrid('clear');
        	  
              $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
              
              $('#nidescdetailsGrid').jqxGrid('setcellvalue', 0, "qty",1);
          	  
              $('#nidescdetailsGrid').jqxGrid('setcellvalue', 0, "unitprice",$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "total"));
              $('#nidescdetailsGrid').jqxGrid('setcellvalue', 0, "total",$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "total"));
          	 
              $('#nidescdetailsGrid').jqxGrid('setcellvalue', 0, "nettotal",$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "total"));
          	 
              var aa=$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "taxvalue");
               if(parseFloat(aa)>0) {
            	   var cc=document.getElementById("taxperc").value;
            	 
            	   $('#nidescdetailsGrid').jqxGrid('setcellvalue', 0, "taxper",cc);
                	 
            	   $('#nidescdetailsGrid').jqxGrid('setcellvalue', 0, "taxperamt",$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "taxvalue"));
                	 
            	  
              }
               $('#nidescdetailsGrid').jqxGrid('setcellvalue', 0, "taxamount",$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "nettotal"));
          	 
          	 
         	    var summaryData= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
               
               
               var summaryData11= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
               
               var summaryData1= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
              
               document.getElementById("nettotal").value =summaryData11.sum.replace(/,/g,''); ;
              document.getElementById("subtotal").value =summaryData.sum.replace(/,/g,''); ;
          	 document.getElementById("subtax").value =summaryData1.sum.replace(/,/g,''); ;
              
              document.getElementById("setdocno").value =0;
     
        	     	}, 1000);
         
         document.getElementById("maintotal").value =$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "nettotal");
    	 document.getElementById("maintax").value =$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "taxvalue");
 
    	 
    	 
    
    	 
      
    });  
 
    
   
});


</script>
<div id="orderlistgrid"></div>