


 <%@page import="com.dashboard.purchases.purchasevendorquote.ClspurchasevendorquoteDAO"%>
 <% ClspurchasevendorquoteDAO searchDAO = new ClspurchasevendorquoteDAO(); 

 
           	String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
        	String fromdate = request.getParameter("fromdate")==null?"NA":request.getParameter("fromdate").trim();
        	String todate = request.getParameter("todate")==null?"NA":request.getParameter("todate").trim();
        	
        	System.out.println("----fromdate---"+fromdate);
        	System.out.println("----todate---"+todate);
        	
           	  %> 
           	  
           	  
           	   <style type="text/css">
      
        .yellowClass
        {
            color: green;
        }
       </style>
<script type="text/javascript">
	var temp1='<%=barchval%>';
	 var vehdatas;
	 var bb;
	if(temp1!='NA')
{
		vehdatas='<%=searchDAO.subgridsearch(barchval,fromdate,todate)%>'; 
		 
		 
}
	else{
		vehdatas;
		 bb=1;
	}
	
	
	
$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     	var rendererstring1=function (aggregates){
     	var value1=aggregates['sum1'];
     	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
     }
        var cellclassname = function (row, column, value, data) {
 
            if (value=='All') {
                      return "yellowClass";
                      }
                 
                  
              };
        
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	    {name : 'doc_no', type: 'string'  },
						{name : 'voc_no', type: 'string'  },
						{name : 'vendor', type: 'String'  },
						{name : 'reftype', type: 'string'  }
						
						],
				    localdata: vehdatas,
        
        
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
    
    
    $("#sidegrid").jqxGrid(
    {
        width: '100%',
        height: 220,
        source: dataAdapter,
          
        
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
              
						{ text: 'Rfq NO', datafield: 'voc_no', width: '17%'  },
						{ text: 'Vendor', datafield: 'vendor', width: '55%' },
						{ text: 'Ref NO', datafield: 'reftype', width: '28%'  },
						{ text: 'doc_no', datafield: 'doc_no', width: '28%',hidden:true  },
					
					]
    
    });

 
 
    $('#sidegrid').on('rowdoubleclick', function (event) 
    		{ 
    	
    	
    		
    		    var boundIndex = event.args.rowindex;
    		    
    	
    		   	  $("#overlay, #PleaseWait").show();
    	
      		    var docno = $('#sidegrid').jqxGrid('getcelltext',boundIndex, "doc_no");
        	 
        		   
 
        		    
        		    $("#listdiv").load("listgrid.jsp?docno="+docno);
    		    	 
        		
    		    
    		});
    
    

});

	
	
</script>
<div id="sidegrid"></div>
