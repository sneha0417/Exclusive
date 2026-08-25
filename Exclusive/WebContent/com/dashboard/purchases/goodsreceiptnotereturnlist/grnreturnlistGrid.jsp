
 
 <%@page import="com.dashboard.purchase.ClspurchaseReportsDAO"%>
 <% ClspurchaseReportsDAO searchDAO = new ClspurchaseReportsDAO(); 
 
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
	
	 datas='<%=searchDAO.grrlistsearch(barchval,fromdate,todate,statusselect,acno)%>'; 
		// alert(enqdata); --%>
} 
else
{ 
	
	datas;
	
	}  

$(document).ready(function () {
	
	chkfoc();
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
						{name : 'unit', type: 'String'  },
						{name : 'refno', type: 'String'  },
						
						
						{name : 'dtype', type: 'String'  },
						
				 
						
						{name : 'account', type: 'String'  },      
						{name : 'acname', type: 'String'  }, 
						
						
						{name : 'foc', type: 'number'  },
		 
						
						
				 
			 
						
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
    
    
   
   
    
    $("#grrlistgrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        
/*         showaggregates:true,
        showstatusbar:true,
        
        statusbarheight: 21,
         */
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
 
                     { text: 'Doc No',datafield: 'voc_no', width: '5%' },
         			 { text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy'},
         			 { text: 'Ref No',datafield: 'refno', width: '10%' },
         			 
         		     { text: 'Account', datafield: 'account',  width: '5%'  },
                     { text: 'Account Name', datafield: 'acname',  width: '12%'  },
           	         { text: 'Product Id', datafield: 'productid',  width: '15%' }, 
           	         { text: 'Product Name', datafield: 'productname',  width: '26%' },
           	         { text: 'Unit', datafield: 'unit',  width: '5%' },
           	         { text: 'Out Qty', datafield: 'qty',  width: '12%' ,cellsformat:'d2'},
           	        
		           	 
		       
		           	 { text: 'FOC Out Qty', datafield: 'foc',  width: '6%' ,cellsformat:'d2' ,hidden:true},
		            
		         	
 

					 
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
   
});

function chkfoc()
{
 
   var x=new XMLHttpRequest();
   x.onreadystatechange=function(){
   if (x.readyState==4 && x.status==200)
    {
      var items= x.responseText.trim();
     
      if(parseInt(items)>0)
       {
     
 
    	  $('#grrlistgrid').jqxGrid('showcolumn', 'foc');
 
    	  
    
    	  
    	  
        }
          else
      {
      
        	  $('#grrlistgrid').jqxGrid('hidecolumn', 'foc');
 
        	   
      
      }
      
       }}
   x.open("GET","checkfoc.jsp?",true);
	x.send();
 
      
        
	
}

</script>
<div id="grrlistgrid"></div>