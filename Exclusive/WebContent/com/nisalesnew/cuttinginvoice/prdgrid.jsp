  <%@page import="com.nisalesnew.cuttinginvoice.ClsCuttingInvoiceDAO"%>
<% ClsCuttingInvoiceDAO  sDAO = new ClsCuttingInvoiceDAO(); 

String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");

String masterrefno=request.getParameter("masterrefno")==null?"0":request.getParameter("masterrefno");


 

%>
       <script type="text/javascript">
       
       var masterrefno='<%=masterrefno%>';
       var docno='<%=docno%>';
       var data1;
  if(masterrefno>0)
	  {
	  data1= '<%=sDAO.refreload(masterrefno)%>';
	  }
  else if(docno>0)
	  {
	  data1= '<%=sDAO.refreload(docno,"")%>';
	  }
			 

$(document).ready(function () {
	var list1 =['YES','NO'];
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
   	if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
	   {
		value=0.0;
	   }
	
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
     
	
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
   
                  
                     
                        {name : 'productid', type: 'String'  },
						{name : 'productname', type: 'string'  },
						{name : 'floor', type: 'String'  },
						{name : 'flatids',type:'string'},
						
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
						
	
						{name : 'polrate', type: 'number'},
						{name : 'polcharge', type: 'number'},
						{name : 'temp', type: 'String'},
						{name : 'amount', type: 'number'  },
						
						
						{name : 'psrno', type: 'string'  },
						{name : 'unit', type: 'string'  },
						{name : 'unitdocno', type: 'string'  },
						{name : 'specid', type: 'string'  },
						
						{name : 'proid', type: 'string'  },
						{name : 'proname', type: 'string'  },
						
						{name : 'bevcodename', type: 'string'  },
						{name : 'polcodename', type: 'string'  },
						
						 
						{name : 'refrow', type: 'string'  }, 
						{name : 'qtyval', type: 'number'  },
						
						
						
						
						
						
						  
						
						
						
					 
						
					
						
						],
				    localdata: data1,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    $("#prdGridID").on("bindingcomplete", function (event) { 
		
		
        if($('#mode').val()=="A"){

      if($('#rreftype').val()=='DLY'){
    	
     	 var rows = $("#prdGridID").jqxGrid('getrows');   

         	  for(var i=0;i<rows.length;i++){
         	   	 
         		  
         		 calculatedatagrid(i);
            		 
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
    
    
   
   
    
    $("#prdGridID").jqxGrid(
    {
        width: '100%',
        height: 300,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 21,
        selectionmode: 'singlecell',
        pagermode: 'default',
        disabled:true,
        editable:true ,
        columnsresize:true,
        
        handlekeyboardnavigation: function (event) {
     	   

        	 

          
     			 var cell1 = $('#prdGridID').jqxGrid('getselectedcell');
     		
     			 
             	 if (cell1 != undefined && cell1.datafield == 'bevcodename') {  
             		 
                     var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                     if (key == 114) {  
                  	    document.getElementById("rowindex").value = cell1.rowindex;   
                  	  $('#prdGridID').jqxGrid('clearselection');
                    	codeinfoSearchContent('bsearchcode.jsp?name=1');
                      	
      				           }
                     
                     
                     }
     			 
	 if (cell1 != undefined && cell1.datafield == 'polcodename') {  
             		 
                     var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                     if (key == 114) {  
                  	    document.getElementById("rowindex").value = cell1.rowindex;   
                      	  $('#prdGridID').jqxGrid('clearselection');
                      	  
                       	codeinfoSearchContent('bsearchcode.jsp?name=2');
                      	
      				           }
                     
                     
                     }
     			  
       	
        	
     		  
                  var cell4 = $('#prdGridID').jqxGrid('getselectedcell');
                 
                  
                  if (cell4 != undefined && (cell4.datafield == 'productid' || cell4.datafield == 'productname'  )) 
                  
                 {	 
                 	 document.getElementById("errormsg").innerText="";	 
                 
                 	 
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
	                       
                 
	                    if(document.getElementById("rreftype").value=="DLY")
		            	  {
		   	            	  
	   	               	 var rows = $("#prosearch").jqxGrid('getrows');  
	   	             
	            	
	                   var prodocs=rows[0].doc_no;
	            
	              	  
	            		var rows1 = $("#prdGridID").jqxGrid('getrows');
	          	    var aa=0;
	          	    for(var i=0;i<rows1.length;i++){
	  
	          	  
	   	          	  
	   	          		   if(parseInt(rows1[i].refrow)==parseInt(prodocs))
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
	          		  $('#sidesearchwndow').jqxWindow('close'); 
	          		   return 0;
	          		  
	          		   
	          		   }
	          	   else
	          		   {
	          		   
	          		   document.getElementById("errormsg").innerText="";
	          		   }
	          	   
	            	  
	            	  }
	            	  
	                	  
	                	   
	                	  
	     
	                	  
	                	   
	               	 var rows = $("#prosearch").jqxGrid('getrows');
	  		    
	                	
	                	   $('#prdGridID').jqxGrid('render');
	              	  var rowindex1 =$('#rowindex').val();
	               $('#prdGridID').jqxGrid('setcellvalue', rowindex1, "proid" ,rows[0].part_no);
	            
	               $('#prdGridID').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].productname);
	             
	 
	                $('#prdGridID').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
	                $('#prdGridID').jqxGrid('setcellvalue', rowindex1, "productname" ,rows[0].productname);
	              
	                $('#prdGridID').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
	                $('#prdGridID').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,rows[0].munit);
	                $('#prdGridID').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno );
	                $('#prdGridID').jqxGrid('setcellvalue', rowindex1, "specid" ,rows[0].specid );
	                
	                if(document.getElementById("rreftype").value=="DLY")
	            	  {
	                	
	                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "floor" ,rows[0].floor );
	                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "flatids" ,rows[0].flatids );
	                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "width" ,rows[0].width );
	                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "height" ,rows[0].height );
	                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "quantity" ,rows[0].quantity );
	                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "sqm" ,rows[0].sqm );
	                	
	                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "totsize" ,rows[0].totsize );
	                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "price" ,rows[0].price );
	                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "bevcodename" ,rows[0].bevcodename );
	                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "bevcode" ,rows[0].bevcode );
	               	
	                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "bevrate" ,rows[0].bevrate );
	                	
	                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "bevvalue" ,rows[0].bevvalue );
	                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "polcodename" ,rows[0].polcodename );
	               	
	                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "polcode" ,rows[0].polcode );
	                	
	                 	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "polrate" ,rows[0].polrate );
	                    
	                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "polcharge" ,rows[0].polcharge );
	                	
	                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "temp" ,rows[0].temp );
	                	
	                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "amount" ,rows[0].amount );
	                	
	                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "refrow" ,rows[0].rowno );
	                	
	                	$('#prdGridID').jqxGrid('setcellvalue', rowindex1, "qtyval" ,rows[0].qtyval );
	                	
	                	
	                	
	                	
	                	
	            	  }
	   	            	  
	                	
	                
	                
	          
	             $('#sidesearchwndow').jqxWindow('close'); 
	                	   
	          var rows = $('#prdGridID').jqxGrid('getrows');
             var rowlength= rows.length;
             if(rowindex1 == rowlength - 1)
             	{  
             $("#prdGridID").jqxGrid('addrow', null, {});
             	} 
             
             
             $("#prdGridID").jqxGrid('ensurerowvisible', rowlength);
	        	            } 
	                   
         
                  
	               if (key != 13) {          
                  
				                 if (cell4 != undefined && cell4.datafield == 'productid') {
					        
					        		 
					        		   document.getElementById("gridtext").focus();
					        		 
				                 }
				                 if (cell4 != undefined && cell4.datafield == 'productname') {
				         	        
					        		 
					        		   document.getElementById("gridtext1").focus();
					        		 
				               }
					               
	               }
                      } 
     		 
       
             }, 
        
        
        
        columns: [   
                  
                
					
           	         { text: 'SL No', sortable: false, filterable: true, editable: false,
                              groupable: false, draggable: true, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							}, 
					 /* { text: 'Product ID', datafield: 'productid', width: '10%'},
					 { text: 'Product Name', datafield: 'productname', width: '15%'}, */
						{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '15%',
                   	  
						    createeditor: function (row, cellvalue, editor, cellText, width, height) {
						     
						         editor.html('<input type="text" id="part_no" name="part_no" style="width:100%;height:99%;"   />' ); 
						   
						        
						    },  
						 
                    
						
						},
						{ text: 'Product Name' , datafield: 'productname',columntype: 'custom'  ,
							
							createeditor: function (row, cellvalue, editor, cellText, width, height) {
						       
						         editor.html('<input type="text" id="productname" name="productname" style="width:100%;height:99%;"   />' ); 
						     
						        
						    },  
						},
					 { text: 'Psrno', datafield: 'psrno', width: '5%' ,hidden:true},
					 
					 { text: 'Unit', datafield: 'unit', width: '5%',hidden:true },
					 { text: 'unitdocno', datafield: 'unitdocno', width: '5%' ,hidden:true},
					 { text: 'specid', datafield: 'specid', width: '5%',hidden:true },
				 
					 { text: 'Floor', datafield: 'floor', width: '6%' ,hidden:true},
					 { text: 'Flats', datafield: 'flatids', width: '6%' ,hidden:true},
					 
					 
					 {text: 'Width(mm)', datafield: 'width', width: '6%', cellsformat:'d4'},
					 
				     { text: 'Height(mm)',datafield: 'height', width: '6%', cellsformat:'d4' }, 
				    
				     
				     { text: 'Quantity',datafield: 'quantity', width: '6%' , cellsformat:'d2'},
				     
				     
				     { text: 'SQM',  datafield: 'sqm' ,hidden:true,  width: '10%',cellsalign: 'center',aggregatesrenderer:rendererstring1 ,align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
	                       editor.jqxDropDownList({autoDropDownHeight: true,  enableBrowserBoundsDetection:true,source: list1 });
	                        
						
						}

					
	                         },
					 { text: 'Tot Size', datafield: 'totsize', width: '6%', cellsformat:'d4', cellsalign:'right', align:'right',editable:false  ,hidden:true },
					 { text: 'Price', datafield: 'price', width: '7%', cellsformat:'d4', cellsalign:'right', align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring },
					 { text: 'Bevelling Code', datafield: 'bevcodename', width: '6%',editable:false ,hidden:true },
					 { text: '  Code2', datafield: 'bevcode', width: '6%',hidden:true },
					 { text: 'Bev. Rate', datafield: 'bevrate', width: '5%', cellsformat:'d2', cellsalign:'right', align:'right' ,hidden:true},
					 { text: 'Bev. Value', datafield: 'bevvalue', width: '5%' ,cellsformat:'d2', cellsalign:'right', align:'right',editable:false ,hidden:true},
					 { text: 'Polishing Code', datafield: 'polcodename', width: '6%',editable:false ,hidden:true },
					 { text: '  Code1', datafield: 'polcode', width: '6%',hidden:true},
					 { text: 'Pol Rate', datafield: 'polrate', width: '4%', cellsformat:'d2', cellsalign:'right', align:'right' ,hidden:true},
					 { text: 'Pol Charge', datafield: 'polcharge', width: '5%', cellsformat:'d2', cellsalign:'right', align:'right',editable:false ,hidden:true},
					 { text: 'Temp', datafield: 'temp', width: '5% ',hidden:true},
					 { text: 'Amount', datafield: 'amount',editable:false, width: '8%', cellsformat:'d4', cellsalign:'right', align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring },
					 
					 {text: 'proid', datafield: 'proid', width: '5%',hidden:true },
					 { text: 'proname', datafield: 'proname', width: '5%' ,hidden:true},
					 { text: 'refrow', datafield: 'refrow', width: '5%' ,hidden:true },
					  { text: 'Qtyval',datafield: 'qtyval', width: '6%' , cellsformat:'d2',hidden:true},
					 
					 
 
					 
					]
   
    });
    
    if ($("#mode").val() == "A" || $("#mode").val() == "E") {
    	
    	  $("#prdGridID").jqxGrid({ disabled: false});
    	  if($("#mode").val() == "A" && document.getElementById("rreftype").value=="DLY")
    		  {
    		var summaryData10= $("#prdGridID").jqxGrid('getcolumnaggregateddata', 'amount', ['sum'],true);
     	   
		   	var aa1=summaryData10.sum;
		 
		   	document.getElementById("charge").value=0;
		 	document.getElementById("discount").value=0;
		 	document.getElementById("taxamount").value=0;
    		   	document.getElementById("totalamount").value=aa1;
    		   	document.getElementById("nettotal").value=aa1;
    		   	document.getElementById("invvalue").value=aa1;
    		   	calculatedatanet();
    		  }
    	
    }
    
 
    
 
	
	 $('#prdGridID').on('cellclick', function (event) {
		 
		 document.getElementById("errormsg").innerText="";
			var df=event.args.datafield;

			  
      	  if(df == "bevcodename") 
      		  { 
      		 
		 	 
      		 var rowindextemp = event.args.rowindex;
      	    document.getElementById("rowindex").value = rowindextemp;   
      	  $('#prdGridID').jqxGrid('clearselection');
      	codeinfoSearchContent('bsearchcode.jsp?name=1');
		
			}
      	  
      	  
      	  if(df=="polcodename")
      		  {
      		  
      		 var rowindextemp = event.args.rowindex;
     	    document.getElementById("rowindex").value = rowindextemp;   
     	  $('#prdGridID').jqxGrid('clearselection');
     	codeinfoSearchContent('psearchcode.jsp?name=2');
      		  
      		  }
		 
		 
		 
      		  
	 });
	
    
    
    
    
    $('#prdGridID').on('cellbeginedit', function (event) {
   	 
   	 
    	
    	var columnindex1=event.args.columnindex;
    	$('#datas').val(0);

    	
    	var df=event.args.datafield; 

     
    	
    	  if(df == "productid")
    		  { 
    		   
          	 productSearchContent('productSearch.jsp?id=search'+"&reftype="+document.getElementById("rreftype").value+"&reftypedocno="+document.getElementById("masterrrefno").value);
      	 var rowindextemp = event.args.rowindex;
      	    document.getElementById("rowindex").value = rowindextemp;  
      	    
     var temp= $('#prdGridID').jqxGrid('getcellvalue', rowindextemp, "productid"); 
  
     if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
	   { 
    	 $('#gridtext').val("");  
    	 $('#part_no').val("");  
    	 
	   }
     else
    	 {
    	 
    	   
         $('#part_no').val($('#prdGridID').jqxGrid('getcellvalue', rowindextemp, "proid"));
         
         
         $('#gridtext').val($('#prdGridID').jqxGrid('getcellvalue', rowindextemp, "proid"));
         
         
         
        
         $('#prdGridID').jqxGrid('setcellvalue', rowindextemp, "productid" ,$('#prdGridID').jqxGrid('getcellvalue', rowindextemp, "proid"));

         
    	 }
      
         
      		  } 
      	  
      if(df == "productname")
  		  { 
    	  if(document.getElementById("errormsg").innerText!="")
 		 {
    		   
 		 return 0;
 		 }
    	  productSearchContent('productSearch.jsp?id=search'+"&reftype="+document.getElementById("rreftype").value+"&reftypedocno="+document.getElementById("masterrrefno").value);
	 var rowindextemp = event.args.rowindex;
	    document.getElementById("rowindex").value = rowindextemp;  
	    
	      var temp= $('#prdGridID').jqxGrid('getcellvalue', rowindextemp, "productname"); 
          
	      
          // alert(temp);
           if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
		   { 
        	   $('#gridtext1').val(""); 
        	   $('#productname').val("");  
		   }
           else
          	 {
	    

        	   $('#productname').val($('#prdGridID').jqxGrid('getcellvalue', rowindextemp, "proname"));
        	   
        	   $('#gridtext1').val($('#prdGridID').jqxGrid('getcellvalue', rowindextemp, "proname"));
        	   
               
               $('#prdGridID').jqxGrid('setcellvalue', rowindextemp, "productname" ,$('#prdGridID').jqxGrid('getcellvalue', rowindextemp, "proname"));

               
          	 }
            

   
		  } 
        
       
      	 
          });
    
    
    
    $("#prdGridID").on('cellvaluechanged', function (event) {
    	
    
    		 
    		
    		 
    	
    	
    	   var rowBoundIndex = event.args.rowindex;
    	   var datafield = event.args.datafield;
    	   
    	  if(parseInt($('#datas').val())!=1)
    		  {
    	   
     
    	   if(datafield=="productid")
    		   {
    	   
    	$('#prdGridID').jqxGrid('setcellvalue', rowBoundIndex, "productid" ,$('#prdGridID').jqxGrid('getcellvalue', rowBoundIndex, "proid"));
        $('#sidesearchwndow').jqxWindow('close');
    		   }
    	   
    	   if(datafield=="productname")
    		   {
    		   	$('#prdGridID').jqxGrid('setcellvalue', rowBoundIndex, "productname" ,$('#prdGridID').jqxGrid('getcellvalue', rowBoundIndex, "proname"));
                $('#sidesearchwndow').jqxWindow('close');
    		   
    		   }
    		  
    	   
    		  }
    	  
    	 
    	  if(document.getElementById("rreftype").value=="DLY")
    	  {
    		  
    		  
    		  if(datafield=="quantity")
    			  {
    			  
    			  valuechange(rowBoundIndex);
    			  }
    		  
    	  }
    	  
    	  
    	  if(datafield=="quantity" ||  datafield=="price")
    		  {
    		  calculatedatagrid(rowBoundIndex);
    		  }
    	  
    	  if(datafield=="amount")
		  {
    			 
    	 	var summaryData10= $("#prdGridID").jqxGrid('getcolumnaggregateddata', 'amount', ['sum'],true);
    	   
    		   	var aa1=summaryData10.sum;
    		 
    		   	document.getElementById("charge").value=0;
    		 	document.getElementById("discount").value=0;
    		 	//document.getElementById("taxamount").value=0;
        		   	document.getElementById("totalamount").value=aa1;
        		   	document.getElementById("nettotal").value=aa1;
        		   	document.getElementById("invvalue").value=aa1;
        		 
        		   	calculatedatanet(); 
        		  
		  }
    	  
    	
    	  
    	   
   
    		});
    
    

    
    var applyFilter = function (datafield,value) {
    	    
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
      //  document.getElementById("part_no").focus();
        	}
        else  if (datafield == 'productname') 
    	         {
            
            $("#prosearch").jqxGrid('addfilter', 'productname' , filtergroup);
        //    document.getElementById("productname").focus();
            	}
        
        
   
        $("#prosearch").jqxGrid('applyfilters');
        
        
 		  

    }
   
    
    
     $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
    // create context menu
       var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
       $("#prdGridID").on('contextmenu', function () {
           return false;
       });
       
       $("#Menu").on('itemclick', function (event) {
    	   var args = event.args;
           var rowindex = $("#prdGridID").jqxGrid('getselectedrowindex');
           if ($.trim($(args).text()) == "Edit Selected Row") {
               editrow = rowindex;
               var offset = $("#prdGridID").offset();
               $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
               // get the clicked row's data and initialize the input fields.
               var dataRecord = $("#prdGridID").jqxGrid('getrowdata', editrow);
               // show the popup window.
               $("#popupWindow").jqxWindow('show');
           }
           else {
               var rowid = $("#prdGridID").jqxGrid('getrowid', rowindex);
               $("#prdGridID").jqxGrid('deleterow', rowid);
           }
       });
       
       $("#prdGridID").on('rowclick', function (event) {
           if (event.args.rightclick) {
		   if(document.getElementById("mode").value=="A"  ){
               $("#prdGridID").jqxGrid('selectrow', event.args.rowindex);
               var scrollTop = $(window).scrollTop();
               var scrollLeft = $(window).scrollLeft();
               contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
               return false;
           }
		   }
       });

 

    
   
    
  
});

