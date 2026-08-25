  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.procurement.purchase.purchaseorder.ClspurchaseorderDAO"%>
<% ClspurchaseorderDAO purchaseorderDAO = new ClspurchaseorderDAO(); %>  

<%
String reqmasterdocno=request.getParameter("reqmasterdocno")==null?"0":request.getParameter("reqmasterdocno").trim();
String dtype=request.getParameter("dtype")==null?"0":request.getParameter("dtype").trim();
String accdocno=request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();


String dates=request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
String cmbbilltype=request.getParameter("cmbbilltype")==null?"0":request.getParameter("cmbbilltype").trim();

String prodsearchtype=request.getParameter("prodsearchtype")==null?"0":request.getParameter("prodsearchtype").trim();
String rrefno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();
String reftype=request.getParameter("reftype")==null?"0":request.getParameter("reftype").trim();
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
String estdate=request.getParameter("estdate")==null?"0":request.getParameter("estdate").trim();
String id = request.getParameter("id")==null?"0":request.getParameter("id");
String productname = request.getParameter("productsname")==null?"0":request.getParameter("productsname");
String brandname = request.getParameter("brandsname")==null?"0":request.getParameter("brandsname");
String gridunit = request.getParameter("gridunit")==null?"0":request.getParameter("gridunit");
String gridprdname = request.getParameter("gridprdname")==null?"0":request.getParameter("gridprdname");
String scope = request.getParameter("scopeid")==null?"0":request.getParameter("scopeid");
String scopeproduct = request.getParameter("scopeproduct")==null?"0":request.getParameter("scopeproduct");
String gridcategory = request.getParameter("gridcategory")==null?"0":request.getParameter("gridcategory");
String gridssubcategory = request.getParameter("gridssubcategory")==null?"0":request.getParameter("gridssubcategory");
 

