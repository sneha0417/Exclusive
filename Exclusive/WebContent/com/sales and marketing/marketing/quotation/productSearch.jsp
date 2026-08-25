<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.sales.marketing.salesquotation.ClsSalesQuotationDAO"%>
<%ClsSalesQuotationDAO DAO= new ClsSalesQuotationDAO(); %> 
<%
String prodsearchtype=request.getParameter("prodsearchtype")==null?"0":request.getParameter("prodsearchtype").trim();
String rrefno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();
String reftypes=request.getParameter("reftypes")==null?"0":request.getParameter("reftypes").trim();
String mode=request.getParameter("mode")==null?"0":request.getParameter("mode").trim();

String cmbbilltype=request.getParameter("cmbbilltype")==null?"0":request.getParameter("cmbbilltype").trim();

String clientcaid=request.getParameter("clientcaid")==null?"0":request.getParameter("clientcaid").trim();

String dates=request.getParameter("dates")==null?"0":request.getParameter("dates").trim();

%>
  
  
  
       <script type="text/javascript">
       var reftypes='<%=reftypes%>';
       
       var modes='<%=mode%>'
       
			 var prodsearchdata= '<%=DAO.searchProduct(session,prodsearchtype,rrefno,reftypes,clientcaid,dates,cmbbilltype)%>';
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
                            {name : 'qty', type: 'number'  },
                            {name : 'outqty', type: 'number'  },
                            {name : 'balqty', type: 'number'  },
                            {name : 'totqty', type: 'number'  },
                            
							 {name : 'unitprice', type: 'string'  },
                            
                            {name : 'total', type: 'string'  },
                            {name : 'discper', type: 'string'  },
                            {name : 'dis', type: 'string'  },
                            {name : 'netotal', type: 'string'  },
                            {name : 'brandname', type: 'string'  },
                            {name : 'allowdiscount', type: 'number'  }, 
                            
                            {name : 'taxper', type: 'number'  },
                            
                            {name : 'discountset', type: 'number'  },
                        	{name : 'taxdocno', type: 'string'    }, 
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
                height: 530,
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
                              { text: 'Product', datafield: 'part_no', width: '28%' },
                              { text: 'Product Name', datafield: 'productname'  },
                              { text: 'Unit', datafield: 'unit', width: '10%' },
                              { text: 'Method', datafield: 'method', width: '10%',hidden:true },
                              { text: 'Unitdoc', datafield: 'unitdocno', width: '10%' ,hidden:true},
                              { text: 'psrno', datafield: 'psrno', width: '10%' ,hidden:true},
                              { text: 'specid', datafield: 'specid', width: '10%' ,hidden:true},
                              { text: 'Quantity', datafield: 'qty', width: '10%',hidden:true },
                              { text: 'outqty', datafield: 'outqty', width: '10%',hidden:true },
                              { text: 'balqty', datafield: 'balqty', width: '10%',hidden:true },
                              { text: 'totqty', datafield: 'totqty', width: '10%',hidden:true },
             
                              { text: 'unitprice', datafield: 'unitprice', width: '10%'  ,hidden:true},
          
          					{ text: 'Total', datafield: 'total', width: '10%' ,hidden:true },                
							{ text: 'Discount%', datafield: 'discper', width: '5%'		,hidden:true	},
							{ text: 'Discount', datafield: 'dis', width: '10%'	,hidden:true	},
							{ text: 'Net Total', datafield: 'netotal', width: '10%',hidden:true },
                              
							  { text: 'brandname', datafield: 'brandname', width: '10%',hidden:true },
						
							 
	                            { text: 'allowdiscount', datafield: 'allowdiscount', width: '10%' ,hidden:true },
	                            { text: 'taxper', datafield: 'taxper', width: '10%',hidden:true}, 
							    { text: 'discountset', datafield: 'discountset', width: '10%' ,hidden:true}, 
								  { text: 'taxdocno', datafield: 'taxdocno', width: '10%', hidden:true}, 
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
        	
        	   $('#jqxQuotation').jqxGrid('render');
        	  var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
            	
                var rowindex2 = event.args.rowindex;
   
                
              //  $('#datas').val("1"); 
               
              if(reftypes=="RFQ")
        		  {
        		  var prdid=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
           	   
           	   var unitprice=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice");
           	   
           	   var disper=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "discper");
			 
			          		var rows = $("#jqxQuotation").jqxGrid('getrows');
			        	    var aa=0;
			        	    for(var i=0;i<rows.length;i++){
			        	 
			            	
			        	    	 
			        		   if(parseInt(rows[i].prodoc)==parseInt(prdid))
			        			   {
			         
			        			   if(parseFloat(rows[i].unitprice)==parseFloat(unitprice))
			        			   {
			        				   
			        				      				   
			        				   
			        				   if(parseFloat(rows[i].discper)==parseFloat(disper))
				        			   {
			        					   var munit=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitdocno");
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
              else
            	  {
              
              
               var prodocs=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
               
       
            	  
          		var rows = $("#jqxQuotation").jqxGrid('getrows');
        	    var aa=0;
        	    for(var i=0;i<rows.length;i++){
        	 
        	    	
        	   
        	    	 
        		   if(parseInt(rows[i].prodoc)==parseInt(prodocs))
        			   {
        			   var munit=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitdocno");
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
              
            	  
              $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "allowdiscount" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "allowdiscount"));
              $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "taxper" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "taxper"));   
              
              $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "taxdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "taxdocno"));
              
              $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "proid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "proname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));       
               
              $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "brandname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "brandname"));
              
              $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "productid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "productname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));
               $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "prodoc" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
              $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unit"));
              $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitdocno"));
              $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "psrno"));
              $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "qty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "qty"));
              $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "outqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "outqty"));
              $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "balqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "balqty"));
              $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "totqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "totqty"));
              $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "specid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "specid"));
              
              $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "unitprice" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice"));
        	  $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "total" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "total"));
              
              $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "netotal" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "netotal"));
              
              document.getElementById("datas2").value="0";
           
        	  if(parseInt($('#prosearch').jqxGrid('getcellvalue', rowindex2, "discountset"))>0)
        		  {
        		
        		   var dscper=document.getElementById("dscper").value;
        		   
        		     
        		   
        		 	if(dscper>0)
		      		{
        		 
        		 	var allowdiscount=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "allowdiscount");
		      		var  discallowper=parseFloat(allowdiscount)*(parseFloat(dscper)/100);  
		      	 
		           document.getElementById("datas2").value="1";
		            $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "disper1" ,discallowper);
	        		  $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "discper" ,discallowper);
	        		  
	        		  
	        		  
	        		  
	        		  if(reftypes=="CEQ")
		          	    {
	        			  if(discallowper>0)
                 			{  
   	        		 var total=$('#jqxQuotation').jqxGrid('getcellvalue', rowindex1, "total");
   	        		 
   	        		 
   	        	
   	        		 var discount=(parseFloat(total)*(parseFloat(discallowper.toFixed(2))/100));
   	        		 
   	        	 
   	        		 var  netotal=parseFloat(total)-parseFloat(discount);
   	        		     
   	        		     $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "dis" ,discount);
   	        		     $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "netotal" ,netotal);
   	        		     
                 			}
   	        		     
		            	}
	        		  
		      		}
        		 	else
        		 		{
        		 		 
        		 		
        		 		  document.getElementById("datas2").value="1";
        		 		  $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "disper1" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "allowdiscount"));
                		  $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "discper" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "allowdiscount"));
                		  
                		  
                		   if(reftypes=="CEQ")
   		          	    {
                				
             	              
                        	 
 	              		var allowdiscount=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "allowdiscount");
 	              		if(allowdiscount>0)
               			{
 	              		 var total=$('#jqxQuotation').jqxGrid('getcellvalue', rowindex1, "total");
 	              		 
    	        		 var discount=(parseFloat(total)*(parseFloat(allowdiscount.toFixed(2))/100));
    	        		 var  netotal=parseFloat(total)-parseFloat(discount);
    	        		     
    	        		     $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "dis" ,discount);
    	        		     $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "netotal" ,netotal);
               			}
   		          	    }
        		 		}
        		  
        		  
        		  }
        

		      
		     	      
        	 
		     	 
        	  document.getElementById("datas2").value="0";
              
              
              
          	  if(reftypes=="RFQ")
        		  
        		  
    		  {  
    		//  total discper dis netotal
    		
    		
    		
               $('#datas1').val(0);
               
               if(modes=="E")
            	   {
            	   
            	     var qty1= $('#jqxQuotation').jqxGrid('getcellvalue', rowindex2, "qty");	
   	               	 var outqty1= $('#jqxQuotation').jqxGrid('getcellvalue', rowindex2, "outqty"); 
 	            	 var totout=parseFloat(qty1)+parseFloat(outqty1);
 	            		$('#jqxQuotation').jqxGrid('setcellvalue', rowindex2, "outqty",totout);
            	   
            	   }
               
 
                $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "unitprice" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice"));
        	  $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "total" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "total"));
        	  $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "discper" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "discper"));
        	  $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "dis" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "dis"));
        	  $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "netotal" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "netotal"));
        	  
        	  $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "unitprice1" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice"));
        	  $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "disper1" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "discper"));
        	  

        	  
        	  $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "chksearchset" ,1);
        	  $('#datas1').val(1);
    		    }  
    	  
              
              var rows = $('#jqxQuotation').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1 == rowlength - 1)
                	{  
                $("#jqxQuotation").jqxGrid('addrow', null, {});
                	} 
                	  
                $("#jqxQuotation").jqxGrid('ensurerowvisible', rowlength);
              $('#sidesearchwndow').jqxWindow('close'); 
            }); 
           
            
       
        });
		
    </script>
    <div id="prosearch"></div>
    
    