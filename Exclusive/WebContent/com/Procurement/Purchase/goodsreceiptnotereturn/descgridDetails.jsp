  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


<%
String nipurdoc=request.getParameter("nipurdoc")==null?"0":request.getParameter("nipurdoc").trim();

%>
<script type="text/javascript">
var descdata1;

var temp='<%=nipurdoc%>';

if(temp>0)
{
 
	descdata1;
}

else
 
{   
	descdata1;

 } 


        $(document).ready(function () { 	
        
        	  var rendererstring1=function (aggregates){
               	var value=aggregates['sum1'];
               	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
               }    
            
         var rendererstring=function (aggregates){
         	var value=aggregates['sum'];
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
         }
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [  
     						
                      		{name : 'productid', type: 'string'    },
                    		{name : 'productname', type: 'string'    },
                    		{name : 'unit', type: 'number'    },
     						{name : 'qty', type: 'int'    },
     				 
     						{name : 'srno', type: 'int'  }
     						
     						
                 ],
              
                 localdata: descdata1,
                
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

            
            
            $("#serviecGrid").jqxGrid(
            {
                width: '100%',
                height: 302,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                disabled:true,
                statusbarheight: 25,
                selectionmode: 'singlecell',
                pagermode: 'default',
                
                //Add row method
         //Add row method
                handlekeyboardnavigation: function (event) {
                 var rows = $('#serviecGrid').jqxGrid('getrows');
                  var rowlength= rows.length;
                    var cell = $('#serviecGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'unitprice' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key ==9) {                                                        
                            var commit = $("#serviecGrid").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    }
                    },
                
                
                columns: [
                
							   { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
				
							{ text: 'Product', datafield: 'productid', width: '12%', },
							{ text: 'ProductName', datafield: 'productname', width: '50%' ,cellsalign: 'left', align:'left'},
							{ text: 'Unit', datafield: 'unit', width: '20%' },
							{ text: 'Quantity', datafield: 'qty', width: '13%' ,cellsalign: 'left', align:'left'},
							 
						
							
	              ]
            });
           if(temp==0)
        	   {
            $("#serviecGrid").jqxGrid('addrow', null, {});
         
        	   }
           
           
           if(($('#mode').val()=='A')||($('#mode').val()=='E'))
   		       {
   		  $("#serviecGrid").jqxGrid({ disabled: false}); 
   		        }
           
           
        
            
          
        });
    </script>
<div id="serviecGrid"></div>

