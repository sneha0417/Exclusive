<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.sales.InventoryTransfer.physicalstockadjustment.ClsphysicalStockadjustmentDAO"%>
<%ClsphysicalStockadjustmentDAO DAO= new ClsphysicalStockadjustmentDAO();%>
<%
String prodsearchtype=request.getParameter("prodsearchtype")==null?"0":request.getParameter("prodsearchtype").trim();
String rrefno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();

String location=request.getParameter("location")==null?"0":request.getParameter("location").trim();
String branch=request.getParameter("branch")==null?"0":request.getParameter("branch").trim();






%>
 
       <script type="text/javascript">
  
			 var prodsearchdata= '<%=DAO.searchProduct(session,location,branch)%>';
		$(document).ready(function () { 	
        	/* var url=""; */

            var source =
            {
                datatype: "json",
                datafields: [ 
                            
                            {name : 'part_no', type: 'string'  },
                            {name : 'productname', type: 'string'  },
                            {name : 'doc_no', type: 'string'  },
                            {name : 'unit', type: 'string'  },
                            {name : 'unitdocno', type: 'string'  },
                            {name : 'psrno', type: 'string'  },
                            {name : 'specid', type: 'string'  },
                            {name : 'method', type: 'string'  },
                            {name : 'stk_qty', type: 'number'  },
                            {name : 'outqty', type: 'number'  },
                            {name : 'balqty', type: 'number'  },
                            {name : 'totqty', type: 'number'  },
                            {name : 'stkid', type: 'number'  },
                            {name : 'unitprice', type: 'number'  },
                            
                            {name : 'brandname', type: 'string'  },
                            
                            {name : 'rsv_qty', type: 'string'  },
                            
                            {name : 'cost_price', type: 'number'  },
                            
                            
                            
                            
                       //     munit
     						
                        ],
         
                		//  url: url1,
                 localdata: prodsearchdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
           
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#prosearch").jqxGrid(
            {
                width: '100%',
                height: 560,
                source: dataAdapter,
                columnsresize: true,
                filterable: true, 
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [
							
                          { text: '', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,cellsalign: 'center', align:'center',
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
                       
                              { text: 'DOC NO', datafield: 'doc_no', width: '20%'},
                              { text: 'Product', datafield: 'part_no', width: '28%' },
                              { text: 'Product Name', datafield: 'productname', width: '55%' },
                              { text: 'Unit', datafield: 'unit', width: '10%' },
                              { text: 'Unit Price', datafield: 'unitprice', width: '15%',hidden:true },
                              { text: 'Method', datafield: 'method', width: '10%',hidden:true },
                              { text: 'Unitdoc', datafield: 'unitdocno', width: '10%' ,hidden:true},
                              { text: 'psrno', datafield: 'psrno', width: '10%' ,hidden:true},
                              { text: 'specid', datafield: 'specid', width: '10%' ,hidden:true},
                              { text: 'Quantity', datafield: 'stk_qty', width: '10%' ,hidden:true  },
                              { text: 'outqty', datafield: 'outqty', width: '10%',hidden:true },
                              { text: 'balqty', datafield: 'balqty', width: '10%',hidden:true },
                              { text: 'totqty', datafield: 'totqty', width: '10%',hidden:true },
                              { text: 'stockid', datafield: 'stkid', width: '10%',hidden:true },
             
                              { text: 'brandname', datafield: 'brandname', width: '10%',hidden:true },
                              { text: 'rsv_qty', datafield: 'rsv_qty', width: '10%' ,hidden:true  },
                              
                              { text: 'Unit cost_price', datafield: 'cost_price', width: '15%',hidden:true   },
                              
                              
                              
						
	             
						]
            })
             
            
        /*     $('#prosearch').on('cellclick', function (event) {
            	
            	 var rowindex2 = event.args.rowindex;
            	 
            	 alert(rowindex2);
            	
            });  */
            
            
            $('#prosearch').on('rowclick', function (event) {
             document.getElementById("datas").value="1";
                
                
               
            }); 
          $('#prosearch').on('rowdoubleclick', function (event) {
        	
        	   $('#jqxstkAdjustment').jqxGrid('render');
        	  var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
            	
                var rowindex2 = event.args.rowindex;
   
                
               // $('#datas').val("1"); 
                
            	    var rsv_qty=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "rsv_qty");
            
       		 if(parseFloat(rsv_qty)>0)
   			   {
       			document.getElementById("errormsg").innerText="Not able to process";
     		   
     		   return 0; 
   			   }
   		   
       	  else
		   {
		   document.getElementById("errormsg").innerText="";
		   }
 
               
               var prodocs=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
               
            /*   if(parseInt($('#prosearch').jqxGrid('getcellvalue', rowindex2, "method"))==0)
            	  { */
            	  
          		var rows = $("#jqxstkAdjustment").jqxGrid('getrows');
        	    var aa=0;
        	    
        	    
        	    
        	    
        	    
        	    for(var i=0;i<rows.length;i++){
        	 
        	     
        	    	
        	    	 
        		   if(parseInt(rows[i].prodoc)==parseInt(prodocs))
        			   {
        			   aa=1;
        			   break;
        			   }
        		   else{
        			   
        			   aa=0;
        		       } 

        	 
        	   
        	                         }
        	   
        	    
       
        	   
        	   if(parseInt(aa)==1)
        		   {
        		   
        			document.getElementById("errormsg").innerText="You have already select this product";
        		   
        		   return 0;
        		   
        		   }
        	   else
        		   {
        		   document.getElementById("errormsg").innerText="";
        		   }
        	   
        	 
        	   
          	  
          	 /*  } */
            	 
       	     
            	
              $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "proid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "proname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));       
               
              $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "brandname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "brandname")); 
              
              $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "productid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "productname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));
              $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "prodoc" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
              $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unit"));
              $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitdocno"));
              $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "psrno"));
              $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "stk_qty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "stk_qty"));
              $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "outqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "outqty"));
              $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "balqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "balqty"));
              $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "totqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "totqty"));
        	  $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "specid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "specid"));
        	  $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "stkid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "stkid"));
        	  $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "unitprice" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice"));
        	  /* $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "cost_price" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "cost_price")); */
        	  
         	  $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "cost_price1" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "cost_price"));
        	  
        	   $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "valorderqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "stk_qty"));
 
                
    	          
     	        if($('#mode').val()=="E"){
            		
            		 
            	 
            		} 
     	          
        	   
        	   
              var rows = $('#jqxstkAdjustment').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1 == rowlength - 1)
                	{  
                $("#jqxstkAdjustment").jqxGrid('addrow', null, {});
                	} 
                	  
                $("#jqxstkAdjustment").jqxGrid('ensurerowvisible', rowlength);
              $('#sidesearchwndow').jqxWindow('close'); 
            }); 
           
            
       
        });
		
    </script>
    <div id="prosearch"></div>
    
    