  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.InventoryTransfer.goodsissuenotereturn.ClsGoodsissuenotereturnDAO"%>
<% ClsGoodsissuenotereturnDAO searchDAO = new ClsGoodsissuenotereturnDAO(); %> 


<%
String refmasterdoc_no=request.getParameter("refmasterdoc_no")==null?"0":request.getParameter("refmasterdoc_no").trim();
String reftype=request.getParameter("reftype")==null?"0":request.getParameter("reftype").trim();
String locid=request.getParameter("locid")==null?"0":request.getParameter("locid").trim();

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
       
       
       var locid='<%=locid%>';
       
       
       var dtype='<%=reftype%>';
       var prddata;
      
    	   
    	   prddata= '<%=searchDAO.searchProduct(session,locid,refmasterdoc_no,reftype,productname,brandname,id,gridunit,gridprdname,gridcategory,gridssubcategory)%>';
    	 
  
             
       
       
			
			 
			 
			 
			 
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
                            
                            {name : 'cost_price', type: 'number'  },
                            
                            {name : 'savecost_price', type: 'number'  },
                            {name : 'stockid', type: 'number'  },
                         /*    
                             {name : 'unitprice', type: 'number'  },
                            {name : 'discount', type: 'number'  }, */
                /*             {name : 'totprqty', type: 'number'  }, */
                
                  			 {name : 'rdocno', type: 'number'  },
                            {name : 'detdocno', type: 'number'  },
                            
                            
                            
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
                       
                              { text: 'DOC NO', datafield: 'doc_no', width: '20%' ,hidden:true  },
                              { text: 'Product', datafield: 'part_no', width: '20%' },
                              { text: 'Product Name', datafield: 'productname' }, 
                              { text: 'Unit', datafield: 'unit', width: '10%' },
                              { text: 'Method', datafield: 'method', width: '10%' ,hidden:true},
                              { text: 'Unitdoc', datafield: 'unitdocno', width: '10%' ,hidden:true},
                              { text: 'psrno', datafield: 'psrno', width: '10%' ,hidden:true},
                              
                              { text: 'rowno', datafield: 'rowno', width: '10%',hidden:true  },
                              
                              
                              { text: 'Unit Price', datafield: 'unitprice', width: '10%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2' ,hidden:true },
                              
                              { text: 'Quantity', datafield: 'qty', width: '10%' ,cellsformat:'d2' ,hidden:true},
                              {text: 'qutval', datafield: 'qutval', width: '10%' , cellsformat:'d2' ,hidden:true },
  							  { text: 'pqty', datafield: 'pqty', width: '9%' ,  cellsformat:'d2'  ,hidden:true },
  							  {text: 'saveqty', datafield: 'saveqty', width: '10%', cellsformat:'d2' ,hidden:true },
  							  
  								{text: 'cost_price', datafield: 'cost_price', width: '10%', cellsformat:'d2' ,hidden:true },
  							
  								{text: 'savecost_price', datafield: 'savecost_price', width: '10%', cellsformat:'d2' ,hidden:true },
  							
  								{text: 'stockid', datafield: 'stockid', width: '10%'   ,hidden:true    },
  							
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
                
                
                
                if(dtype=='GIS')
                    
            	   {   
	               	 
            	 
            	 var doc_no=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
            	 var rdocno=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "rdocno");
	               	 
               	 /* 	
                   var doc_no=rows[0].doc_no;
                 var rdocno=rows[0].rdocno;
                 
                 
                  */
                 
    
              	  
            		var rows1 = $("#serviecGrid").jqxGrid('getrows');
          	     var aa=0;
          	    for(var i=0;i<rows1.length;i++){
          	   
          		   if(parseInt(rows1[i].rdocno)==parseInt(rdocno))
          			   {
          		   if(parseInt(rows1[i].prodoc)==parseInt(doc_no))
      			   { 
          		     
          			 var munit=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitdocno");
          			   
            		  // var munit=rows[0].unitdocno;
      				 if((parseInt(document.getElementById("multimethod").value)==1))
          				{	
      					   
  	        			   if(parseInt(rows1[i].unitdocno)==parseInt(munit))
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
   
                
                if(dtype!='GIS')
                    
           	   {  
              	   
              	        var prodocs=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
              	        
              	        
    	
     	                
              	        
 		                	   var rows = $("#serviecGrid").jqxGrid('getrows');
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
        	   }	
                     	 
                     	
           	  
                     
                     
                     
                    /*  else
                     	{
                     	
                     	

 			               var stockid=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "stockid");
 			   
 			            	  
 			          		var rows = $("#serviecGrid").jqxGrid('getrows');
 			        	    var aa=0;
 			        	    for(var i=0;i<rows.length;i++){
 			        	 
 			        	    	
 			        	    	 
 			        		   if(parseInt(rows[i].stkid)==parseInt(stockid))
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
 			       
                     	
                     	}
                     
                      */
                     
                     
                     
      
 
         
                	 
                	   $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));       
                        
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "brandname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "brandname"));  
                       
                  	 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "specid"));
                       
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "productname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unit"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitdocno"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "psrno"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "qty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "qty"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "qutval" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "qutval"));
                       
                       
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "stkid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "stockid"));
                       
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "detdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "detdocno"));
                 	  $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "rdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "rdocno"));
                         
                       
                       
                    //   $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "savecost_price" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "savecost_price"));
                       
                       
                    //   $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "cost_price" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "cost_price"));
                       
                       
         	    	 
                 
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
    
    