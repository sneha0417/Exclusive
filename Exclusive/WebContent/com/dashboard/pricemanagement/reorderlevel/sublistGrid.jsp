 <%@page import="com.dashboard.pricemanagement.reorderlevel.ClsReorderDAO"%>
 <% ClsReorderDAO searchDAO = new ClsReorderDAO(); 


 	String psrno = request.getParameter("psrno")==null?"NA":request.getParameter("psrno").trim();
  	
  	
  	    
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
    
    
    
    
    
              
</style>       
<script type="text/javascript">
 var temp4='<%=psrno%>';
var datasub;
var dat1;

 if(temp4!='NA')
{ 
	 
	 
	 datasub='<%=searchDAO.reordersubsearch(psrno)%>';  
	  
		// alert(enqdata); --%>
	 
} 
else
{ 
	
	datasub;

	
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
		if (data.cellselects==1) {
			 
        return "redClass";
    }
		else{
			 
		}
		 
		
		};  
    var source =
    {
        datatype: "json",
        datafields: [   


               /*          {name : 'psrno', type: 'String'  },
                        {name : 'type', type: 'String'  },
                        {name : 'doc_no', type: 'number'  },
                        {name : 'reorderlevels', type: 'number'  },
						{name : 'reorderqtys', type: 'number'  },
					
						
						 */
						 
						 
						  {name : 'bdocno', type: 'int'  },
	   						{name : 'selects', type: 'bool' }, 
	   						{name : 'discontinued', type: 'bool'   },
	   						{name : 'branch', type: 'string'  },
	   						{name : 'bin', type: 'string'   },
	   						{name : 'minstock', type: 'number'   },
	   						{name : 'maxstock', type: 'number' },
	   						{name : 'retailprice', type: 'number'  },
								{name : 'wholesale', type: 'number' },
								{name : 'normal', type: 'number'  },
								
								{name : 'reorderlevel', type: 'number'  },
								{name : 'reorderqty', type: 'number'  },
								{name : 'typess', type: 'number'  }
								
							 
						
						],
				    localdata: datasub,
        
        
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
    
    
   
   
    
    $("#sublist").jqxGrid(
    {
        width: '98%',
        height: 200,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        editable:true,
       
        
        selectionmode: 'singlecell',
        pagermode: 'default',
         
        columns: [   	
                  { 	text: 'SL#', sortable: false, filterable: false, editable: false,
                      	groupable: false, draggable: false, resizable: false,cellclassname: cellclassname,
                      datafield: 'sl', columntype: 'number', width: '5%',
                      cellsrenderer: function (row, column, value) {
                         return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
                	 
                	{ text: 'typess', datafield: 'typess', width: '10%' ,hidden:true },
                    
                	{ text: 'Branch id', datafield: 'bdocno', width: '10%',hidden:true },
					{ text: 'Select', datafield: 'selects', columntype: 'checkbox',checked:false,  width: '6%',cellsalign: 'center', align: 'center' },
					{ text: 'Discontinued', datafield: 'discontinued', columntype: 'checkbox', checked:false,  width: '10%',cellsalign: 'center', align: 'center' },
					{ text: ' '+document.getElementById("cmpbranch").value, datafield: 'branch', width: '25%', editable: false },	
					{ text: 'Bin', datafield: 'bin', width: '10%' },	
					{ text: 'Min. Stock', datafield: 'minstock', width: '10%' },
					{ text: 'Max. Stock', datafield: 'maxstock', width: '10%' },
					
					{ text: 'Reorder Level', datafield: 'reorderlevel', width: '12%', cellsformat: 'd2' }, 
					{ text: 'Reorder Qty', datafield: 'reorderqty', width: '12%' , cellsformat: 'd2'},
					
					{ text: 'Retail Price', datafield: 'retailprice', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right',hidden:true },
					{ text: 'Whole Sale', datafield: 'wholesale', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right' ,hidden:true},
					{ text: 'Normal', datafield: 'normal', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right',hidden:true },
       	   		 	]
   
    }); 
  
  
   if(temp4=='NA')
    	{ 
    	  $("#sublist").jqxGrid('addrow', null, {});
    		
    	}  
    
    
    $("#overlay, #PleaseWait").hide();
    
   
});


</script>
<div id="sublist"></div>

