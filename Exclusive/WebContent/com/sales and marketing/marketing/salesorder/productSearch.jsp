<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.sales.marketing.salesorder.ClsSalesOrderDAO"%>
<%ClsSalesOrderDAO DAO= new ClsSalesOrderDAO();%>
<%
String prodsearchtype=request.getParameter("prodsearchtype")==null?"0":request.getParameter("prodsearchtype").trim();
String rrefno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();
String cmbprice=request.getParameter("cmbprice")==null?"0":request.getParameter("cmbprice").trim();

String clientid=request.getParameter("clientid")==null?"0":request.getParameter("clientid").trim();
 
String reftypes=request.getParameter("reftypes")==null?"0":request.getParameter("reftypes").trim();


String clientcaid=request.getParameter("clientcaid")==null?"0":request.getParameter("clientcaid").trim();

String dates=request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
String cmbbilltype=request.getParameter("cmbbilltype")==null?"0":request.getParameter("cmbbilltype").trim();
%>
 
       <script type="text/javascript">
  var reftypes='<%=reftypes%>';
			 var prodsearchdata= '<%=DAO.searchProduct(session,prodsearchtype,rrefno,cmbprice,clientid,clientcaid,dates,cmbbilltype)%>';
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
                            {name : 'stkid', type: 'number'  },
                            
                            
                            {name : 'eidtprice', type: 'string'  },
                            {name : 'unitprice', type: 'string'  },
                            
                            {name : 'total', type: 'string'  },
                            {name : 'discper', type: 'string'  },
                            {name : 'dis', type: 'string'  },
                            {name : 'unitprice', type: 'string'  },
                            
                            {name : 'netotal', type: 'string'  },
                            
                            {name : 'brandname', type: 'string'  },
                            {name : 'allowdiscount', type: 'number'  },  
                            {name : 'taxper', type: 'number'  },
                            
                            
                            
                            {name : 'discountset', type: 'number'  },
                            
                            
                            {name : 'taxdocno', type: 'string'    },
                            
                         //  total discper dis netotal
                            
                            
                            
                        //    eidtprice unitprice
                            
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
                              { text: 'Method', datafield: 'method', width: '10%' ,hidden:true },
                              { text: 'Unitdoc', datafield: 'unitdocno', width: '10%' ,hidden:true},
                              { text: 'psrno', datafield: 'psrno', width: '10%' ,hidden:true},
                              { text: 'specid', datafield: 'specid', width: '10%' ,hidden:true},
                              { text: 'Quantity', datafield: 'qty', width: '10%',hidden:true },
                              { text: 'outqty', datafield: 'outqty', width: '10%',hidden:true },
                              { text: 'balqty', datafield: 'balqty', width: '10%',hidden:true },
                              { text: 'totqty', datafield: 'totqty', width: '10%',hidden:true },
                              { text: 'stockid', datafield: 'stkid', width: '10%',hidden:true },
                              
                              { text: 'unitprice', datafield: 'unitprice', width: '10%'  ,hidden:true},
                              { text: 'eidtprice', datafield: 'eidtprice', width: '10%' ,hidden:true },
             
						
                        
          					{ text: 'Total', datafield: 'total', width: '10%' ,hidden:true },                
							{ text: 'Discount%', datafield: 'discper', width: '5%'		,hidden:true	},
							{ text: 'Discount', datafield: 'dis', width: '10%'	,hidden:true	},
							{ text: 'Net Total', datafield: 'netotal', width: '10%',hidden:true },
                              
							  { text: 'brandname', datafield: 'brandname', width: '10%',hidden:true },
                              
							    { text: 'allowdiscount', datafield: 'allowdiscount', width: '10%' ,hidden:true},
							    { text: 'taxper', datafield: 'taxper', width: '10%',hidden:true}, 
							    { text: 'discountset', datafield: 'discountset', width: '10%',hidden:true }, 
							    
							    
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
        	
        	   $('#jqxSalesOrder').jqxGrid('render');
        	  var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
            	
                var rowindex2 = event.args.rowindex;
   
                
               // $('#datas').val("1"); 
               
          
                       	  
        	  if(reftypes=="SQOT")
        		  {
        		  var prdid=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
           	   
           	   var unitprice=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice");
           	   
           	   var disper=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "discper");
			 
			          		var rows = $("#jqxSalesOrder").jqxGrid('getrows');
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
               
        
            	  
          		var rows = $("#jqxSalesOrder").jqxGrid('getrows');
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
         	  
       	   
              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "allowdiscount" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "allowdiscount"));   
              
              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "taxper" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "taxper"));   
              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "taxdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "taxdocno"));
            	  
              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "unitprice" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice"));
              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "eidtprice" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "eidtprice"));	  
            	
              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "proid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "proname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));       
               
              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "brandname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "brandname"));   
              
 
              
              
              
              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "productid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "productname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));
               $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "prodoc" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unit"));
              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitdocno"));
              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "psrno"));
              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "qty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "qty"));
              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "outqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "outqty"));
              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "balqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "balqty"));
              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "totqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "totqty"));
        	  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "specid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "specid"));
        	  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "stkid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "stkid"));
        	  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "method" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "method"));
        	  document.getElementById("datas2").value="0";
        	  if(reftypes=="DIR")
        		  
        		  
        		  {  
        	  if(parseInt($('#prosearch').jqxGrid('getcellvalue', rowindex2, "discountset"))>0)
        		  {
        		
        		   var dscper=document.getElementById("dscper").value;
        		   
        		     
        		   
        		 	if(dscper>0)
		      		{
        		 
        		 	var allowdiscount=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "allowdiscount");
		      		var  discallowper=parseFloat(allowdiscount)*(parseFloat(dscper)/100);  
		      	 
		          document.getElementById("datas2").value="1";
		            $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "disper1" ,discallowper);
	        		  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "discper" ,discallowper);
	        		  
		      		}
        		 	else
        		 		{
        		 		 
        		 		
        		 		  document.getElementById("datas2").value="1";
        		 		  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "disper1" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "allowdiscount"));
                		  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "discper" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "allowdiscount"));
        		 		}
        		  
        		  
        		  }
        

		      
		     	      
        		  }
		     	 
        	  document.getElementById("datas2").value="0";

				     
        	  
        	  if(reftypes=="SQOT")
        		  
        		  
        		  {  
        		//  total discper dis netotal
              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "unitprice1" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice"));
        	  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "disper1" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "discper"));
                  
            	  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "total" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "total"));
            	  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "discper" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "discper"));
            	  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "dis" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "dis"));
            	  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "netotal" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "netotal"));
        		    }  
        	  
        	  
        	  
                
              var rows = $('#jqxSalesOrder').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1 == rowlength - 1)
                	{  
                $("#jqxSalesOrder").jqxGrid('addrow', null, {});
                	} 
                	  
                $("#jqxSalesOrder").jqxGrid('ensurerowvisible', rowlength);
              $('#sidesearchwndow').jqxWindow('close'); 
            }); 
           
            
       
        });
		
    </script>
    <div id="prosearch"></div>
    
    