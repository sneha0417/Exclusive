  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.procurement.purchase.purchaseorder.ClspurchaseorderDAO"%>
<% ClspurchaseorderDAO purchaseorderDAO = new ClspurchaseorderDAO(); %> 

<%
String purdoc=request.getParameter("purdoc")==null?"0":request.getParameter("purdoc");
String reqdoc=request.getParameter("reqdoc")==null?"0":request.getParameter("reqdoc");
String chk=request.getParameter("chk")==null?"NA":request.getParameter("chk");
String from=request.getParameter("from")==null?"0":request.getParameter("from");
String reftype=request.getParameter("reftype")==null?"NA":request.getParameter("reftype");
String cmbreftype=request.getParameter("cmbreftype")==null?"NA":request.getParameter("cmbreftype");
String reqmasterdocno=request.getParameter("reqmasterdocno")==null?"0":request.getParameter("reqmasterdocno");


String acno=request.getParameter("acno")==null?"0":request.getParameter("acno");


String dates=request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
String cmbbilltype=request.getParameter("cmbbilltype")==null?"0":request.getParameter("cmbbilltype").trim();



String prcharrays=request.getParameter("prcharray")==null?"0":request.getParameter("prcharray");
String modebprfs=request.getParameter("modebprf")==null?"0":request.getParameter("modebprf");
String tempdocno=request.getParameter("tempdocno")==null?"0":request.getParameter("tempdocno").trim();

%>
  <style type="text/css">
  .advanceClass
  {
      
     background-color: #ffdead;     
      	
  }
  .yellowClass
        {
        
       
       background-color: #ffc0cb; 
        
        }
</style>


<script type="text/javascript">
var modebprf='<%=modebprfs%>';
var descdata1;
var temp2='<%=chk%>';
var temp='<%=purdoc%>';
var tempdocnos='<%=tempdocno%>';
 
if(temp2!='NA')
{

	descdata1='<%=purchaseorderDAO.reqgridreload(session,reqdoc,from,cmbreftype,acno,dates,cmbbilltype)%>';  
 
}


else if(temp>0)
{
	 
	descdata1='<%=purchaseorderDAO.maingridreload(purdoc,reftype,reqmasterdocno)%>';  

}
else if(tempdocnos>0)
{
 
	descdata1='<%=purchaseorderDAO.reloadsearchProduct(session,"1",dates,tempdocno)%>';  

}
else
 
