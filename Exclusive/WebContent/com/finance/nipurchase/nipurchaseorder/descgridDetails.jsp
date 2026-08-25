  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.nipurchase.nipurchaseorder.ClsnipurchaseorderDAO" %>



	
<%

ClsnipurchaseorderDAO viewDAO=new ClsnipurchaseorderDAO();
%>

<%
String nipurdoc=request.getParameter("nipurdoc")==null?"0":request.getParameter("nipurdoc").trim();

%>
<script type="text/javascript">
var descdata;

var temp='<%=nipurdoc%>';

if(temp>0)
{
 
	descdata='<%=viewDAO.reloadnioreder(session,nipurdoc)%>';  

}

else
 
{   
	descdata;

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
     						
     						{name : 'description', type: 'string'    },
     						{name : 'qty', type: 'float'    },
     						{name : 'unitprice', type: 'number'    },
     						{name : 'total', type: 'number'    },
     						{name : 'discount', type: 'number'    },
     						{name : 'netamt', type: 'number'    },
     						{name : 'nettotal', type: 'number'    },
     						{name : 'nuprice', type: 'number'    },
     						{name : 'srno', type: 'int'  },
     						 {name : 'taxper', type: 'number'  },  
        					 {name : 'taxamount', type: 'number'  },
        					{name : 'taxperamt', type: 'number'  },
     						
     						
                 ],
              
                 localdata: descdata,
                
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

            
            
            $("#descdetailsGrid").jqxGrid(
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
              /*   handlekeyboardnavigation: function (event) {
                 var rows = $('#descdetailsGrid').jqxGrid('getrows');
                  var rowlength= rows.length;
                    var cell = $('#descdetailsGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'unitprice' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key ==9) {                                                        
                            var commit = $("#descdetailsGrid").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    }
                    }, */
                
                
                columns: [
                
							   { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
				
							{ text: 'Description', datafield: 'description'  },
							{ text: 'Quantity', datafield: 'qty', width: '10%' ,cellsalign: 'left', align:'left'},
							{ text: 'Unit Price', datafield: 'unitprice', width: '10%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2'},
							{ text: 'Total', datafield: 'total', width: '10%' ,editable: false,cellsalign: 'right', align:'right',cellsformat:'d2'},
		    				{ text: 'Discount', datafield: 'discount', width: '10%',cellsalign: 'right', align:'right',cellsformat:'d2' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
							{ text: 'Net Amount', datafield: 'nettotal', width: '15%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false},
							{ text: 'Tax %', datafield: 'taxper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right'  ,editable:true},
							{ text: 'Tax Amount', datafield: 'taxperamt', width: '5%', cellsformat: 'd2'  , cellsalign: 'right', align: 'right'  ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Net Total', datafield: 'taxamount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right'  ,aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
							{ text: 'nuprice', datafield: 'nuprice', width: '9%',cellsformat:'d2',hidden:true},
							{ text: 'srno', datafield: 'srno', width: '9%',hidden:true}
						
							
	              ]
            });
           if(temp==0)
        	   {
            $("#descdetailsGrid").jqxGrid('addrow', null, {});
         
        	   }
           
           
           if(($('#mode').val()=='A')||($('#mode').val()=='E'))
   		       {
   		  $("#descdetailsGrid").jqxGrid({ disabled: false}); 
   		        }
           
         
           
            function valchange(rowBoundIndex)
            {
            	
            	
            	var qty= $('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
            	var unitprice=	$('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");	
            	var total=parseFloat(qty)*parseFloat(unitprice);
           		
    		    $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
    		    
    		   var gtotal= $('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
				  
    	   		var discount=$('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "discount");	
    	        		    
    	        		
    	   		var nettotal=parseFloat(gtotal)-parseFloat(discount);
    	   		if(discount==""||discount==null||discount=="undefiend")
    	   			{
    	   		  $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",total);
    	   			}
    	   		else{
    	   			$('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",nettotal);
    	   		}
    	        		    
    	        		    var summaryData= $("#descdetailsGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
    	                    
    	                    document.getElementById("nettotal").value=summaryData.sum;
    		    
    	            var nettotalval=  $('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal");
           var nuprice=parseFloat(nettotalval)/parseFloat(qty);
                       $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "nuprice",nuprice);
            }

            $("#descdetailsGrid").on('cellvaluechanged', function (event) 
            {
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		     
            		if(datafield=="qty")
            		    {
            
            			valchange(rowBoundIndex);
            		    }
            		if(datafield=="unitprice")
        		    {
            			valchange(rowBoundIndex);
      
            			   var rows = $('#descdetailsGrid').jqxGrid('getrows');
                           var rowlength= rows.length;
                           if(rowBoundIndex == rowlength - 1)
                           	{  
                           $("#descdetailsGrid").jqxGrid('addrow', null, {});
                           	} 
                           	
            			
        		    }
            		if(datafield=="discount")
        		    {
            			valchange(rowBoundIndex);
   				
        		    }
            		
            		
          		  if(datafield=="taxper")
          		  {
          				var netotal=$('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal"); 
                  		
                  		
                
                  		  var taxper= $('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "taxper"); 
                  		  if(parseFloat(taxper)>0)
                			{ 
                  			  
                  			  
                  		  var taxempamount=parseFloat(netotal)*(parseFloat(taxper)/100);
                  		  
                  		  
                  		  $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",taxempamount);
                  		  
                  		  var taxtotalamount=parseFloat(netotal)+parseFloat(taxempamount);
                  		  
                  		  $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",taxtotalamount);
                			}
                  		  
                  		  else
                  			  {
                  			  $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",0);
                  			  $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",netotal);
                  			  }
                  		  
                  		  
          		  }
          		
          		
          		
          		
          	   	  if(datafield=="nettotal")
          		  {
          		var netotal=$('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal"); 
          		
          		
          		var taxpers=document.getElementById("taxpers").value ; 
          		if(parseFloat(taxpers)>0)
          			{
          			$('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxper",taxpers); 
      		 		 var taxper= taxpers; 
          		  
          		  var taxempamount=parseFloat(netotal)*(parseFloat(taxper)/100);
          		  
          		  
          		  $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",taxempamount);
          		  
          		  var taxtotalamount=parseFloat(netotal)+parseFloat(taxempamount);
          		  
          		  $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",taxtotalamount);
          			
          			}
          		else
          			{
          			 $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",0);
            		  $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",netotal);
          			}
          		
  
          		  
          		 
          		  }
            		 
            		});
            
          
        });
        function funinterstate()
		{
			
		   var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
			       var items= x.responseText.trim();
			       
			       var item = items.split('::');
					var itemval1  = item[0];
					var itemval2 = item[1];
			       
			    
			       if(parseInt(itemval1)>0){
			    	   $('#txtproducttype').show();
			    	   $('#billtype').show();
			    	      $('#descdetailsGrid').jqxGrid('showcolumn', 'taxper');
		            	  $('#descdetailsGrid').jqxGrid('showcolumn', 'taxamount');
		            	  $('#descdetailsGrid').jqxGrid('showcolumn', 'taxperamt');
		            	  $('#descdetailsGrid').jqxGrid('hidecolumn', 'nettotal');
		            	  if($('#mode').val()=='E')
		            		  {
		            		  
		                  	if(parseInt(itemval2)>0)
		            		{
		                  		document.getElementById("validates").value=1;
		   				 $('#txtproducttype').attr('readonly', true);
		   				 
		   				 
		   				 $('#txtproducttype').attr('disabled', false);
		            		
		            		}
		            	
		            	else
		            		{
		            		document.getElementById("validates").value=0;
		            		 $('#txtproducttype').attr('readonly', true);
			   				 
			   				 
			   				 $('#txtproducttype').attr('disabled', true);
		            		}
		            		  
		            		  }
		            	  
		            						
						
			       }
					else{
						 
						 $('#txtproducttype').hide();
				    	   $('#billtype').hide();
				    	   
				    	   
				    	   $('#descdetailsGrid').jqxGrid('hidecolumn', 'taxper');
			            	  $('#descdetailsGrid').jqxGrid('hidecolumn', 'taxamount');
			            	  $('#descdetailsGrid').jqxGrid('hidecolumn', 'taxperamt');
			            	  
			            	  $('#descdetailsGrid').jqxGrid('showcolumn', 'nettotal');
				    	   
						
					}
					}
				else{
					
				}
				}
		x.open("GET","interstate.jsp?docnos="+document.getElementById("accdocno").value,true);

		x.send();
				
		}
    </script>
<div id="descdetailsGrid"></div>

