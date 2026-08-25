  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.procurement.purchase.purchaserequestforquote.ClspurchaserequestforquoteDAO"%>
<% ClspurchaserequestforquoteDAO  purchaserequestforquoteDAO = new ClspurchaserequestforquoteDAO(); %> 

<%
String reqmasterdocno=request.getParameter("reqmasterdocno")==null?"0":request.getParameter("reqmasterdocno").trim();
String dtype=request.getParameter("dtype")==null?"0":request.getParameter("dtype").trim();
String id=request.getParameter("id")==null?"0":request.getParameter("id").trim();
String accdocno=request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
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
       var id='<%=id%>';
       var prddata;
       if(id=='1'){
       if(dtype=='CEQ' || dtype=='PR')
       
    	   {
    	   
    	   prddata = '<%=purchaserequestforquoteDAO.searchreqProduct(reqmasterdocno,session,accdocno,dtype,id,productname,brandname,gridunit,gridprdname,gridcategory,gridssubcategory)%>';   
    	   
    	   }
       else
    	   {
    	   
    	   prddata= '<%=purchaserequestforquoteDAO.searchProduct(session,accdocno,id,productname,brandname,gridunit,gridprdname,gridcategory,gridssubcategory)%>';
    	   }
       }
       else{
    	   prddata=[];
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
                            {name : 'brandname', type: 'string'  },
                            
                            
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
                              { text: 'Product', datafield: 'part_no', width: '28%' },
                              { text: 'Product Name', datafield: 'productname', width: '55%' },
                              { text: 'Unit', datafield: 'unit', width: '13%' },
                              { text: 'Method', datafield: 'method', width: '10%' ,hidden:true},
                              { text: 'Unitdoc', datafield: 'munit', width: '10%' ,hidden:true},
                              { text: 'psrno', datafield: 'psrno', width: '10%' ,hidden:true},
                               
                              { text: 'Quantity', datafield: 'qty', width: '10%' ,cellsformat:'d2' ,hidden:true},
                              {text: 'qutval', datafield: 'qutval', width: '10%' , cellsformat:'d2' ,hidden:true},
  							{ text: 'pqty', datafield: 'pqty', width: '9%' ,  cellsformat:'d2' ,hidden:true },
  							{text: 'saveqty', datafield: 'saveqty', width: '10%', cellsformat:'d2'  ,hidden:true},
                             
  							{text: 'specid', datafield: 'specid', width: '10%' ,hidden:true  },
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
          $('#prosearch').on('rowclick', function (event) {
        	 
        	   $('#serviecGrid').jqxGrid('render');
        	  var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
            	
                var rowindex2 = event.args.rowindex;
   
                
               // $('#datas').val("1"); 
               
               
               var prodocs=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
               
              if(parseInt($('#prosearch').jqxGrid('getcellvalue', rowindex2, "method"))==0)
            	  {
            	  
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
            	  
            	  
            	
 
                 
                 if(dtype=='CEQ' || dtype=='PR')
                     
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
                 
               //  $("#serviecGrid").jqxGrid('selectcell',rowindex1, "qty");
                 $('#datas1').val(1);
          	   }
                 
                 
                 else
                	 {
                	 
                	 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "brandname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "brandname"));
                	   $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
                       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));       
                        
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
    
    