{   
	descdata1;

 } 


        $(document).ready(function () { 
        	chkbrand();
        	chktax();
        	 chklastpurchase();
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
         		          
         		         	if ($("#mode").val() == "E") {    
         		   	  var clstatus= $('#serviecGrid').jqxGrid('getcellvalue', row, "clstatus");
     		          if(parseInt(clstatus)==1)
     		  		{
     		  		
     		  		return "advanceClass";
     		  	
     		  	      }  
     		                    
         		       	} 
						if ($("#mode").val() == "view") {    
         	         		   	  var clstatus= $('#serviecGrid').jqxGrid('getcellvalue', row, "clstatus");
         	     		          if(parseInt(clstatus)==1)
         	     		  		{
         	     		  		
         	     		  		return "advanceClass";
         	     		  	
         	     		  	      } 
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
     						{name : 'prddesc', type: 'string'    },
     					
     						
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
                    		
                    		 {name : 'clstatus', type: 'int'  }, 
                    			{name : 'unitprice1', type: 'string'  }, 
         						
         						{name : 'disper1', type: 'string'  },
         						{name : 'brandname', type: 'string'  },
         						
         						
           					 {name : 'taxper', type: 'number'  },  
           					 {name : 'taxamount', type: 'number'  },
           					{name : 'taxperamt', type: 'number'  },
           				  {name : 'taxdocno', type: 'string'    },
         						
                 ],
              
                 localdata: descdata1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

    $("#serviecGrid").on("bindingcomplete", function (event) { 
    			
    			
                if($('#mode').val()=="A"){
       
              if($('#reftype').val()=='PR' || $('#reftype').val()=='SOR'  ||  $('#reftype').val()=='RFQ' ){
            	
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
	                			  $('#serviecGrid').jqxGrid('setcellvalue', i, "taxamount",nettotal);
	                			  }
	                		 
	             	                         }
                                    }
                               } 
         	         
     
    			
    			
    		}); 
            
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
               
                editmode: 'selectedcell',
                selectionmode: 'singlecell',
                pagermode: 'default',
                columnsresize:true,
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
                	
                	
                	

                	  var cell2 = $('#serviecGrid').jqxGrid('getselectedcell');
                    	if (cell2 != undefined && cell2.datafield == 'unitprice' &&   document.getElementById("puchasechk").value == 1) {
                       	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                       	if (key == 114) { 
                           	var psrno= $('#serviecGrid').jqxGrid('getcellvalue',  cell2.rowindex, "psrno");
                           	if(parseInt(psrno)>0)
                           		{
                           	      document.getElementById("rowindex").value =  cell2.rowindex;  
                            	  $('#serviecGrid').jqxGrid('clearselection');
                            	  priceSearchContent('purchasepriceSearch.jsp?rowindex='+document.getElementById("rowindex").value+"&psrno="+psrno);
                       	
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
                      
	             	 if(document.getElementById("reftype").value=="RFQ" || document.getElementById("reftype").value=="SOR")
	                	{
	            
	   	               	 var rows = $("#prosearch").jqxGrid('getrows');  
	                	  
	   	     
	   	              
	   	              
	                    var unitprice=rows[0].unitprice;
	   	              
	   	                var prdid=rows[0].doc_no;
	   	                var disper=rows[0].discper;
	   	   
	   	          
	              	  
		  	            		var rows1 = $("#serviecGrid").jqxGrid('getrows');
		  	          	    var aa=0;
		  	          	    for(var i=0;i<rows1.length;i++){
		  	          	 
		  	          	    	
		  	          	    	 
		  	          		   if(parseInt(rows1[i].prodoc)==parseInt(prdid))
		  	          			   {
		  	          			  
		  	           		   if(parseFloat(rows1[i].unitprice)==parseFloat(unitprice))
		  	           			  {
		  	           		 
		  	           
		  	           
		  	           		   if(parseFloat(rows1[i].discper)==parseFloat(disper))
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
 	      				 if(parseInt(document.getElementById("multimethod").value)==1)
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
  	               
  	             $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "brandname" ,rows[0].brandname);
  	               

 		  	      $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "taxper" ,rows[0].taxper);
 	  		  	   $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "taxdocno" ,rows[0].taxdocno);
 	               
  	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
  	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "productname" ,rows[0].productname);
  	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,	rows[0].doc_no);
  	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
  	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,rows[0].munit);
  	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno );
  	                
  	              $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,rows[0].specid );
  	                
  	                if(document.getElementById("reftype").value!="DIR")
  	                	{
  	            	  $('#datas1').val(0);
  	              	$('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "qty" ,rows[0].qty);
  	                	
  	                  $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "qutval" ,rows[0].qutval);
  	                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "pqty" ,rows[0].pqty);
  	                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "saveqty" ,rows[0].saveqty);

  	  		  	      $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "taxper" ,rows[0].taxper);
  	  	                 
  	                 
  	               if(document.getElementById("reftype").value=="SOR" || document.getElementById("reftype").value=="RFQ")
  	            	   {
  	            	   
  	            	   
  	            	    $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unitprice" ,rows[0].unitprice);
  	            	    $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "total" ,rows[0].total);
    	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "discper" ,rows[0].discper);
    	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "discount" ,rows[0].discount);
    	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "nettotal" ,rows[0].nettotal);
    	                
    	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unitprice1" ,rows[0].unitprice);
    	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "disper1" ,rows[0].discper);
  	            	   
  	          /*   	   
                  	 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unitprice" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice"));
                     $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "discper" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "discper"));
                     $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "discount" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "discount"));
                     $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "nettotal" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "nettotal"));
                     $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "total" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "total"));
                     
                     
                     $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "discper1" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "discper"));
                     $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unitprice1" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice"));
                	  */
  	            	   
  	            	   
  	            	   }
  	          
  	                 
  	         	  $('#datas1').val(1);
  	          
  	                	
  	                	
  	                	}
  	                
  	                
  	            
  	         //  $("#serviecGrid").jqxGrid('selectcell',rowindex1, "qty");
  	         
  	        //  $("#serviecGrid").jqxGrid('begincelledit', rowindex1, 'qty');
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
       
            	if(parseInt(document.getElementById("productchk").value)==0){
       		   document.getElementById("gridtext").focus();
            	}
            }
            if (cell4 != undefined && cell4.datafield == 'productname') {
    	        
            	if(parseInt(document.getElementById("productchk").value)==0){
       		   document.getElementById("gridtext1").focus();
            	}
              }
              
  	                }
  	                
  	                
  	                
                   } 
       		 
                	
                	
                	
              /*    var rows = $('#serviecGrid').jqxGrid('getrows');
                  var rowlength= rows.length;
                    var cell = $('#serviecGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'unitprice' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key ==9) {                                                        
                            var commit = $("#serviecGrid").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    } */
                   
                    
                
                    
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
                          	  
                            	/* cellbeginedit: function (row) {
                                    if (document.getElementById("reftype").value=="PR")
                             {
                                  return false;
                             } 
                                    
                            	
                            	}, */
                            	
                            	
                            	
  							    createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							     
  							         editor.html('<input type="text" id="part_no" name="part_no" style="width:100%;height:99%;"   />' ); 
  							   
  							        
  							    },  
  							 
                           
  							 
							}, 
							{ text: 'Product Name', datafield: 'productname' , width: '25%'  ,cellclassname: cellclassname ,columntype: 'custom',
								

  								createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							       
  							         editor.html('<input type="text" id="productname" name="productname" style="width:100%;height:99%;"   />' ); 
  							     
  							        
  							    },  
							
							}, 
							{text: 'Brand Name', datafield: 'brandname', width: '10%' , editable:false,cellclassname: cellclassname  },
							
							
							{text: 'Description', datafield: 'prddesc', width: '10%'  ,cellclassname: cellclassname  },
							
							
							
							{ text: 'Unit', datafield: 'unit', width: '6%',cellclassname: cellclassname, editable:false  }, 
							{ text: 'Quantity', datafield: 'qty', width: '5%' ,cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2'},
							{ text: 'Unit Price', datafield: 'unitprice', width: '9%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2',cellclassname: cellclassname },
							{ text: 'Total', datafield: 'total', width: '9%' ,editable: false,cellsalign: 'right', align:'right',cellsformat:'d2' ,cellclassname: cellclassname},
							{text: 'Discount %', datafield: 'discper', width: '7%' ,cellsformat:'d2',cellsalign: 'right', align:'right',cellclassname: cellclassname},
							{ text: 'Discount', datafield: 'discount', width: '8%',cellsalign: 'right', align:'right',cellsformat:'d2' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname},
							{ text: 'Net Amount', datafield: 'nettotal', width: '9%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname},
							{text: 'prodoc', datafield: 'prodoc', width: '10%' ,hidden:true},
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',hidden:true  }, 
							{text: 'psrno', datafield: 'psrno', width: '10%',hidden:true },
							{text: 'qutval', datafield: 'qutval', width: '10%' ,cellsformat:'d2'   ,hidden:true  },
							{text: 'pqty', datafield: 'pqty', width: '9%',cellsformat:'d2'  ,hidden:true  },
							{text: 'saveqty', datafield: 'saveqty', width: '10%' ,cellsformat:'d2'   ,hidden:true },
						 
							{text: 'pid', datafield: 'proid', width: '10%' ,hidden:true  }, 
  							{text: 'pname', datafield: 'proname', width: '10%'  ,hidden:true}, 
							
							 
							{text: 'checktype', datafield: 'checktype', width: '10%'  ,hidden:true},    
							{text: 'specid', datafield: 'specid', width: '10%' ,hidden:true  },
							
							{text: 'clstatus', datafield: 'clstatus', width: '10%'   ,hidden:true   },
							{text: 'unitprice1', datafield: 'unitprice1', width: '10%' ,hidden:true  },
							{text: 'disper1', datafield: 'disper1', width: '10%',hidden:true  },
							
							
	 
							
							{ text: 'Tax %', datafield: 'taxper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false},
							{ text: 'Tax Amount', datafield: 'taxperamt', width: '5%', cellsformat: 'd2'  , cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring },
							
							{ text: 'Total Amount', datafield: 'taxamount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
							   {text: 'taxdocno', datafield: 'taxdocno', width: '10%'  ,hidden:true  },
								
							
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
           
           
           
           if(document.getElementById("reftype").value=="SOR" || document.getElementById("reftype").value=="RFQ")
		{
	
       
       
       var summaryData1= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
		    var summaryData= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
		  
          document.getElementById("productTotal").value=summaryData1.sum.replace(/,/g,'');
     document.getElementById("netTotaldown").value=summaryData.sum.replace(/,/g,'');
		 var summaryData3= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'discount', ['sum'],true);
  	   document.getElementById("prddiscount").value=summaryData3.sum.replace(/,/g,'');
  	  var ordertotal="0";
      var nettotalval="0";
      var exptotalval="0";
          
          if(document.getElementById("nettotal").value!="" && !(document.getElementById("nettotal").value==null) && !(document.getElementById("nettotal").value=="undefiend")) 
       	   {
       	          
       nettotalval=parseFloat(document.getElementById("nettotal").value);
       	   }
          
          
          
    
   
         ordertotal=parseFloat(nettotalval)+parseFloat(exptotalval)+parseFloat(document.getElementById("netTotaldown").value);
       	   
    
	funRoundAmt(ordertotal,"orderValue");
          
	
	
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
		  
           

           $('#serviecGrid').on('cellbeginedit', function (event) {
        	  
      // 	document.getElementById("errormsg").innerText="";
       	
        var rowindex2 = event.args.rowindex;
        var qtyvalidate=$('#serviecGrid').jqxGrid('getcellvalue', rowindex2, "qty");
        
        if(parseFloat(qtyvalidate)<=0)
        	{

    		document.getElementById("errormsg").innerText="Quantity Is Zero ";
    		////$('#serviecGrid').jqxGrid({ editable: false}); 
    		return 0;
        	
        	}
    
       	
        $('#datas').val(0);
    	var columnindex1=event.args.datafield;

    	// alert("in "+columnindex1);
    	  if(columnindex1 == "productid")
    		  { 
    		 
      	    	/* if(document.getElementById("reftype").value=="PR")
        		{
    	    		
    	    		 var rowindextemp = event.args.rowindex;
			    	    document.getElementById("rowindex").value = rowindextemp;  
    	    	 
			    	    var reqmasterdocno = document.getElementById("reqmasterdocno").value;  
			    		 reqproductSearchContent('refproductSearch.jsp?reqmasterdocno='+reqmasterdocno+'');
        		}
    	    	else
    	    		{   */
    		  
    	    		
    	    		  var accdocno = document.getElementById("accdocno").value;    
    	    		  var reqmasterdocno = document.getElementById("reqmasterdocno").value;    
    	    		  var dates=document.getElementById("nipurchaseorderdate").value;
                		 
                		 
                		 var cmbbilltype=document.getElementById("cmbbilltype").value;     	
    	    		  
                		 if(parseInt(document.getElementById("productchk").value)==0)
           			  {
           			  $('#serviecGrid').jqxGrid('setcolumnproperty','productid','editable',true);
                 	   	$('#serviecGrid').jqxGrid('setcolumnproperty','productname','editable',true);
						        	 productSearchContent('productSearch.jsp?reqmasterdocno='+reqmasterdocno+'&dtype='+document.getElementById("reftype").value+'&accdocno='+accdocno+"&dates="+dates+"&cmbbilltype="+cmbbilltype+"&id=1");
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
       
    		  /*   }    */
    	  
    	  
    	if(columnindex1 == "productname")
		  { 
    		  if(document.getElementById("errormsg").innerText!="")
      		 {
         		   
      		 return 0;
      		 }	
    		 
    		  
/*     	if(document.getElementById("reftype").value=="PR")
    		{
	    		
	    		 var rowindextemp = event.args.rowindex;
		    	    document.getElementById("rowindex").value = rowindextemp;  
		    	    var reqmasterdocno = document.getElementById("reqmasterdocno").value;  
	    		 reqproductSearchContent('refproductSearch.jsp?reqmasterdocno='+reqmasterdocno);
    		}
	    	else
	    		{  */
	    		
	    		
	    		  var accdocno = document.getElementById("accdocno").value;  
	    		 var reqmasterdocno = document.getElementById("reqmasterdocno").value;  
	    		 
	    		  var dates=document.getElementById("nipurchaseorderdate").value;
         	      var cmbbilltype=document.getElementById("cmbbilltype").value;     	
         	     if(parseInt(document.getElementById("productchk").value)==0)
   			  {
           		  $('#serviecGrid').jqxGrid('setcolumnproperty','productid','editable',true);
             	   	$('#serviecGrid').jqxGrid('setcolumnproperty','productname','editable',true);
	    		 
	    		 productSearchContent('productSearch.jsp?reqmasterdocno='+reqmasterdocno+'&dtype='+document.getElementById("reftype").value+'&accdocno='+accdocno+"&dates="+dates+"&cmbbilltype="+cmbbilltype+"&id=1");
   			  }			
	    		 var rowindextemp = event.args.rowindex;
							    document.getElementById("rowindex").value = rowindextemp;  
							    
							      var temp= $('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "productname"); 
						        
							      
						        // alert(temp);
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
 
		  /*   }    */
      
        
        
        
        
        
        
        
        
        
           
           });

         $('#serviecGrid').on('celldoubleclick', function (event) {
        	 
        	 
        	 
        	 
         	var columnindex1=event.args.datafield;
         	 
             	  if(columnindex1 == "unitprice" && document.getElementById("puchasechk").value == 1)
             		  { 
                     
             	 var rowindextemp = event.args.rowindex;
             	 
             	var psrno= $('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "psrno");
             	
             	if(parseInt(psrno)>0)
             		{
             	   document.getElementById("rowindex").value = rowindextemp;  
              	  $('#serviecGrid').jqxGrid('clearselection');
              	 priceSearchContent('purchasepriceSearch.jsp?rowindex='+document.getElementById("rowindex").value+"&psrno="+psrno);
             		}
             	  	
             		   } 
             	 var rowindex2 = event.args.rowindex;
                 var qtyvalidate=$('#serviecGrid').jqxGrid('getcellvalue', rowindex2, "qty");
                 
                 if(parseFloat(qtyvalidate)<=0)
                 	{

             		document.getElementById("errormsg").innerText="Quantity Is Zero ";
             		////$('#serviecGrid').jqxGrid({ editable: false}); 
             		return 0;
                 	
                 	}
             
                	
                 $('#datas').val(0);
             	var columnindex1=event.args.datafield;

             	// alert("in "+columnindex1);
             	  if(columnindex1 == "productid")
             		  { 
             		 
               	    	/* if(document.getElementById("reftype").value=="PR")
                 		{
             	    		
             	    		 var rowindextemp = event.args.rowindex;
         			    	    document.getElementById("rowindex").value = rowindextemp;  
             	    	 
         			    	    var reqmasterdocno = document.getElementById("reqmasterdocno").value;  
         			    		 reqproductSearchContent('refproductSearch.jsp?reqmasterdocno='+reqmasterdocno+'');
                 		}
             	    	else
             	    		{   */
             		  
             	    		
             	    		  var accdocno = document.getElementById("accdocno").value;    
             	    		  var reqmasterdocno = document.getElementById("reqmasterdocno").value;    
             	    		  var dates=document.getElementById("nipurchaseorderdate").value;
                         		 
                         		 
                         		 var cmbbilltype=document.getElementById("cmbbilltype").value;     	
             	    		  
                         		 if(parseInt(document.getElementById("productchk").value)==1)
                    			  {
                    			  $('#serviecGrid').jqxGrid('setcolumnproperty','productid','editable',false);
                          	   	$('#serviecGrid').jqxGrid('setcolumnproperty','productname','editable',false);
         						        	 productSearchContent('productMasterSearch.jsp?reqmasterdocno='+reqmasterdocno+'&dtype='+document.getElementById("reftype").value+'&accdocno='+accdocno+"&dates="+dates+"&cmbbilltype="+cmbbilltype);
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
                
             		  /*   }    */
             	  
             	  
             	if(columnindex1 == "productname")
         		  { 
             		  if(document.getElementById("errormsg").innerText!="")
               		 {
                  		   
               		 return 0;
               		 }	
             		 
             		  
         /*     	if(document.getElementById("reftype").value=="PR")
             		{
         	    		
         	    		 var rowindextemp = event.args.rowindex;
         		    	    document.getElementById("rowindex").value = rowindextemp;  
         		    	    var reqmasterdocno = document.getElementById("reqmasterdocno").value;  
         	    		 reqproductSearchContent('refproductSearch.jsp?reqmasterdocno='+reqmasterdocno);
             		}
         	    	else
         	    		{  */
         	    		
         	    		
         	    		  var accdocno = document.getElementById("accdocno").value;  
         	    		 var reqmasterdocno = document.getElementById("reqmasterdocno").value;  
         	    		 
         	    		  var dates=document.getElementById("nipurchaseorderdate").value;
                  	      var cmbbilltype=document.getElementById("cmbbilltype").value;     	
                  	     if(parseInt(document.getElementById("productchk").value)==1)
            			  {
                    		  $('#serviecGrid').jqxGrid('setcolumnproperty','productid','editable',true);
                      	   	$('#serviecGrid').jqxGrid('setcolumnproperty','productname','editable',true);
         	    		 
         	    		 productSearchContent('productMasterSearch.jsp?reqmasterdocno='+reqmasterdocno+'&dtype='+document.getElementById("reftype").value+'&accdocno='+accdocno+"&dates="+dates+"&cmbbilltype="+cmbbilltype);
            			  }			
         	    		 var rowindextemp = event.args.rowindex;
         							    document.getElementById("rowindex").value = rowindextemp;  
         							    
         							      var temp= $('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "productname"); 
         						        
         							      
         						        // alert(temp);
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
          
         		  /*   }    */
               
             	 
             	
             	  
                 });
            
           function valchange(rowBoundIndex)
           {
           	
           	  
            	//  $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "discper", 12); 
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
   	                    var summaryData1= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
   	        		    var summaryData= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
   	        		  
   	                    document.getElementById("productTotal").value=summaryData1.sum.replace(/,/g,'');
   	                    
   	                 
   	                    
   	               document.getElementById("netTotaldown").value=summaryData.sum.replace(/,/g,'');
   	         
   	               
   	         	  if(document.getElementById('chkdiscount').checked) {
   	         		 var summaryData3= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'discount', ['sum'],true);
   	         		 
   	         		 if(document.getElementById("descountVal").value>0)
   	         			 {
   	         		   funRoundAmt(document.getElementById("descountVal").value,"descountVal");
   	         			 }
   	         		 else
   	         			 {
   	         			document.getElementById("descountVal").value=summaryData3.sum.replace(/,/g,'');
   	         			 }
   	         	 
   	         	    
   	         	 document.getElementById("prddiscount").value="";
   	         	   
   	         	   
   	         	  }
   	         	  
   	         	  else
   	         		  {
   	         		  
   	         		 var summaryData3= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'discount', ['sum'],true);
     	         	   document.getElementById("prddiscount").value=summaryData3.sum.replace(/,/g,'');
     	         	 document.getElementById("descountVal").value="";
   	         		  
   	         		  }
   	         	  
   	               
   	       /*          if(document.getElementById("nettotal").value!="" ||document.getElementById("nettotal").value==null || document.getElementById("nettotal").value=="undefiend") 
   	            	   {
   	               
   	            var aa=parseFloat(document.getElementById("netTotaldown").value)+parseFloat(document.getElementById("nettotal").value);
   	            	   }
   	               else
   	            	   {
   	            	  var aa=document.getElementById("netTotaldown").value;
   	            	   }
         */  
                
            	//funRoundAmt(aa,"orderValue");
         
         
         
       	  var ordertotal="0";
       	  
       	  var nettotalval="0";
       	  
       
             
             if(document.getElementById("nettotal").value!="" && !(document.getElementById("nettotal").value==null) && !(document.getElementById("nettotal").value=="undefiend")) 
          	   {
          	   
        
          nettotalval=parseFloat(document.getElementById("nettotal").value);
          	   }
             
            
            ordertotal=parseFloat(nettotalval)+parseFloat(document.getElementById("netTotaldown").value);
          	   
       
            	funRoundAmt(ordertotal,"orderValue");
          
            	var summaryData10= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
                
              	var aa1=summaryData10.sum.replace(/,/g,'');
          	   	
             	 
              
            funRoundAmt4(aa1,"st");
             funRoundAmt4(aa1,"taxtotal");
            	// funcalutax();       //1   
   	               
   
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
      		  }
              	  
   		    
   			if(datafield=="nettotal")
   		    {
           		 
                   if($('#datas1').val()==0)
                	   {
				                   var summaryData1= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
				       		       var summaryData= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
				       		  
				                   document.getElementById("productTotal").value=summaryData1.sum.replace(/,/g,'');
				              document.getElementById("netTotaldown").value=summaryData.sum.replace(/,/g,'');
				        
				              
				        	  if(document.getElementById('chkdiscount').checked) {
				        		 
				        		  
				        		 var summaryData3= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'discount', ['sum'],true);
				        	  // document.getElementById("descountVal").value=summaryData3.sum.replace(/,/g,'');
				        	  
				        	   if(document.getElementById("descountVal").value>0)
   	         			 {
   	         			 
				        		   
				        		   funRoundAmt(document.getElementById("descountVal").value,"descountVal");
				        		   
   	         			 }
   	         		 else
   	         			 {
   	         			document.getElementById("descountVal").value=summaryData3.sum.replace(/,/g,'');
   	         			 }
				        	 document.getElementById("prddiscount").value="";
				        	   
				        	   
				        	  }
				        	  
				        	  else
				        		  {
				        		  
				        		 var summaryData3= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'discount', ['sum'],true);
					         	   document.getElementById("prddiscount").value=summaryData3.sum.replace(/,/g,'');
					         	 document.getElementById("descountVal").value="";
				        		  
				        		  }
				        	  
				        	  
				        	  var ordertotal="0";
			   	         	  
			   	         	  var nettotalval="0";
			   	         	  
			   	           var exptotalval="0";
			   	               
			   	               if(document.getElementById("nettotal").value!="" && !(document.getElementById("nettotal").value==null) && !(document.getElementById("nettotal").value=="undefiend")) 
			   	            	   {
			   	            	   
			   	          
			   	            nettotalval=parseFloat(document.getElementById("nettotal").value);
			   	            	   }
			   	               
			   	               
			   	  /*              
			   	            if(document.getElementById("expencenettotal").value!="" && !(document.getElementById("expencenettotal").value==null) && !(document.getElementById("expencenettotal").value=="undefiend")) 
			            	   {
			   	         
			   	             
			   	          exptotalval=parseFloat(document.getElementById("expencenettotal").value);
			            	   }
			               
			   	                */
			   	               
			   	               
			   	              
			   	              ordertotal=parseFloat(nettotalval)+parseFloat(exptotalval)+parseFloat(document.getElementById("netTotaldown").value);
			   	            	   
			                
			            	funRoundAmt(ordertotal,"orderValue");
				        	  
				        	  
 	 				var summaryData10= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
			                
			          	   	var aa1=summaryData10.sum.replace(/,/g,'');
			          	   	
			 
			          	 
			          	funRoundAmt4(aa1,"st");
			        	 funRoundAmt4(aa1,"taxtotal");
			        	 funcalutax(); //3
				        	  	  
				        	  
				           		
                	   }
                   
                   
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
   		    
   		    

   	   
   	  if(parseInt($('#datas').val())!=1)
   		  {
   	   
   		  if(modebprf!="a1"){
   	   if(datafield=="productid")
   		   {
   	   
   	$('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "productid" ,$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "proid"));
       //$('#sidesearchwndow').jqxWindow('close');
   		   }
   	   
   	   if(datafield=="productname")
   		   {
   		   	$('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "productname" ,$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "proname"));
              // $('#sidesearchwndow').jqxWindow('close');
   		   
   		   }
   		  }
   	   
   		  }
   		    
   		   
           		if(datafield=="qty")
           		    {
           			 
           			if(parseInt($('#datas1').val())==0) // this for prd search in request not imported case qty not set
           			
           				{
           				
           				 
           				return 0;
           				}
           			
                	if(document.getElementById("reftype").value!="DIR")
                		{
                	
            
           			
           			
                		var qutval=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "qutval");	
               	        
                      	 
                        var quty=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
                     
                        
                        
                        
                        	if(quty>qutval)
                        		{
                        		document.getElementById("errormsg").innerText=" Qty value not more than Actual Qty "+qutval;
                        		
                        		
                        		qty=qutval;
                        	   $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "qty",qutval);
                        	  
                        		}
                        	
                        	
                        	
                        	else
                        		{
                        		
                        		qty=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");		
                        		}
                 		 
                	
                         	if(($('#mode').val()=='E'))
                    		{ 
                    	
                        	
                   	    var rqqty= qty;	
                     	var remqty= $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "pqty");	
                      	 
                      	 
                     	var blance=parseFloat(rqqty)+parseFloat(remqty); 
                     	
                     	 $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "saveqty",blance);
                    		}
                         	
                         	
                         	else
                         		{  
                         		
                         	 
                         		
                         		 $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "saveqty",qty);
                         		  }  
                      
                     	 
                 		
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
           	  if(document.getElementById('chkdiscount').checked) {
           		//funcalcu();
           		//alert("1");
           		
           	  }else{
		           		if(datafield=="discount")
		       		    {
		           			
		           		var	 totals=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
		           		
		           		var discounts=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "discount");
		           			
		           		var	discper=(100/parseFloat(totals))*parseFloat(discounts);
		           		
		           	// $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "qty",qutval);
		           			
		           			$('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "discper",discper);
		           			valchange(rowBoundIndex);
		  				
		       		    }
		           		
		           		
		           		
		           		if(datafield="discper")
		           			
		           			
		           			
		           			{
		           			
		           			
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
		           		
		           		
		           		
		       
           		}
           	  

           	  
          	  if(datafield=="nettotal")
    		  {
           		  
           		  //alert("ASDAds");
           		  
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
         		
       
           		 
           		});
           
           
           
           var applyFilter = function (datafield,value) {
        	   if(parseInt($('#datas').val())!=1)
        		  {  
               var filtertype = 'stringfilter';
             
             
               if (datafield == 'part_no' || datafield == 'productname') filtertype = 'stringfilter';
               var filtergroup = new $.jqx.filter();
        
                   var filter_or_operator = 1;

                   var filtervalue = value;
   	            var filtercondition = 'contains';
                   
                   var filter = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
                   filtergroup.addfilter(filter_or_operator, filter);
              
               
               if (datafield == 'part_no') 
               	{
              
               $("#prosearch").jqxGrid('addfilter', 'part_no' , filtergroup);
            //   document.getElementById("part_no").focus();
               	}
               else  if (datafield == 'productname') 
           	         {
                   
                   $("#prosearch").jqxGrid('addfilter', 'productname' , filtergroup);
                 //  document.getElementById("productname").focus();
                   	}
               
               
          
               $("#prosearch").jqxGrid('applyfilters');
               
        		  }
               
       
           }
          
            
           
           
        $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
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
                  }
              });
              
              $("#serviecGrid").on('rowclick', function (event) {
                  if (event.args.rightclick) {
       		   if(document.getElementById("mode").value=="A" ){
                      $("#serviecGrid").jqxGrid('selectrow', event.args.rowindex);
                      var scrollTop = $(window).scrollTop();
                      var scrollLeft = $(window).scrollLeft();
                      contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                      return false;
                  }
       		   }
              });

			  
          
        });
        
        
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
            	 
            	  
            	  $('#taxsss').hide();
            	  $('#billname').show();
            	  $('#cmbbilltype').show();
            	  $('#serviecGrid').jqxGrid('showcolumn', 'taxper');
            	  $('#serviecGrid').jqxGrid('showcolumn', 'taxamount');
            	  $('#serviecGrid').jqxGrid('showcolumn', 'taxperamt');
            	  
            	  
                }
                  else
              {
                	  $('#taxsss').hide();
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
        
        
        
        
        function chklastpurchase()
        {
         
           var x=new XMLHttpRequest();
           x.onreadystatechange=function(){
           if (x.readyState==4 && x.status==200)
            {
              var items= x.responseText.trim();
             
              if(parseInt(items)>0)
               {
            	   document.getElementById("puchasechk").value=1;
            	  
            	  
                }
                  else
              {
                	   document.getElementById("puchasechk").value=0; 
              }
              
               }}
           x.open("GET","checklastpurchase.jsp?",true);
        	x.send();
         
              
                
        	
        } 
        if(modebprf=="a1")
    	{
        	
    	  var splt=prcharray.split(",");
    	 
    	 for(var i=0;i<splt.length;i++)
    	 {
    		 var data=splt[i].split("::");
    		 

			 /* 
				purchaseorderarray.push(psrno+"::"+unitdocno+"::"+productid+"::"+productname+"::"
						+brandname+"::"+unit+"::"+purorderqty+"::"+specid+"::");
    		 
    		  */
    		 
    		 var psrno=data[0].trim()=="undefined" || data[0].trim()=="NaN" || data[0].trim()==""|| data[0]==null?"0":data[0].trim();
		
    		var unitdocno=data[1].trim()=="undefined" || data[1].trim()=="NaN" || data[1].trim()==""|| data[1]==null?"0":data[1].trim();
    		var productid=data[2].trim()=="undefined" || data[2].trim()=="NaN" || data[2].trim()==""|| data[2]==null?"0":data[2].trim();
    		
    	 
				var productname=data[3].trim()=="undefined" || data[3].trim()=="NaN" || data[3].trim()==""|| data[3]==null?"0":data[3].trim();
				var brandname=data[4].trim()=="undefined" || data[4].trim()=="NaN" || data[4].trim()==""|| data[4]==null?"0":data[4].trim();
				var unit=data[5].trim()=="undefined" || data[5].trim()=="NaN" || data[5].trim()==""|| data[5]==null?"0":data[5].trim();
				var purqty=data[6].trim()=="undefined" || data[6].trim()=="NaN" || data[6].trim()==""|| data[6]==null?"0":data[6].trim();
				var specid=data[7].trim()=="undefined" || data[7].trim()=="NaN" || data[7].trim()==""|| data[7]==null?"0":data[7].trim();
 
				 
				 
				$("#serviecGrid").jqxGrid('addrow', null, {});
          	   $('#serviecGrid').jqxGrid('setcellvalue', i, "productid" ,productid);
          	    $('#serviecGrid').jqxGrid('setcellvalue', i, "productname" ,productname);
                $('#serviecGrid').jqxGrid('setcellvalue', i, "brandname" ,brandname);
    
                $('#serviecGrid').jqxGrid('setcellvalue', i, "unit" ,unit);
                $('#serviecGrid').jqxGrid('setcellvalue', i, "qty" ,purqty);
                $('#serviecGrid').jqxGrid('setcellvalue', i, "prodoc" ,psrno);
                $('#serviecGrid').jqxGrid('setcellvalue', i, "unitdocno" ,unitdocno);
                $('#serviecGrid').jqxGrid('setcellvalue', i, "psrno" ,psrno);
                $('#serviecGrid').jqxGrid('setcellvalue', i, "proid" ,productid);
                $('#serviecGrid').jqxGrid('setcellvalue', i, "proname" ,productname);
                $('#serviecGrid').jqxGrid('setcellvalue', i, "specid" ,specid);
    	 }
    	 
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
            	 
            	     $('#serviecGrid').jqxGrid('setcolumnproperty','productid','editable',false);
            	   	$('#serviecGrid').jqxGrid('setcolumnproperty','productname','editable',false);
            	   		
            	   } 
                
                  else
              {
                	   document.getElementById("productchk").value=0; 
                	   $('#serviecGrid').jqxGrid('setcolumnproperty','productid','editable',true);
               	   	$('#serviecGrid').jqxGrid('setcolumnproperty','productname','editable',true);
              }
              
               }}
           x.open("GET","checkproductconfig.jsp?",true);
        	x.send();

        	
        } 
      
    </script>
    <div id="serviecGrid"></div>
   <div id='jqxWidget'>
   <div id="serviecGrid"></div>
    <div id="popupWindow">
 
 <div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div> 
    
<!-- <div id="serviecGrid"></div> -->
<input type="hidden" id="rowindex">
   <input type="hidden" id="datas1"/>  

   <input type="hidden" id="datas"/>     <!--   FOR DOUBLE CLICK -->
   
   
   
