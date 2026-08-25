<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.sales.InventoryTransfer.InventoryTransferRecept.ClsTransferReceptDAO"%>
<%ClsTransferReceptDAO DAO= new ClsTransferReceptDAO();%>
<%
String prodsearchtype=request.getParameter("prodsearchtype")==null?"0":request.getParameter("prodsearchtype").trim();
String rrefno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();
String reftype=request.getParameter("reftype")==null?"0":request.getParameter("reftype").trim();
String locationfrmid=request.getParameter("locationfrmid")==null?"0":request.getParameter("locationfrmid").trim();
%>
  
       <script type="text/javascript">
  
			 var prodsearchdata= '<%=DAO.searchProduct(session,prodsearchtype,rrefno,locationfrmid)%>';
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
                            {name : 'unitprice', type: 'number'  },
                            
                            {name : 'brandname', type: 'string'  }, 
                            
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
             
                              { text: 'brandname', datafield: 'brandname', width: '10%',hidden:true },
						
	             
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
        	
        	   $('#jqxInvReceptGrid').jqxGrid('render');
        	  var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
            	
                var rowindex2 = event.args.rowindex;
   
                
               // $('#datas').val("1"); 
               
               
            /*    var prodocs=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
               
             
            	  
          		var rows = $("#jqxInvReceptGrid").jqxGrid('getrows');
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
        	   
          	   */
           
            	if($('#mode').val()=="A"){
            		
                    var stkids=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "stkid");
        
               		var rows = $("#jqxInvReceptGrid").jqxGrid('getrows');
             	    var aa=0;
             	    for(var i=0;i<rows.length;i++){
             	 
             	     
             	    	 
             		   if(parseInt(rows[i].stkid)==parseInt(stkids))
             			   {
             			   aa=1;
             			   
             			  
             			   break;
             			   }
             		   else{
             			   
             			   aa=0;
             		       } 

             	  
             	   
             	    }
                   	}
                   	
                   	
                   	if($('#mode').val()=="E"){
                   		
                   	   var stkids=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "stkid");
                   	   
                  		var rows = $("#jqxInvReceptGrid").jqxGrid('getrows');
                	    var aa=0;
                	    for(var i=0;i<rows.length;i++){
                	 
                	     var refstockid=rows[i].refstkid;
                	     
                	     if(parseInt(refstockid)>0)
                	    	 {
                	    	
                	    	 }
                	     else
                	    	 {
                	    	 
                	    	refstockid=rows[i].stkid;
                	    	 }
                	     
                	    	 
                		   if(parseInt(refstockid)==parseInt(stkids))
                			   {
                			   aa=1;
                			   
                			  
                			   break;
                			   }
                		   else{
                			   
                			   aa=0;
                		       } 

                	  
                	   
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
             	   
               	  
               	 
            	  
            	
              $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));  
              
              
              $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "brandname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "brandname")); 
               
              $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "productname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));
              $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
              $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unit"));
              $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitdocno"));
              $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "psrno"));
              $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "qty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "qty"));
              $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "outqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "outqty"));
              $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "balqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "balqty"));
              $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "totqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "totqty"));
        	  $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "specid"));
        	  $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "stkid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "stkid"));
        	  $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "unitprice" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice"));
        	//  $("#jqxInvReceptGrid").jqxGrid('selectcell',rowindex1, "qty" );
                
              var rows = $('#jqxInvReceptGrid').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1 == rowlength - 1)
                	{  
                $("#jqxInvReceptGrid").jqxGrid('addrow', null, {});
                	} 
                	  
                $("#jqxInvReceptGrid").jqxGrid('ensurerowvisible', rowlength);
              $('#sidesearchwndow').jqxWindow('close'); 
            }); 
           
            
       
        });
		
    </script>
    <div id="prosearch"></div>
    
    