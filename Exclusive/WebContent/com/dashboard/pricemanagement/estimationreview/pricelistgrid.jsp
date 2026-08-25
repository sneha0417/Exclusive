 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 
 
 <%@page import="com.dashboard.pricemanagement.estimationreview.ClsEstimationReviewDAO"%>
 <% ClsEstimationReviewDAO searchDAO = new ClsEstimationReviewDAO();  
  String contextPath=request.getContextPath();%>
<% 
String psrno=request.getParameter("psrno")==null?"0":request.getParameter("psrno").toString();
%>
<script type="text/javascript">
 
 
  var psrno='<%=psrno%>';
if(psrno>0){
	var pmdata='<%=searchDAO.pricelistgridsearch(psrno)%>'; 
	 pmdata1='<%=searchDAO.pricelistgridsearchex(psrno)%>'; 
	
	
 
	 
}
else{  
	var pmdata;
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
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						 {name : 'slno', type: 'number' }, 
     						 
     						{name : 'scode', type: 'string'  },        
     						{name : 'sname', type: 'string'   },
     						{name : 'sdoc_no', type: 'string'   },
     					 
     						{name : 'stdcost', type: 'number'  },
							 
							 {name : 'salmargin', type: 'number'  },
							  
							 {name : 'psellingprices', type: 'number'  },
							  
							 {name : 'fixingprice', type: 'number'  },
                        ],
                         localdata: pmdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
           
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxpmgt").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                editable: true,
                columnsresize: true,
                selectionmode: 'singlecell',  
                
                       
                columns: [
                          { text: 'SL#',cellsalign: 'center', align:'center', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false , resizable: false,
                              datafield: 'sl', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";  
                              }  
                            },	
                           
							{ text: 'doc_no', datafield: 'sdoc_no', editable: false,  width: '18%',hidden:true },
							{ text: 'Scope Code', datafield: 'scode', width: '12%', editable: false  },
							 { text: 'Scope Name', datafield: 'sname' , editable: false  },
		           	         { text: 'Std_Cost', datafield: 'stdcost',  width: '10%'  ,editable:true,cellsformat:'d2' ,cellsalign: 'right', align:'right' },
		         	  		 { text: 'Present Selling Price', datafield: 'psellingprices',  width: '15%' ,cellsformat:'d2' ,cellsalign: 'right', align:'right', editable: false  }, 
		         	  		 { text: 'Sales Margin', datafield: 'salmargin',  width: '10%' ,cellsformat:'d2'  ,cellsalign: 'right', align:'right' ,editable: true}, 
		         	  		 { text: 'Final Price', datafield: 'fixingprice',  width: '10%',cellsformat:'d2' ,cellsalign: 'right', align:'right', editable: false },  	 
		         	       


				 
						]
            });
         
            
            $('#jqxpmgt').on('cellvaluechanged', function (event) {
                var datafield = event.args.datafield;
            	var rowindex2 = event.args.rowindex;
             
             
        	    	if(datafield=="stdcost" || datafield=="salmargin")
        	    		{
            	              	var std_cost =$('#jqxpmgt').jqxGrid('getcellvalue', rowindex2, "stdcost");
            				 	var sal_margin=$('#jqxpmgt').jqxGrid('getcellvalue', rowindex2, "salmargin");
            				 	var sellingprice=0;
            				 	
            				 	
            				 	
        		    			 if(parseFloat(sal_margin)>0)
        		    				 {
        		    				 
        		    				 
        		    					  sellingprice=parseFloat(std_cost)*(1+(parseFloat(sal_margin)/100));
        		    					  
        		    					 
        		    					  
        		    				 }
        		    			 else
        		    				 {
        		    				 sellingprice=std_cost;
        		    				 }
            					$('#jqxpmgt').jqxGrid('setcellvalue', rowindex2, "fixingprice",sellingprice);
            			 
            			 
        	    		}
             });
            
            
      
            $("#overlay, #PleaseWait").hide(); 
            
        });
</script>
<div id="jqxpmgt"></div>
 