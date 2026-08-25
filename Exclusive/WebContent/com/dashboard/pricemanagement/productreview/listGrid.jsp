
 
 <%@page import="com.dashboard.pricemanagement.pricemanagementreview.ClsPriceManagementReviewDAO"%>
 <% ClsPriceManagementReviewDAO searchDAO = new ClsPriceManagementReviewDAO(); 
 
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
	
	 datas='<%=searchDAO.listgridsearch(barchval,fromdate,todate,statusselect)%>'; 
		// alert(enqdata); --%>
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
        datafields: [   //  tr_no voc_no  accname
                     
 
                        {name : 'voc_no', type: 'String'  },
						 
						{name : 'accname', type: 'String'  }, 
						{name : 'doc_no', type: 'String'  },
						
						  
				 
			 
						
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
    
    
   
   
    
    $("#sidelistgrid").jqxGrid(
    {
        width: '90%',
        height: 300,
        source: dataAdapter,
        rowsheight:20,
         selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [   
                
         
                     { text: 'Doc No',datafield: 'voc_no', width: '20%' },
         			 
                     { text: 'Account Name', datafield: 'accname',  width: '80%'  },
                     { text: 'doc_no', datafield: 'doc_no',  width: '80%' ,hidden:true },
           	  
					
					]
   
    });
    
    $("#overlay, #PleaseWait").hide();
    $('#sidelistgrid').on('rowdoubleclick', function (event) {
        
    	var rowindex2 = event.args.rowindex;
    	
    	
    	 var barchval = document.getElementById("cmbbranch").value;
         var fromdate= $("#fromdate").val();
    	 var todate= $("#todate").val();
    	 var statusselect=$("#statusselect").val();
    	 var doc_no=$('#sidelistgrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
    	 
    	   $("#overlay, #PleaseWait").show();
    	  $("#mainlistdiv").load("mainlistGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&statusselect="+statusselect+"&doc_no="+doc_no);
    	
    	 	
    	 	  
    	     });
    
    
 
    
   
});


</script>
<div id="sidelistgrid"></div>