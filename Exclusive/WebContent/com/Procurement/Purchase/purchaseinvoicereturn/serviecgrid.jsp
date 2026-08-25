  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.procurement.purchase.purchaseinvoicereturn.ClspurchaseinvoicereturnDAO"%>
<% ClspurchaseinvoicereturnDAO purchaseretDAO = new ClspurchaseinvoicereturnDAO(); %> 

<%
String purdoc=request.getParameter("purdoc")==null?"0":request.getParameter("purdoc").trim();
String reqdoc=request.getParameter("reqdoc")==null?"0":request.getParameter("reqdoc").trim();
String chk=request.getParameter("chk")==null?"NA":request.getParameter("chk").trim();
String from=request.getParameter("from")==null?"0":request.getParameter("from").trim();
String reftype=request.getParameter("reftype")==null?"NA":request.getParameter("reftype").trim();
String reqmasterdocno=request.getParameter("reqmasterdocno")==null?"0":request.getParameter("reqmasterdocno").trim();
String dates=request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
String cmbbilltype=request.getParameter("cmbbilltype")==null?"0":request.getParameter("cmbbilltype").trim();
String accdocno=request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
%>
  <style type="text/css">
  .advanceClass
  {
      color: #FF0000;
  }
  .yellowClass
        {
        
       
       background-color: #ffc0cb; 
        
        }
</style>


<script type="text/javascript">
var descdata1;
var temp2='<%=chk%>';
var temp='<%=purdoc%>';
if(temp2!='NA')
{

	descdata1='<%=purchaseretDAO.reqgridreload(reqdoc,from,session,dates,cmbbilltype,accdocno)%>';  
 
}


else if(temp>0)
{
 
	descdata1='<%=purchaseretDAO.maingridreload(purdoc,reftype,reqmasterdocno)%>';  

}

else
 
