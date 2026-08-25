 <%@page import="com.nisales.cuttingorder.ClsCuttingOrderDAO"%>
<% ClsCuttingOrderDAO  ClsCuttingOrderDAO = new ClsCuttingOrderDAO();

String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>
       <script type="text/javascript">
  
			 var prdata= '<%=ClsCuttingOrderDAO.searchProduct(session,id)%>';
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
                            
                            {name : 'specid', type: 'string'  },
                            {name : 'brandname', type: 'string'  },
                            
                       
     						
                        ],
         
                		//  url: url1,
                 localdata: prdata,
                
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
                              { text: 'Product Name', datafield: 'productname' },
                              { text: 'Unit', datafield: 'unit', width: '10%' },
                              { text: 'Method', datafield: 'method', width: '10%',hidden:true },
                              { text: 'Unitdoc', datafield: 'munit', width: '10%' ,hidden:true},
                              { text: 'psrno', datafield: 'psrno', width: '10%' ,hidden:true},
                              
                              { text: 'specid', datafield: 'specid', width: '10%',hidden:true },
                              
                              
                              { text: 'brandname', datafield: 'brandname', width: '10%',hidden:true },
                              
                              
                              
						
						
	             
						]
            })
             
            
 
            
            $('#prosearch').on('rowclick', function (event) {
             document.getElementById("datas").value="1";
                
                
               
            }); 
          $('#prosearch').on('rowdoubleclick', function (event) {
        	
        	   $('#cuttingOrderGridID').jqxGrid('render');
        	  var rowindex1 =$('#rowindex').val();
             
            	
                var rowindex2 = event.args.rowindex;
   
                
               // $('#datas').val("1"); 
               
               
           /*     var prodocs=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
               
              if(parseInt($('#prosearch').jqxGrid('getcellvalue', rowindex2, "method"))==0)
            	  {
            	  
          		var rows = $("#cuttingOrderGridID").jqxGrid('getrows');
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
            	  
            	  
            	 */
                             
               
               
                
                
                $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowindex1, "proid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
                $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowindex1, "proname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));
                
                
                $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowindex1, "productid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
                $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowindex1, "productname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));
                $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "psrno"));
            	 $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unit"));
                $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "munit"));
                
                
                
                
                $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowindex1, "specid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "specid"));
                
                
/*                 $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowindex1, "brandname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "brandname")); */
              
                
                
 
                
              var rows = $('#cuttingOrderGridID').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1 == rowlength - 1)
                	{  
                $("#cuttingOrderGridID").jqxGrid('addrow', null, {});
                	} 
                	  
                $("#cuttingOrderGridID").jqxGrid('ensurerowvisible', rowlength);
              $('#sidesearchwndow').jqxWindow('close'); 
            }); 
           
            
       
        });
		
    </script>
    <div id="prosearch"></div>
    
    