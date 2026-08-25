  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.procurement.purchase.goodsreceiptnote.ClsgoodsreceiptnoteDAO"%>
<% ClsgoodsreceiptnoteDAO searchDAO = new ClsgoodsreceiptnoteDAO(); %> 

<%
String refmasterdoc_no=request.getParameter("refmasterdoc_no")==null?"0":request.getParameter("refmasterdoc_no").trim();

String dtype=request.getParameter("dtype")==null?"0":request.getParameter("dtype").trim();



%>

       <script type="text/javascript">
       
       
       var dtype='<%=dtype%>';
       var prddata;
       if(dtype=='PO')
       
    	   {
    	   
    	   prddata = '<%=searchDAO.searchorderProduct(refmasterdoc_no,session)%>';   
    	   
    	   }
       else
    	   {
    	   
    	   prddata= '<%=searchDAO.searchProduct(session)%>';
    	   }
  
             
       
       
			
			 
			 
			 
			 
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
                            {name : 'munit', type: 'string'  },
                            {name : 'psrno', type: 'string'  },
                            {name : 'method', type: 'string'  },
                          
                            
                            
                             {name : 'qty', type: 'number'  },
                                                      
                            {name : 'qutval', type: 'number'  },
                            {name : 'pqty', type: 'number'  },
                            {name : 'saveqty', type: 'number'  },
                            {name : 'specid', type: 'string'  },
                            
                            {name : 'unitprice', type: 'number'  },
                            
                            {name : 'rowno', type: 'Int'  },
                            
                            {name : 'discount', type: 'number'  },
                            
                            {name : 'disper', type: 'number'  },
                            {name : 'brandname', type: 'string'  },
                         /*    
                            {name : 'unitprice', type: 'number'  },
                            {name : 'discount', type: 'number'  }, */
                /*             {name : 'totprqty', type: 'number'  }, */
                            
                            
                            
                       //     munit
     						
                        ],
         
                		//  url: url1,
                 localdata: prddata,
                
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
                       
                              { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Product', datafield: 'part_no', width: '15%' },
                              { text: 'Product Name', datafield: 'productname'  }, 
                              { text: 'Unit', datafield: 'unit', width: '10%' },
                              { text: 'Method', datafield: 'method', width: '10%' ,hidden:true},
                              { text: 'Unitdoc', datafield: 'munit', width: '10%' ,hidden:true},
                              { text: 'psrno', datafield: 'psrno', width: '10%' ,hidden:true},
                              
                              { text: 'rowno', datafield: 'rowno', width: '10%',hidden:true  },
                              
                              
                              { text: 'Unit Price', datafield: 'unitprice', width: '10%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2' ,hidden:true },
                              
                              { text: 'Quantity', datafield: 'qty', width: '10%' ,cellsformat:'d2' ,hidden:true},
                              {text: 'qutval', datafield: 'qutval', width: '10%' , cellsformat:'d2' ,hidden:true },
  							  { text: 'pqty', datafield: 'pqty', width: '9%' ,  cellsformat:'d2'  ,hidden:true },
  							  {text: 'saveqty', datafield: 'saveqty', width: '10%', cellsformat:'d2' ,hidden:true },
  							
  							
  			                /*  { text: 'Unitprice', datafield: 'unitprice', width: '10%' ,cellsformat:'d2' },
                             {text: 'Discount', datafield: 'discount', width: '10%' , cellsformat:'d2'  }, */
                           /*   {text: 'totprqty', datafield: 'totprqty', width: '10%' , cellsformat:'d2'  }, */
  							
                             
  							
                             
  							{text: 'specid', datafield: 'specid', width: '10%' ,hidden:true },
  							
  							{text: 'discount', datafield: 'discount', width: '10%' ,hidden:true },
  							
  							{text: 'disper', datafield: 'disper', width: '10%' ,hidden:true },
  							{text: 'brandname', datafield: 'brandname', width: '10%' ,hidden:true },
                             
  						 
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
        	
        	   $('#serviecGrid').jqxGrid('render');
        	  var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
            	
                var rowindex2 = event.args.rowindex;
   
                
               // $('#datas').val("1"); 
               
       
                   if(dtype!='PO')
                     
          	   {   
                	           if(parseInt($('#prosearch').jqxGrid('getcellvalue', rowindex2, "method"))==0)
		            	  {  
                	   
                	        var prodocs=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
                	        
                	        
      	
       	                
                	        
		                	   var rows = $("#serviecGrid").jqxGrid('getrows');
		               	    var aa=0;
		               	    for(var i=0;i<rows.length;i++){
				               	 
		               	    	
		               	    	 
			               		   if(parseInt(rows[i].prodoc)==parseInt(prodocs))
			               			   {
			               			 var munit=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "munit");
		              				 if((parseInt(document.getElementById("multimethod").value)==1))
		                  				{	
		      		        			   if(parseInt(rows[i].unitdocno)==parseInt(munit))
		      		        			   {
		      		        				   aa=1;
		      		            			   break;
		      		        			   }
		                  				}
		              				 else
		              					 {
		        					    
			               			   aa=1;
			               			   break;
		              					 }
			               			   
			               			   
			               			   
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
          	   }
          	   }
               
                   else{
				          
                	   
                	   
    /*     	              
   	                   var unitprice=rows[0].unitprice;
 	   	              
 	   	           var prdid=rows[0].prdid;
 	   	           var disper=rows[0].disper; */
                	   
                	   var prdid=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
                	   
                	   var unitprice=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice");
                	   
                	   var disper=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "disper");
				 
				          		var rows = $("#serviecGrid").jqxGrid('getrows');
				        	    var aa=0;
				        	    for(var i=0;i<rows.length;i++){
						        	 
				        	    	
				        	    	 
					        		   if(parseInt(rows[i].prodoc)==parseInt(prdid))
					        			   {
					        			  
					        			   if(parseFloat(rows[i].unitprice)==parseFloat(unitprice))
					        			   {
					        				   
					        				   if(parseFloat(rows[i].disper)==parseFloat(disper))
						        			   {
					        					   var munit=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "munit");
						              				 if((parseInt(document.getElementById("multimethod").value)==1))
						                  				{	
						      		        			   if(parseInt(rows[i].unitdocno)==parseInt(munit))
						      		        			   {
						      		        				   aa=1;
						      		            			   break;
						      		        			   }
						                  				}
						              				 else
						              					 {
						        					    	
					        					  
					        					   aa=1;
								        		   break;
						              					 }
						        			   }
					        			   }
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
				        	   
          	  
           }  
            	   
            	  
            	
 
                 
                 if(dtype=='PO')
                     
          	   { 
                 
                	  $('#datas1').val(0);
                	  
                	  
                	  
               //       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unitprice" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice"));
                	  
                      
                	  
                	  	  
                	 /*  var totaldqty=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "totprqty");
                	  var qty= $('#prosearch').jqxGrid('getcellvalue', rowindex2, "qty");
                	var unitprice=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice");
                	  	  
                	 var discount=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "discount");
                	 
                	var total=parseFloat(unitprice)*parseFloat(qty);
                	
                	
                	 
                	  $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "total" ,total);
                	  
                	  
                	 if(parseFloat(discount)>0) 
                		 {
                		 
                		var discountval=(parseFloat(discount)/parseFloat(totaldqty))*parseFloat(qty);
                		
                		 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "discount" ,discountval);
                		 
                		 var nettotal=parseFloat(total)-parseFloat(discountval);
                		 
                		 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "nettotal" ,nettotal);
                		 }
                	 
                	 else{
                		 
                		 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "discount" ,0);
                		 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "nettotal" ,total);
                	     }  
                	  	  
                	  	   */
                	  
                	  
                	  
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "qutval" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "qutval"));
                 
      
                 
                	 
                	   $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "specid"));
                	 
                	 
                 
                     $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "saveqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "qty"));
                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "pqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "pqty"));
          
                 
                 
              	$('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "qty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "qty"));
             	
                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
               $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));       
               $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "brandname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "brandname"));       
         
               
               
                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "productname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));
                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unit"));
                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "munit"));
                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "psrno"));  
                 
                 
                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unitprice" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice"));  
                 
                 
                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "discount" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "discount")); 
                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "disper" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "disper")); 
                 
                 
                 
              //   discount disper
                 
                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "refrowno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "rowno"));  
                 
                 
                 
              //   $("#serviecGrid").jqxGrid('selectcell',rowindex1, "unit");
                 
                 
                 $('#datas1').val(1);
          	   }
                 
                 
                 else
                	 {
                	 
                	 
                	   $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));       
                        
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "brandname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "brandname"));  
                       
                  	 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "specid"));
                       
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "productname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unit"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "munit"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "psrno"));
                      // $("#serviecGrid").jqxGrid('selectcell',rowindex1, "unit");
                	 }
                 
                 
                 
                 
              var rows = $('#serviecGrid').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1 == rowlength - 1)
                	{  
                $("#serviecGrid").jqxGrid('addrow', null, {});
                	} 
                	  
                $("#serviecGrid").jqxGrid('ensurerowvisible', rowlength);  
              $('#sidesearchwndow').jqxWindow('close'); 
            }); 
           
            
       
        });
		
    </script>
    <div id="prosearch"></div>
    
    