{   
	descdata1;

 } 


        $(document).ready(function () { 	
        	chkbrand();
        	chkfoc();
        	chktax();
       	  var rendererstring2=function (aggregates){
             	var value=aggregates['sum2'];
             	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "  Total" + '</div>';
             }    
          
  
        
        	  var rendererstring1=function (aggregates){
               	var value=aggregates['sum1'];
               	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
               }    
            
         var rendererstring=function (aggregates){
         	var value=aggregates['sum'];
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
         }
             
     	 
             
             $('#gridtext').keyup(function(){
             	

 			      $("#prosearch").jqxGrid('clearfilters');
       		  
             
                 $('#part_no').val($(this).val());
                 var dataField = "part_no";
          applyFilter(dataField,$(this).val());  
                 
                 
                 
             });
             
         
             $('#gridtext1').keyup(function(){
             	

 			      $("#prosearch").jqxGrid('clearfilters');
     		  
           
               $('#productname').val($(this).val());
               var dataField = "productname";
    		   applyFilter(dataField,$(this).val());  
               
               
               
           });
         
         
         var cellclassname =  function (row, column, value, data) {


         	  var ss= $('#serviecGrid').jqxGrid('getcellvalue', row, "qty");
         		          if(parseFloat(ss)<=0)
         		  		{
         		  		
         		  		return "yellowClass";
         		  	
         		  		}
         	    
         	    	/* return "greyClass";
         	    	
         		        var element = $(defaultHtml);
         		        element.css({ 'background-color': '#F3F297', 'width': '100%', 'height': '100%', 'margin': '0px' });
         		        return element[0].outerHTML;
         	*/

         		}
         
         
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [     
     						
                      		{name : 'productid', type: 'string'    },
                    		{name : 'productname', type: 'string'    },
                    		{name : 'unit', type: 'String'    },
     						{name : 'qty', type: 'number'    },
     						{name : 'unitprice', type: 'number'    },
     						{name : 'total', type: 'number'    },
     						{name : 'discount', type: 'number'    },       
     					
     						{name : 'nettotal', type: 'number'    },
     						{name : 'prodoc', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
     						
     						{name : 'qutval', type: 'number'    },
     						{name : 'saveqty', type: 'number'    },
     						
     						{name : 'discper', type: 'number'    },
     						
     						{name : 'checktype', type: 'number'    },   //no use
     						{name : 'pqty', type: 'number'    },
     						
     				     	{name : 'proid', type: 'string'    },
                    		{name : 'proname', type: 'string'    },
                    		{name : 'specid', type: 'string'  },
                    		
                    		 {name : 'foc', type: 'number'    },  
                    		{name : 'stockid', type: 'number'  },
                    		
                    		 
                    		  {name : 'oldqty', type: 'number'  },      
                    		  
                    		  {name : 'oldfoc', type: 'number'  },      
                    		  
                    		 
                    			{name : 'rdtype', type: 'string'    },
                    			
                    			
                    			 {name : 'maxfoc', type: 'number'    },  
                    			
                    			 
                    			 {name : 'mainqty', type: 'number'    },  
                    			 {name : 'brandname', type: 'String'    },
                    			 
                    			 {name : 'taxper', type: 'number'  },  
            					 {name : 'taxamount', type: 'number'  },
            					{name : 'taxperamt', type: 'number'  },
                    			 
                    		  
                 ],
              
                 localdata: descdata1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
 $("#serviecGrid").on("bindingcomplete", function (event) { 
    			
    			
                if($('#mode').val()=="A"){
       
              if($('#reftype').val()=='PIV'){
            	
             	 var rows = $("#serviecGrid").jqxGrid('getrows');   
 
	             	  for(var i=0;i<rows.length;i++){
	             	   		var netotal=$('#serviecGrid').jqxGrid('getcellvalue', i, "nettotal"); 
	                		
	                		  var taxper= $('#serviecGrid').jqxGrid('getcellvalue', i, "taxper"); 
	                		  if(parseFloat(taxper)>0)
	                			  {
	                		  var taxempamount=parseFloat(netotal)*(parseFloat(taxper)/100);
	                		  
	                		  
	                		  $('#serviecGrid').jqxGrid('setcellvalue', i, "taxperamt",taxempamount);
	                		  
	                		  var taxtotalamount=parseFloat(netotal)+parseFloat(taxempamount);
	                		  
	                		  $('#serviecGrid').jqxGrid('setcellvalue', i, "taxamount",taxtotalamount);
	                			  }
	                		  else
	                			  {
	                			  $('#serviecGrid').jqxGrid('setcellvalue', i, "taxamount",netotal);
	                			  }
	                		 
	             	                         }
                                    }
                               } 
         	         
     
    			
    			
    		}); 
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#serviecGrid").jqxGrid(
            {
                width: '99.5%',
                height: 297,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                disabled:true,
                statusbarheight: 21,
                selectionmode: 'singlecell',
                pagermode: 'default',
                
                //Add row method
         //Add row method
                handlekeyboardnavigation: function (event) {
                	
                	
                	
                   	
               	 if(document.getElementById("reftype").value=="DIR")
             		{
                       
            			 var cell1 = $('#serviecGrid').jqxGrid('getselectedcell');
            		
            			 
                    	 if (cell1 != undefined && cell1.datafield == 'unit') {  
                    		 
                		 
                    		 if((parseInt(document.getElementById("multimethod").value)==1))
             				{	
                    			 
                    		 
                            var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                            if (key == 114) {  
                           	 
                   			 
                              var rowindextemp=cell1.rowindex;
                         	    document.getElementById("rowindex").value = cell1.rowindex;   
                             	  $('#serviecGrid').jqxGrid('clearselection');
                             	qtyinfoSearchContent('searchunit.jsp?psrno='+$('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "psrno")+
                             			"&mode="+document.getElementById("mode").value);
                             	
                            	 
                            }
                            
             				}
                            
                            
                            }
            			 
                   }
	
                	
                	

                    var cell4 = $('#serviecGrid').jqxGrid('getselectedcell');
                   
                    
                    if (cell4 != undefined && (cell4.datafield == 'productid' || cell4.datafield == 'productname'  )) 
                    
                   {	 
                   	 
                   	 
                   	 
  	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
  	                 
  	                  if (key == 9) {    
  	                	   
  	                	 if(cell4.datafield == 'productid')
	                		  {
	                		var aa= $('#part_no').val();
	                		  }
	                	  else if(cell4.datafield == 'productname')
	                		  {
	                		var aa= $('#productname').val();  
	                		  }
	                		
	                 
                   if(typeof(aa)=="undefined")
                   
                   	{
                   	 
                   	return 0;
                   	}
                      	  
  	                	 if(document.getElementById("reftype").value=="PIV")
 	                	{
                    	 
   	                  
   	                	   
   	                	  
   	             	   
 	   	               	 var rows = $("#prosearch").jqxGrid('getrows');  
   	                	  
   	                	  
   	                   var stockid=rows[0].stockid;
   	                
   	          
          		var rows1 = $("#serviecGrid").jqxGrid('getrows');
   	          	    var aa=0;
   	          	    for(var i=0;i<rows1.length;i++){
   	          	 
   	          	    	
   	          	    	 
   	          		   if(parseInt(rows1[i].stockid)==parseInt(stockid))
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
   	                  
   	                  
   	                  
   	                  else
   	                	  {
   	                	  
   	                	  
  	   	               	 var rows = $("#prosearch").jqxGrid('getrows');  
  	                	  
  	                	  
  	  	                   var prodocs=rows[0].doc_no;
  	  	                
  	  	                if(parseInt(rows[0].method)==0)
  	  	              	  {
  	  	              	  
  	  	            		var rows1 = $("#serviecGrid").jqxGrid('getrows');
  	  	          	    var aa=0;
  	  	          	    for(var i=0;i<rows1.length;i++){
  	  	          	 
  	  	          	    	
  	  	           	 
  	  	          	    	
 	  	          	    	 
   	  	          		   if(parseInt(rows1[i].prodoc)==parseInt(prodocs))
   	  	          			   {
   	  	          		   var munit=rows[0].munit;
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
   	                	  
   	                	  
   	                	  
  	                	  
  	                	   
  	               	 var rows = $("#prosearch").jqxGrid('getrows');
  	  		    
  	                	
  	                	   $('#serviecGrid').jqxGrid('render');
  	              	  var rowindex1 =$('#rowindex').val();
  	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,rows[0].part_no);
  	            
  	               $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].productname);
  	               
  	             
  	             
   		  	      $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "taxper" ,rows[0].taxper);
  	 
  	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
  	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "productname" ,rows[0].productname);
  	              $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "brandname" ,rows[0].brandname);
  	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,	rows[0].doc_no);
  	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
  	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,rows[0].munit);
  	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno );
  	                
  	              $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,rows[0].specid );
  	                
  	                if(document.getElementById("reftype").value=="PIV")
  	                	{
  	            	  $('#datas1').val(0);
  	              	$('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "qty" ,rows[0].qty);
  	                	
  	                  $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "qutval" ,rows[0].qutval);
  	                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "pqty" ,rows[0].pqty);
  	                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "saveqty" ,rows[0].saveqty);
  	                 
  	                 
  	               $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "stockid" ,rows[0].stockid);
  	             $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unitprice" ,rows[0].unitprice);
  	    	       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "total" ,rows[0].total);
  	    	       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "discper" ,rows[0].disper);
  	             
  	    	      $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "discount" ,rows[0].discount);
  	           
  	         $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "nettotal" ,rows[0].nettotal);
 
  	         
  	         
  	       $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "foc" ,rows[0].foc);
	           
	         $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "maxfoc" ,rows[0].maxfoc);

	                 
	         $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "rdtype" ,rows[0].rdtype);


  	                 
	         $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "mainqty" ,rows[0].mainqty);    
  	                 
  	                 
  	                 
  	         	  $('#datas1').val(1);
  	          
  	                	
  	                	
  	                	}
  	             $('#sidesearchwndow').jqxWindow('close'); 
  	                	   
  	          var rows = $('#serviecGrid').jqxGrid('getrows');
               var rowlength= rows.length;
               if(rowindex1 == rowlength - 1)
               	{  
               $("#serviecGrid").jqxGrid('addrow', null, {});
               	} 
               
               $("#serviecGrid").jqxGrid('ensurerowvisible', rowlength);
  	        	            } 

  	                  if (key != 13) {          
  	                	if (cell4 != undefined && cell4.datafield == 'productid') {
  	               		  if(parseInt(document.getElementById("productchk").value)==0)
  	        			  {
  	               		   	document.getElementById("gridtext").focus();
  	        			  }
  	                    }
  	                    if (cell4 != undefined && cell4.datafield == 'productname') {
  	                    	 if(parseInt(document.getElementById("productchk").value)==0)
  	        					{
  	            		   		document.getElementById("gridtext1").focus();
  	        					} 
  	                  	}
  	                }
                   } 
       		 
                	
                	
  
                    },
                
                
                columns: [
                
							   { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '3%',cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
				
                        	{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '8%',cellclassname: cellclassname,
                          	  
                            
                            	
                            	
                            	
  							    createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							     
  							         editor.html('<input type="text" id="part_no" name="part_no" style="width:100%;height:99%;"   />' ); 
  							   
  							        
  							    },  
  							 
                           
  							 
							}, 
							{ text: 'Product Name', datafield: 'productname',  cellclassname: cellclassname ,columntype: 'custom',
								

  								
  								createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							       
  							         editor.html('<input type="text" id="productname" name="productname" style="width:100%;height:99%;"   />' ); 
  							     
  							        
  							    },  
							
							}, 
						    { text: 'Brand Name', datafield: 'brandname', width: '10%',cellclassname: cellclassname,editable:false },
							{ text: 'Unit', datafield: 'unit', width: '6%',cellclassname: cellclassname,editable:false },
							
				 
							  
							  { text: 'oldqty', datafield: 'oldqty', width: '5%' ,cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2',hidden:true},
							  
							{ text: 'Quantity', datafield: 'qty',cellsalign: 'left', width: '5%' ,align:'left',cellclassname: cellclassname,cellsformat:'d2'
								  
								 
							
							
							},
							{ text: 'FOC', datafield: 'foc', width: '5%' ,cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2',
								
								cellbeginedit: function (row) {
                                    if ($('#serviecGrid').jqxGrid('getcellvalue', row, "rdtype")=="GRN")
                             {
                                  return false;
                             } 
                                    
                            	
                            	},
								
								 },
				 
								 { text: 'maxfoc', datafield: 'maxfoc', width: '5%' ,cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2',hidden:true},
							
								 
							{ text: 'Unit Price', datafield: 'unitprice', width: '9%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2',cellclassname: cellclassname, 
									 
							
							
									 cellbeginedit: function (row) {
		                                    if (document.getElementById("reftype").value=="PIV")
		                             {
		                                  return false;
		                             } 
		                                    
		                            	
		                            	},
							
							
							},
							{ text: 'Total', datafield: 'total', width: '9%' ,editable: false,cellsalign: 'right', align:'right',cellsformat:'d2' ,cellclassname: cellclassname,
								
							
								 cellbeginedit: function (row) {
	                                    if (document.getElementById("reftype").value=="PIV")
	                             {
	                                  return false;
	                             } 
	                                    
	                            	
	                            	},
						
							
							
							},
							{ text: 'Discount %', datafield: 'discper', width: '7%' ,  cellsformat:'d2',cellsalign: 'right', align:'right',cellclassname: cellclassname,
								
							
								 cellbeginedit: function (row) {
	                                    if (document.getElementById("reftype").value=="PIV")
	                             {
	                                  return false;
	                             } 
	                                    
	                            	
	                            	},
						
							
							},
							{ text: 'Discount', datafield: 'discount', width: '8%',cellsalign: 'right', align:'right',cellsformat:'d2' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname,
								
							
							
								 cellbeginedit: function (row) {
	                                    if (document.getElementById("reftype").value=="PIV")
	                             {
	                                  return false;
	                             } 
	                                    
	                            	
	                            	},
						
							
							},
							{ text: 'Net Amount', datafield: 'nettotal', width: '9%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname,
								
							
							
								 cellbeginedit: function (row) {
	                                    if (document.getElementById("reftype").value=="PIV")
	                             {
	                                  return false;
	                             } 
	                                    
	                            	
	                            	},
						
							},
							
							 
							{text: 'prodoc', datafield: 'prodoc', width: '10%' ,hidden:true},
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',hidden:true  },
							{text: 'psrno', datafield: 'psrno', width: '10%',hidden:true },
							
							{text: 'stockid', datafield: 'stockid', width: '10%' ,hidden:true },
							
							
							{text: 'qutval', datafield: 'qutval', width: '10%' ,cellsformat:'d2'  ,hidden:true  },
							{ text: 'pqty', datafield: 'pqty', width: '9%',cellsformat:'d2'  ,hidden:true   },
							{text: 'saveqty', datafield: 'saveqty', width: '10%' ,cellsformat:'d2'  ,hidden:true },
						 
							{text: 'pid', datafield: 'proid', width: '10%' ,hidden:true   }, 
  							{text: 'pname', datafield: 'proname', width: '10%' ,hidden:true  }, 
							
							 
							{text: 'checktype', datafield: 'checktype', width: '10%'  ,hidden:true  },    
							{text: 'specid', datafield: 'specid', width: '10%' ,hidden:true  },
							{text: 'rdtype', datafield: 'rdtype', width: '10%'  ,hidden:true   },
							
							{text: 'mainqty', datafield: 'mainqty', width: '10%' ,hidden:true    },
							
							{text: 'oldfoc', datafield: 'oldfoc', width: '10%'  ,hidden:true   },
				            
							{ text: 'Tax %', datafield: 'taxper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false},
							{ text: 'Tax Amount', datafield: 'taxperamt', width: '5%', cellsformat: 'd2'  , cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
							
							{ text: 'Total Amount', datafield: 'taxamount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
							
							
	              ]
            });
           if(temp==0)
        	   {
            $("#serviecGrid").jqxGrid('addrow', null, {});
         
 
         
        	   }
           
           
           if(($('#mode').val()=='A')||($('#mode').val()=='E'))
   		       {
   		  $("#serviecGrid").jqxGrid({ disabled: false}); 
   		        }
           
           
 
           
          	if(document.getElementById("reftype").value=="PIV")
    		{
    
         
         
         
		    var summaryData= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
		   
           document.getElementById("netTotaldown").value=summaryData.sum.replace(/,/g,'');
       
       
           var summaryData1= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
	   
          document.getElementById("productTotal").value=summaryData1.sum.replace(/,/g,'');
    
           var summaryData2= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'discount', ['sum'],true);
		   
           document.getElementById("prddiscount").value=summaryData2.sum.replace(/,/g,'');
         
         
           var summaryData10= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
           
         	var aa1=summaryData10.sum.replace(/,/g,'');
         	if(temp2!='NA')
         	{
    	
        	 
       	 funRoundAmt4(aa1,"st");
       	 funRoundAmt4(aa1,"taxtotal");
       	 funcalutax();
         	}
         
         
         
              
    		}
           
    	 $('#serviecGrid').on('cellclick', function (event) {
    		 
    		 document.getElementById("errormsg").innerText="";	 
    		 
   			 if(document.getElementById("reftype").value=="DIR")
        		{
   							var df=event.args.datafield;
   			
   							  
   			             	  if(df == "unit")
   			             		  { 
   			             		 
   						 if(parseInt(document.getElementById("multimethod").value)==1)
   							{	 
   						 
   						 var rowindextemp = event.args.rowindex;
   			       	    document.getElementById("rowindex").value = rowindextemp;   
   			       	  $('#serviecGrid').jqxGrid('clearselection');
   			      	qtyinfoSearchContent('searchunit.jsp?psrno='+$('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "psrno")+
   			      			"&mode="+document.getElementById("mode").value);
   							}
   						 
   						 
   						 
   			             		  }
   			       	
        		}
    	 }); 

    	 
  $('#serviecGrid').on('celldoubleclick', function (event) {
  		var columnindex1=event.args.datafield;
      	
  		if(columnindex1 == "productid")
    	 { 
    	    	var accdocno = document.getElementById("accdocno").value;    
    	    	var reqmasterdocno = document.getElementById("reqmasterdocno").value;    
    	      	var dates=document.getElementById("masterdate").value; 
    	   		var cmbbilltype=document.getElementById("cmbbilltype").value;
    	   		if(parseInt(document.getElementById("productchk").value)==0){
    	   			$('#serviecGrid').jqxGrid('setcolumnproperty', 'productid', 'editable', true);
      			  $('#serviecGrid').jqxGrid('setcolumnproperty', 'productname', 'editable', true);
    	   			 productSearchContent('productSearch.jsp?reqmasterdocno='+reqmasterdocno+'&dtype='+document.getElementById("reftype").value+"&dates="+dates+"&cmbbilltype="+cmbbilltype+"&accdocno="+accdocno+"&id=1");
    			}
    	   		         	 
            	var rowindextemp = event.args.rowindex;
        	    document.getElementById("rowindex").value = rowindextemp;  
    	}
       	if(columnindex1 == "productname")
     	{ 
     	  	if(document.getElementById("errormsg").innerText!="")
       		{
          		return 0;
       		}	
 			var reqmasterdocno = document.getElementById("reqmasterdocno").value;  
 			var accdocno = document.getElementById("accdocno").value; 
 		 	var dates=document.getElementById("masterdate").value; 
    		 	var cmbbilltype=document.getElementById("cmbbilltype").value;
    		 	
    		 if(parseInt(document.getElementById("productchk").value)==0){
 	   			$('#serviecGrid').jqxGrid('setcolumnproperty', 'productid', 'editable', true);
 			  $('#serviecGrid').jqxGrid('setcolumnproperty', 'productname', 'editable', true);
 	   			 productSearchContent('productSearch.jsp?reqmasterdocno='+reqmasterdocno+'&dtype='+document.getElementById("reftype").value+"&dates="+dates+"&cmbbilltype="+cmbbilltype+"&accdocno="+accdocno+"&id=1");
 			}
 	   		 
 	    	var rowindextemp = event.args.rowindex;
 			document.getElementById("rowindex").value = rowindextemp;  
     	}
   });
    	 
    	 
           $('#serviecGrid').on('cellbeginedit', function (event) {
     //  	document.getElementById("errormsg").innerText="";
       	
        var rowindex2 = event.args.rowindex;
        var qtyvalidate=$('#serviecGrid').jqxGrid('getcellvalue', rowindex2, "qty");
        
        if(parseFloat(qtyvalidate)<=0)
        	{

    		document.getElementById("errormsg").innerText="Quantity Is Zero ";
    		 
    		return 0;
        	
        	}
        else
        	{
        	//document.getElementById("errormsg").innerText="";
        	
 
        	
        	}
       	
        $('#datas').val(0);
    	var columnindex1=event.args.columnindex;

        var df=event.args.datafield;

        
  	  if(df == "productid")
  		{ 
   		  var dates=document.getElementById("masterdate").value; 
   		  var cmbbilltype=document.getElementById("cmbbilltype").value;
   		  var accdocno = document.getElementById("accdocno").value; 
    	  var reqmasterdocno = document.getElementById("reqmasterdocno").value;    
    	  if(parseInt(document.getElementById("productchk").value)==1){
	   		  
	   			$('#serviecGrid').jqxGrid('setcolumnproperty', 'productid', 'editable', false);
	  			$('#serviecGrid').jqxGrid('setcolumnproperty', 'productname', 'editable', false);
		        productSearchContent('productMasterSearch.jsp?reqmasterdocno='+reqmasterdocno+'&dtype='+document.getElementById("reftype").value+"&dates="+dates+"&cmbbilltype="+cmbbilltype+"&accdocno="+accdocno);
		  }
    	  var rowindextemp = event.args.rowindex;
		  document.getElementById("rowindex").value = rowindextemp;  
		  var temp= $('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "productid"); 
		  if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
		  { 
			$('#gridtext').val("");  
			$('#part_no').val("");  
		  }
		  else
		  {
		       $('#part_no').val($('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));
		       $('#gridtext').val($('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));
		       $('#serviecGrid').jqxGrid('setcellvalue', rowindextemp, "productid" ,$('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));
 	  	  }
    	}	    
	    if(df == "productname")
    		  { 
	    	 if(document.getElementById("errormsg").innerText!="")
      		 {
      		 return 0;
      		 }	
       		 var dates=document.getElementById("masterdate").value; 
    		 var cmbbilltype=document.getElementById("cmbbilltype").value;
    		 var accdocno = document.getElementById("accdocno").value; 
	    	 var reqmasterdocno = document.getElementById("reqmasterdocno").value;  
	    	 if(parseInt(document.getElementById("productchk").value)==1){
		   		  
		   			$('#serviecGrid').jqxGrid('setcolumnproperty', 'productid', 'editable', false);
		  			$('#serviecGrid').jqxGrid('setcolumnproperty', 'productname', 'editable', false);
			        productSearchContent('productMasterSearch.jsp?reqmasterdocno='+reqmasterdocno+'&dtype='+document.getElementById("reftype").value+"&dates="+dates+"&cmbbilltype="+cmbbilltype+"&accdocno="+accdocno);
			 }
	    	 var rowindextemp = event.args.rowindex;
			 document.getElementById("rowindex").value = rowindextemp;  
			 var temp= $('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "productname"); 
			 if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
			 { 
				 $('#gridtext1').val(""); 
				 $('#productname').val("");  
			 }
			 else
			 {
		      	   $('#productname').val($('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));
		      	   $('#gridtext1').val($('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));
		             $('#serviecGrid').jqxGrid('setcellvalue', rowindextemp, "productname" ,$('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));
        	 }
    		}
           });
           function valchange(rowBoundIndex)
           {
           	var qty= $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
           	var unitprice=	$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");	
           	var total=parseFloat(qty)*parseFloat(unitprice);
   		    $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
   		   var gtotal= $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
   	   		var discount=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "discount");	
   	   		var nettotal=parseFloat(gtotal)-parseFloat(discount);
   	   		if(discount==""||discount==null||discount=="undefiend")
   	   			{
   	   		  $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",total);
   	   			}
   	   		else{
   	   			$('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",nettotal);
   	   		}
   	        		    var summaryData= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
   	               document.getElementById("netTotaldown").value=summaryData.sum.replace(/,/g,'');
   	            var summaryData1= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true); 
	               document.getElementById("productTotal").value=summaryData1.sum.replace(/,/g,'');
	               var summaryData2= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'discount', ['sum'],true);
   	               document.getElementById("prddiscount").value=summaryData2.sum.replace(/,/g,'');
               	var summaryData10= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
                   
                 	var aa1=summaryData10.sum.replace(/,/g,'');
             	   	
                	 
               	 funRoundAmt4(aa1,"st");
               	 funRoundAmt4(aa1,"taxtotal");
                 funcalutax();
   	               
   	
           }

           $("#serviecGrid").on('cellvaluechanged', function (event) 
           {
           	var datafield = event.args.datafield;
       		
   		    var rowBoundIndex = event.args.rowindex;    
   		    
   		    
    	  	 if(datafield=="taxperamt")
    		  {
   			var summaryData10= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
             
       	   	var aa1=summaryData10.sum.replace(/,/g,'');
       	   	        	 
       	funRoundAmt4(aa1,"st");
       	  funcalutax();
    		  }
            	 
    	  	 
    	   	  if(datafield=="nettotal")
    		  {
           		 
    		var netotal=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal"); 
    		
    		  var taxper= $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "taxper"); 
    		  if(parseFloat(taxper)>0)
    			  {
    			  
    			  
    		  var taxempamount=parseFloat(netotal)*(parseFloat(taxper)/100);
    		  
    		  
    		  $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",taxempamount);
    		  
    		  var taxtotalamount=parseFloat(netotal)+parseFloat(taxempamount);
    		  
    		  $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",taxtotalamount);
    			  }
    		  else
    			  {
    			  $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",netotal);
    			  }
    		 
    		  }
           	  if(datafield=='qty' || datafield=='discount' || datafield=='discper' || datafield=='unitprice'){	   
            	  
           	 
           		  
        		  funcalutax();
          	  }
         		
   			if(datafield=="nettotal")
   		    {
           		
                   if($('#datas1').val()==0)
                	   {
				                   //var summaryData1= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
				       		       var summaryData= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
				       		  
				                   //document.getElementById("productTotal").value=summaryData1.sum.replace(/,/g,'');
				              document.getElementById("netTotaldown").value=summaryData.sum.replace(/,/g,'');
				        
				             
				        	  
				              
				   	            var summaryData1= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true); 
				        		   
					               document.getElementById("productTotal").value=summaryData1.sum.replace(/,/g,'');
					               
					               var summaryData2= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'discount', ['sum'],true);
					        		   
				   	               document.getElementById("prddiscount").value=summaryData2.sum.replace(/,/g,'');
				   	               
				           		//tttttt
				           		
				 	        	  
					         	   	var summaryData10= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
					                
					          	   	var aa1=summaryData10.sum.replace(/,/g,'');
					          	   	
					 
					          	 
					          	funRoundAmt4(aa1,"st");
					        	 funRoundAmt4(aa1,"taxtotal");
					        	  funcalutax();
						        	  
                	   }
   		    }
   		    
   		    

   	   
//    	  if(parseInt($('#datas').val())!=1)
//    		  {
   	   
   
//    	   if(datafield=="productid")
//    		   {
   	   
//    	$('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "productid" ,$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "proid"));
//        $('#sidesearchwndow').jqxWindow('close');
//    		   }
   	   
//    	   if(datafield=="productname")
//    		   {
//    		   	$('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "productname" ,$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "proname"));
//                $('#sidesearchwndow').jqxWindow('close');
//    		   }
   	   
//    		  }
   	  
   	  
   		  /*   if(datafield=="foc") 
   		    	{
   		     
       			if(parseInt($('#datas1').val())==0) // this for prd search in request not imported case qty not set
       			
       				{
       			   	
       				 
       				return 0;
       				}
       			
       			if(document.getElementById("reftype").value=="PIV")
        		{
   			   		

            		var focval=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "maxfoc");	
           	        
                  	 
                    var foc=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "foc");
                 	
                  	if(foc>focval)
            		{
            		document.getElementById("errormsg").innerText=" FOC value not more than Actual FOC - "+focval;
            		
            		
            		 
            	   $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "foc",focval);
            	  
            		}
                  	else
                  		{
                  		 $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "foc",foc);
                  		}
            	
                  	
                  	if($('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "rdtype")=="PIV")
                  	{
                  	
                	var saveqty=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "saveqty");	
           	        
                 	 
                    var pqtys=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "pqty");
                    
                    var mainquty=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "mainqty");
                    
                    
                   // alert()
                    
        
              // alert(parseFloat(mainquty)==(parseFloat(saveqty)+parseFloat(pqtys)));
                  	if(parseFloat(mainquty)==(parseFloat(saveqty)+parseFloat(pqtys)))
            		{
                  		 
                  	 
                  		
            		document.getElementById("errormsg").innerText="Total FOC of "+focval+"  must be returned ";
            		
            		
            		 
            	   $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "foc",focval);
            	   
            	   return 0;
            	  
            		}  
                  	
                  	}
            	
                  	
                  	
                  	
                  	
        		}
       			
   		    	
   		    	} */
   		   
           		if(datafield=="qty")
           		    {
           			 
           			if(parseInt($('#datas1').val())==0) // this for prd search in request not imported case qty not set
           			
           				{
           				
           				//alert("1");
           				return 0;
           				}
           			
                	if(document.getElementById("reftype").value=="PIV")
                		{
                	
            
           			
           			
                		var qutval=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "qutval");	
               	        
                      	 
                        var quty=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
                     
                        
                        
                        
                        	if(quty>qutval)
                        		{
                        		document.getElementById("errormsg").innerText=" Qty value not more than Actual Qty - "+qutval;
                        		
                        		
                        		qty=qutval;
                        	   $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "qty",qutval);
                        	  
                        		}
                        	
                        	
                        	
                        	else
                        		{
                        		
                        		qty=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");		
                        		}
                 		 
                	
/*                          	if(($('#mode').val()=='E'))
                    		{ 
                    	
                        
                         		
                         		
                        	
                     	var rqqty= qty;	
                     	var remqty= $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "pqty");	
                      	 
                      	 
                     	var blance=parseFloat(rqqty)+parseFloat(remqty); 
                     	
                     	 $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "saveqty",blance);
                     	 
                   
                     	 
                      	if($('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "rdtype")=="PIV")
                      	{
                     	 
                     	 
                     	var saveqty1=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "saveqty");	
               	        
                   	 
                      //  var pqtys=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "pqty");
                        
                        var mainquty=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "mainqty");
            
              
                      	if(parseFloat(mainquty)==(parseFloat(saveqty1)))
                		{
                      		 
                      		var focval=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "maxfoc");
                      		 if(parseFloat(focval)>0)
                     		{
                   			
                		  document.getElementById("errormsg").innerText="Total FOC of "+focval+"  must be returned ";
                		
                     		}
                		 
                	   $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "foc",focval);
                	   
                     		
                	  
                		}
                 		
                     	 
                      	}
                     	 
                    		}
                         	
                         	
                         	else
                         		{   */
                         		
                         	 
                         		
                         		 $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "saveqty",qty);
                         		 
                         		 
                         		 
                         		 
                         		 
                         		 
           /*                      	if($('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "rdtype")=="PIV")
                                  	{
                                 	 
                                 	 
                                  	var saveqty1=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "saveqty");	
                           	        
                               	 
                                   var pqtys=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "pqty");
                                    
                                    var mainquty=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "mainqty");
                        
                          
                                  	if(parseFloat(mainquty)==(parseFloat(saveqty1)+parseFloat(pqtys)))
                            		{
                                  		 
                                  		var focval=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "maxfoc");
                                  		 if(parseFloat(focval)>0)
                                  		{
                            		  document.getElementById("errormsg").innerText="Total FOC of "+focval+"  must be returned ";
                            		
                                  		}
                            		 
                            	   $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "foc",focval);
                            	   
                            	 
                            	  
                            		}  
                             		
                                 	 
                                  	}
                         		  */
                         		 
                         		 
                         		 
                         		 
                         		/*   }   */
                      
                     	 
                 		
                 		}  
           			
           			
           			
           			
           			
           			
           			
           			valchange(rowBoundIndex);
           		    }  
           		if(datafield=="unitprice")
       		    {
           	  	  /* if(document.getElementById('chkdiscount').checked) {
                		 
             			 
             		 
           	  	  } */
           		if(parseInt($('#datas1').val())==0)
           			
   				{
   				return 0;
   				}
   			
           	  	  
           			valchange(rowBoundIndex);
     
           			
           			
       		    }
      /*      	  if(document.getElementById('chkdiscount').checked) {
           		funcalcu();
           		
           	  }else{ */
		           		if(datafield=="discount")
		       		    {
		           			
		           			if(parseInt($('#datas1').val())==0)
		               			
		       				{
		       				return 0;
		       				}
		           			
		           		var	 totals=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
		           		
		           		var discounts=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "discount");
		           			
		           		var	discper=(100/parseFloat(totals))*parseFloat(discounts);
		           		
		           	 
		           			
		           			$('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "discper",discper);
		           			valchange(rowBoundIndex);
		  				
		       		    }
		           		
		           		
		           		
		           		if(datafield="discper")
		           			
		           			
		           			
		           			{
		           			
		           			if(parseInt($('#datas1').val())==0)
		               			
		       				{
		       				return 0;
		       				}
		           	/* 		if(datafield=='dis'){
		                    	discper=(100/parseFloat(total))*parseFloat(discount);
		                    	}
		                 if(datafield=='discper'){
		                    	discount=(parseFloat(total)*parseFloat(discper))/100;
		                    	}
		           			 */
		           			
		           			var	 totals=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
				           		
				           		var discper=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "discper");
				           	var	discounts=(parseFloat(totals)*parseFloat(discper))/100;
		           			 
		           		$('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "discount",discounts);
		           			 
		           			 
		           			 
		           			
		           			//valchange(rowBoundIndex);
		           			}
           		/* } */
           	  
           	
           		
         	 
		        
           	  
           	  
           		 
           		});
           
           
           
           var applyFilter = function (datafield,value) {
               
               var filtertype = 'stringfilter';
             
             
               if (datafield == 'part_no' || datafield == 'productname') filtertype = 'stringfilter';
               var filtergroup = new $.jqx.filter();
        
                   var filter_or_operator = 1;

                   var filtervalue = value;
   	            var filtercondition = 'starts_with';
                   
                   var filter = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
                   filtergroup.addfilter(filter_or_operator, filter);
              
               
               if (datafield == 'part_no') 
               	{
              
               $("#prosearch").jqxGrid('addfilter', 'part_no' , filtergroup);
             // document.getElementById("part_no").focus();
               	}
               else  if (datafield == 'productname') 
           	         {
                   
                   $("#prosearch").jqxGrid('addfilter', 'productname' , filtergroup);
                  // document.getElementById("productname").focus();
                   	}
               
               
          
               $("#prosearch").jqxGrid('applyfilters');
               
               
               
       
           }
      /*     $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
           // create context menu
              var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
              $("#serviecGrid").on('contextmenu', function () {
                  return false;
              });
              
           $("#Menu").on('itemclick', function (event) {
           	   var args = event.args;
                  var rowindex = $("#serviecGrid").jqxGrid('getselectedrowindex');
                  if ($.trim($(args).text()) == "Edit Selected Row") {
                      editrow = rowindex;
                      var offset = $("#serviecGrid").offset();
                      $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                      // get the clicked row's data and initialize the input fields.
                      var dataRecord = $("#serviecGrid").jqxGrid('getrowdata', editrow);
                      // show the popup window.
                      $("#popupWindow").jqxWindow('show');
                  }
                  else {
                      var rowid = $("#serviecGrid").jqxGrid('getrowid', rowindex);
                      $("#serviecGrid").jqxGrid('deleterow', rowid);
                      
                      var summaryData= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
		       		  
	                   //document.getElementById("productTotal").value=summaryData1.sum.replace(/,/g,'');
	              document.getElementById("netTotaldown").value=summaryData.sum.replace(/,/g,'');
	        
	             
	        	  
	              
	   	            var summaryData1= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true); 
	        		   
		               document.getElementById("productTotal").value=summaryData1.sum.replace(/,/g,'');
		               
		               var summaryData2= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'discount', ['sum'],true);
		        		   
	   	               document.getElementById("prddiscount").value=summaryData2.sum.replace(/,/g,'');
	   	               
	           		//tttttt
	           		
	 	        	  
		         	   	var summaryData10= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
		                
		          	   	var aa1=summaryData10.sum.replace(/,/g,'');
		          	   	
		 
		          	 
		          	funRoundAmt4(aa1,"st");
		        	 funRoundAmt4(aa1,"taxtotal");
		        	  funcalutax();
                  }
              });
              
              $("#serviecGrid").on('rowclick', function (event) {
                  if (event.args.rightclick) {
       		   if(document.getElementById("mode").value=="A"){
       			   
                      $("#serviecGrid").jqxGrid('selectrow', event.args.rowindex);
                      var scrollTop = $(window).scrollTop();
                      var scrollLeft = $(window).scrollLeft();
                      contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                      return false;
                  }
       		   }
              });    */
          
        });
        
        
        
        function chkfoc()
        {
         
    	   var x=new XMLHttpRequest();
    	   x.onreadystatechange=function(){
    	   if (x.readyState==4 && x.status==200)
    	    {
    	      var items= x.responseText.trim();
    	     
    	      if(parseInt(items)>0)
    	       {
    	     
    	    	  
    	    	  $('#serviecGrid').jqxGrid('showcolumn', 'foc');
    	    
    	    	  
    	    	  
    	        }
    	          else
    	      {
    	      
    	        	  $('#serviecGrid').jqxGrid('hidecolumn', 'foc');
    	      
    	      }
    	      
    	       }}
    	   x.open("GET","checkfoc.jsp?",true);
    		x.send();
    	 
    	      
    	        
        	
        }
        function chkbrand()
        {
         
    	   var x=new XMLHttpRequest();
    	   x.onreadystatechange=function(){
    	   if (x.readyState==4 && x.status==200)
    	    {
    	      var items= x.responseText.trim();
    	     
    	      if(parseInt(items)>0)
    	       {
    	     
    	    	  
    	    	  $('#serviecGrid').jqxGrid('showcolumn', 'brandname');
    	    
    	    	  
    	    	  
    	        }
    	          else
    	      {
    	      
    	        	  $('#serviecGrid').jqxGrid('hidecolumn', 'brandname');
    	      
    	      }
    	      
    	       }}
    	   x.open("GET","checkbrand.jsp?",true);
    		x.send();
    	 
    	      
    	        
        	
        }
    	 
        function chktax()
        {
         
           var x=new XMLHttpRequest();
           x.onreadystatechange=function(){
           if (x.readyState==4 && x.status==200)
            {
              var items= x.responseText.trim();
             
              if(parseInt(items)>0)
               {
            	 
            	  
            	  $('#tax').hide();
            	  $('#billname').show();
            	  $('#cmbbilltype').show();
            	  $('#serviecGrid').jqxGrid('showcolumn', 'taxper');
            	  $('#serviecGrid').jqxGrid('showcolumn', 'taxamount');
            	  $('#serviecGrid').jqxGrid('showcolumn', 'taxperamt');
            
            	  
            	  
                }
                  else
              {
                	  $('#tax').hide();
                	  $('#billname').hide();
                	  $('#cmbbilltype').hide();
                	  $('#serviecGrid').jqxGrid('hidecolumn', 'taxper');
                	  $('#serviecGrid').jqxGrid('hidecolumn', 'taxamount');
                	  $('#serviecGrid').jqxGrid('hidecolumn', 'taxperamt');
              
              }
              
               }}
           x.open("GET","checktax.jsp?",true);
        	x.send();
         
              
                
        	
        }
        function chkproductconfig()
        {
           var x=new XMLHttpRequest();
           x.onreadystatechange=function(){
           if (x.readyState==4 && x.status==200)
            {
              var items= x.responseText.trim();
              if(parseInt(items)>0)
               {
            	   document.getElementById("productchk").value=1;
            	   $('#serviecGrid').jqxGrid('setcolumnproperty','proname','editable',false);
            	   $('#serviecGrid').jqxGrid('setcolumnproperty','brandname','editable',false);
               } 
               else
               {
                	document.getElementById("productchk").value=0; 
                	$('#serviecGrid').jqxGrid('setcolumnproperty','proname','editable',true);
               	   	$('#serviecGrid').jqxGrid('setcolumnproperty','brandname','editable',true);
               }
             }
          }
          x.open("GET","checkproductconfig.jsp?",true);
          x.send();
        }
    </script>

 <div id="serviecGrid"></div>
   <!--  <div id='jqxWidget'>
   <div id="serviecGrid"></div>
    <div id="popupWindow">
 
 <div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>   -->

<input type="hidden" id="rowindex">
   <input type="hidden" id="datas1"/>  

   <input type="hidden" id="datas"/>     <!--   FOR DOUBLE CLICK -->
