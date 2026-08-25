 <%@page import="com.nisalesnew.cuttinginvoice.ClsCuttingInvoiceDAO"%>
<% ClsCuttingInvoiceDAO  sDAO = new ClsCuttingInvoiceDAO(); 
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String reftype=request.getParameter("reftype")==null?"0":request.getParameter("reftype");
String reftypedocno=request.getParameter("reftypedocno")==null?"0":request.getParameter("reftypedocno");
%>
       <script type="text/javascript">
      var reftypes='<%=reftype%>';
			 var prdata= '<%=sDAO.searchProduct(session,id,reftype,reftypedocno)%>';
			 
			 
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
                            
                       
                      		{name : 'floor', type: 'String'  },
    						{name : 'flatids',type:'number'},
    						
    						{name : 'width',type:'number'},
    						{name : 'height',type:'number'},
    						
    						{name : 'quantity', type: 'number'  },
    						{name : 'sqm', type: 'String'  },
    						{name : 'totsize', type: 'number'  },
    						{name : 'price', type: 'number'},
    						{name : 'bevcode', type: 'String'},
    						{name : 'bevrate', type: 'number'  },
    					
    						{name : 'bevvalue', type: 'number'  },
    						{name : 'polcode', type: 'string'  },
    						
    						{name : 'bevcodename', type: 'string'  },
    						{name : 'polcodename', type: 'string'  },
    						
    						{name : 'polrate', type: 'number'},
    						{name : 'polcharge', type: 'number'},
    						{name : 'temp', type: 'String'},
    						{name : 'amount', type: 'number'  },
    						
    						{name : 'rowno', type: 'string'  },
    						{name : 'qtyval', type: 'number'  },  
    						
     						
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
                              
                              
                             { text: 'Floor', datafield: 'floor', width: '6%'  ,hidden:true},
         					 
         					 { text: 'Flat', datafield: 'flatids', width: '6%'  ,hidden:true},
         					 {text: 'Width(mm)', datafield: 'width', width: '6%', cellsformat:'d4'  ,hidden:true},
         					 
         				     { text: 'Height(mm)',datafield: 'height', width: '6%', cellsformat:'d4'   ,hidden:true}, 
         				    
         				     
         				     { text: 'Quantity',datafield: 'quantity', width: '6%' , cellsformat:'d2'  ,hidden:true},
         					 { text: 'SQM', datafield: 'sqm', width: '6%'     ,hidden:true},
         					 { text: 'Tot Size', datafield: 'totsize', width: '6%', cellsformat:'d4', cellsalign:'right', align:'right',editable:false    ,hidden:true},
         					 { text: 'Price', datafield: 'price', width: '7%', cellsformat:'d4', cellsalign:'right', align:'right'   ,hidden:true},
         					 { text: 'Bevelling Code', datafield: 'bevcodename', width: '6%',editable:false  ,hidden:true},
         					 { text: '  Code2', datafield: 'bevcode', width: '6%'  ,hidden:true},
         					 { text: 'Bev. Rate', datafield: 'bevrate', width: '5%', cellsformat:'d2', cellsalign:'right', align:'right'  ,hidden:true},
         					 { text: 'Bev. Value', datafield: 'bevvalue', width: '5%' ,cellsformat:'d2', cellsalign:'right', align:'right',editable:false  ,hidden:true},
         					 { text: 'Polishing Code', datafield: 'polcodename', width: '6%',editable:false   ,hidden:true},
         					 { text: '  Code1', datafield: 'polcode', width: '6%'  ,hidden:true},
         					 { text: 'Pol Rate', datafield: 'polrate', width: '4%', cellsformat:'d2', cellsalign:'right', align:'right'  ,hidden:true},
         					 { text: 'Pol Charge', datafield: 'polcharge', width: '5%', cellsformat:'d2', cellsalign:'right', align:'right',editable:false  ,hidden:true},
         					 { text: 'Temp', datafield: 'temp', width: '5%' ,hidden:true},
         					 { text: 'Amount', datafield: 'amount',editable:false, width: '8%', cellsformat:'d4', cellsalign:'right', align:'right'    ,hidden:true},
         					   { text: 'Quantity',datafield: 'qtyval', width: '6%' , cellsformat:'d2' ,hidden:true},
         					 
         					 { text: 'rowno', datafield: 'rowno', width: '5%' ,hidden:true},
         				 
						
	             
						]
            })
             
            
 
            
            $('#prosearch').on('rowclick', function (event) {
             document.getElementById("datas").value="1";
                
                
               
            }); 
          $('#prosearch').on('rowdoubleclick', function (event) {
        	
        	   $('#prdGridID').jqxGrid('render');
        	  var rowindex1 =$('#rowindex').val();
             
            	
                var rowindex2 = event.args.rowindex;
   
                
              
               
               
         var prodocs=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "rowno");
               
              if(reftypes=="DLY")
            	  {
            	  
          		var rows = $("#prdGridID").jqxGrid('getrows');
        	    var aa=0;
        	    for(var i=0;i<rows.length;i++){
        	 
         	    	 
         		   if(parseInt(rows[i].refrow)==parseInt(prodocs))
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
            	  
            	  
            	 
                             
               
               
                
                
                $('#prdGridID').jqxGrid('setcellvalue', rowindex1, "proid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
                $('#prdGridID').jqxGrid('setcellvalue', rowindex1, "proname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));
                
                
                $('#prdGridID').jqxGrid('setcellvalue', rowindex1, "productid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
                $('#prdGridID').jqxGrid('setcellvalue', rowindex1, "productname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));
                $('#prdGridID').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "psrno"));
            	 $('#prdGridID').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unit"));
                $('#prdGridID').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "munit"));
                
                
                
                
                $('#prdGridID').jqxGrid('setcellvalue', rowindex1, "specid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "specid"));
                
               
                if(reftypes=="DLY")
          	  {
                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "floor" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "floor"));
                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "flatids" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "flatids"));
                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "width" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "width"));
                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "height" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "height"));
                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "quantity" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "quantity"));
                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "sqm" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "sqm"));
                	
                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "totsize" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "totsize"));
                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "price" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "price"));
                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "bevcodename" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "bevcodename"));
                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "bevcode" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "bevcode"));
               	
                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "bevrate" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "bevrate"));
                	
                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "bevvalue" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "bevvalue"));
                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "polcodename" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "polcodename"));
               	
                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "polcode" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "polcode"));
                	
                 	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "polrate" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "polrate"));
                    
                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "polcharge" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "polcharge"));
                	
                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "temp" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "temp"));
                	
                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "amount" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "amount"));
                	
                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "refrow" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "rowno"));
                	
                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "qtyval" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "qtyval"));
             
		 
                	
                	
          	  }
           
                	
                
                
                
/*                 $('#prdGridID').jqxGrid('setcellvalue', rowindex1, "brandname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "brandname")); */
              
                
                
 
                
              var rows = $('#prdGridID').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1 == rowlength - 1)
                	{  
                $("#prdGridID").jqxGrid('addrow', null, {});
                	} 
                	  
                $("#prdGridID").jqxGrid('ensurerowvisible', rowlength);
              $('#sidesearchwndow').jqxWindow('close'); 
            }); 
           
            
       
        });
		
    </script>
    <div id="prosearch"></div>
    
    