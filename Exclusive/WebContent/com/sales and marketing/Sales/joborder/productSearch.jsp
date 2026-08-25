<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.salesandmarketing.Sales.joborder.ClsJobOrderDAO"%>
<%ClsJobOrderDAO DAO= new ClsJobOrderDAO();%>
<%-- <% 
String prodsearchtype=request.getParameter("prodsearchtype")==null?"0":request.getParameter("prodsearchtype").trim();
String rrefno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();
String reftype=request.getParameter("reftype")==null?"0":request.getParameter("reftype").trim();

String cmbprice=request.getParameter("cmbprice")==null?"0":request.getParameter("cmbprice").trim();

String clientid=request.getParameter("clientid")==null?"0":request.getParameter("clientid").trim();
String cmbreftype=request.getParameter("cmbreftype")==null?"0":request.getParameter("cmbreftype").trim();

String location=request.getParameter("location")==null?"0":request.getParameter("location").trim();

String clientcaid=request.getParameter("clientcaid")==null?"0":request.getParameter("clientcaid").trim();

String dates=request.getParameter("dates")==null?"0":request.getParameter("dates").trim();

 
%> --%>
 
       <script type="text/javascript">
  
			 var prodsearchdata='<%=DAO.searchProduct(session)%>';
			 
			 
		$(document).ready(function () { 	
        	/* var url=""; */

        	
        	var reftypes='DIR';
        	
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
                              { text: 'allowdiscount', datafield: 'allowdiscount', width: '10%',hidden:true },
                              
                              
                              
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
            	 
            	
                var rowindex2 = event.args.rowindex;
   
             
               
               var prodocs=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
               
   
            	   
            	  
                	   
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
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "qty" ,1);
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "oldqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "qty"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "outqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "outqty"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "balqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "balqty"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "totqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "totqty"));
        	  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "specid"));
        	  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "stkid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "stkid"));
        	  
        	  
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
    
    