function valuechange(rowBoundIndex)
{
	var quantity=$('#prdGridID').jqxGrid('getcellvalue', rowBoundIndex, "quantity");
	var qtyval=$('#prdGridID').jqxGrid('getcellvalue', rowBoundIndex, "qtyval");
	
	
	
	if(parseFloat(quantity)>parseFloat(qtyval))
		{
		
		
		 
		 document.getElementById("errormsg").innerText=" Quantity value not more than Actual Quantity "+qtyval;

	 
		 
		 $('#prdGridID').jqxGrid('setcellvalue', rowBoundIndex, "quantity" ,qtyval);
		 
		
		}
	
	
	
}

 
function calculatedatagrid(rowBoundIndex)
{
	var width=$('#prdGridID').jqxGrid('getcellvalue', rowBoundIndex, "width");
	var height=$('#prdGridID').jqxGrid('getcellvalue', rowBoundIndex, "height");
	var quantity=$('#prdGridID').jqxGrid('getcellvalue', rowBoundIndex, "quantity");
	
	var price=$('#prdGridID').jqxGrid('getcellvalue', rowBoundIndex, "price");
 
	
	if(width=="" || width==null || width==0 ||typeof(width)=="undefined"|| typeof(width)=="NaN")
	{
		width=0;
	}
	 
	if(height=="" || height==null || height==0 || typeof(height)=="undefined"|| typeof(height)=="NaN")
	{
		height=0;
	}
	 
		 
	if(quantity=="" || quantity==null || quantity==0 || typeof(quantity)=="undefined"|| typeof(quantity)=="NaN")
	{
		quantity=0;
	}
	
 
	
	if(price=="" || price==null || price==0 || typeof(price)=="undefined"|| typeof(price)=="NaN")
	{
		price=0;
	}
	else
		{
			$('#prdGridID').jqxGrid('setcellvalue', rowBoundIndex, "amount",(parseFloat(price)*parseFloat(quantity)));
		
		}
	
	
	
	 
}

</script>
 <div id='jqxWidget'>
    
    <div id="popupWindow">
 
 <div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
   </div>
  <input type="hidden" id="datas"/> 
    <input type="hidden" id="rowindex"/> 
  
  
<div id="prdGridID"></div>