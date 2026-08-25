
 
 <%@page import="com.dashboard.purchases.purchaserequestfollowup.ClsPurchaseRequestFollowupDAO"%>
 <% ClsPurchaseRequestFollowupDAO searchDAO = new ClsPurchaseRequestFollowupDAO(); 
 
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  
  	String reqdocno = request.getParameter("reqdocno")==null?"NA":request.getParameter("reqdocno").trim();
  	
  	String statusselect = request.getParameter("statusselect")==null?"0":request.getParameter("statusselect").trim();
  	
 
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
var datas;

 if(temp4!='NA')
{ 
  datasex='<%=searchDAO.listsearchex(barchval,fromdate,todate,statusselect,reqdocno)%>';  
  datas='<%=searchDAO.listsearch(barchval,fromdate,todate,statusselect,reqdocno)%>'; 
		 
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
				 
						{name : 'desc1', type: 'String'  }, 
						{name : 'brhid', type: 'String'  }, 
						{name : 'fdate', type: 'date'  }, 
					 
						
						
						 
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
        height: 220,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
      
        columnsresize: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                 	 { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '5%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                     },	
                     { text: ' No',datafield: 'doc_no', width: '5%',hidden:true },
                     { text: 'Doc No',datafield: 'voc_no', width: '10%' },
         			 { text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
         			 { text: 'Ref No',datafield: 'refno', width: '20%' },
         			  
                     { text: 'Description', datafield: 'desc1'   },
                	 { text: 'Follow up Date', datafield: 'fdate', width: '15%',cellsformat:'dd.MM.yyyy'},
                	 
           	        
					
					]
   
    });
    
    
    $('#orderlistgrid').on('rowdoubleclick', function (event) {
        var rowindex1 = event.args.rowindex;
 
        disitems(1);
    	var docno=$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
    	
    	
    	document.getElementById("brhid").value=$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "brhid");;
    	
	    document.getElementById("masterdocno").value=docno;
	    
	   
	    
	    $("#overlay, #PleaseWait").show(); 
	    
	  
	    
		 $('#cmbinfo').attr("disabled",false);
		 
		 
		 
 	    $("#listdiv1").load("subGrid.jsp?docno="+docno);
 	   $("#detaildiv").load("detailgrid.jsp?rdoc="+docno);
 	   
 	   
 	   
 	   
 	    
 	    
 	   
    }); 
    
    
    $("#overlay, #PleaseWait").hide();
    
   
});


</script>
<div id="orderlistgrid"></div>