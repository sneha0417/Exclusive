
 
 <%@page import="com.dashboard.purchases.purchaseorderfollowup.ClsPurchaseorderFollowupDAO"%>
 <% ClsPurchaseorderFollowupDAO searchDAO = new ClsPurchaseorderFollowupDAO(); 
 
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
	 datasex='<%=searchDAO.orderlistsearchEX(barchval,fromdate,todate,statusselect,acno)%>'; 
	 datas='<%=searchDAO.orderlistsearch(barchval,fromdate,todate,statusselect,acno)%>'; 
		 
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
						{name : 'dtype', type: 'String'  },
						{name : 'account', type: 'String'  },      
						{name : 'acname', type: 'String'  }, 
						{name : 'desc1', type: 'String'  }, 
						{name : 'brhid', type: 'String'  }, 
						{name : 'fdate', type: 'date'  }, 
						
						{name : 'names', type: 'String'  },
						{name : 'nettotal', type: 'number'},
						{name : 'balamnt', type: 'number'}
						
						
						 
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
        showstatusbar:true,
        
        statusbarheight: 21,
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
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                     },	
                     { text: ' No',datafield: 'doc_no', width: '5%',hidden:true },
                     { text: 'Doc No',datafield: 'voc_no', width: '5%' },
         			 { text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy'},
         			 { text: 'Ref No',datafield: 'refno', width: '10%' },
         			 { text: 'Type',datafield: 'dtype', width: '12%' },
         		     { text: 'Account', datafield: 'account',  width: '10%'  },
                     { text: 'Account Name', datafield: 'acname',  width: '20%'  },
                     
                     { text: 'Status', datafield: 'names',  width: '11%'  },
                   
                     
                     { text: 'Description', datafield: 'desc1'   },
                	 { text: 'Follow up Date', datafield: 'fdate', width: '8%',cellsformat:'dd.MM.yyyy'},
                	 { text: 'Total', datafield: 'nettotal', width: '10%', cellsalign: 'right',align: 'right' , cellsformat:'d2',  aggregates: ['sum'],aggregatesrenderer:rendererstring},
                	 { text: 'Balance Total', datafield: 'balamnt', width: '10%' , cellsalign: 'right',align: 'right', cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
                     
           	        
					
					]
   
    });
    
    
    $('#orderlistgrid').on('rowdoubleclick', function (event) {
        var rowindex1 = event.args.rowindex;
        disitems(0);
   	    $("#updatdata").attr('disabled', false );
    	var docno=$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
    	
    	
    	document.getElementById("brhid").value=$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "brhid");;
    	
	    document.getElementById("masterdocno").value=docno;
	    $("#overlay, #PleaseWait").show(); 
	    
	  
	    
		 $('#cmbinfo').attr("disabled",false);
		 
		 
		 
 	    $("#listdiv1").load("ordersubGrid.jsp?docno="+docno);
 	   $("#detaildiv").load("detailgrid.jsp?rdoc="+docno);
 	    
 	    
 	   
    }); 
    
    
    $("#overlay, #PleaseWait").hide();
    
   
});


</script>
<div id="orderlistgrid"></div>