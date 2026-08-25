<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.sales.Sales.branchInvoice.ClsBranchInvoiceDAO"%>
<%ClsBranchInvoiceDAO DAO= new ClsBranchInvoiceDAO();%>
<% 
String prodsearchtype=request.getParameter("prodsearchtype")==null?"0":request.getParameter("prodsearchtype").trim();
String rrefno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();
String reftype=request.getParameter("reftype")==null?"0":request.getParameter("reftype").trim();

String cmbprice=request.getParameter("cmbprice")==null?"0":request.getParameter("cmbprice").trim();

String clientid=request.getParameter("clientid")==null?"0":request.getParameter("clientid").trim();
String cmbreftype=request.getParameter("cmbreftype")==null?"0":request.getParameter("cmbreftype").trim();

String location=request.getParameter("location")==null?"0":request.getParameter("location").trim();

String clientcaid=request.getParameter("clientcaid")==null?"0":request.getParameter("clientcaid").trim();

String dates=request.getParameter("dates")==null?"0":request.getParameter("dates").trim();

String cmbbilltype=request.getParameter("cmbbilltype")==null?"0":request.getParameter("cmbbilltype").trim();




%>
 
       <script type="text/javascript">
  
			 var prodsearchdata='<%=DAO.searchProduct(session,prodsearchtype,rrefno,reftype,cmbprice,clientid,cmbreftype,location,clientcaid,dates,cmbbilltype)%>';
			 
			 
		$(document).ready(function () { 	
        	/* var url=""; */

        	
        	var reftypes='<%=cmbreftype%>';
        	
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
                            {name : 'unitprice', type: 'number'  },
                            {name : 'eidtprice', type: 'string'  },
                            {name : 'locid', type: 'string'  },
                            
                            
                            {name : 'dis', type: 'number'  },
                            {name : 'discper', type: 'number'  },
                            
                            {name : 'method', type: 'string'  },
                            
                            {name : 'brandname', type: 'string'  },
                            {name : 'allowdiscount', type: 'number'  },
                            
                            
                            {name : 'lbrchg', type: 'number'  },
                            
                            
                            {name : 'taxper', type: 'number'  },
                            
                            {name : 'discountset', type: 'number'  },
                            
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
                       
                              { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Product', datafield: 'part_no', width: '28%' },
                              { text: 'Product Name', datafield: 'productname', width: '55%' },
                              { text: 'Unit', datafield: 'unit', width: '10%'  },
                              { text: 'Unit Price', datafield: 'unitprice', width: '15%',hidden:true },
                              { text: 'Method', datafield: 'method', width: '10%',hidden:true },
                              { text: 'Unitdoc', datafield: 'unitdocno', width: '10%' ,hidden:true},
                              { text: 'psrno', datafield: 'psrno', width: '10%' ,hidden:true},
                              { text: 'specid', datafield: 'specid', width: '10%' ,hidden:true},
                              { text: 'Quantity', datafield: 'qty', width: '10%',hidden:true },
                              { text: 'outqty', datafield: 'outqty', width: '10%',hidden:true },
                              { text: 'balqty', datafield: 'balqty', width: '10%',hidden:true },
                              { text: 'totqty', datafield: 'totqty', width: '10%',hidden:true },
                              { text: 'stockid', datafield: 'stkid', width: '10%',hidden:true },
             
  
                              { text: 'eidtprice', datafield: 'eidtprice', width: '10%' , hidden:true },
                              { text: 'locid', datafield: 'locid', width: '10%' ,hidden:true  },
                              { text: 'dis', datafield: 'dis', width: '10%' , hidden:true },           
                              { text: 'discper', datafield: 'discper', width: '10%' , hidden:true },
                              
                              { text: 'brandname', datafield: 'brandname', width: '10%'  ,hidden:true  },
                              { text: 'allowdiscount', datafield: 'allowdiscount', width: '10%',hidden:true},
                              
                              { text: 'lbrchg', datafield: 'lbrchg', width: '10%',hidden:true},
                              
                              { text: 'taxper', datafield: 'taxper', width: '10%',hidden:true},
                              
                              { text: 'discountset', datafield: 'discountset', width: '10%' ,hidden:true }, 
                              
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
        	
        	   $('#jqxInvoiceGrid').jqxGrid('render');
        	  var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
            	
                var rowindex2 = event.args.rowindex;
   
                
               // $('#datas').val("1"); 
               
               
               var prodocs=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
               
         /*      if(parseInt($('#prosearch').jqxGrid('getcellvalue', rowindex2, "method"))==0)
            	  {
            	   */
            	   
            	   if(reftypes=='DIR' || reftypes=='SOR'|| reftypes=='JOR')
            		   {
                	   
                 		var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');
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
            	   
            	   if(reftypes=='DEL')
        		   {
          		var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');
        	    var aa=0;
        	    for(var i=0;i<rows.length;i++){
        	 
        	    	 var prodocs1=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
        	    	 var locid=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "locid");
        	    	 
        	    	 
        		   if(parseInt(rows[i].prodoc)==parseInt(prodocs1))
        			   {
        			   
        				   if(parseInt(rows[i].locid)==parseInt(locid))
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
            	  
            	   
            	   
             $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "taxper" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "taxper"));   
            	   
            	   
            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "lbrchg" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "lbrchg"));   
            	   
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "allowdiscount" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "allowdiscount"));   
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "unitprice" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "eidtprice" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "eidtprice"));	   
            	
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));       
               
 
              
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "brandname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "brandname"));
              
              
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "locid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "locid")); 
               
              
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "productname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));
               $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unit"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitdocno"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "psrno"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "qty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "qty"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "oldqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "qty"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "outqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "outqty"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "balqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "balqty"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "totqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "totqty"));
        	  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "specid"));
        	  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "stkid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "stkid"));
        	  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "unitprice" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice"));
        	  
        	 
        	  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "dis" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "dis"));
        	  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "discper" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "discper"));
        	  
        	  
        	  
        	  document.getElementById("datas2").value="0";
        	  if(reftypes=="DIR" || reftypes=="JOR" || reftypes=="DEL")
        		  
        		  
    		  { 
        	  if(parseInt($('#prosearch').jqxGrid('getcellvalue', rowindex2, "discountset"))>0)
        		  {
        		
        		   var dscper=document.getElementById("dscper").value;
        		   
        		     
        		   
        		 	if(dscper>0)
		      		{
        		 
        		 	var allowdiscount=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "allowdiscount");
		      		var  discallowper=parseFloat(allowdiscount)*(parseFloat(dscper)/100);  
		      	 
		           document.getElementById("datas2").value="1";
		          //  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "disper1" ,discallowper);
	        		  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "discper" ,discallowper);
	        		  
	        		  
	        		  
	        		  if(reftypes=="JOR" || reftypes=="DEL")
	        			  {
	        			  
	        			  
	        			  if(discallowper>0)
               			{  
 	        		 var total=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowindex1, "total");
 	        		 
 	        		 
 	        	
 	        		 var discount=(parseFloat(total)*(parseFloat(discallowper.toFixed(2))/100));
 	        		 
 	        	 
 	        		 var  netotal=parseFloat(total)-parseFloat(discount);
 	        		     
 	        		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "dis" ,discount);
 	        		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "netotal" ,netotal);
 	        		     
	        			  }
	        		  
	        		  
	        		 
		      		}
		      		}
        		 	else
    		 		{
    		 		 
    		 		
    		 		  document.getElementById("datas2").value="1";
    		 		 // $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "disper1" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "allowdiscount"));
            		   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "discper" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "allowdiscount"));
            		  
            		   
 	        		  if(reftypes=="JOR" || reftypes=="DEL")
 	        			  {
 	        			    
            		   
            		   
            	     	 
	              		var allowdiscount=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "allowdiscount");
	              		if(allowdiscount>0)
              			{
	              		 var total=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowindex1, "total");
	              		 
   	        		 var discount=(parseFloat(total)*(parseFloat(allowdiscount.toFixed(2))/100));
   	        		 var  netotal=parseFloat(total)-parseFloat(discount);
   	        		     
   	        		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "dis" ,discount);
   	        		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "netotal" ,netotal);
              			}
            		   
	              		
 	        			  }
            		   
            		   
    		 		}
        		  
        		  
        		 
        
    		  }
		      
    		  }     
        	 
		     	 
        	  document.getElementById("datas2").value="0";
	        	 
        	  
        	//  $("#jqxInvoiceGrid").jqxGrid('selectcell',rowindex1, "qty" ); dis discper
                
              var rows = $('#jqxInvoiceGrid').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1 == rowlength - 1)
                	{  
                $("#jqxInvoiceGrid").jqxGrid('addrow', null, {});
                	} 
                	  
                $("#jqxInvoiceGrid").jqxGrid('ensurerowvisible', rowlength);
              $('#sidesearchwndow').jqxWindow('close'); 
            }); 
           
            
       
        });
		
    </script>
    <div id="prosearch"></div>
    
    