%>

       <script type="text/javascript">
       
       
       var dtype='<%=dtype%>';
       var prddata;
       if(dtype=='PR' || dtype=='SOR' || dtype=='RFQ')
       
    	   {
    	   
    	   prddata='<%=purchaseorderDAO.searchreqProduct(reqmasterdocno,session,dtype,accdocno,cmbbilltype,dates,cldocno,estdate,productname,brandname,id,gridunit,gridprdname,scope,gridcategory,gridssubcategory)%>';   
    	   
    	   }
       else
    	   {
    	   
    	   prddata='<%=purchaseorderDAO.searchProduct(session,accdocno,cmbbilltype,dates,cldocno,estdate,productname,brandname,id,gridunit,gridprdname,scope,gridcategory,gridssubcategory)%>';
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
                            
                            {name : 'unitprice', type: 'string'  },
                            {name : 'discper', type: 'string'  },
                            {name : 'discount', type: 'string'  },
                            {name : 'nettotal', type: 'string'  },
                            {name : 'total', type: 'string'  },
                            {name : 'brandname', type: 'string'  },
                       
                        	{name : 'taxper', type: 'string'    },
                        	
                        	{name : 'taxdocno', type: 'string'    },
                        	
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
                              { text: 'Method', datafield: 'method', width: '10%' ,hidden:true},
                              { text: 'Unitdoc', datafield: 'munit', width: '10%' ,hidden:true},
                              { text: 'psrno', datafield: 'psrno', width: '10%' ,hidden:true},
                              
                              
                              
                              { text: 'Quantity', datafield: 'qty', width: '10%' ,cellsformat:'d2' ,hidden:true},
                              {text: 'qutval', datafield: 'qutval', width: '10%' , cellsformat:'d2' ,hidden:true},
  							{ text: 'pqty', datafield: 'pqty', width: '9%' ,  cellsformat:'d2' ,hidden:true },
  							{text: 'saveqty', datafield: 'saveqty', width: '10%', cellsformat:'d2'  ,hidden:true},
                             
  							{text: 'specid', datafield: 'specid', width: '10%' ,hidden:true  },
  							
  							
  							{text: 'unitprice', datafield: 'unitprice', width: '10%'   ,hidden:true },    
  							{text: 'discper', datafield: 'discper', width: '10%' ,hidden:true },
  							{text: 'discount', datafield: 'discount', width: '10%'  ,hidden:true },
  							{text: 'nettotal', datafield: 'nettotal', width: '10%' ,hidden:true  },
  							
  							{text: 'total', datafield: 'total', width: '10%'  ,hidden:true },
  							{ text: 'brandname', datafield: 'brandname', width: '10%',hidden:true },
  							 { text: 'taxper', datafield: 'taxper', width: '10%', hidden:true}, 
  							  { text: 'taxdocno', datafield: 'taxdocno', width: '10%', hidden:true}, 
   							
  	/* 						
  						     
                            {name : 'unitprice', type: 'string'  },
                             {name : 'discper', type: 'string'  },
                             {name : 'discount', type: 'string'  },
                            {name : 'nettotal', type: 'string'  },
                            {name : 'total', type: 'string'  },
  							 */
                             
	             
						]
            })
             
            
        /*      $('#prosearch').on('cellclick', function (event) {
            	
            	 var rowindex2 = event.args.rowindex;
            	 
            	 alert(rowindex2);
            	
            });  */
            
            
            $('#prosearch').on('rowclick', function (event) {
             document.getElementById("datas").value="1";
                
                
               
            }); 
          $('#prosearch').on('rowclick', function (event) {
        	 
        	   $('#serviecGrid').jqxGrid('render');
        	  var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
            	
                var rowindex2 = event.args.rowindex;
   
                
               // $('#datas').val("1"); 
               
               
               
               
                 if(dtype=='SOR' || dtype=='RFQ' )
        		  {
        		  var prdid=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
           	   
           	   var unitprice=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice");
           	   
           	   var disper=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "discper");
			 
			          		var rows = $("#serviecGrid").jqxGrid('getrows');
			        	    var aa=0;
			        	    for(var i=0;i<rows.length;i++){
					        	 
			        	    	
			        	    	 
				        		   if(parseInt(rows[i].prodoc)==parseInt(prdid))
				        			   {
				         
				        			   if(parseFloat(rows[i].unitprice)==parseFloat(unitprice))
				        			   {
				        				   
				        				      				   
				        				   
				        				   if(parseFloat(rows[i].discper)==parseFloat(disper))
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
               
               else
                     {       	 
               
               
               var prodocs=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
               
              if(parseInt($('#prosearch').jqxGrid('getcellvalue', rowindex2, "method"))==0)
            	  {
            	  
          		var rows = $("#serviecGrid").jqxGrid('getrows');
        	    var aa=0;
        	    for(var i=0;i<rows.length;i++){
               	 
        	    	
       	    	 
         		   if(parseInt(rows[i].prodoc)==parseInt(prodocs))
         			   {
         			  
         			   var munit=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "munit");
         			   
         			   
       				 if(parseInt(document.getElementById("multimethod").value)==1)
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
            	
 
                 
                 if(dtype=='PR' || dtype=='SOR' || dtype=='RFQ')
                     
          	   { 
                 
                	  $('#datas1').val(0);
                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "qutval" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "qutval"));
                 
                /*  if(parseFloat($('#prosearch').jqxGrid('getcellvalue', rowindex2, "pqty"))==0)
                	 
                	 
                	 {
                	 
                     $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "saveqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "qty"));
                	 
                	 }
                 
                 else if(parseFloat($('#prosearch').jqxGrid('getcellvalue', rowindex2, "pqty"))>0)
                	 {
                	 
                	 var totsav=parseFloat($('#prosearch').jqxGrid('getcellvalue', rowindex2, "qty"))+parseFloat($('#prosearch').jqxGrid('getcellvalue', rowindex2, "pqty"));
                	 
                	 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "saveqty" ,totsav);
                	 }     */   
                 
                	 
                	 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "specid"));
                	 
                	 
                 
                     $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "saveqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "qty"));
                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "pqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "pqty"));
          
                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "taxper" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "taxper"));  
                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "taxdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "taxdocno")); 
                 
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
                 
           
                 if(dtype=='SOR' || dtype=='RFQ')
                	 
                	 {
                	// unitprice discper discount nettotal total discper discount
                	 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unitprice" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice"));
                	 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "total" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "total"));
                     $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "discper" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "discper"));
                     $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "discount" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "discount"));
                     $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "nettotal" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "nettotal"));
                    
                     
                     
                     $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "disper1" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "discper"));
                     $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unitprice1" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice"));
                	 
                	 }
                 
                 
                 
                 
                 $('#datas1').val(1);
          	   }
                 
                 
                 else
                	 {
                	 
                	 
                	   $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));       
                        
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "taxper" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "taxper"));  
                       
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "taxdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "taxdocno")); 
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "brandname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "brandname"));
                       
                  	 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "specid"));
                       
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "productname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unit"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "munit"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "psrno"));
                     //  $("#serviecGrid").jqxGrid('selectcell',rowindex1, "qty");
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
    
    